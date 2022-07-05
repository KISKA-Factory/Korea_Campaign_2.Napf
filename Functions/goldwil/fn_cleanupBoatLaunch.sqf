if (isNil "KOR_goldwil_boatLaunchCleanupItems") exitWith {};

[] remoteExec ["KOR_fnc_effect_removeGetUpBoatAction",0,true];

KOR_goldwil_boatLaunchCleanupItems apply {
    deleteVehicle _x;
};


nil
