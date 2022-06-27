#include "..\..\Headers\Player Radius Defines.hpp"

scriptName "KOR_fnc_setupGoldwilBoatLaunch";


KOR_goldwil_boatLaunchCleanupItems = [];
private _simpleBoat = [KOR_socBoat] call BIS_fnc_replaceWithSimpleObject;
KOR_goldwil_boatLaunchCleanupItems pushBack _simpleBoat;


private _chemlightPositions = ["Golwil Insert Boat Chemlight Positions"] call KISKA_fnc_getMissionLayerObjects;
_chemlightPositions apply {
    private _chemlight = createvehicle ["Chemlight_green_infinite", _x,[],0,"NONE"];
    _chemlight setPosASL (getPosASL _x);
    KOR_goldwil_boatLaunchCleanupItems pushBack _chemlight;
};

private _swccTypes = ["rhsusf_socom_swcc_officer", "rhsusf_socom_swcc_crewman"];
private _swccSpawns = ["Goldwil Boat Launch SWCC Spawns"] call KISKA_fnc_getMissionLayerObjects;
_swccSpawns apply {
    private _agent = createAgent [selectRandom _swccTypes, _x, [], 0, "NONE"];
    _agent setPosASL (getPosASL _x);
    _agent setDir (getDir _x);
    KOR_goldwil_boatLaunchCleanupItems pushBack _agent;
    sleep 1;
    [_agent,"STAND","ASIS"] call BIS_fnc_ambientAnim;
};


waitUntil {
    sleep 5;
    CONDITION_PLAYER_WITHIN_RADIUS_2D(KOR_goldwilMarker,1100);
};

[] call KOR_fnc_cleanupBoatLaunch;


nil
