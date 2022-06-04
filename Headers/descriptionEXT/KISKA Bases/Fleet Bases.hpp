class freedomFlightDeck
{
    class simples
    {
        class blackWasps
        {
            positions = "Freedom Black Wasp Markers";
            class unarmed
            {
                type = "B_Plane_Fighter_01_Stealth_F";
                followTerrain = 0;
                offset[] = {0,0,2.3};
                /* vectorUp[] = {-0.000532132,0.0165445,0.999863}; */
                animations[] = {
                    {"wing_fold_l",1},
                    {"wing_fold_cover_l",1},
                    {"wing_fold_cover_r",1},
                    {"wing_fold_r",1},
                    {"canopy_open",15}
                };
            };
            class armed : unarmed
            {
                type = "B_Plane_Fighter_01_F";
            };
        };
        class f35Freedom : F35
        {
            positions = "Freedom F35 Markers";

        };
    };
};

class lhdFlightDeck
{
    class simples
    {
        class f35LHD : F35
        {
            positions = "LHD f35 Markers";

        };
    };
};
