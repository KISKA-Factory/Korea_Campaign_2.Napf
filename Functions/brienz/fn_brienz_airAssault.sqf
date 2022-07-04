#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_brienz_airAssault";

hint "air assault";

missionNamespace setVariable ["KOR_brienz_airAssaultCalled",true];

// spawn heli
// spawn group
// add group to kill event
// put group in back of heli
// tell heli to land
// kick out group
// tell group to attack (or tell to stalk players)
// have heli move to be deleted

private _spawnPositions = ["Brienz Hidden Group Spawns"] call KISKA_fnc_getMissionlayerObjects;
for "_i" from 0 to 2 do {
    private _group = [
        6,
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
