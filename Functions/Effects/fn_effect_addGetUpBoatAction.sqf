scriptName "KOR_fnc_effect_addGetUpBoatAction";

if (!hasInterface) exitWith {};

private _getOntoBoatActionID = [
    KOR_socBoat_teleport,
    10,
    [
        "Get Onto Boat",
        {player setPosASL (getPosASL KOR_socBoat_teleport)},
        [],
        10,
        true,
        true,
        "",
        "((getPosASL player) select 2) < -1"
    ]
] call KISKA_fnc_addProximityPlayerAction;

localNamespace setVariable ["KOR_getOntoBoatActionId", _getOntoBoatActionID];
