KOR_testing = !(["ACE_main"] call KISKA_fnc_isPatchLoaded);

[] call KOR_fnc_setupClassEventHandler;

private _arsenals = ["Arsenals"] call KISKA_fnc_getMissionLayerObjects;
[_arsenals] call KISKA_fnc_addArsenal;

["medic"] call KISKA_fnc_traitManager_addToPool_global;
["engineer"] call KISKA_fnc_traitManager_addToPool_global;


KOR_response = {
    params ["_group","_groupsToRespond","_priority"];

    sleep 3;

    private _groupIsAlive = [_group] call KISKA_fnc_isGroupAlive;
    if !(_groupIsAlive) exitWith {};

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

        // some time is needed after reseting units with doFollow or they will lock up
        sleep 1;

        [_x, group _closestEnemy, 15, {
            params ["_stalkerGroup"];
            hint ("reset group: " + (str _stalkedGroup));
            _stalkerGroup setVariable ["KISKA_bases_responseMissionPriority", nil];
            _stalkerGroup setVariable ["KISKA_bases_respondingToId", nil];
        }] spawn KISKA_fnc_stalk;

        _x setVariable ["KISKA_bases_responseMissionPriority",_priority];
        _x setVariable ["KISKA_bases_respondingToId", _groupReinforceId];
    };
};

["KOR_goldwil"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_clear"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_destroyBoats"] call KISKA_fnc_createTaskFromConfig;

[
    ["Goldwil Boats"] call KISKA_fnc_getMissionLayerObjects,
    "KOR_goldwil_destroyBoats"
] call KISKA_fnc_setupKillTask;

/* KOR_base_goldWil = ["Goldwil"] call KISKA_fnc_bases_createFromConfig;

[
    KOR_base_goldWil get "unit list",
    "KOR_goldwil_clear"
] call KISKA_fnc_setupKillTask; */


/* KOR_base_brienzOutpost = ["BrienzOutpost"] call KISKA_fnc_bases_createFromConfig;

[
    KOR_base_brienzOutpost get "unit list",
    "KOR_brienz_secureCommStation"
] call KISKA_fnc_setupKillTask; */


/* ["freedomFlightDeck"] call KISKA_fnc_bases_createFromConfig; */
/* ["lhdFlightDeck"] call KISKA_fnc_bases_createFromConfig; */


[] call KOR_fnc_setupGoldwilBoatLaunch;
_this spawn KOR_fnc_handle_insertToGoldwil;
