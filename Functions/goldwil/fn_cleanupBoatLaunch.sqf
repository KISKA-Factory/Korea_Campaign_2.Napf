if (isNil "KOR_goldwil_boatLaunchCleanupItems") exitWith {};

KOR_goldwil_boatLaunchCleanupItems apply {
    deleteVehicle _x;
};


nil
