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


private _unitsToKill = KISKA_bases_brienzMain get "unit list";
KISKA_multiKillEventMap_brienzInfantry = [
    _unitsToKill,
    {
        private _armorKilled = KISKA_multiKillEventMap_brienzArmor getOrDefault ["thresholdMet",false]
        if (_armorKilled) then {
            [""] call KISKA_fnc_endTask;
        };
    },
    0.90
] call KISKA_fnc_setupMultiKillEvent;



private _vehiclesToKill = KISKA_bases_brienzMain get "land vehicles";
KISKA_multiKillEventMap_brienzArmor = [
    _vehiclesToKill,
    {
        private _infantryKilled = KISKA_multiKillEventMap_brienzInfantry getOrDefault ["thresholdMet",false]
        if (_infantryKilled) then {
            [""] call KISKA_fnc_endTask;
        };
    }
] call KISKA_fnc_setupMultiKillEvent;
