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
            postions = "Transmitter Outpost Spawns";
            numberOfUnits = 20;
            unitsPerGroup = 5;

            canPath = ON;
            dynamicSim = ON;
        };
    };
};
