scriptName "KOR_fnc_brienz_securedOutpost"


["Artillery support now available"] remoteExec ["KISKA_fnc_dataLinkMsg",0];
["KOR_120Guided"] call KISKA_fnc_supportManager_addToPool_global;
["KOR_230HE"] call KISKA_fnc_supportManager_addToPool_global;
["KOR_arsenalDrop"] call KISKA_fnc_supportManager_addToPool_global;
