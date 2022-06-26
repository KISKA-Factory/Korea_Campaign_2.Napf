#include "..\..\Headers\Unit Classes.hpp"

scriptName "KOR_fnc_setupClassEventHandler";

if (KOR_testing) exitWith {};

private _enemyClasses = [
    "O_T_Soldier_GL_F",
    "O_T_Soldier_AT_F",
    "O_T_Soldier_A_F",
    "O_T_Soldier_AHAT_F",
    "O_T_Soldier_AAA_F",
    "O_T_Soldier_AAT_F",
    "O_T_Soldier_AR_F",
    "O_T_Medic_F",
    "O_T_Crew_F",
    "O_T_Engineer_F",
    "O_T_Soldier_Exp_F",
    "O_T_Helicrew_F",
    "O_T_Helipilot_F",
    "O_T_Soldier_M_F",
    "O_T_soldier_mine_F",
    "O_T_Soldier_AA_F",
    "O_T_Pilot_F",
    "O_T_Soldier_Repair_F",
    "O_T_Soldier_LAT_F",
    "O_T_Soldier_HAT_F",
    "O_T_Soldier_unarmed_F",
    "O_T_Soldier_TL_F",
    "O_T_Soldier_SL_F",
    "O_T_Soldier_F",
    "O_T_Soldier_AAR_F"
];


private _spawnCode = {
    params ["_unit"];

    [
        configFile >> "KISKA_loadouts" >> "KISKA_loadouts_koreaSummer_night",
        _unit
    ] spawn KISKA_fnc_assignUnitLoadout;
};

_enemyClasses apply {
    [_x, "init", _spawnCode] call CBA_fnc_addClassEventHandler;
};


nil
