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

            class reinforce
            {
                id = "Goldwil_checkpoint";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_patrolNorth",
                    "Goldwil_perimeterNorth"
                };
            };
        };
        class mainExterior
        {
            numberOfUnits = 15;
            unitsPerGroup = -1;

            positions = "Goldwil Main Exterior Spawns";

            dynamicSim = ON;
            canPath = ON;
            ambientAnim = ON;

            class reinforce
            {
                id = "Goldwil_main";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_checkpoint",
                    "Goldwil_patrolNorth",
                    "Goldwil_patrolSouth",
                    "Goldwil_perimeterSouth",
                    "Goldwil_perimeterNorth"
                };
                priority = 2;
            };
        };
        class perimeterSouth
        {
            numberOfUnits = -1;
            unitsPerGroup = -1;

            positions = "Goldwil Perimeter Spawn Markers South";
            dynamicSim = ON;
            canPath = ON;
            ambientAnim = ON;

            class reinforce
            {
                id = "Goldwil_perimeterSouth";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_main",
                    "Goldwil_patrolSouth"
                };

            };
        };
        class perimeterNorth : perimeterSouth
        {
            positions = "Goldwil Perimeter Spawn Markers North";

            class reinforce
            {
                id = "Goldwil_perimeterNorth";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_patrolNorth",
                    "Goldwil_checkpoint"
                };
            };
        };
        class boatLaunchExterior
        {
            numberOfUnits = 10;
            unitsPerGroup = 5;
            positions = "Goldwil Boat Launch Exterior Spawns";

            dynamicSim = ON;
            canPath = ON;

            class reinforce
            {
                id = "Goldwil_boatLaunchExterior";
                canCall[] = {
                    "Goldwil_main",
                    "Goldwil_patrolNorth",
                    "Goldwil_perimeterSouth",
                    "Goldwil_patrolSouth"
                };
                onEnteredCombat = "_this spawn KOR_response; true";
                priority = 5;
            };
        };
        class boatLaunchInterior : boatLaunchExterior
        {
            positions = "Goldwil Boat Launch Ineterior Spawns";
            class reinforce
            {
                id = "Goldwil_boatLaunchInterior";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_main",
                    "Goldwil_patrolNorth",
                    "Goldwil_perimeterSouth",
                    "Goldwil_patrolSouth"
                };
            };
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
        class patrolNorth
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
                patrolPoints = "Goldwil Patrol Markers North";
                onEnteredCombat = "_this spawn KOR_response; true";
                random = OFF;
                numberOfPoints = -1;
            };

            class reinforce
            {
                id = "Goldwil_patrolNorth";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_main",
                    "Goldwil_perimeterNorth"
                };
            };
        };
        class patrolSourth : patrolNorth
        {
            spawnPosition = "KOR_goldwil_patrolSpawn_2";
            class SpecificPatrol : SpecificPatrol
            {
                patrolPoints = "Goldwil Patrol Markers South";
            };

            class reinforce
            {
                id = "Goldwil_patrolSouth";
                onEnteredCombat = "_this spawn KOR_response; true";
                canCall[] = {
                    "Goldwil_main",
                    "Goldwil_perimeterSouth"
                };
            };
        };
    };
};
