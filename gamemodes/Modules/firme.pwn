#include <YSI\y_hooks>

#define MAX_FIRMI 100
enum Firme
{
    fSQLID,
    fImaVlasnika,
    fVlasnik[MAX_PLAYER_NAME],
    fVrsta,
    fNaziv[64],
    fIznuda[64],
    Float:fUlazX,
    Float:fUlazY,
    Float:fUlazZ,
    Float:fIzlazX,
    Float:fIzlazY,
    Float:fIzlazZ,
    fNeaktivnost,
    fLevel,
    fCena,
    fKasa,
    fInt,
    fZatvoreno,
    fProizvodi,
    fMaxProizvodi,
    fVW
};
new FirmaInfo[MAX_FIRMI][Firme];
new UsaoFirma[MAX_PLAYERS];
new FirmaPickup[sizeof(FirmaInfo)];
new Text3D:FirmaLabel[sizeof(FirmaInfo)];
/////////////////////////////////////////////////
hook OnGameModeInit()
{
    // =============================== [ ucitaj firme ] ============================= //
    mysql_tquery(SQL, "SELECT * FROM `firme` ORDER BY `fSQLID` ASC", "_SQLLoadFirme", "");
    Y_HOOKS_CONTINUE_RETURN_1
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if( newkeys == KEY_SECONDARY_ATTACK )
    {
        for(new i; i < MAX_FIRMI; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, FirmaInfo[i][fUlazX], FirmaInfo[i][fUlazY], FirmaInfo[i][fUlazZ]) && !IsPlayerInAnyVehicle(playerid))
            {
                if(FirmaInfo[i][fVrsta] == VRSTA_SBIZZ) return SCM(playerid,-1,""VARADERO"[V:RPG] "SIVA"Ne mozete uci u tu firmu!");
                if(FirmaInfo[i][fZatvoreno] == 1) return GameTextForPlayer(playerid,"~w~Firma ~b~zakljucana",5000,3);
                SetPlayerVirtualWorld(playerid, FirmaInfo[i][fVW]);
                SetPlayerInterior(playerid, FirmaInfo[i][fInt]);
                SetPlayerPos(playerid, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]);
                UsaoFirma[playerid] = i;
                if(FirmaInfo[i][fVrsta] == VRSTA_SEXSHOP) GameTextForPlayer(playerid,"~w~Usli ste u sex shop~n~~r~/kupi",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_RESTORAN) GameTextForPlayer(playerid,"~w~Usli ste u restoran~n~~b~/meni",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_BURG) GameTextForPlayer(playerid,"~w~Usli ste u burg~n~~b~/meni",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_CLUCKIN) GameTextForPlayer(playerid,"~w~Usli ste u cluckin~n~~b~/meni",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_PIZZA) GameTextForPlayer(playerid,"~w~Usli ste u piceriju~n~~b~/meni",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_DISCO) GameTextForPlayer(playerid,"~w~Usli ste u disco~n~~b~/pice",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_BAR) GameTextForPlayer(playerid,"~w~Usli ste u bar~n~~b~/pice",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_PIGPEN) GameTextForPlayer(playerid,"~w~Usli ste u pig pen~n~~b~/pice",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_GYM) GameTextForPlayer(playerid,"~w~Usli ste u teretanu~n~~b~/teretana",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_BARBER) GameTextForPlayer(playerid,"~w~Usli ste u frizerski salon~n~~b~/frizura",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_BINCO) GameTextForPlayer(playerid,"~w~Usli ste u binco butik~n~~b~/odeca",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_VICTIM) GameTextForPlayer(playerid,"~w~Usli ste u victim butik~n~~b~/odeca",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_SUBURBAN) GameTextForPlayer(playerid,"~w~Usli ste u suburban butik~n~~b~/odeca",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_ZIP) GameTextForPlayer(playerid,"~w~Usli ste u zip butik~n~~b~/odeca",5000,3);
                else if(FirmaInfo[i][fVrsta] == VRSTA_KLADIONICA) GameTextForPlayer(playerid,"~w~Usli ste u kladionicu~n~~w~za kupovinu listica ~r~/kupi",5000,3);
                return 1;
            }
            if(IsPlayerInRangeOfPoint(playerid, 3.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ])
            && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW] && !IsPlayerInAnyVehicle(playerid))
            {
                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 0);
                SetPlayerPos(playerid, FirmaInfo[i][fUlazX], FirmaInfo[i][fUlazY], FirmaInfo[i][fUlazZ]);
                TogglePlayerControllable(playerid, 0);
                g_freeze[playerid] =  SetTimerEx("Freeze",3000, false, "i", playerid);
                UsaoFirma[playerid] = -1;
                return 1;
            }
        }
    }
    Y_HOOKS_CONTINUE_RETURN_1
}


function: _sqlDeleteFirma(playerid, firmaid)
{

    new rows;
    cache_get_row_count(rows);
    if(!rows) return SendClientMessage(playerid, -1, "ID te firme nije pronadjen u bazi!");
    else 
    {
        new q[64];
        mysql_format( SQL, q, sizeof(q), "DELETE FROM `firme` WHERE `fSQLID` = '%d'", firmaid);
        mysql_tquery(SQL, q);
        va_SendClientMessage(playerid, -1, "Obrisali ste firmu id: %d", firmaid);
        va_SendClientMessageToAll(-1 , "Administrator: %s je obrisao Firmu ID: (%d).", GetName(playerid), firmaid);
    }
    return 1;
}

