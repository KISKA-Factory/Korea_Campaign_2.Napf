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
        class checkpoint
        {
            numberOfUnits = 16;
            unitsPerGroup = 8;
            canPath = ON;

            positions = "Goldwil Checkpoint Spawns";
            dynamicSim = ON;
            ambientAnim = ON;
        };
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
        class boatLaunchInterior : boatLaunchExterior
        {
            positions = "Goldwil Boat Launch Ineterior Spawns";
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
    class patrols
    {
        class patrol_1
        {
            spawnPosition = "KOR_goldwil_patrolSpawn_1";
            numberOfUnits = 7;
            dynamicSim = ON;

            speed = "LIMITED";
            behaviour = "SAFE";
            combatMode = "RED";
            formation = "STAG COLUMN";

            onGroupCreated = "";

            class SpecificPatrol
            {
                patrolPoints = "Goldwil Patrol Markers 1";
                random = OFF;
                numberOfPoints = -1;
            };
        };
        class patrol_2 : patrol_1
        {
            spawnPosition = "KOR_goldwil_patrolSpawn_2";
            class SpecificPatrol : SpecificPatrol
            {
                patrolPoints = "Goldwil Patrol Markers 2";
            };
        };
    };
};
