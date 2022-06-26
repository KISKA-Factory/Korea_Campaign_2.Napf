#include "..\..\Headers\Unit Classes.hpp"





KISKA_fnc_slingLoad_1 = {
    scriptName "KISKA_fnc_slingLoad";

    params [
        ["_heli",objNull,[objNull]],
        ["_liftObject",objNull,[objNull]],
        ["_dropOffPoint",objNull,[[],objNull,grpNull,locationNull]],
        ["_afterDropCode",{},[[],{},""]],
        ["_flightPath",[],[[]]]
    ];

    /* ----------------------------------------------------------------------------
        Verify Params
    ---------------------------------------------------------------------------- */
    if !(alive _heli) exitWith {
        ["_heli is not alive! Exiting...", true] call KISKA_fnc_log;
        []
    };

    private _pilot = currentPilot _heli;
    if !(alive _pilot) exitWith {
        [[_heli,"'s pilot is not alive! Exiting..."], true] call KISKA_fnc_log;
        []
    };

    if !(alive _liftObject) exitWith {
        ["_liftObject is dead, will not lift..."] call KISKA_fnc_log;
        []
    };

    if !(_heli canSlingLoad _liftObject) exitWith {
        [[_heli," can't lift ",_liftObject], true] call KISKA_fnc_log;
        []
    };

    private _dropOffPointIsInvalid = (
        (_dropOffPoint isEqualTypeAny [grpNull,locationNull,objNull] AND
        {isNull _dropOffPoint}) OR
        (_dropOffPoint isEqualTo [])
    );

    if (_dropOffPointIsInvalid) exitWith {
        ["Invalid _dropOffPoint provided",true] call KISKA_fnc_log;
        []
    };

    /* ----------------------------------------------------------------------------
        Add waypoints
    ---------------------------------------------------------------------------- */
    private _group = group _pilot;
    [_group] call CBA_fnc_clearWaypoints;

    private _liftWP = _group addWaypoint [_liftObject, 0];
    _liftWP setWaypointType "HOOK";
    _liftWP setWaypointBehaviour "SAFE";
    _liftWP setWaypointCombatMode "BLUE";

    /* [
        _group,
        _liftObject,
        -1,
        "HOOK",
        "SAFE",
        "BLUE"
    ] call CBA_fnc_addWaypoint; */


    if (_flightPath isNotEqualTo []) then {
        _flightPath apply {
            [
                _group,
                _x,
                -1,
                "MOVE"
            ] call CBA_fnc_addWaypoint;
        };
    };


    _pilot setVariable ["KISKA_postSlingLoadCode",_afterDropCode];
    [
        _group,
        _dropOffPoint,
        -1,
        "UNHOOK",
        "UNCHANGED",
        "NO CHANGE",
        "UNCHANGED",
        "NO CHANGE",
        "private _afterDropCode = this getVariable ['KISKA_postSlingLoadCode',{}]; [[this],_afterDropCode] call KISKA_fnc_callBack; this setVariable ['KISKA_postSlingLoadCode',nil]"
    ] call CBA_fnc_addWaypoint;


    [_pilot, _group, waypoints _group];
};










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

// keep players from exiting while heli takes off
[KOR_insertHeli_goldwil, true] remoteExecCall ["lock",KOR_insertHeli_goldwil];
[] spawn {
    sleep 15;
    // let people switch seats
    [KOR_insertHeli_goldwil, false] remoteExecCall ["lock",KOR_insertHeli_goldwil];
};


/* ----------------------------------------------------------------------------
    Fastrope
---------------------------------------------------------------------------- */
private _fastrope = {
    private _afterDropCode = {
        ["KOR_insert"] call KISKA_fnc_endTask;

        ["Artillery support now available"] remoteExec ["KISKA_fnc_dataLinkMsg",0];
        ["KOR_120Guided"] call KISKA_fnc_supportManager_addToPool_global;
        ["KOR_230HE"] call KISKA_fnc_supportManager_addToPool_global;
        ["KOR_arsenalDrop"] call KISKA_fnc_supportManager_addToPool_global;

        _this spawn {
            params ["_heli"];

            private _pilot = currentPilot _heli;
            [[_pilot],(getPosATL KOR_insertHeliMovePos)] remoteExec ["doMove",_pilot];

            waitUntil {
                sleep 2;
                _heli distance2D KOR_insertHeliMovePos <= 400;
            };

            deleteVehicleCrew _heli;
            deleteVehicle _heli;
        };
    };

    [
        KOR_insertHeli_goldwil,
        KOR_goldwil_insertBoat,
        (fullCrew [KOR_insertHeli_goldwil,"cargo"]) apply {
            _x select 0
        },
        {},
        28
    ] call KISKA_fnc_ACE_fastRope;
};


/* ----------------------------------------------------------------------------
    Drop off players
---------------------------------------------------------------------------- */
[
    KOR_insertHeli_goldwil,
    KOR_goldwil_insertBoat,
    KOR_goldwil_insertPos,
    _fastrope
] call KISKA_fnc_slingLoad;
