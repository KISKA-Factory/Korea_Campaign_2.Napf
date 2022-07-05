scriptName "KOR_fnc_effect_removeGetUpBoatAction";

if (!hasInterface) exitWith {};

private _actionId = localNamespace getVariable ["KOR_getOntoBoatActionId", -1];

if (_actionId isNotEqualTo -1) then {
    [_actionId] call KISKA_fnc_removeProximityPlayerAction;
};


nil
