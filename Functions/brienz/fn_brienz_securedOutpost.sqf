scriptName "KOR_fnc_brienz_securedOutpost";

["Arsenal is inbound to the building rooftop"] remoteExec ["KISKA_fnc_datalinkMsg",0];
["ETA 2 Minutes",10] remoteExec ["KISKA_fnc_datalinkMsg",0];
[] spawn KOR_fnc_brienz_dropOffArsenal;
sleep 120;

["Marines will attack Brienz in 3 minutes"] remoteExec ["KISKA_fnc_datalinkMsg",0];
sleep 180;
["KOR_CAS"] call KISKA_fnc_supportManager_addToPool_global;
["KOR_CAS"] call KISKA_fnc_supportManager_addToPool_global;
["KOR_CAS"] call KISKA_fnc_supportManager_addToPool_global;
["KOR_CAS"] call KISKA_fnc_supportManager_addToPool_global;
["CAS is now available"] remoteExec ["KISKA_fnc_datalinkMsg", 0];
[] call KOR_fnc_brienz_setupBattle;


nil
