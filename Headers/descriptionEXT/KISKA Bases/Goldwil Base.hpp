#include "..\..\Unit Classes.hpp"

class Goldwil
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
            turrets = "Goldwil Turrets";
            dynamicSim = ON;
        };
    };

    class infantry
    {
        class main
        {
            numberOfUnits = 15;
            unitsPerGroup = -1;

            positions = "Goldwil Main Exterior Spawns";

            dynamicSim = ON;
            canPath = ON;
            ambientAnim = ON;
        };
        class perimeterSouth
        {
            numberOfUnits = -1;
            unitsPerGroup = -1;

            positions = "Goldwil Perimeter Spawn Markers South";
            dynamicSim = ON;
            canPath = ON;
            ambientAnim = ON;
        };
        class perimeterNorth : perimeterSouth
        {
            positions = "Goldwil Perimeter Spawn Markers North";
        };
        class boatLaunchExterior
        {
            numberOfUnits = 10;
            unitsPerGroup = 5;
            positions = "Goldwil Boat Launch Exterior Spawns";

            dynamicSim = ON;
            canPath = ON;
        };
        class docks_1
        {
            numberOfUnits = 9;
            unitsPerGroup = 3;
            positions = "Goldwil Boat Launch Dock Spawns 1";

            dynamicSim = ON;
            canPath = OFF;
        };
        class docks_2 : docks_1
        {
            positions = "Goldwil Boat Launch Dock Spawns 2";
        };
    };

    class simples
    {
        class gaz
        {
            positions = "Goldwil GAZ Markers";
            class tigr1
            {
                type = "rhs_tigr_sts_msv";
            };
            class tigr2
            {
                type = "rhs_tigr_m_msv";
            };
        };

        class trucks
        {
            positions = "Goldwil Truck Markers";
            class ural_ammo
            {
                type = "RHS_Ural_Flat_MSV_01";
                selections[] = {
                    {"clan_sign",1},
                    {"clan",1}
                };
            };
            class ural_troop : ural_ammo
            {
                type = "RHS_Ural_Open_MSV_01";
            };
        };
    };
    /* class patrols
    {
        class patrol_1
        {
            spawnPosition = "";
            numberOfUnits = 5;
            dynamicSim = ON;

            speed = "LIMITED";
            behaviour = "SAFE";
            combatMode = "RED";
            formation = "STAG COLUMN";

            onGroupCreated = "";

            class SpecficPatrol
            {
                patrolPoints = "";
                random = OFF;
                numberOfPoints = -1;
            };
        };
    }; */
};
