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
        class GoldwilPerimeterSouth
        {
            numberOfUnits = -1;
            unitsPerGroup = -1;

            positions = "Goldwil Perimeter Spawn Markers South";
            dynamicSim = ON;
            canPath = ON;
            ambientAnim = ON;
        };
        class GoldwilPerimeterNorth : GoldwilPerimeterSouth
        {
            positions = "Goldwil Perimeter Spawn Markers North";
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
