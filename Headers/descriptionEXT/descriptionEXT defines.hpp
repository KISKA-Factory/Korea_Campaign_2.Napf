/* ----------------------------------------------------------------------------
	Corpse & Wreck Manager Modes
---------------------------------------------------------------------------- */
#define CW_MANAGER_MODE_NONE 0
#define CW_MANAGER_MODE_ALL 1
#define CW_MANAGER_MODE_ONLY_RESPAWNED 2
#define CW_MANAGER_MODE_ALL_BUT_RESPAWNED 3

/* ----------------------------------------------------------------------------
	Debug Console Settings
---------------------------------------------------------------------------- */
#define ENABLE_DEBUG_CONSOLE_EDITOR 0
#define ENABLE_DEBUG_CONSOLE_ADMIN_HOSTS 1
#define ENABLE_DEBUG_CONSOLE_ALL 2

/* ----------------------------------------------------------------------------
	Game Types
---------------------------------------------------------------------------- */
#define GAME_TYPE_UNKNOWN Unknown
#define GAME_TYPE_DEATHMATCH DM
#define GAME_TYPE_CAPTURE_THE_FLAG CTF
#define GAME_TYPE_COOP Coop
#define GAME_TYPE_CAPTURE_THE_ISLAND CTI
#define GAME_TYPE_SECTOR_CONTROL SC
#define GAME_TYPE_TEAM_DEATHMATCH TDM
#define GAME_TYPE_ROLE_PLAY RPG
#define GAME_TYPE_SANDBOX Sandbox
#define GAME_TYPE_KING_OF_THE_HILL KOTH
#define GAME_TYPE_LAST_MAN_STANDING LastMan
#define GAME_TYPE_SURVIVAL Survive
#define GAME_TYPE_ZEUS Zeus
#define GAME_TYPE_SUPPORT Support
#define GAME_TYPE_END_GAME EndGame
#define GAME_TYPE_APEX Apex
#define GAME_TYPE_ESCAPE Escape
#define GAME_TYPE_COMBAT_PATROL Patrol
#define GAME_TYPE_VANGUARD Vanguard
#define GAME_TYPE_WARLORDS Warlords

/* ----------------------------------------------------------------------------
	Respawn Types
---------------------------------------------------------------------------- */
#define RESPAWN_TYPE_NONE 0
#define RESPAWN_TYPE_BIRD 1
#define RESPAWN_TYPE_INSTANT 2
#define RESPAWN_TYPE_BASE 3
#define RESPAWN_TYPE_GROUP 4
#define RESPAWN_TYPE_SIDE 5

/* ----------------------------------------------------------------------------
	Respawn Templates
---------------------------------------------------------------------------- */
#define RESPAWN_TEMPLATE_NONE "None"
#define RESPAWN_TEMPLATE_SPECTATOR "Spectator"
#define RESPAWN_TEMPLATE_INSTANT "Instant"
#define RESPAWN_TEMPLATE_BASE "Base"
#define RESPAWN_TEMPLATE_GROUP "Group"
#define RESPAWN_TEMPLATE_SIDE "Side"
#define RESPAWN_TEMPLATE_SEAGULL "Seagull"
#define RESPAWN_TEMPLATE_WAVE "Wave"
#define RESPAWN_TEMPLATE_TICKETS "Tickets"
#define RESPAWN_TEMPLATE_COUNTER "Counter"
#define RESPAWN_TEMPLATE_END_MISSION "EndMission"
#define RESPAWN_TEMPLATE_MENU_POSITION "MenuPosition"
#define RESPAWN_TEMPLATE_MENU_INVENTORY "MenuInventory"

/* ----------------------------------------------------------------------------
	respawnOnStart Modes
---------------------------------------------------------------------------- */
// players do not respawn on mission start and onPlayerRespawn is NOT run
#define RESPAWN_ON_START_NONE -1
// players do NOT respawn on mission start but onPlayerRespawn IS run at start
#define RESPAWN_ON_START_NONE_RUN_SCRIPT 0
// players do respawn on mission start and onPlayerRespawn is run
#define RESPAWN_ON_START_RUN_SCRIPT 1

/* ----------------------------------------------------------------------------
	Misc
---------------------------------------------------------------------------- */
#define OFF 0
#define ON 1

/* ----------------------------------------------------------------------------
	Task Types
---------------------------------------------------------------------------- */
// Action task types
#define TASK_TYPE_ATTACK "attack"
#define TASK_TYPE_DANGER "danger"
#define TASK_TYPE_DEFAULT "default"
#define TASK_TYPE_DEFEND "defend"
#define TASK_TYPE_DESTROY "destroy"
#define TASK_TYPE_DOWNLOAD "download"
#define TASK_TYPE_EXIT "exit"
#define TASK_TYPE_GET_IN "getin"
#define TASK_TYPE_GET_OUT "getout"
#define TASK_TYPE_HEAL "heal"
#define TASK_TYPE_INTERACT "interact"
#define TASK_TYPE_KILL "kill"
#define TASK_TYPE_LAND "land"
#define TASK_TYPE_LISTEN "listen"
#define TASK_TYPE_MEET "meet"
#define TASK_TYPE_MOVE "move"
#define TASK_TYPE_MOVE1 "move1"
#define TASK_TYPE_MOVE2 "move2"
#define TASK_TYPE_MOVE3 "move3"
#define TASK_TYPE_MOVE4 "move4"
#define TASK_TYPE_MOVE5 "move5"
#define TASK_TYPE_NAVIGATE "navigate"
#define TASK_TYPE_REARM "rearm"
#define TASK_TYPE_REFUEL "refuel"
#define TASK_TYPE_REPAIR "repair"
#define TASK_TYPE_RUN "run"
#define TASK_TYPE_SCOUT "scout"
#define TASK_TYPE_SEARCH "search"
#define TASK_TYPE_TAKEOFF "takeoff"
#define TASK_TYPE_TALK "talk"
#define TASK_TYPE_TALK1 "talk1"
#define TASK_TYPE_TALK2 "talk2"
#define TASK_TYPE_TALK3 "talk3"
#define TASK_TYPE_TALK4 "talk4"
#define TASK_TYPE_TALK5 "talk5"
#define TASK_TYPE_TARGET "target"
#define TASK_TYPE_UPLOAD "upload"
#define TASK_TYPE_USE "use"
#define TASK_TYPE_WAIT "wait"
#define TASK_TYPE_WALK "walk"

// Object task Types

#define TASK_TYPE_ARMOR "armor"
#define TASK_TYPE_BACKPACK "backpack"
#define TASK_TYPE_BOAT "boat"
#define TASK_TYPE_BOX "box"
#define TASK_TYPE_CAR "car"
#define TASK_TYPE_CONTAINER "container"
#define TASK_TYPE_DOCUMENTS "documents"
#define TASK_TYPE_HELI "heli"
#define TASK_TYPE_INTEL "intel"
#define TASK_TYPE_MAP "map"
#define TASK_TYPE_MINE "mine"
#define TASK_TYPE_PLANE "plane"
#define TASK_TYPE_RADIO "radio"
#define TASK_TYPE_RIFLE "rifle"
#define TASK_TYPE_WHITEBOARD "whiteboard"
