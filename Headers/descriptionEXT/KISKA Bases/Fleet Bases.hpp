class F35
{
    positions = "";
    class stealth
    {
        type = "CUP_B_F35B_Stealth_USMC";
        followTerrain = 0;
        offset[] = {0,0,2.4};
        animations[] = {
            {"canopy_elevator",15},
            {"exhausts_side",-1},
            {"exhaust_base",-1},
            {"hatch_eng_b_1_1",-1},
            {"hatch_eng_b_1_2",-1},
            {"hatch_eng_t_1",-1},
            {"hatch_eng_t_2_1",-1},
            {"hatch_eng_t_2_2",-1},
            {"hatch_eng_b_3_1",-1},
            {"hatch_eng_b_3_2",-1},
            {"heat_shield_left",0},
            {"heat_shield_right",0}
        };
        selections[] = {
            {"zasleh",1},
            {"clan_sign",1},
            {"clan",1}
        };
    };
    class nonstealth : stealth
    {
        type = "CUP_B_F35B_USMC";
    };
};

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
