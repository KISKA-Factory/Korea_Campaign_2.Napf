#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_brienz_airAssault";

missionNamespace setVariable ["KOR_brienz_airAssaultCalled",true];


private _spawnPositions = ["Brienz Air Assault Spawns"] call KISKA_fnc_getMissionlayerObjects;
private _landingPositions = ["Brienz Air Assult LZs"] call KISKA_fnc_getMissionlayerObjects;


{

    private _heliInfo = [
        _x,
        -1,
        KOREAN_LIGHT_HELI_CLASS,
        OPFOR,
        false,
        [ENEMEY_HELI_PILOT_UNIT_CLASS]
    ] call KISKA_fnc_spawnVehicle;

    private _group = [
        6,
        [ ENEMY_INFANTRY_UNIT_CLASSES ],
        OPFOR,
        _x,
        false
    ] call KISKA_fnc_spawnGroup;

    private _infantryUnits = units _group;
    [
        _infantryUnits,
        "#" + (KISKA_multiKillEventMap_brienzInfantry get "id")
    ] call KISKA_fnc_setupMultiKillEvent;

    private _heli = _heliInfo select 0;
    _infantryUnits apply {
        _x moveInCargo _heli;
    };

    private _stalkingPlayers = _forEachIndex > 2;

    private _landFunction = [[_group, _infantryUnits, _stalkingPlayers],{
        _this spawn {
            params ["_heli"];

            private _pilot = currentPilot _heli;
            waitUntil {
                if (!(alive _heli) OR !(alive _pilot)) exitWith {
                    _heli setDamage 1;
                    true
                };

                if (count (crew _heli) isEqualTo 1) exitWith {
                    [[_pilot],(getPosATL KOR_deletePos_enemy)] remoteExec ["doMove",_pilot];

                    waitUntil {
                        sleep 2;
                        _heli distance2D KOR_deletePos_enemy <= 400;
                    };

                    deleteVehicleCrew _heli;
                    deleteVehicle _heli;
                    true
                };

                sleep 2;
                false
            };

        };


        _thisArgs params ["_infantryGroup", "_infantryUnits","_stalkingPlayers"];
        [_infantryGroup, true] remoteExec ["enableDynamicSimulation",0,true];

        params ["_heli"];
        _infantryGroup leaveVehicle _heli;

        _infantryUnits apply {
            moveOut _x;
        };

        if !(_stalkingPlayers) then {
            [_infantryGroup, [14609.6,2950.91,0], 25] call KISKA_fnc_attack;

        } else {
            private _nearestPlayer = objNull;
            private _nearestDistance = -1;
            private _infantryLeader = leader _infantryGroup;
            (call CBA_fnc_players) apply {
                private _distance = _x distance _infantryLeader;
                if ((_nearestDistance isEqualTo -1) OR (_distance < _nearestDistance)) then {
                    _nearestPlayer = _x;
                    _nearestDistance = _distance;
                };
            };
            [_infantryGroup, _nearestPlayer] call KISKA_fnc_stalk;

        };
    }];

    [
        _heli,
        _landingPositions select _forEachIndex,
        "GET OUT",
        true,
        _landFunction
    ] call KISKA_fnc_heliLand;
} forEach _spawnPositions;


["CCM_AV_ColdWaters"] remoteExec ["KISKA_fnc_playMusic",[0,-2] select isDedicated];

nil
