#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_handle_insertToGoldwil";

#define NUMBER_OF_CREW 4

if (!canSuspend) exitWith {
    _this spawn KOR_fnc_handleInsert;
};


/* ----------------------------------------------------------------------------
    Setup helicopter & crew
---------------------------------------------------------------------------- */
private _heliType = [
    "vtx_MH60S",
    "B_Heli_Transport_01_F"
] select KOR_testing;

private _vehicleInfo = [
    KOR_insertHeli_1_spawn,
    -1,
    _heliType,
    BLUFOR,
    true,
    [
        MARINE_HELI_PILOT_UNIT_CLASS,
        MARINE_HELI_PILOT_UNIT_CLASS,
        MARINE_HELI_CREW_UNIT_CLASS,
        MARINE_HELI_CREW_UNIT_CLASS
    ]
] call KISKA_fnc_spawnVehicle;
KOR_insertHeli_goldwil = _vehicleInfo select 0;

private _heliGroup = _vehicleInfo select 2;
[_heliGroup,true] call KISKA_fnc_ACEX_setHCTransfer;
_heliGroup setBehaviour "SAFE";
_heliGroup setCombatMode "BLUE";

[KOR_insertHeli_goldwil, false] remoteExec ["allowDamage", 0, true];
private _crew = _vehicleInfo select 1;
_crew apply {
    [_x, false] remoteExec ["allowDamage", 0, true];
};

["KOR_goldwil_insert"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_insert_boardTheHeli"] call KISKA_fnc_createTaskFromConfig;


/* ----------------------------------------------------------------------------
    Wait for players to board heli
---------------------------------------------------------------------------- */
waituntil {
	sleep 1;
	private _alivePlayers = count (call KISKA_fnc_alivePlayers);
	(
        (_alivePlayers > 0) AND
        {count (crew KOR_insertHeli_goldwil) isEqualTo (NUMBER_OF_CREW + _alivePlayers)}
    )
};

["CCM_AM_acquaintance"] remoteExec ["KISKA_fnc_playMusic", [0,-2] select isDedicated];
["KOR_goldwil_insert_boardTheHeli"] call KISKA_fnc_endTask;


/* ----------------------------------------------------------------------------
    Drop off players
---------------------------------------------------------------------------- */
// keep players from exiting while heli takes off
[KOR_insertHeli_goldwil, true] remoteExecCall ["lock",KOR_insertHeli_goldwil];


private _pilot = currentPilot KOR_insertHeli_goldwil;
private _insertHeliWaypointPos = getPosATL KOR_insertHeliMovePos;
[_pilot,_insertHeliWaypointPos] remoteExec ["move",_pilot];

[] spawn {
    sleep 15;
    // let people switch seats
    [KOR_insertHeli_goldwil,false] remoteExecCall ["lock",KOR_insertHeli_goldwil];
};

/* waitUntil {
    sleep 2;
    KOR_insertHeli_goldwil distance2D KOR_insertHeliMovePos <= 350;
}; */
