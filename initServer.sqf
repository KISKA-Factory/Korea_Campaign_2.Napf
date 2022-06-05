["KOR_goldwil"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_clear"] call KISKA_fnc_createTaskFromConfig;
["KOR_goldwil_destroyBoats"] call KISKA_fnc_createTaskFromConfig;


[
    ["Goldwil Boats"] call KISKA_fnc_getMissionLayerObjects,
    "KOR_goldwil_destroyBoats"
] call KISKA_fnc_setupKillTask;

["Goldwil"] call KISKA_fnc_createBaseFromConfig;
