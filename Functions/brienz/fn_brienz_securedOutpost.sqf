scriptName "KOR_fnc_brienz_securedOutpost";

["Arsenal is inbound to your position"] remoteExec ["KISKA_fnc_datalinkMsg",0];
["ETA 90 seconds",10] remoteExec ["KISKA_fnc_datalinkMsg",0];
[] spawn KOR_fnc_brienz_dropOffArsenal;
sleep 90;

["Marines will attack Brienz in 2 minutes"] remoteExec ["KISKA_fnc_datalinkMsg",0];
sleep 120;
[] call KOR_fnc_brienz_setupBattle;


nil
