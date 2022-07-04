#include "..\..\Headers\Unit Classes.hpp"
scriptName "KOR_fnc_brienz_dropOffArsenal";


/* ----------------------------------------------------------------------------
    Setup helicopter & crew
---------------------------------------------------------------------------- */
private _heliType = [
    "vtx_MH60S",
    "B_Heli_Transport_01_F"
] select KOR_testing;

private _vehicleInfo = [
    KOR_brienz_arsenalHeliSpawn,
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

private _heliGroup = _vehicleInfo select 2;
[_heliGroup,true] call KISKA_fnc_ACEX_setHCTransfer;
_heliGroup setBehaviour "SAFE";
_heliGroup setCombatMode "BLUE";

_heli setCaptive true;
[_heli, false] remoteExec ["allowDamage", 0, true];
private _crew = _vehicleInfo select 1;
_crew apply {
    [_x, false] remoteExec ["allowDamage", 0, true];
};


[
    _heli,
    KOR_brienz_arsenal,
    KOR_brienz_fastropePos,
    [
        [_heli],
        {
            [_this select 0,_thisArgs select 0] spawn {
                params ["_pilot","_heli"];

                [[_pilot],(getPosATL KOR_deletePos_2)] remoteExec ["doMove",_pilot];

                waitUntil {
                    sleep 2;
                    _heli distance2D KOR_deletePos_2 <= 400;
                };

                deleteVehicleCrew _heli;
                deleteVehicle _heli;
            };
        }
    ]
] call KISKA_fnc_slingLoad;
