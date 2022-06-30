// Side IDs are from BIS_fnc_sideID
#define SIDE_OPFOR 0
#define SIDE_BLUFOR 1
#define SIDE_INDEP 2


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

class KISKA_Bases
{
    #include "Goldwil Base.hpp"
    #include "Fleet Bases.hpp"
    #include "Brienz Bases.hpp"

};
