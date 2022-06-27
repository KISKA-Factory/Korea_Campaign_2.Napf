#include "..\..\Headers\Unit Classes.hpp"
#include "..\..\Headers\Player Radius Defines.hpp"

scriptName "KOR_fnc_handle_insertToGoldwil";

#define NUMBER_OF_CREW 4

if (!canSuspend) exitWith {
    _this spawn KOR_fnc_handle_insertToGoldwil;
};


/* ----------------------------------------------------------------------------
    Setup helicopter & crew
---------------------------------------------------------------------------- */
private _heliType = [
    "vtx_MH60S",
    "B_Heli_Transport_01_F"
] select KOR_testing;

private _vehicleInfo = [
    KOR_goldwilInsertHeliSpawn,
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


/* ----------------------------------------------------------------------------
    Task create
---------------------------------------------------------------------------- */
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

// keep players from exiting while heli takes off
[KOR_insertHeli_goldwil, true] remoteExecCall ["lock",KOR_insertHeli_goldwil];
[] spawn {
    sleep 15;
    // let people switch seats
    [KOR_insertHeli_goldwil, false] remoteExecCall ["lock",KOR_insertHeli_goldwil];
};


/* ----------------------------------------------------------------------------
    Drop off players
---------------------------------------------------------------------------- */
private _afterDropCode = {
    ["KOR_goldwil_insert"] call KISKA_fnc_endTask;

    /* ["Artillery support now available"] remoteExec ["KISKA_fnc_dataLinkMsg",0];
    ["KOR_120Guided"] call KISKA_fnc_supportManager_addToPool_global;
    ["KOR_230HE"] call KISKA_fnc_supportManager_addToPool_global;
    ["KOR_arsenalDrop"] call KISKA_fnc_supportManager_addToPool_global; */

    _this spawn {
        params ["_heli"];

        private _pilot = currentPilot _heli;
        [[_pilot],(getPosATL KOR_deletePos)] remoteExec ["doMove",_pilot];

        waitUntil {
            sleep 2;
            _heli distance2D KOR_deletePos <= 400;
        };

        deleteVehicleCrew _heli;
        deleteVehicle _heli;
    };
};

[
    KOR_insertHeli_goldwil,
    KOR_goldwil_insertPos,
    (fullCrew [KOR_insertHeli_goldwil,"cargo"]) apply {
        _x select 0
    },
    _afterDropCode,
    28
] call KISKA_fnc_ACE_fastRope;