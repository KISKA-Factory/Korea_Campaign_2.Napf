// Side IDs are from BIS_fnc_sideID
#define SIDE_OPFOR 0
#define SIDE_BLUFOR 1
#define SIDE_INDEP 2

#define OFF 0
#define ON 1

class KISKA_Bases
{
    class aBase
    {
        side = SIDE_OPFOR;
        infantryClasses[] = { // these arrays can be weigthed or unweighted
            //"someClass"
        };

        class turrets
        {
            //infantryClasses[] = {};
            class turretSet_1
            {
                //side = SIDE_OPFOR;
                //turrets[] = {}; // fill with variable names of turrets
                turrets = ""; // Searches for mission layer objects
                //infantryClasses[] = {};
                dynamicSim = ON;

                // script that is compiled once and called on each unit after all units are created for this set
                // params: 0: <OBJECT> - the created unit
                onUnitCreated = "";

                // script that is compiled once and called on each unit and turret after the unit has been moved in as gunner
                // params: 0: <OBJECT> - the created unit   1: <OBJECT> - the turret the unit's in
                onUnitMovedInGunner = "";
            };
        };

        class infantry
        {
            //infantryClasses[] = {};
            class infantrySpawnSet_1
            {
                //infantryClasses[] = {};
                // side = SIDE_OPFOR;
                numberOfUnits = -1; // if -1, number of available positions is used this can only max out at the number of available positions
                unitsPerGroup = 1;

                // script that is compiled once and called with all units after all are created
                    // params: 0: <ARRAY> - the created units
                onUnitsCreated = "";

                positions = ""; // will search for objects in mission layer
                //positions[] = {};

                dynamicSim = ON;
                canPath = ON;
            };

        };

        class patrols
        {
            //infantryClasses[] = {};
            class patrol_1
            {
                // side = SIDE_OPFOR;
                //infantryClasses[] = {};
                spawnPosition = ""; // used with object, needs to be object's variable name
                //spawnPosition[] = {}; // position in ATL format
                numberOfUnits = 5;
                // script that is compiled and run on the patrol group after they are spawned and given patrol route
                // params are 0: <GROUP> - the patrol group
                onGroupCreated = "";

                // same as strings for corresponding waypoint commands
                behaviour = "SAFE";
                speed = "LIMITED";
                combatMode = "RED";
                formation = "STAG COLUMN";
                dynamicSim = ON;

                // SpecificPatrol will be used over RandomPatrol. Remove it if using RandomPatrol
            /*
                class SpecificPatrol
                {
                    patrolPoints = ""; // used with mission layer
                    //patrolPoints[] = {};
                    random = 1; // patrol randomly around the points or in order defined
                    numberOfPoints = -1; // patrol every provided positon if -1
                };
            */

                class RandomPatrol // uses CBA_fnc_taskPatrol
                {
                    //center[] = {}; // leave empty or remove to patrol around spawnPosition
                    numberOfPoints = 3; // number of waypoints
                    radius = 500; // max radius waypoints will be created around the area
                    waypointType = "MOVE";
                };

            };

        };

        class simples
        {
            followTerrain = 1;  // follow terrain when placed
            superSimple = 1; // use super simple objects

            class someClass
            {
                followTerrain = 1;  // overrides default setting above for this class
                superSimple = 1; // overrides default setting above for this class
                objectClasses[] = {

                };

                //positions = ""; // use with mission layer objects
                positions[] = { // expects positionWorld positions

                };
            };
        };
    };
};
