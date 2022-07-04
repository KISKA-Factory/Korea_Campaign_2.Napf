#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_brienz_setupBattle";

/* ----------------------------------------------------------------------------
    Marine Infantry
---------------------------------------------------------------------------- */
private _infantryGroupSpawns = ["Brienz Marine Infantry Spawns"] call KISKA_fnc_getMissionlayerObjects;
private _infantryGroupMovePositions = ["Brienz Marine Infantry Move Positions"] call KISKA_fnc_getMissionlayerObjects;

{
    private _infantryGroup = [
        6,
        [MARINE_INFANTRY_UNIT_CLASSES],
        BLUFOR,
        _x,
        true
    ] call KISKA_fnc_spawnGroup;

    private _attackPos = _infantryGroupMovePositions select _forEachIndex;
    [_infantryGroup, _attackPos, -1, "aware"] call KISKA_fnc_attack;

    (units _infantryGroup) apply {
        [_x, false] remoteExec ["allowDamage",0,true];
    };
} forEach _infantryGroupSpawns;

/* ----------------------------------------------------------------------------
    Marine Armor
---------------------------------------------------------------------------- */
/* private _armorSpawns = ["Brienz Marine Armor Spawns"] call KISKA_fnc_getMissionlayerObjects;
private _armorAttackPositions = ["Brienz Marine Armor Attack Positions"] call KISKA_fnc_getMissionlayerObjects;

{
    private _vehicleInfo = [
        _x,
        -1,
        "CUP_B_LAV25_USMC",
        BLUFOR,
        true,
        [
            MARINE_ARMOR_CREW_UNIT_CLASS,
            MARINE_ARMOR_CREW_UNIT_CLASS,
            MARINE_ARMOR_CREW_UNIT_CLASS
        ]
    ] call KISKA_fnc_spawnVehicle;

    private _group = _vehicleInfo select 2;
    [
        _group,
        _armorAttackPositions select _forEachIndex
    ] call KISKA_fnc_attack;

    private _crew = _vehicleInfo select 1;
    _crew apply {
        [_x, false] remoteExec ["allowDamage",0,true];
    };

    private _vehicle = _vehicleInfo select 0;
    [_vehicle, false] remoteExec ["allowDamage",0,true];

} forEach _armorSpawns; */

/* ----------------------------------------------------------------------------
    Infantry to kill
---------------------------------------------------------------------------- */
["KOR_brienz_supportMarines"] call KISKA_fnc_createTaskFromConfig;

private _unitsToKill = KISKA_bases_brienzMain get "unit list";
KISKA_multiKillEventMap_brienzInfantry = [
    _unitsToKill,
    {
        private _armorKilled = KISKA_multiKillEventMap_brienzArmor getOrDefault ["thresholdMet",false];
        if (_armorKilled) then {
            ["KOR_brienz_supportMarines"] call KISKA_fnc_endTask;
        };
    },
    0.90,
    {
        params ["","_eventMap"];

        private _total = _eventMap getOrDefault ["total", 1];
        private _killed = _eventMap getOrDefault ["killed", 1];
        private _percentageKilled = _killed / _total;
        if (_percentageKilled >= 0.45) then {
            [] call KOR_fnc_brienz_reinforcements;
        };
        if (_percentageKilled >= 0.7) then {
            [] call KOR_fnc_brienz_airAssault;
        };
    }
] call KISKA_fnc_setupMultiKillEvent;


/* ----------------------------------------------------------------------------
    Armor to kill
---------------------------------------------------------------------------- */
private _vehiclesToKill = KISKA_bases_brienzMain get "land vehicles";
KISKA_multiKillEventMap_brienzArmor = [
    _vehiclesToKill,
    {
        private _infantryKilled = KISKA_multiKillEventMap_brienzInfantry getOrDefault ["thresholdMet",false];
        if (_infantryKilled) then {
            ["KOR_brienz_supportMarines"] call KISKA_fnc_endTask;
        };
    }
] call KISKA_fnc_setupMultiKillEvent;
