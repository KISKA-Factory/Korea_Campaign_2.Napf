#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_brienz_setupBattle";



// marines drive to site
// marines disembark armor
// enemy start attacking marines
// enemy helicopters land behind players
// enemy helicopters land in Brienz
// enemies that land near player need to mortar them (they can't effectively move into building)


// if garrison has all vehicles destoryed and enemy units are down to 10%
private _infantryGroupSpawns = ["Brienz Marine Infantry Spawns"] call KISKA_fnc_getMissionlayerObjects;
private _infantryGroupMovePositions = ["Brienz Marine Infantry Move Positions"] call KISKA_fnc_getMissionlayerObjects;

{
    private _infantryGroup = [
        8,
        [MARINE_INFANTRY_UNIT_CLASSES],
        BLUFOR,
        _x,
        true
    ] call KISKA_fnc_spawnGroup;

    private _attackPos = _infantryGroupMovePositions select _forEachIndex;
    [_infantryGroup, _attackPos, -1, "aware"] call KISKA_fnc_attack;
} forEach _infantryGroupSpawns;


private _unitsToKill = +(KISKA_bases_brienzMain get "unit list");
missionNamespace setVariable ["KOR_brienz_unitsToKill", _unitsToKill];
_unitsToKill apply {
    _x addEventHandler ["KILLED", {
        if (missionNamespace getVariable ["KOR_brienz_ninetyPercentDead",false]) then {
            private _totalUnitCount = count (missionNamespace getVariable "KOR_brienz_unitsToKill");
            private _currentDeadCount = missionNamespace getVariable ["KOR_brienz_killedUnitCount", 0];
            _currentDeadCount = _currentDeadCount + 1;
            private _ninentyPercentDead = (_currentDeadCount / _totalUnitCount) >= 0.90;

            if (_ninentyPercentDead) then {
                missionNamespace setVariable ["KOR_brienz_ninetyPercentDead",true];
                if (missionNamespace getVariable ["KOR_brienz_vehiclesKilled",false]) then {
                    [""] call KISKA_fnc_endTask;
                };

            } else {
                missionNamespace setVariable ["KOR_brienz_killedUnitCount", _currentDeadCount];

            };

        };
    }];
};



private _vehiclesToKill = +(KISKA_bases_brienzMain get "land vehicles");
missionNamespace setVariable ["KOR_brienz_totalArmorCount",count _vehiclesToKill];
_vehiclesToKill apply {
    _x addEventHandler ["KILLED", {
        private _totalKilledCount = missionNamespace getVariable ["KOR_brienz_killedArmorCount",0];
        _totalKilledCount = _totalKilledCount + 1;
        private _totalToKill = missionNamespace getVariable ["KOR_brienz_totalArmorCount", 0];

        if (_totalKilledCount isEqualTo _totalToKill) then {
            missionNamespace setVariable ["KOR_brienz_vehiclesKilled",true];
            if (missionNamespace getVariable ["KOR_brienz_ninetyPercentDead",true]) then {
                [""] call KISKA_fnc_endTask;
            };

        } else {
            missionNamespace setVariable ["KOR_brienz_killedArmorCount",_totalKilledCount];

        };
    }];
};
