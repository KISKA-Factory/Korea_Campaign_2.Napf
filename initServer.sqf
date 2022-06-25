KOR_response = {
    [str _this] call KISKA_fnc_log;
    params ["_group","_groupsToRespond","_priority"];
    /* hint str _group; */

    /* sleep 3; */

    /* private _moveToPosition = getPosATL _leaderOfCallingGroup; */
    private _simDistance = dynamicSimulationDistance "Group";
    private _targets = [];
    private "_leaderOfCallingGroup";
    waitUntil {
        sleep 1;
        // in case leader changes
        _leaderOfCallingGroup = leader _group;
        if !(alive _leaderOfCallingGroup) exitWith {true};
        _targets = _leaderOfCallingGroup targets [true, _simDistance];
        _targets isNotEqualTo []
    };

    // in case _closestEnemy dies while processing
    private _closestEnemy = objNull;
    private _distanceOfClosest = -1;
    _targets apply {
        private _distance = _x distance _leaderOfCallingGroup;
        if (!(alive _closestEnemy) OR (_distance < _distanceOfClosest)) then {
            _distanceOfClosest = _distance;
            _closestEnemy = _x;
        };
    };

    private _groupRespondingToId = _group getVariable ["KISKA_bases_respondingToId",""];
    private _groupIsAlsoResponding = _groupRespondingToId isNotEqualTo "";
    private _groupReinforceId = _group getVariable ["KISKA_bases_reinforceId",""];

    _groupsToRespond apply {
        private _currentMissionPriority = _x getVariable ["KISKA_bases_responseMissionPriority",-1];
        if (_currentMissionPriority > _priority) then {
            continue;
        };

        // check that the group being called doesn't already have
        // the group calling responding to them
        // e.g. group1 calls for group2, group2 then calls for group1
        // group2 shouldn't acknowledge this because group1 already called
        private _reinforceId = _x getVariable ["KISKA_bases_reinforceId",""];
        private _willBeCircularResponse = _reinforceId isEqualTo _groupRespondingToId;
        if (_groupIsAlsoResponding AND _willBeCircularResponse) then {
            continue;
        };

        private _leaderOfRespondingGroup = leader _x;
        if ((isNull _x) OR (isNull _leaderOfRespondingGroup)) then {
            continue;
        };

        private _currentBehaviour = combatBehaviour _x;
        private _distanceBetweenGroups = _leaderOfRespondingGroup distance _leaderOfCallingGroup;
        if (
            (_distanceBetweenGroups > 20) AND
            (_currentBehaviour != "combat")
        ) then {
            [_x,"aware"] remoteExec ["setBehaviour",_leaderOfRespondingGroup];
            [_x,"aware"] remoteExec ["setCombatBehaviour",_leaderOfRespondingGroup];

        };

        private _groupUnits = units _x;
        // reset infantry positions
        _groupUnits apply {
            _x setVariable ["KISKA_bases_stopAmbientAnim",true];
            [_x,"AUTO"] remoteExec ["setUnitPos",_x];
        };
        // in case unit was told to stop with doStop
        [_groupUnits, _leaderOfRespondingGroup] remoteExec ["doFollow", _leaderOfRespondingGroup];
        /* [_x] remoteExec ["CBA_fnc_clearWaypoints", _leaderOfRespondingGroup]; */
        sleep 1;
        /* [_leaderOfRespondingGroup, _moveToPosition] remoteExec ["move", _leaderOfRespondingGroup]; */

        [_x, group _closestEnemy, 15, {false}, {
            params ["_stalkerGroup"];
            hint ("reset group: " + (str _stalkedGroup));
            _stalkerGroup setVariable ["KISKA_bases_responseMissionPriority", nil];
            _stalkerGroup setVariable ["KISKA_bases_respondingToId", nil];
        }] spawn KISKA_fnc_stalk;
        /* [_x, "FULL"] remoteExec ["setSpeedMode", _leaderOfRespondingGroup]; */
        _x setVariable ["KISKA_bases_responseMissionPriority",_priority];
        _x setVariable ["KISKA_bases_respondingToId", _groupReinforceId];
    };

    hint "fired";

    true
};

["KOR_goldwil"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_clear"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_destroyBoats"] call KISKA_fnc_createTaskFromConfig;


[
    ["Goldwil Boats"] call KISKA_fnc_getMissionLayerObjects,
    "KOR_goldwil_destroyBoats"
] call KISKA_fnc_setupKillTask;

KOR_base_goldWil = ["Goldwil"] call KISKA_fnc_bases_createFromConfig;
["freedomFlightDeck"] call KISKA_fnc_bases_createFromConfig;
["lhdFlightDeck"] call KISKA_fnc_bases_createFromConfig;

















