
if (!hasInterface) exitWith {};

KOR_goldwil_insertSub addAction [
    "Open Extra Sub Storage",
    {
        player action ["Gear",KOR_hiddenSubBox];
    },
    [],
    10,
    true,
    true,
    "",
    "!(player in KOR_goldwil_insertSub) AND {!(((getPosASL player) select 2) < -1)}",
    5
];
