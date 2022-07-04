#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_brienz_reinforcements";

missionNamespace setVariable ["KOR_brienz_reinforcementsCalled",true];

private _spawnPositions = ["Brienz Hidden Group Spawns"] call KISKA_fnc_getMissionlayerObjects;

for "_i" from 0 to 2 do {
    private _group = [
        5,
        [ ENEMY_INFANTRY_UNIT_CLASSES ],
        OPFOR,
        selectRandom _spawnPositions
    ] call KISKA_fnc_spawnGroup;

    [
        (units _group),
        "#" + (KISKA_multiKillEventMap_brienzInfantry get "id")
    ] call KISKA_fnc_setupMultiKillEvent;

    [_group, [14609.6,2950.91,0], 25] call KISKA_fnc_attack;
};


nil