KISKA_fnc_stalk = {
/* ----------------------------------------------------------------------------
Function: KISKA_fnc_stalk

Description:
	Rewrite of BIS_fnc_stalk for optimizations and features.
    One provided group will continually be provided waypoints to another group's
     positions providing a "stalking" affect.

Parameters:
    0: _stalkerGroup <GROUP or OBJECT> - The group to do the stalking
    1: _stalkedGroup <GROUP or OBJECT> - The group to be stalked
    2: _refreshInterval <NUMBER> - How often the _stalkerGroup will have their waypoint
        updated with the position of the _stalkedGroup, and how often to check the _conditionToEndStalking
    3: _conditionToEndStalking <STRING, ARRAY, or CODE> - Code that (if returns true)
        can end the stalking. (See KISKA_fnc_callBack _callBackFunction parameter)
    4: _postStalking <STRING, ARRAY, or CODE> - Code that after stalking is complete
        will be executed. (See KISKA_fnc_callBack _callBackFunction parameter)

Returns:
    NOTHING

Examples:
    (begin example)

    (end)

Author:
	Ansible2
---------------------------------------------------------------------------- */
scriptName "KISKA_fnc_stalk";


if !(canSuspend) exitWith {
    ["Must be run in scheduled environment. Exiting to scheduled...",true] call KISKA_fnc_log;
    _this spawn KISKA_fnc_stalk;
};


params [
    ["_stalkerGroup",grpNull,[objNull,grpNull]],
    ["_stalkedGroup",grpNull,[objNull,grpNull]],
    ["_refreshInterval",25,[123]],
    ["_conditionToEndStalking",{false},[[],{},""]],
    ["_postStalking",{},[[],{},""]]
];


/* ----------------------------------------------------------------------------
    Parameter verification
---------------------------------------------------------------------------- */
if (isNull _stalkerGroup) exitWith {
    ["_stalkerGroup is null! Exiting...",true] call KISKA_fnc_log;
    nil
};

if (isNull _stalkedGroup) exitWith {
    ["_stalkedGroup is null! Exiting...",true] call KISKA_fnc_log;
    nil
};

if (_refreshInterval < 5) exitWith {
    ["_refreshInterval was less than 5, adjusting to 5",true] call KISKA_fnc_log;
    _refreshInterval = 5;
    nil
};

if (_stalkerGroup isEqualType objNull) then {
    _stalkerGroup = group _stalkerGroup;
};

private _groupAlreadyBeingStalked = _stalkerGroup getVariable ["KISKA_isStalking",grpNull];
if !(isNull _groupAlreadyBeingStalked) exitWith {
    [[_stalkerGroup," is already stalking the group ",_groupAlreadyBeingStalked," an cannot stalk multiple groups"]] call KISKA_fnc_log;
    nil
};

if (_stalkedGroup isEqualType objNull) then {
    _stalkedGroup = group _stalkedGroup;
};


/* ----------------------------------------------------------------------------
    Main loop
---------------------------------------------------------------------------- */
_stalkerGroup setVariable ["KISKA_stalkingGroup",_stalkedGroup];
[_stalkerGroup] call CBA_fnc_clearWaypoints;

private _stalkedGroupIsStalkable = true;
private _stalkerGroupCanStalk = true;
private _isGroupAlive = {
    params ["_group"];
    (!isNull _group) AND
    {((units _group) findIf {alive _x}) isNotEqualTo -1}
};

while {_stalkerGroupCanStalk AND _stalkedGroupIsStalkable} do {
    [_stalkerGroup] call CBA_fnc_clearWaypoints;

    private _stalkerGroupLeader = leader _stalkerGroup;
    private _stalkedGroupLeader = leader _stalkedGroup;
    private _distance2DBetweenGroups = _stalkerGroupLeader distance2D _stalkedGroupLeader;
    if (_distance2DBetweenGroups > 20) then {
        [_stalkerGroup, _stalkedGroupLeader, 25, "MOVE", "AWARE", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;
    } else {
        [_stalkerGroup, (getPosATL _stalkedGroupLeader)] remoteExec ["move", _stalkerGroupLeader];
    };

    private _conditionMet = [
        [_stalkerGroup,_stalkedGroup],
        _conditionToEndStalking
    ] call KISKA_fnc_callBack;
    if (_conditionMet) then {break};


    sleep _refreshInterval;


    _stalkerGroupCanStalk = [_stalkerGroup] call _isGroupAlive;
    _stalkedGroupIsStalkable = [_stalkedGroup] call _isGroupAlive;
};

/* ----------------------------------------------------------------------------
    Post
---------------------------------------------------------------------------- */
if !(isNull _stalkerGroup) then {
    _stalkerGroup setVariable ["KISKA_stalkingGroup",nil];
    (units _stalkerGroup) apply {
        [_x,objNull] remoteExec ["commandTarget",_x];
    };
    [_stalkerGroup] call CBA_fnc_clearWaypoints;
};


[
    [_stalkerGroup,_stalkedGroup],
    _postStalking
] call KISKA_fnc_callBack;


nil
};