function: _SQLLoadFirme()
{
    if(cache_num_rows()) 
    {
        for(new i; i < cache_num_rows(); i++)
        {
            cache_get_value_name_int(i,"ID", FirmaInfo[i][fSQLID]);
            cache_get_value_name_int(i,"ImaVlasnika", FirmaInfo[i][fImaVlasnika]);
            cache_get_value_name(i, "Vlasnik",FirmaInfo[i][fVlasnik],32);
            cache_get_value_name_int(i,"Vrsta", FirmaInfo[i][fVrsta]);
            cache_get_value_name(i, "Naziv",FirmaInfo[i][fNaziv],64);
            cache_get_value_name(i, "Iznuda",FirmaInfo[i][fIznuda],64); 
            cache_get_value_name_float(i, "UlazX",FirmaInfo[i][fUlazX]);
            cache_get_value_name_float(i, "UlazY",FirmaInfo[i][fUlazY]);
            cache_get_value_name_float(i, "UlazZ",FirmaInfo[i][fUlazZ]);
            cache_get_value_name_float(i, "IzlazX",FirmaInfo[i][fIzlazX]);
            cache_get_value_name_float(i, "IzlazY",FirmaInfo[i][fIzlazY]);
            cache_get_value_name_float(i, "IzlazZ",FirmaInfo[i][fIzlazZ]);
            cache_get_value_name_int(i,"Neaktivnost",FirmaInfo[i][fNeaktivnost]);
            cache_get_value_name_int(i,"Level",FirmaInfo[i][fLevel]);
            cache_get_value_name_int(i,"Cena",FirmaInfo[i][fCena]);
            cache_get_value_name_int(i,"Kasa",FirmaInfo[i][fKasa]);
            cache_get_value_name_int(i,"Int",FirmaInfo[i][fInt]);
            cache_get_value_name_int(i,"Zatvoreno",FirmaInfo[i][fZatvoreno]);
            cache_get_value_name_int(i,"Proizvodi",FirmaInfo[i][fProizvodi]);
            cache_get_value_name_int(i,"MaxProizvodi",FirmaInfo[i][fMaxProizvodi]);
            cache_get_value_name_int(i,"VW",FirmaInfo[i][fVW]);

            new stringgg[255];
            new b = i;
            
            if(FirmaInfo[b][fImaVlasnika] == 0)
            {
                format(stringgg,sizeof(stringgg),"[{FFFFFF} %s {1A80D2}]\nFirma na prodaju!({FFFFFF}%d{1A80D2})\n{1A80D2}Cena :{FFFFFF} $%d{1A80D2} | Level :{FFFFFF} %d\n{1A80D2}Za kupovinu upisite {FFFFFF}/kupifirmu",FirmaInfo[b][fNaziv], b, FirmaInfo[b][fCena],FirmaInfo[b][fLevel]);
                FirmaLabel[b] = CreateDynamic3DTextLabel(stringgg, 0x33CCFFFF, FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 25, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
                FirmaPickup[b] = CreateDynamicPickup(1274, 1, FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ]);
            }
            else if(FirmaInfo[b][fImaVlasnika] == 1)
            {
                format(stringgg,sizeof(stringgg),"[{FFFFFF} %s {1A80D2}]\nVlasnik :{FFFFFF} %s\n{1A80D2}Level:{FFFFFF} %d{1A80D2} | ID:{FFFFFF} %d\n{1A80D2}Neaktivnost : {FFFFFF}%d h", FirmaInfo[b][fNaziv], FirmaInfo[b][fVlasnik],FirmaInfo[b][fLevel], b, FirmaInfo[b][fNeaktivnost]);
                FirmaLabel[b] = CreateDynamic3DTextLabel(stringgg, 0x33CCFFFF, FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 25, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 20.0);
                FirmaPickup[b] = CreateDynamicPickup(1239, 1, FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ]);
            }
            if(FirmaInfo[b][fVrsta] == VRSTA_BURG)      CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 10, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_CLUCKIN)   CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 14, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_PIZZA)     CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 29, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_PIGPEN)    CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 48, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_BAR)       CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 49, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_GYM)       CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 54, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_SEXSHOP)   CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 36, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_BINCO)     CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 45, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_GUNSHOP)   CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 6, -1, 0, 0, -1,  150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_DISCO)     CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 48, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_RESTORAN)  CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 50, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_ZIP)       CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 45, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_VICTIM)    CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 45, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_SUBURBAN)  CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 45, -1, 0, 0, -1, 150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_BARBER)    CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 7, -1, 0, 0, -1,  150.0);
            if(FirmaInfo[b][fVrsta] == VRSTA_KLADIONICA)CreateDynamicMapIcon(FirmaInfo[b][fUlazX], FirmaInfo[b][fUlazY], FirmaInfo[b][fUlazZ], 25, -1, 0, 0, -1, 150.0);
        }
        printf("[ Sistem ] Firme: Uctano je %d firmi, vreme: (%dms)", cache_num_rows(), cache_get_query_exec_time(MILLISECONDS));
    }           
    return 1;
}

SacuvajFirmu(idfirme)
{
    new q[301];
    mysql_format(SQL, q, sizeof(q), "UPDATE `firme` SET `ImaVlasnika` = '%d', `Vlasnik` = '%s', `Vrsta` = '%d', `Naziv` = '%s', `Iznuda` = '%s' WHERE `fSQLID` = '%d' LIMIT 1",
    FirmaInfo[idfirme][fImaVlasnika],
    FirmaInfo[idfirme][fVlasnik],
    FirmaInfo[idfirme][fVrsta],
    FirmaInfo[idfirme][fNaziv],
    FirmaInfo[idfirme][fIznuda],

    FirmaInfo[idfirme][fSQLID]);
    mysql_tquery(SQL, q);

    mysql_format(SQL, q, sizeof(q), "UPDATE `firme` SET `UlazX`  = '%f', `UlazY` = '%f', `UlazZ` = '%f', `IzlazX` = '%f', `IzlazY` = '%f', `IzlazZ` = '%f' WHERE `fSQLID` = '%d' LIMIT 1",
    FirmaInfo[idfirme][fUlazX],
    FirmaInfo[idfirme][fUlazY],
    FirmaInfo[idfirme][fUlazZ],
    FirmaInfo[idfirme][fIzlazX],
    FirmaInfo[idfirme][fIzlazY],
    FirmaInfo[idfirme][fIzlazZ],

    FirmaInfo[idfirme][fSQLID]);
    mysql_tquery(SQL, q);

    mysql_format(SQL, q, sizeof(q), "UPDATE `firme` SET `Neaktivnost`  = '%d', `Level` = '%d', `Cena` = '%d', `Kasa` = '%d', `Int` = '%d', `Zatvoreno` = '%d', `Proizvodi` = '%d', `MaxProizvodi` = '%d'. `VW` = '%d' WHERE `fSQLID` = '%d' LIMIT 1",
    FirmaInfo[idfirme][fNeaktivnost],
    FirmaInfo[idfirme][fLevel],
    FirmaInfo[idfirme][fCena],
    FirmaInfo[idfirme][fKasa],
    FirmaInfo[idfirme][fInt],
    FirmaInfo[idfirme][fZatvoreno],
    FirmaInfo[idfirme][fProizvodi],
    FirmaInfo[idfirme][fMaxProizvodi],
    FirmaInfo[idfirme][fVW],

    FirmaInfo[idfirme][fSQLID]);
    mysql_tquery(SQL, q);

    return 1;
}


forward DodajNeaktivnostFirmi();
public DodajNeaktivnostFirmi()
{
    for(new fID = 0; fID < sizeof(FirmaInfo); fID++)
    {
        if(FirmaInfo[fID][fImaVlasnika] == 1)
        {
            if(!IsPlayerConnected(GetPlayerID(FirmaInfo[fID][fVlasnik])))
            {
                FirmaInfo[fID][fNeaktivnost] += 1;
                Firme_Neaktivnost(fID);
                SacuvajFirmu(fID);
            }
            else
            {
                FirmaInfo[fID][fNeaktivnost] = 0;
                Firme_Neaktivnost(fID);
                SacuvajFirmu(fID);
            }
            if(FirmaInfo[fID][fNeaktivnost] > 500)
            {
                FirmaInfo[fID][fImaVlasnika] = 0;
                FirmaInfo[fID][fKasa] = 0;
                FirmaInfo[fID][fZatvoreno] = 1;
                FirmaInfo[fID][fNeaktivnost] = 0;
                strmid(FirmaInfo[fID][fIznuda],"Niko",0,strlen("Niko"),255);
                strmid(FirmaInfo[fID][fVlasnik], "Niko", 0, strlen("Niko"), 255);
                FirmaLabelIPickup(fID);
                SacuvajFirmu(fID);
                new stringgger[256];
                format(stringgger, 128, "[ Nekretnine ]{FFFFFF} Trenutno je na raspolaganju nova firma na adresi %s %d, po ceni od %d$!", fID, UlicaFirme(fID), FirmaInfo[fID][fCena]);
                SCMTA(SVETLOPLAVA, stringgger);
            }
        }
    }
    return 1;
}


