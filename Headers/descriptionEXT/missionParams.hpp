#define OFF_OR_ON {"OFF","ON"}
#define NO_OR_YES {"NO","YES"}
#define ZERO_OR_ONE {0,1}

#define A_SECTION_HEADER(NAME)\
	class NAME##_LABEL \
	{ \
		title = ======= ##NAME## Settings =======; \
		values[] = {0}; \
		texts[] = {""}; \
		default = 0; \
	};
#define A_SPACE(NAME)\
	class NAME##_SPACE \
	{ \
		title = " "; \
		values[] = {0}; \
		texts[] = {""}; \
		default = 0; \
	};

//__EXEC(_savedParams = [profileNamespace getVariable "BLWK_savedMissionParameters",createHashMap] select call compile "profileNamespace getVariable ['BLWK_savedMissionParameters',[]] isEqualType []");
#define GET_DEFAULT_PARAM(NAME,DEFAULT_VALUE) default = __EVAL(_savedParams getOrDefault [#NAME,DEFAULT_VALUE]);

//A_SECTION_HEADER(NAME);
//A_SPACE(NAME);
