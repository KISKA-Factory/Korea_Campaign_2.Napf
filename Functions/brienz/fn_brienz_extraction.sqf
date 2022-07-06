#include "..\..\Headers\Unit Classes.hpp"
scriptName "KOR_fnc_brienz_extraction";

#define NUMBER_OF_CREW 4

if (!canSuspend) exitWith {
    _this spawn KOR_fnc_brienz_extraction;
};


/* ----------------------------------------------------------------------------
    Setup helicopter & crew
---------------------------------------------------------------------------- */
private _heliType = [
    "vtx_MH60S",
    "B_Heli_Transport_01_F"
] select KOR_testing;

private _vehicleInfo = [
    KOR_brienz_extractionSpawn,
    -1,
    _heliType,
    BLUFOR,
    false,
    [
        MARINE_HELI_PILOT_UNIT_CLASS,
        MARINE_HELI_PILOT_UNIT_CLASS,
        MARINE_HELI_CREW_UNIT_CLASS,
        MARINE_HELI_CREW_UNIT_CLASS
    ]
] call KISKA_fnc_spawnVehicle;

private _heli = _vehicleInfo select 0;
KOR_brienz_extracHeli = _heli;
[_heli, false] remoteExec ["allowDamage", 0, true];

private _heliGroup = _vehicleInfo select 2;
[_heliGroup,true] call KISKA_fnc_ACEX_setHCTransfer;
_heliGroup setBehaviour "SAFE";
_heliGroup setCombatMode "BLUE";

private _crew = _vehicleInfo select 1;
_crew apply {
    [_x, false] remoteExec ["allowDamage", 0, true];
};


[
    _heli,
    KOR_brienz_extractionLZ,
    "GET IN",
    false
] call KISKA_fnc_heliLand;

/* ----------------------------------------------------------------------------
    Task create
---------------------------------------------------------------------------- */
["KOR_brienz_extract"] call KISKA_fnc_createTaskFromConfig;
["KOR_brienz_extract_boardTheHeli"] call KISKA_fnc_createTaskFromConfig;


/* ----------------------------------------------------------------------------
    Wait for players to board heli
---------------------------------------------------------------------------- */
waituntil {
	sleep 1;
	private _alivePlayers = count (call KISKA_fnc_alivePlayers);
	(
        (_alivePlayers > 0) AND
        {count (crew _heli) isEqualTo (NUMBER_OF_CREW + _alivePlayers)}
    )
};


[KOR_musicMap get "Extraction"] remoteExec ["KISKA_fnc_playMusic", [0,-2] select isDedicated];
["KOR_brienz_extract_boardTheHeli"] call KISKA_fnc_endTask;


// keep players from exiting while heli takes off
[_heli, true] remoteExecCall ["lock",_heli];
[_heli] spawn {
    params ["_heli"];
    sleep 15;
    // let people switch seats
    [_heli, false] remoteExecCall ["lock",_heli];
};

private _pilot = currentPilot _heli;
_pilot setBehaviour "CARELESS"
[[_pilot],(getPosATL KOR_goldwilInsertHeliSpawn)] remoteExec ["doMove",_pilot];

[] spawn {
    sleep 60;
    ["KOR_brienz_extract"] call KISKA_fnc_endTask;
    [] call BIS_fnc_endMissionServer;
};