CMD:kreirajfirmu(playerid, params[])
{
    //#pragma unused help
    //if(PlayerInfo[playerid][pSuspendovan] == 1) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "BELA"VI STE SUSSPENDOVANI VAMA SU KOMANDE ZABRANJENE ");
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Vlasnik!");
	if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
    new vrsta,cena,lvl, firmaid; 
    
    if(sscanf(params, "iii", vrsta, lvl , cena))
	{
    	SCM(playerid, -1, "[V:RPG] Pomoc | "SPLAVA"/kreirajfirmu [id] [vrsta] [level] [cena]");
    	SCM(playerid, -1, "Vrste Firmi | "SPLAVA"0: Market | 1: Market | 2: Burg");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"3: Cluckin Bell | 4: Pizza | 5: Pig Pen");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"6: Bar | 7: Gym | 8: Sex Shop | 9: Binco");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"10: Gun Shop | 11: Disco | 12: Restoran");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"13: Zip | 14: Victim | 15: Suburban");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"16: Night Club | 17: Elite Restoran | 18: Gun Shop 2");
        SCM(playerid, -1, "Vrste Firmi | "SPLAVA"19: Barber | 20: Kladionica | 21: S biznis");
    	return 1;
	}
	if(firmaid >= MAX_FIRMI) return SCM(playerid,-1, ""SRWBOJA"[ Varadero ] "SIVA"Dostigli ste maksimalan broj firmi, laku noc i dobro vece!");
	
	new q[128];
	mysql_format(SQL, q, sizeof q, "INSERT INTO `firme` SET `Vrsta` = '%d', `Level` = '%d', `Cena` = '%d'",	vrsta,lvl,cena);		
	mysql_tquery(SQL, q, "_sqlInsertFirma", "ddddd", firmaid, playerid, vrsta, lvl, cena);
	
	return 1;
}

