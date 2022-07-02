#include "..\..\Unit Classes.hpp"

class BrienzOutpost
{
    side = SIDE_OPFOR;
    infantryClasses[] = {
        ENEMY_INFANTRY_UNIT_CLASSES
    };

    class infantry
    {
        class transmitterBuilding_1
        {
            positions = "Transmitter Building Floor 1 Spawns";
            numberOfUnits = 10;
            unitsPerGroup = 2;

            canPath = ON;
            dynamicSim = ON;
        };
        class transmitterBuilding_2 : transmitterBuilding_1
        {
            positions = "Transmitter Building Floor 2 Spawns";
        };
        class transmitterBuilding_3 : transmitterBuilding_1
        {
            positions = "Transmitter Building Floor 3 Spawns";
        };

        class transmitterOutside
        {
            positions = "Transmitter Outpost Spawns";
            numberOfUnits = 20;
            unitsPerGroup = 5;

            canPath = ON;
            dynamicSim = ON;
        };
    };
};

class brienzMainReinforce
{
    id = "";
    onEnteredCombat = "_this spawn KOR_fnc_brienzMainCombat; true";
};

class BrienzMain
{
    side = SIDE_OPFOR;
    infantryClasses[] = {
        ENEMY_INFANTRY_UNIT_CLASSES
    };

    class turrets
    {
        class GoldwilTurrets
        {
            side = SIDE_OPFOR;
            turrets = "Brienz Main Turrets";
            dynamicSim = ON;

            class reinforce : brienzMainReinforce
            {};
        };
    };


    /* class infantry
    {
        class group_1
        {
            positions = "";
            numberOfUnits = ;
            unitsPerGroup = -1;

            canPath = OFF;
            dynamicSim = ON;

        };
    }; */

    class landVehicles
    {
        class apc_1
        {
            vehicleClass[] = {
                "rhs_btr80a_vv",
                "rhs_btr80_vv",
                "rhs_btr70_vv",
                "rhs_btr60_vv",
                "rhs_brm1k_vv",
                "rhs_bmp2k_vv",
                "rhs_bmp2d_vv",
                "rhs_bmp1p_vv"
            };
            position = "KOR_brienzMain_apc_marker_1";
            dynamicSim = ON;
            canPath = ON;

            crew[] = {
                ENEMEY_ARMOR_CREW_UNIT_CLASS,
                ENEMEY_ARMOR_CREW_UNIT_CLASS,
                ENEMEY_ARMOR_CREW_UNIT_CLASS
            };
            class reinforce : brienzMainReinforce
            {};
        };

        class apc_2 : apc_1
        {
            position = "KOR_brienzMain_apc_marker_2";
        };
        class apc_3 : apc_1
        {
            position = "KOR_brienzMain_apc_marker_3";
        };
        class apc_4 : apc_1
        {
            position = "KOR_brienzMain_apc_marker_4";
        };
        class apc_5 : apc_1
        {
            position = "KOR_brienzMain_apc_marker_5";
        };
        class apc_6 : apc_1
        {
            position = "KOR_brienzMain_apc_marker_6";
        };
    };
};
