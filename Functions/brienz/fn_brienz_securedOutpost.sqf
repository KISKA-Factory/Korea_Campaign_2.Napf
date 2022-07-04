scriptName "KOR_fnc_brienz_securedOutpost";

["Marines will attack Brienz in 2 minutes"] remoteExec ["KISKA_fnc_datalinkMsg",0];

sleep 120;

[] call KOR_fnc_brienz_setupBattle;
