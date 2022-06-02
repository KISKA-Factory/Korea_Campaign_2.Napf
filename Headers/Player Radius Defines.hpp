#define CONDITION_PLAYER_WITHIN_RADIUS_3D(pos,radius) !(((call CBA_fnc_players) findIf {(_x distance pos) <= radius}) isEqualTo -1)
#define CONDITION_PLAYER_WITHIN_RADIUS_2D(pos,radius) !(((call CBA_fnc_players) findIf {(_x distance2d pos) <= radius}) isEqualTo -1)

#define CONDITION_NO_PLAYER_WITHIN_RADIUS_3D(pos,radius) !(((call CBA_fnc_players) findIf {(_x distance pos) >= radius}) isEqualTo -1)
#define CONDITION_NO_PLAYER_WITHIN_RADIUS_2D(pos,radius) !(((call CBA_fnc_players) findIf {(_x distance2d pos) >= radius}) isEqualTo -1)
