public Plugin:myinfo = 
{
	name        = "Sample Mscript",
	author      = "Bottiger",
	description = "Example mscript",
	version     = "1.0",
	url         = "https://www.skial.com"
};

public void OnPluginStart() 
{
    RegServerCmd("mscript_dostuff", Cmd_DoStuff); // use a point_servercommand to activate this

    HookEvent("teamplay_round_start", OnRoundRestart);
}

// set the health of a boss based on the number of players
public Action Cmd_DoStuff(int args)
{
	int boss = FindEntityByName("targetname_from_hammer");
	
	int players;
	for(int i=1;i<=MaxClients;i++)
	{
		if(IsClientInGame(i) && IsPlayerAlive(i))
		{
			players++;
		}
	}

	SetVariantInt(players * 100);
	AcceptEntityInput(boss, "SetHealth");
}

// hook all zones named "zone_of_death", make them do something special when a player touches it
public Action OnRoundRestart(Handle event, const char[] name, bool dontBroadcast) 
{
    char name[64];
    int zone = MaxClients+1;
    while((zone = FindEntityByClassname(zone, "trigger_multiple")) != -1) 
    {
        GetEntPropString(zone, Prop_Data, "m_iName", name, sizeof(name));
        if(StrEqual(name, "zone_of_death")) 
        {
            SDKHook(zone, SDKHook_StartTouch, OnTouchDeathZone);
        }
    }
}

public Action OnTouchDeathZone(int ent, int other)
{
    if(other > 0 && other <= MaxClients && IsClientInGame(other) && GetClientHealth(other) < 100)
    {
    	TF2_AddCondition(other, TFCond_Kritzkrieged, 5.0);
    }
    return Plugin_Continue;
}


stock int FindEntityByName(char[] targetName, bool networked=true)
{
    int nameLength = strlen(targetName);
    bool wildcard = nameLength > 0 && targetName[nameLength-1] == '*';
    if(wildcard)
    {
        targetName[nameLength-1] = 0;
    }

    int maxEntityIndex = networked ? GetMaxEntities() : GetMaxEntities() * 2;
    for (int ent = MaxClients+1; ent < maxEntityIndex; ent++)
    {
        if (IsValidEntity(ent))
        {
            char name[64];
            GetEntPropString(ent, Prop_Data, "m_iName", name, sizeof(name));

            if((wildcard && strncmp(name, targetName, nameLength-1) == 0) || StrEqual(name, targetName, false))
            {
                return ent;
            }
        }
    }
    return 0;
}