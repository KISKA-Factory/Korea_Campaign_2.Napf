#define ON 1
#define OFF 0

class KISKA_cfgTasks
{
    /* class exampleTask_base // class name will become Task Id
    {
        title = "My Example Task";
        description = "This is an example";

        parentTask = ""; // Parent Task Id
        type = ""; // task type as defined in CfgTaskTypes

        // params for these are:
        // 0: task id (or class name) (STRING)
        // 1: config path (CONFIG)
        // 2: task state (STRING)
        onComplete = ""; // code that runs upon completion of task when using KISKA_fnc_endTask
        onCreate = ""; // code that runs on creation of task when using KISKA_fnc_createTaskFromConfig

        destination[] = {}; // position of task
        compiledDestination = ""; // uncompiled code that needs to return an object, this will overwrite the destination[] property which will only be used if the object returned is null

        defaultState = ""; // "CREATED", "ASSIGNED", "AUTOASSIGNED" (default), "SUCCEEDED", "FAILED", or "CANCELED"
        priority = -1;
        notifyOnComplete = ON;
        notifyOnCreate = ON;

        visibleIn3D = OFF; // 3d marker creation
    };
    class exampleTask_parent : exampleTask_base
    {
        title = "My Example Task Parent";
        description = "This is an example task parent";

        parentTask = "";
        type = "default";

        onComplete = "hint 'Parent complete'";
        onCreate = "hint 'Parent created'";

        destination[] = {};

        defaultState = "";
        priority = -1;
        notifyOnComplete = ON;
        notifyOnCreate = ON;

        visibleIn3D = OFF;
    };
    class exampleTask_child : exampleTask_base
    {
        title = "My Example Task Child";
        description = "This is an example task child";

        parentTask = "exampleTask_parent";
        type = "Move";

        onComplete = "hint 'Child complete'";
        onCreate = "hint 'Child created'";

        destination[] = {};

        defaultState = "";
        priority = -1;
        notifyOnComplete = ON;
        notifyOnCreate = ON;

        visibleIn3D = OFF;
    }; */



    /* ----------------------------------------------------------------------------
        Goldwil
    ---------------------------------------------------------------------------- */
    class KOR_goldwil
    {
        title = "Goldwil Small Craft Base";
        description = "The KPN has a small craft base located in an isolated outpost on the south side of the island. <br /> The KPN has been using it as a staging point for harrassing attacks on our fleet.";

        type = TASK_TYPE_ATTACK;

        destination[] = {11024.9, 2014.1, 0};

        priority = -1;
        notifyOnCreate = OFF;
        notifyOnComplete = ON;

        visibleIn3D = OFF;
    };

    class KOR_goldwil_clear
    {
        parentTask = "KOR_goldwil";

        title = "Clear Goldwil Outpost";
        description = "Destroy remaining enemies at the outpost";

        type = TASK_TYPE_KILL;

        priority = 1;
        notifyOnCreate = OFF;
        notifyOnComplete = ON;

        visibleIn3D = OFF;
    };
    class KOR_goldwil_destroyBoats
    {
        parentTask = "KOR_goldwil";

        title = "Destroy Naval Assets";
        description = "Destroy watercraft at the base";
        type = TASK_TYPE_DESTROY;

        priority = 2;
        notifyOnCreate = OFF;
        notifyOnComplete = ON;

        destination[] = {11270.5, 1765.01, 0};

        visibleIn3D = ON;
    };
    /* ----------------------------------------------------------------------------
        Goldwil insert
    ---------------------------------------------------------------------------- */
    class KOR_goldwil_insert
    {
        parentTask = "KOR_goldwil";

        title = "Insert Into The AO";
        description = "";

        type = TASK_TYPE_MOVE;

        defaultState = "AUTOASSIGNED";

        notifyOnCreate = ON;
        notifyOnComplete = ON;

        visibleIn3D = OFF;
        destination[] = {};

        priority = 100;
    };
    class KOR_goldwil_insert_boardTheHeli
    {
        parentTask = "KOR_goldwil";

        title = "Board The Helicopter";
        description = "The helicopter will transport your team and the Zodiac to near Goldwil";

        type = TASK_TYPE_GET_IN;

        defaultState = "ASSIGNED";

        notifyOnCreate = ON;
        notifyOnComplete = ON;

        visibleIn3D = ON;
        compiledDestination = "KOR_insertHeli_goldwil";
        priority = 100;
    };
};
