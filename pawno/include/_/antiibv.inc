/*
Anti car spammer by RogueDrifter 2018/1/30 
(Will auto respawn the spammed cars after the callback)
===Usables====
-Number of cars a player can stream in- 
#define ACS_MAX_STREAMIN [number]

-Public function called when a player exceeds maximum vehicles streamed in- 
OnPlayerSpamCars(playerid, number);
*/

#if defined ACS_Included
	#endinput
#endif

#define ACS_Included

#include <a_samp> 

#if !defined IsValidVehicle
	native IsValidVehicle(vehicleid);
#endif

#if !defined ACS_MAX_STREAMIN
	#define  ACS_MAX_STREAMIN 100
#endif

#if defined acs_OnPlayerConnect
	forward acs_OnPlayerConnect(playerid);
#endif

#if defined acs_OnPlayerDisconnect
	forward acs_OnPlayerDisconnect(playerid, reason);
#endif

#if defined acs_OnVehicleStreamIn
	forward acs_OnVehicleStreamIn(vehicleid, forplayerid);
#endif

#if defined acs_OnVehicleStreamOut
	forward acs_OnVehicleStreamOut(vehicleid, forplayerid);
#endif

new 
	AcsCheckTimer[MAX_PLAYERS] ;
new
    AcsStreamForP[MAX_VEHICLES];
new 
	AcsStreamedIn[MAX_PLAYERS] ;

stock acs_GetPlayerSpeed(playerid)
{
    new Float:ST[4];

    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);

    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
    return floatround(ST[3]);
}

stock acs_IsAPlane(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 464: return 1; 
        case 548, 425, 417, 487, 488, 497, 563, 447, 469, 465, 501: return 1;
    }
    return 0;
}

forward acs_SpamCheck(playerid);

public acs_SpamCheck(playerid)
{
 	if(AcsStreamedIn[playerid] >= ACS_MAX_STREAMIN)
    {
        if(acs_GetPlayerSpeed(playerid) >=50 && acs_IsAPlane(GetPlayerVehicleID(playerid))) return 0;
        if(acs_GetPlayerSpeed(playerid) >= 100) return 0;

        for(new v; v < MAX_VEHICLES; v++)
        {
            if(!IsValidVehicle(v) || AcsStreamForP[v] != playerid) continue;
            SetVehicleToRespawn(v);
            }

        #if defined OnPlayerSpamCars
        OnPlayerSpamCars(playerid, AcsStreamedIn[playerid]);
        #endif
        }

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	KillTimer(AcsCheckTimer[playerid]);

		#if defined acs_OnPlayerDisconnect
	return acs_OnPlayerDisconnect(playerid, reason);
		#else
	return 1;
		#endif
}

public OnPlayerConnect(playerid)
{
    AcsStreamedIn[playerid]	= 0;
    AcsCheckTimer[playerid] = SetTimerEx("acs_SpamCheck", 2000, true, "i", playerid);

		#if defined acs_OnPlayerConnect
    return acs_OnPlayerConnect(playerid);
    	#else
    return 1;
    	#endif
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
    AcsStreamForP[vehicleid] = forplayerid;
    AcsStreamedIn[forplayerid]			 ++;

        #if defined acs_OnVehicleStreamIn
    return  acs_OnVehicleStreamIn(vehicleid, forplayerid);
        #else
    return 1;
        #endif
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
    AcsStreamForP[vehicleid] = -1;
    AcsStreamedIn[forplayerid]	--;

        #if defined acs_OnVehicleStreamOut
    return  acs_OnVehicleStreamOut(vehicleid, forplayerid);
        #else
    return 1;
        #endif
}

#if defined OnPlayerSpamCars
	forward OnPlayerSpamCars(playerid, number);
#endif

#if defined _ALS_OnPlayerConnect
  #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif

#if defined _ALS_OnPlayerDisconnect
  #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif

#if defined _ALS_OnVehicleStreamIn
  #undef OnVehicleStreamIn
#else
    #define _ALS_OnVehicleStreamIn
#endif

#if defined _ALS_OnVehicleStreamOut
  #undef OnVehicleStreamOut
#else
    #define _ALS_OnVehicleStreamOut
#endif

#define OnPlayerConnect    acs_OnPlayerConnect
#define OnPlayerDisconnect acs_OnPlayerDisconnect

#define OnVehicleStreamIn  acs_OnVehicleStreamIn
#define OnVehicleStreamOut acs_OnVehicleStreamOut