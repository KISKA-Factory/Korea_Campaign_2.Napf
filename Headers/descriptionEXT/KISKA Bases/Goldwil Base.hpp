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
            turrets = "";
            dynamicSim = ON;
        };
    };

    class infantry
    {

    };

    class simples
    {

    };

    class patrols
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
    };
};
