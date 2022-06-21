KOR_response = {
    [str _this] call KISKA_fnc_log;
    params ["_group","_groupsToRespond","_priority"];
    hint str _group;

    sleep 3;

    private _leaderOfCallingGroup = leader _group;
    private _moveToPosition = getPosATL _leaderOfCallingGroup;
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

        };

        private _groupUnits = units _x;
        // reset infantry positions
        _groupUnits apply {
            _x setVariable ["KISKA_bases_stopAmbientAnim",true];
            [_x,"AUTO"] remoteExec ["setUnitPos",_x];
        };
        // in case unit was told to stop with doStop
        [_groupUnits, _leaderOfRespondingGroup] remoteExec ["doFollow", _leaderOfRespondingGroup];
        [_x] remoteExec ["CBA_fnc_clearWaypoints", _leaderOfRespondingGroup];
        sleep 1;
        [_leaderOfRespondingGroup, _moveToPosition] remoteExec ["move", _leaderOfRespondingGroup];
        [_x, "FULL"] remoteExec ["setSpeedMode", _leaderOfRespondingGroup];
        _x setVariable ["KISKA_bases_respondingToId", _groupReinforceId];
    };

    hint str (_leaderOfCallingGroup call BIS_fnc_enemyTargets);

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