function: _sqlInsertFirma(firmaid, playerid, vrsta, lvl, cena)
{
	FirmaInfo[ firmaid ][ fSQLID ] = cache_insert_id();
	firmaid = FirmaInfo[ firmaid ][ fSQLID ];
	new string[500];
	GetPlayerPos(playerid, X,Y,Z);
	if(vrsta == 0) // MARKET 1
	{
        FirmaInfo[firmaid][fIzlazX] = -25.132600; FirmaInfo[firmaid][fIzlazY] = -139.067001;
    	FirmaInfo[firmaid][fIzlazZ] = 1003.546875; FirmaInfo[firmaid][fInt] = 16;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_MARKET;
    	strmid(FirmaInfo[firmaid][fNaziv],"Market 24/7",0,strlen("Market 24/7"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 1) // MARKET 2
	{
        FirmaInfo[firmaid][fIzlazX] = -27.312299; FirmaInfo[firmaid][fIzlazY] = -29.277599;
    	FirmaInfo[firmaid][fIzlazZ] = 1003.557250; FirmaInfo[firmaid][fInt] = 4;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_MARKET;
    	strmid(FirmaInfo[firmaid][fNaziv],"Market 24/7",0,strlen("Market 24/7"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 2) // BURG
	{
        FirmaInfo[firmaid][fIzlazX] = -27.312299; FirmaInfo[firmaid][fIzlazY] = -72.6414;
    	FirmaInfo[firmaid][fIzlazZ] = 1001.5078; FirmaInfo[firmaid][fInt] = 10;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_BURG;
    	strmid(FirmaInfo[firmaid][fNaziv],"Burg",0,strlen("Burg"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
   	}
	else if(vrsta == 3) // Cluckin
	{
        FirmaInfo[firmaid][fIzlazX] = 366.0316; FirmaInfo[firmaid][fIzlazY] = -9.169898;
    	FirmaInfo[firmaid][fIzlazZ] = 1001.851623; FirmaInfo[firmaid][fInt] = 9;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_CLUCKIN;
    	strmid(FirmaInfo[firmaid][fNaziv],"Cluckin Bell",0,strlen("Cluckin Bell"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 4) // Pizza
	{
        FirmaInfo[firmaid][fIzlazX] = 372.411712; FirmaInfo[firmaid][fIzlazY] = -130.457702;
    	FirmaInfo[firmaid][fIzlazZ] = 1001.492187; FirmaInfo[firmaid][fInt] = 5;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_PIZZA;
    	strmid(FirmaInfo[firmaid][fNaziv],"Pizza",0,strlen("Pizza"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 5) // Pig Pen
	{
        FirmaInfo[firmaid][fIzlazX] = 1204.846191; FirmaInfo[firmaid][fIzlazY] = -13.852100;
    	FirmaInfo[firmaid][fIzlazZ] = 1000.921875; FirmaInfo[firmaid][fInt] = 2;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_PIGPEN;
    	strmid(FirmaInfo[firmaid][fNaziv],"Pig Pen",0,strlen("Pig Pen"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 6) // Bar
	{
        FirmaInfo[firmaid][fIzlazX] = 501.870788; FirmaInfo[firmaid][fIzlazY] = -67.582000;
    	FirmaInfo[firmaid][fIzlazZ] = 998.757812; FirmaInfo[firmaid][fInt] = 11;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_BAR;
    	strmid(FirmaInfo[firmaid][fNaziv],"Bar",0,strlen("Bar"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 7) // Gym
	{
        FirmaInfo[firmaid][fIzlazX] = 772.359375; FirmaInfo[firmaid][fIzlazY] = -5.515697;
    	FirmaInfo[firmaid][fIzlazZ] = 1000.728576; FirmaInfo[firmaid][fInt] = 5;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_GYM;
    	strmid(FirmaInfo[firmaid][fNaziv],"Gym",0,strlen("Gym"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 8) // Sex Shop
	{
        FirmaInfo[firmaid][fIzlazX] = -100.295700; FirmaInfo[firmaid][fIzlazY] = -24.654399;
    	FirmaInfo[firmaid][fIzlazZ] = 1000.718811; FirmaInfo[firmaid][fInt] = 3;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_SEXSHOP;
    	strmid(FirmaInfo[firmaid][fNaziv],"Sex Shop",0,strlen("Sex Shop"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 9) // Binco
	{
        FirmaInfo[firmaid][fIzlazX] = 207.766204; FirmaInfo[firmaid][fIzlazY] = -111.266296;
    	FirmaInfo[firmaid][fIzlazZ] = 1005.132812; FirmaInfo[firmaid][fInt] = 15;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_BINCO;
    	strmid(FirmaInfo[firmaid][fNaziv],"Binco",0,strlen("Binco"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
    else if(vrsta == 10) // Gun Shop
	{
        FirmaInfo[firmaid][fIzlazX] = 315.762786; FirmaInfo[firmaid][fIzlazY] = -143.661193;
    	FirmaInfo[firmaid][fIzlazZ] = 999.601623; FirmaInfo[firmaid][fInt] = 7;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_GUNSHOP;
    	strmid(FirmaInfo[firmaid][fNaziv],"Gun Shop",0,strlen("Gun Shop"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 11) // Disco
	{
        FirmaInfo[firmaid][fIzlazX] = 493.439300; FirmaInfo[firmaid][fIzlazY] = -24.916900;
    	FirmaInfo[firmaid][fIzlazZ] = 1000.671875; FirmaInfo[firmaid][fInt] = 17;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_DISCO;
    	strmid(FirmaInfo[firmaid][fNaziv],"Disco",0,strlen("Disco"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 12) // Restoran
	{
        FirmaInfo[firmaid][fIzlazX] = 460.265411; FirmaInfo[firmaid][fIzlazY] = -88.611503;
    	FirmaInfo[firmaid][fIzlazZ] = 999.554687; FirmaInfo[firmaid][fInt] = 4;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_RESTORAN;
    	strmid(FirmaInfo[firmaid][fNaziv],"Restoran",0,strlen("Restoran"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 13) // ZIP
	{
        FirmaInfo[firmaid][fIzlazX] = 161.410293; FirmaInfo[firmaid][fIzlazY] = -96.687202;
    	FirmaInfo[firmaid][fIzlazZ] = 1001.804687; FirmaInfo[firmaid][fInt] = 18;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_ZIP;
    	strmid(FirmaInfo[firmaid][fNaziv],"Zip",0,strlen("Zip"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 14) // Victim
	{
        FirmaInfo[firmaid][fIzlazX] = 227.342803; FirmaInfo[firmaid][fIzlazY] = -8.243800;
    	FirmaInfo[firmaid][fIzlazZ] = 1002.210876; FirmaInfo[firmaid][fInt] = 5;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_VICTIM;
    	strmid(FirmaInfo[firmaid][fNaziv],"Victim",0,strlen("Victim"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 15) // Suburban
	{
        FirmaInfo[firmaid][fIzlazX] = 203.895294; FirmaInfo[firmaid][fIzlazY] = -50.656700;
    	FirmaInfo[firmaid][fIzlazZ] = 1001.804687; FirmaInfo[firmaid][fInt] = 1;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_SUBURBAN;
    	strmid(FirmaInfo[firmaid][fNaziv],"Suburban",0,strlen("Suburban"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 16) // night club
	{
        FirmaInfo[firmaid][fIzlazX] = -2636.5781; FirmaInfo[firmaid][fIzlazY] = 1402.7936;
    	FirmaInfo[firmaid][fIzlazZ] = 906.4609; FirmaInfo[firmaid][fInt] = 3;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_DISCO;
    	strmid(FirmaInfo[firmaid][fNaziv],"Night Club",0,strlen("Night Club"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 17) // Elite Restoran
	{
        FirmaInfo[firmaid][fIzlazX] = -794.9584; FirmaInfo[firmaid][fIzlazY] = 490.1105;
    	FirmaInfo[firmaid][fIzlazZ] = 1376.1953; FirmaInfo[firmaid][fInt] = 1;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_RESTORAN;
    	strmid(FirmaInfo[firmaid][fNaziv],"Elite Restoran",0,strlen("Elite Restoran"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
    else if(vrsta == 18) // Gun Shop 2
	{
        FirmaInfo[firmaid][fIzlazX] = 316.524993; FirmaInfo[firmaid][fIzlazY] = -167.706985;
    	FirmaInfo[firmaid][fIzlazZ] = 999.593750; FirmaInfo[firmaid][fInt] = 6;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_GUNSHOP;
    	strmid(FirmaInfo[firmaid][fNaziv],"Gun Shop",0,strlen("Gun Shop"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
    else if(vrsta == 19) // Barber
	{
        FirmaInfo[firmaid][fIzlazX] = 418.652984; FirmaInfo[firmaid][fIzlazY] = -82.639793;
       	FirmaInfo[firmaid][fIzlazZ] = 1001.804687; FirmaInfo[firmaid][fInt] = 3;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_BARBER;
    	strmid(FirmaInfo[firmaid][fNaziv],"Barber",0,strlen("Barber"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 20) // Kladionica
	{
        FirmaInfo[firmaid][fIzlazX] = 833.8954;
		FirmaInfo[firmaid][fIzlazY] = 7.4047;
    	FirmaInfo[firmaid][fIzlazZ] = 1004.1797;
		FirmaInfo[firmaid][fInt] = 3;
    	FirmaInfo[firmaid][fCena] = cena;
		FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_KLADIONICA;
    	strmid(FirmaInfo[firmaid][fNaziv],"Kladionica",0,strlen("Kladionica"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
	}
	else if(vrsta == 21) // S biznisi
	{
	    FirmaInfo[firmaid][fIzlazX] = 0.0; FirmaInfo[firmaid][fIzlazY] = 0.0;
    	FirmaInfo[firmaid][fIzlazZ] = 0.0; FirmaInfo[firmaid][fInt] = 0;
    	FirmaInfo[firmaid][fCena] = cena; FirmaInfo[firmaid][fLevel] = lvl;
    	FirmaInfo[firmaid][fVrsta] = VRSTA_SBIZZ;
    	strmid(FirmaInfo[firmaid][fNaziv],"Preimenovati",0,strlen("Preimenovati"),255);
    	strmid(FirmaInfo[firmaid][fIznuda],"Niko",0,strlen("Niko"),255);
    }
    FirmaInfo[firmaid][fUlazX] = X; 
    FirmaInfo[firmaid][fUlazY] = Y; 
    FirmaInfo[firmaid][fUlazZ] = Z;
    FirmaInfo[firmaid][fImaVlasnika] = 0; 
    FirmaInfo[firmaid][fZatvoreno] = 1;
    FirmaInfo[firmaid][fVW] = firmaid; 
    FirmaInfo[firmaid][fKasa] = 0;
    FirmaInfo[firmaid][fProizvodi] = 300; 
    FirmaInfo[firmaid][fMaxProizvodi] = 300;
    strmid(FirmaInfo[firmaid][fVlasnik],"Niko",0,strlen("Niko"),255);
    format(string,sizeof(string),""ZPLAVA"[ "BELA"%s "ZPLAVA"]\n"ZPLAVA"Firma na prodaju!\n"ZPLAVA"Cena: "BELA"%d$\n"ZPLAVA"Level: "BELA"%d\n"ZPLAVA"Za kupovinu /kupifirmu",FirmaInfo[firmaid][fNaziv],FirmaInfo[firmaid][fCena],FirmaInfo[firmaid][fLevel]);
    FirmaLabel[firmaid] = CreateDynamic3DTextLabel(string ,0x33CCFFAA,X,Y,Z,25, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 7.0);
    FirmaPickup[firmaid] = CreateDynamicPickup(1274, 1, FirmaInfo[firmaid][fUlazX], FirmaInfo[firmaid][fUlazY], FirmaInfo[firmaid][fUlazZ]);
    format(string,sizeof(string),"[V:RPG] | "CRVENA"Firma Kreiran (Ovo je firma ID: %d)!",firmaid);
	SCM(playerid,-1,string);
	FirmaLabelIPickup(firmaid); 
	SacuvajFirmu(firmaid);


	va_SendClientMessage(playerid, -1, "Kreirali ste firmu ID: %d", FirmaInfo[ firmaid ][ fSQLID ]);
	return 1;
}

///////////////////////////////////////////////////////////////
CMD:izbrisifirmu(playerid, params[])
{
    new targetid;    
    if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Samo Vlasnik!");
    if(sscanf(params,"i",targetid)) return SCM(playerid,-1,""SIVA"USE: "BELA"/izbrisifirmu [ID]");
    
    new q[58+24+1];
    mysql_format( SQL, q, sizeof(q), "SELECT * FROM `firme` where `fSQLID` = '%d'", targetid);
    mysql_tquery( SQL, q, "_sqlDeleteFirma", "ii", playerid, targetid);
    DestroyDynamic3DTextLabel(FirmaLabel[targetid]);
    DestroyDynamicPickup(FirmaPickup[targetid]);        
    return 1;
}

CMD:premjestifirmu(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Vlasnik!");
    if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
    new idfirme; GetPlayerPos(playerid,X,Y,Z);
    if(sscanf(params, "i",idfirme))
    {
        SCM(playerid,-1,""SRWBOJA"[V:RPG] Pomoc | "SIVA"/premjestifirmu [ID]");
        return 1;
    }
    FirmaInfo[idfirme][fUlazX] = X;
    FirmaInfo[idfirme][fUlazY] = Y;
    FirmaInfo[idfirme][fUlazZ] = Z;
    SacuvajFirmu(idfirme);
    FirmaLabelIPickup(idfirme);
    SCM(playerid,-1,""SRWBOJA"[V:RPG] Pomoc | "SIVA"Uspesno ste Premestili Firmu!");
    return 1;
}

CMD:portfirma(playerid, params[])
{
    //if(PlayerInfo[playerid][pSuspendovan] == 1) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "BELA"VI STE SUSSPENDOVANI VAMA SU KOMANDE ZABRANJENE ");
	if(PlayerInfo[playerid][pAdmin] < 3) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Admini (AL 3+)!");
    if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
	new id;
	if(sscanf(params,"i",id)) return SCM(playerid,-1,"[V:RPG] "VARADERO"/portfirma [ID]");

	SendClientMessage(playerid, -1, "Ukoliko ste portovani na farmu, firma ne postoji, jebiga mrzi me da radim proveru voli vas bunta <3");
    SetPlayerPos(playerid,FirmaInfo[id][fUlazX], FirmaInfo[id][fUlazY], FirmaInfo[id][fUlazZ]);
    SetPlayerInterior(playerid,0); 
    SetPlayerVirtualWorld(playerid,0);
	return 1;
}
//////////////////////////////////////////////////////////////
CMD:efirmu(playerid, params[])
{

	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Vlasnik!");
    if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
	new i = -1;
	new string[128];
	for(new x; x < MAX_FIRMI; x++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, FirmaInfo[x][fUlazX], FirmaInfo[x][fUlazY], FirmaInfo[x][fUlazZ]))
		{
			i = x;
			IzmenaFirme[playerid] = x;
			break;
		}
	}
	if(i == -1) return SCM(playerid, -1, ""SRWBOJA"[ Varadero ] "SIVA"Niste kod firme!");
	new akcija[16];
	if(sscanf(params, "s[32]", akcija))
    {
		SCM(playerid,-1,"Firme | "SPLAVA"/efirmu | Prodaj | Info | Otkljucaj");
		SCM(playerid,-1,"Firme | "SPLAVA"/efirma2 za editovanje ostalog!");
		return 1;
	}
	if(!strcmp(akcija, "prodaj", true))
	{
		if(FirmaInfo[i][fImaVlasnika] == 0) return SCM(playerid,-1, ""SRWBOJA"[ Varadero ] "SIVA"Ne mozete prodati firmu jer ta firma nema vlasnika!");
		FirmaInfo[i][fImaVlasnika] = 0;
		FirmaInfo[i][fKasa] = 0;
		FirmaInfo[i][fZatvoreno] = 1;
		strmid(FirmaInfo[i][fVlasnik], "Niko", 0, strlen("Niko"), 255);
		strmid(FirmaInfo[i][fIznuda], "Niko", 0, strlen("Niko"), 255);
		PlayerInfo[playerid][pPosedovanjeFirme] = -1;
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Prodali ste firmu ID: %d!", i); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
	}
	else if(!strcmp(akcija, "info", true))
	{
		new z[3];
		if(FirmaInfo[i][fZatvoreno] == 1) z = "Da";
		else z = "Ne";
		format(string, charsmax(string), "- Vlasnik: %s | Reket: %s | Naziv: %s | Level: %d | Zakljucano: %s", FirmaInfo[i][fVlasnik], FirmaInfo[i][fIznuda],FirmaInfo[i][fNaziv],FirmaInfo[i][fLevel],z); //conver
		SCM(playerid,-1, string);
		format(string, charsmax(string), "- Cena: %d$ | ID: %d | Kasa: %d$ | Proizvodi: %d/%d", FirmaInfo[i][fCena], i, FirmaInfo[i][fKasa], FirmaInfo[i][fProizvodi], FirmaInfo[i][fMaxProizvodi]); //conver
		SCM(playerid,-1, string);
		IzmenaFirme[playerid] = -1;
	}
	else if(!strcmp(akcija, "otkljucaj", true))
	{
		FirmaInfo[i][fZatvoreno] = 0;
		SCM(playerid,-1,""SIVA"Firma je otkljucana!");
	}
	else return SCM(playerid, -1, ""SRWBOJA"[ Varadero ] "SIVA"Netacno uneseno radnja editovanja!");
	return 1;
}
///////////////////////////////////////////////////////////////
CMD:efirmu2(playerid, params[])
{
    //if(PlayerInfo[playerid][pSuspendovan] == 1) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "BELA"VI STE SUSSPENDOVANI VAMA SU KOMANDE ZABRANJENE ");
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Vlasnik!");
    if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
	new i = -1;
	new string[128];
	for(new x; x < MAX_FIRMI; x++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, FirmaInfo[x][fUlazX], FirmaInfo[x][fUlazY], FirmaInfo[x][fUlazZ]))
		{
			i = x;
			IzmenaFirme[playerid] = x;
			break;
		}
	}
	if(i == -1) return SCM(playerid, -1, ""SRWBOJA"[ Varadero ] "SIVA"Niste kod firme!");
	new akcija[16],radnja;
	if(sscanf(params, "s[32]d", akcija,radnja))
    {
		SCM(playerid,-1,"Firme | "SPLAVA"/efirmu2 | Level | Cena | Reket ID: 0 | Kasa | Proizvodi");
		SCM(playerid,-1,"Firme | "SPLAVA"/efirma za editovanje ostalog!");
		return 1;
	}
	if(!strcmp(akcija, "level", true))
	{
        if(radnja < 0 || radnja > 10000000) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Mora biti ispod 10000000!");
        FirmaInfo[IzmenaFirme[playerid]][fLevel] = radnja;
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Izmenili ste level firme id: %d u %d!", i, radnja); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
	}
	else if(!strcmp(akcija, "cena", true))
	{
        if(radnja < 0 || radnja > 10000000) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Mora biti ispod 10000000!");
        FirmaInfo[IzmenaFirme[playerid]][fCena] = radnja;
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Izmenili ste cenu firme id: %d u %d!", i, radnja); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
	}
	else if(!strcmp(akcija, "reket", true))
	{
        if(radnja < 0 || radnja > 10000000) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Mora biti ispod 10000000!");
    	if(radnja == 0)
    	{
        strmid(FirmaInfo[IzmenaFirme[playerid]][fIznuda], "Niko", 0, strlen("Niko"), 255);
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Skinuli ste reket firme id %d!", i); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
		}
	}
	else if(!strcmp(akcija, "kasa", true))
	{
	    if(PlayerInfo[playerid][pAdmin] != 8) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Samo Vlasnik!");
        if(radnja < 0 || radnja > 10000000) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Mora biti ispod 10000000!");
        FirmaInfo[IzmenaFirme[playerid]][fKasa] = radnja;
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Izmenili ste kasu firme id: %d u %d!", i, radnja); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
	}
	else if(!strcmp(akcija, "proizvodi", true))
	{
        if(radnja < 0 || radnja > 10000000) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Mora biti ispod 10000000!");
        FirmaInfo[IzmenaFirme[playerid]][fProizvodi] = radnja;
		FirmaLabelIPickup(i);
		SacuvajFirmu(i);
		format(string, charsmax(string), ""SIVA"[V:RPG] "SIVA"Izmenili ste proizvode firme id: %d u %d!", i, radnja); //conver
		SCM(playerid, -1, string);
		IzmenaFirme[playerid] = -1;
	}
	else return SCM(playerid, -1, ""SRWBOJA"[ Varadero ] "SIVA"Netacno uneseno radnja editovanja!");
	return 1;
}
/////////////////////////////////////////////////////////////
CMD:kupifirmu(playerid, params[])
{
	for(new i; i < sizeof(FirmaInfo); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, FirmaInfo[i][fUlazX], FirmaInfo[i][fUlazY], FirmaInfo[i][fUlazZ]))
		{
			if(!strcmp(FirmaInfo[i][fVlasnik], "Niko", true) && FirmaInfo[i][fImaVlasnika] == 0)
			{
				if(PlayerInfo[playerid][pLevel] < FirmaInfo[i][fLevel]) {
					new string[128];
					format(string, charsmax(string), ""SRWBOJA"[GRESKA]: "SIVA"Treba vam %d level za ovu firmu!", FirmaInfo[i][fLevel]); //conver
					return SCM(playerid,-1, string);
				}
				if(PlayerInfo[playerid][pPosedovanjeFirme] != -1) return SCM(playerid,-1, ""SRWBOJA"[GRESKA] "SIVA"Vec imas firmu!!");
				if(PlayerInfo[playerid][pNovacDzep] < FirmaInfo[i][fCena]) return SCM(playerid,-1, ""SRWBOJA"[GRESKA] "SIVA"Nemas dovoljno novca za ovo firmu!");
				strmid(FirmaInfo[i][fVlasnik], GetName(playerid), 0, strlen(GetName(playerid)), 255);
				FirmaInfo[i][fImaVlasnika] = 1;
				PlayerInfo[playerid][pPosedovanjeFirme] = i;
				FirmaInfo[i][fZatvoreno] = 0;
				SCM(playerid,-1, ""SPLAVA"[V:RPG] "SIVA"Cestitamo, kupili ste firmu!");
				SCM(playerid,-1, ""SPLAVA"[V:RPG] "SIVA"Za komande firme koristite /firma!");
				g_NovacMinus(playerid, FirmaInfo[i][fCena]);
				strmid(FirmaInfo[i][fIznuda],"Niko",0,strlen("Niko"),255);
				UsaoFirma[playerid] = i;
				FirmaLabelIPickup(i);
				SacuvajFirmu(i);
				return 1;
			}
			else return SCM(playerid, -1, ""SRWBOJA"[GRESKA]: "SIVA"Ta firma se ne prodaje!!");
		}
	}
	return 1;
}
// PLAYER CMDS
////////////////////////////////////////////////////////////
CMD:firma(playerid, params[])
{

    if(PlayerInfo[playerid][pPosedovanjeFirme] == -1) return SCM(playerid,-1, ""SRWBOJA"[V:RPG] "SIVA"Nemate firmu!");
    new imedas[MAX_PLAYER_NAME];
	GetPlayerName(playerid, imedas, sizeof(imedas));
	if(strcmp(FirmaInfo[PlayerInfo[playerid][pPosedovanjeFirme]][fVlasnik], imedas, true)) return SCM(playerid,-1, ""SRWBOJA"[GRESKA]: "SIVA"Niste vlasnik te firme!");
    SPD(playerid, 74, DIALOG_STYLE_LIST, ""SPLAVA"Firma Opcije", "[1]-Informacije\n[2]-Otkljucaj Firmu\n[3]-Zakljucaj Firmu\n[4]-Podigni Novac\n[5]-Ostavi Novac\n[6]-Naruci Proizvode\n[7]-Promeni Ime\n[8]-Prodaj Firmu Drzavi\n[9]-Postavi Iznudu\n[10]- Skini Iznudu\n[11]-Prodaj firmu igracu", "Odaberi", "Nazad");
	return 1;
}

CMD:kupi(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 25.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]) && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW])
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_MARKET)
            {
                x++;
                if( UsaoFirma[playerid] == -1 ) return SCM( playerid,-1,""ZPLAVA"[Firma]: "BELA"Morate biti u firmi!");
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new string1[275], string2[275] , string[550];
                format(string1,sizeof(string1),""SRWBOJA"- "BELA"Mobilni Telefon (150$)\n"SRWBOJA"- "BELA"Imenik (50$)\n"SRWBOJA"- "BELA"Cigare (20$)\n"SRWBOJA"- "BELA"Upaljac (10$)\n"SRWBOJA"- "BELA"Dopuna od 100$\n"SRWBOJA"- "BELA"GPS 10000$\n"SRWBOJA"- "BELA"Kanap (350$)\n");
                format(string2,sizeof(string2),""SRWBOJA"- "BELA"Naocare (300$)\n"SRWBOJA"- "BELA"Povez (100$)\n"SRWBOJA"- "BELA"Sok (10$)\n"SRWBOJA"- "BELA"Pivo (10$)\n"SRWBOJA"- "BELA"MP3 (700$)\n"SRWBOJA"- "BELA"Sprej (70$)\n"SRWBOJA"- "BELA"Sat (130$)\n"SRWBOJA"- "BELA"Marama (500$)\n"SRWBOJA"- "BELA"Hrana (300$)\n");
                format(string, sizeof(string), "%s%s", string1, string2);
                SPD(playerid, 86, DIALOG_STYLE_LIST, ""BELA"Market Kupovina", string, "Kupi", "Izlaz");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_SEXSHOP)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                SPD(playerid, 88, DIALOG_STYLE_LIST, ""BELA"Sex Shop", ""LJUB"- "BELA"Sivi Vibrator (50$)\n"LJUB"- "BELA"Beli Vibrator (50$)\n"LJUB"- "BELA"Ljubicasti Vibrator (70$)\n"LJUB"- "BELA"Cvece (10$)", "Kupi", "Izlaz");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_GUNSHOP)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(PlayerInfo[playerid][pGunDozvola] == 0) return SCM(playerid,-1, ""SRWBOJA"[V:RPG] "SIVA"Morate imati dozvolu za oruzije da bi kupili oruzije!");
                if(PlayerInfo[playerid][pDisarm] == 1 && PlayerInfo[playerid][pDisarmVreme] > 0) return SCM(playerid,-1, ""CRVENA"[V:RPG] "SIVA"Imas Disarm ");
                if(Stranica[ playerid ] > 0) { for(new e; e < 15; e++) { PlayerTextDrawHide(playerid, GunTD[ playerid ][ e ]); Stranica[ playerid ] = 0; CancelSelectTextDraw(playerid); } }
                else { for(new e; e < 15; e++) { PlayerTextDrawSetPreviewModel(playerid, GunTD[ playerid ][ 8 ], 348); PlayerTextDrawShow(playerid, GunTD[ playerid ][ e ]); Stranica[ playerid ] = 1; SelectTextDraw(playerid, 0xFFA500FF); PlayerTextDrawSetString(playerid, GunTD[ playerid ][ 4 ], "Deagle"); PlayerTextDrawSetString(playerid, GunTD[ playerid ][ 7 ], "4000$"); } }
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_KLADIONICA)
            {
                x++;
                new broj, brojk = random(300), string[128];
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(sscanf(params, "i",broj)) return SCM(playerid, -1, ""SRWBOJA"[V:RPG] Pomoc | "BELA"/kupi [BROJ 1- 300 (100$)]");
                if(broj < 1 || broj > 300) return SCM(playerid,-1, ""SRWBOJA"[V:RPG] "BELA"Ne mozete ici ispod 1 i vise od 300!");
                if(PlayerInfo[playerid][pNovacDzep] < 100) return SCM(playerid,-1,""SRWBOJA"[ Varadero ] "SIVA"Nemate dovoljno novca!");
                KladionicaBroj[playerid] = broj; g_NovacMinus(playerid, 100);
                if(KladionicaBroj[playerid] == brojk)
                {
                    SCM(playerid,-1,""SPLAVA"[Kladionica]: "SIVA"Cestitamo pogodili ste broj, osvojili ste 20000$!");
                    g_NovacPlus(playerid, 1500);
                    format(string,sizeof(string),"[V:RPG] "SPLAVA"Igrac %s je osvojio na kladionici 20000$!",GetName(playerid));
                    AdminGameMaster(-1, string);
                    FirmaInfo[UsaoFirma[playerid]][fProizvodi]--; FirmaNovac(UsaoFirma[playerid], 50);
                }
                else
                {
                    SCM(playerid,-1,""SRWBOJA"[Kladionica]: "SIVA"Zao nam je ovaj put niste osvojili na kladionici!");
                    FirmaInfo[UsaoFirma[playerid]][fProizvodi]--; FirmaNovac(UsaoFirma[playerid], 50);
                }
                break;
            }
        }
    }
    for(new i = 86; i < 91; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, FirmaInfo[i][fUlazX], FirmaInfo[i][fUlazY], FirmaInfo[i][fUlazZ]))
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_SBIZZ)
            {
                x++;
                KioskKupovina[playerid] = i;
                SPD(playerid, 222, DIALOG_STYLE_LIST, ""BELA"Trafika", ""SRWBOJA"- "BELA"Dopuna (20$)\n"SRWBOJA"- "BELA"Dopuna (50$)\n"SRWBOJA"- "BELA"Dopuna (100$)\n"SRWBOJA"- "BELA"Sok (10$)\n"SRWBOJA"- "BELA"Cigare (20$)\n"SRWBOJA"- "BELA"Upaljac (10$)\n"SRWBOJA"- "BELA"Cokoladica (10$)\n"SRWBOJA"- "BELA"Halo Kartica (50$)", "Odaberi", "Izlaz");
                break;
            }
        }
    }
    return 1;
}
///////////////////////////////////////////////////////////
CMD:meni(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 25.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]))
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_RESTORAN)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new string1[275], string2[292], string[567];
                format(string1,sizeof(string1),""VARADERO"- "BELA"Supa (20$)\n"VARADERO"- "BELA"Pasulj (30$)\n"VARADERO"- "BELA"Riblja Corba (40$)\n"VARADERO"- "BELA"Slovenski Kern's Kulen (60$)\n"VARADERO"- "BELA"Pita od sira (30$)\n"VARADERO"- "BELA"Raznjici (70$)\n");
                format(string2,sizeof(string2),""VARADERO"- "BELA"Palacinke (10$)\n"VARADERO"- "BELA"Cvarci (30$)\n"VARADERO"- "BELA"Biftek (90$)\n"VARADERO"- "BELA"Bllade's Proja (50$)\n"VARADERO"- "BELA"Coca-Cola (10$)\n"VARADERO"- "BELA"Viski (100$)\n"VARADERO"-. "BELA"Pivo (10$)\n"VARADERO"- "BELA"Gusti Sok (10$)");
                format(string, sizeof(string), "%s%s", string1, string2);
                SPD(playerid, 92, DIALOG_STYLE_LIST, ""BELA"Restoran - Meni", string, "Jedi", "Izlaz");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_BURG)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new string1[275], string2[275], string[550];
                format(string1,sizeof(string1),""ZELENA"- "BELA"Hamburger (10$)\n"ZELENA"- "BELA"Cheeseburger (15$)\n"ZELENA"- "BELA"Pomfrit (15$)\n"ZELENA"- "BELA"Pileci Medaljoni (20$)\n"ZELENA"- "BELA"Mijesana Salata (25$)\n");
                format(string2,sizeof(string2),""ZELENA"- "BELA"Kafa (10$)\n"ZELENA"- "BELA"Caj (15$)\n"ZELENA"- "BELA"Sladoled (20$)\n"ZELENA"- "BELA"Coca Cola (10$)\n"ZELENA"- "BELA"Voda (10$)");
                format(string, sizeof(string), "%s%s", string1, string2);
                SPD(playerid, 94, DIALOG_STYLE_LIST, ""BELA"Restoran - Meni", string, "Jedi", "Izlaz");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_CLUCKIN)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new string1[275], string2[275], string[550];
                format(string1,sizeof(string1),""SRWBOJA"- "BELA"Hamburger (10$)\n"SRWBOJA"- "BELA"Sladoledna torta (20$)\n"SRWBOJA"- "BELA"Sendvic (10$)\n"SRWBOJA"- "BELA"Burek (20$)\n");
                format(string2,sizeof(string2),""SRWBOJA"- "BELA"Krofna (15$)\n"SRWBOJA"- "BELA"Kakao (15$)\n"SRWBOJA"- "BELA"Coca Cola (10$)\n"SRWBOJA"- "BELA"Kafa (10$)");
                format(string, sizeof(string), "%s%s", string1, string2);
                SPD(playerid, 100, DIALOG_STYLE_LIST, ""BELA"Cluckin - Meni", string, "Jedi", "Izlaz");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_PIZZA)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                SPD(playerid, 102, DIALOG_STYLE_LIST, ""BELA"Pizza - Meni", ""SRWBOJA"- "BELA"Capricoza (30$)\n"SRWBOJA"- "BELA"Margarita (25$)\n"SRWBOJA"- "BELA"Piletina (15$)\n"SRWBOJA"- "BELA"Pomfrit (15$)\n"SRWBOJA"- "BELA"Limunada (10$)\n"SRWBOJA"- "BELA"Kafa (10$)", "Jedi", "Izlaz");
                break;
            }
        }
    }
    return 1;
}
////////////////////////////////////////////////////////////
CMD:naruci(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    if(IsPlayerInRangeOfPoint(playerid, 25.0, 1455.5018,-1896.7522,23.1622))
    {
        new str[350];
        format(str, sizeof(str), ""ORANGE"- "BELA"Pivo (10$)\n"ORANGE"- "BELA"Rakija (20$)\n"ORANGE"- "BELA"Viski (Jack Daniels 50$)\n"ORANGE"- "BELA"Liker (40$)\n"ORANGE"- "BELA"Pelinkovac (35$)\n"ORANGE"- "BELA"Vodka (30$)\n"ORANGE"- "BELA"Lozovaca (25$)\n"ORANGE"- "BELA"Vino (Vranac 30$)\n"ORANGE"- "BELA"Voda (10$)");
        SPD(playerid, 104, DIALOG_STYLE_LIST, ""BELA"Pice - Meni", str, "Odaberi", "Izlaz");
    }
    return 1;
}
///////////////////////////////////////////////////////////
CMD:disco(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 25.0, -2653.1223,1410.0814,906.2734))
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_DISCO)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new str[350];
                format(str, sizeof(str), ""ORANGE"- "BELA"Pivo (10$)\n"ORANGE"- "BELA"Rakija (20$)\n"ORANGE"- "BELA"Viski (Jack Daniels 50$)\n"ORANGE"- "BELA"Liker (40$)\n"ORANGE"- "BELA"Pelinkovac (35$)\n"ORANGE"- "BELA"Vodka (30$)\n"ORANGE"- "BELA"Lozovaca (25$)\n"ORANGE"- "BELA"Vino (Vranac 30$)\n"ORANGE"- "BELA"Voda (10$)");
                SPD(playerid, 104, DIALOG_STYLE_LIST, ""BELA"Pice - Meni", str, "Odaberi", "Izlaz");
                break;
            }
        }
    }
    return 1;
}
////////////////////////////////////////////////////////////
CMD:pice(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 25.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]) && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW])
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_PIGPEN || FirmaInfo[i][fVrsta] == VRSTA_BAR || FirmaInfo[i][fVrsta] == VRSTA_DISCO)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                new str[350];
                format(str, sizeof(str), ""ORANGE"- "BELA"Pivo (10$)\n"ORANGE"- "BELA"Rakija (20$)\n"ORANGE"- "BELA"Viski (Jack Daniels 50$)\n"ORANGE"- "BELA"Liker (40$)\n"ORANGE"- "BELA"Pelinkovac (35$)\n"ORANGE"- "BELA"Vodka (30$)\n"ORANGE"- "BELA"Lozovaca (25$)\n"ORANGE"- "BELA"Vino (Vranac 30$)\n"ORANGE"- "BELA"Voda (10$)");
                SPD(playerid, 104, DIALOG_STYLE_LIST, ""BELA"Pice - Meni", str, "Odaberi", "Izlaz");
                break;
            }
        }
    }
    return 1;
}
////////////////////////////////////////////////////////////
CMD:teretana(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 25.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]) && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW])
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_GYM)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                SPD(playerid, 106, DIALOG_STYLE_LIST, ""BELA"Teretana", ""VARADERO"- "BELA"Normalni Trening (100$)\n"VARADERO"- "BELA"Box Trening (200$)\n"VARADERO"- "BELA"Kung Fu Trening (300$)\n"VARADERO"- "BELA"KneeHead Trening (400$)\n"VARADERO"- "BELA"Grabkick Trening (500$)\n"VARADERO"- "BELA"Elbow Trening (600$)", "Odaberi", "Izlaz");
                break;
            }
        }
    }
    return 1;
}
////////////////////////////////////////////////////////////
CMD:frizura(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    new x;
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 15.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]) && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW])
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_BARBER)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                SPD(playerid, 108, DIALOG_STYLE_LIST, ""BELA"Frizure", ""LJUB"- "BELA"Klasicna Frizura (100$)\n"LJUB"- "BELA"Elvis Frizura (200$)\n"LJUB"- "BELA"Afro Frizura (300$)", "Odaberi", "Odustani");
                break;
            }
        }
    }
    return 1;
}
/////////////////////////////////////////////////////////////
CMD:odjeca(playerid, params[])
{
    //#pragma unused help
    new x; if(PlayerInfo[playerid][pLider] != 0 || PlayerInfo[playerid][pClan] != 0) return SCM(playerid,-1,""ZELENA"[V:RPG] "SIVA"Clanovi organizacije ne mogu menjati odelo!");
    for(new i; i < MAX_FIRMI; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 15.0, FirmaInfo[i][fIzlazX], FirmaInfo[i][fIzlazY], FirmaInfo[i][fIzlazZ]) && GetPlayerVirtualWorld(playerid) == FirmaInfo[i][fVW])
        {
            if(FirmaInfo[i][fVrsta] == VRSTA_BINCO)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(GetPlayerInterior(playerid) == 15) Interijer[playerid] = VRSTA_BINCO;
                SetPlayerVirtualWorld(playerid, FirmaInfo[i][fVW]); SetPlayerInterior(playerid, FirmaInfo[i][fInt]);
                SetPlayerPos(playerid, 215.7672,-99.8672,1005.2578);
                TogglePlayerControllable(playerid, 0);
                ShowModelSelectionMenu(playerid, skinlist, "Butik");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_SUBURBAN)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(GetPlayerInterior(playerid) == 1) Interijer[playerid] = VRSTA_SUBURBAN;
                SetPlayerVirtualWorld(playerid, FirmaInfo[i][fVW]); SetPlayerInterior(playerid, FirmaInfo[i][fInt]);
                SetPlayerPos(playerid, 214.3559,-41.4176,1002.0234);
                TogglePlayerControllable(playerid, 0);
                ShowModelSelectionMenu(playerid, skinlist, "Butik");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_VICTIM)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(GetPlayerInterior(playerid) == 5) Interijer[playerid] = VRSTA_VICTIM;
                SetPlayerVirtualWorld(playerid, FirmaInfo[i][fVW]); SetPlayerInterior(playerid, FirmaInfo[i][fInt]);
                SetPlayerPos(playerid, 217.6989,-8.7642,1001.2109);
                TogglePlayerControllable(playerid, 0);
                ShowModelSelectionMenu(playerid, skinlist, "Butik");
                break;
            }
            else if(FirmaInfo[i][fVrsta] == VRSTA_ZIP)
            {
                x++;
                if(FirmaInfo[UsaoFirma[playerid]][fProizvodi] <= 0) return SCM(playerid,-1,""ZPLAVA"[Firma]: "BELA"Nemamo vise proizvoda!");
                if(GetPlayerInterior(playerid) == 5) Interijer[playerid] = VRSTA_VICTIM;
                SetPlayerVirtualWorld(playerid, FirmaInfo[i][fVW]); SetPlayerInterior(playerid, FirmaInfo[i][fInt]);
                SetPlayerPos(playerid, 217.6989,-8.7642,1001.2109);
                TogglePlayerControllable(playerid, 0);
                ShowModelSelectionMenu(playerid, skinlist, "Butik");
                break;
            }
        }
    }
    return 1;
}
///////////////////////////////////////////////////////////
CMD:naocare(playerid, params[])
{
    //#pragma unused help
    if(UlogovanProvera[playerid] == 0) return SCM(playerid,-1,"[V:RPG] "SRWBOJA"Moras se ulogovati da bi koristio ovu komandu!");
    if(PlayerInfo[playerid][pNaocare] == 0) return SCM(playerid,-1, ""SRWBOJA"[V:RPG] "SIVA"Nemas naocare!");
    new string[128];
    if(Naocare[playerid] == true)
    {
        RemovePlayerAttachedObject(playerid, NAOCARE_SLOT);
        format(string,sizeof(string), "* %s skida naocare.", GetName(playerid));
        e_RadiusMSG(20.0, playerid, HEX_PROX, string);
        Naocare[playerid] = false;
    }
    else
    {
        SetPlayerAttachedObject(playerid, NAOCARE_SLOT, 19006, 2, 0.09, 0.04, 0, 88, 75, 0);
        format(string,sizeof(string), "* %s stavlja naocare.", GetName(playerid));
        e_RadiusMSG(20.0, playerid, HEX_PROX, string);
        Naocare[playerid] = true;
    }
    return 1;
}