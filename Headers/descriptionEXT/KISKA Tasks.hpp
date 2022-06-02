#define ON 1
#define OFF 0

class KISKA_cfgTasks
{
    class exampleTask_base // class name will become Task Id
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
    };
};
