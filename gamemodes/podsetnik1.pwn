	new q[128];
	mysql_format(SQL, q, sizeof q, "INSERT INTO `stanovi` SET `Level` = '%d', `Cena` = '%d'", level, cena);		
	mysql_tquery(SQL, q, "_sqlInsertStan", "dddd", idstan, playerid, level, cena);
	return 1;

}

function: _sqlInsertStan(idstan, playerid, cena,level)
{
	GetPlayerPos(playerid,X,Y,Z);

	idstan = cache_insert_id();
	StanInfo[idstan][sSQLID] = idstan;	

    StanInfo[idstan][sIzlazX] = 244.1522; 
	StanInfo[idstan][sIzlazY] = 305.0730; 
	StanInfo[idstan][sIzlazZ] = 999.1484; 
	StanInfo[idstan][sVW] = idstan;
	StanInfo[idstan][sCena] = cena; 
	StanInfo[idstan][sLevel] = level; 
	StanInfo[idstan][sUlazX] = X;
    StanInfo[idstan][sUlazY] = Y; 
    StanInfo[idstan][sUlazZ] = Z; 
    StanInfo[idstan][sProveraVlasnika] = 
    StanInfo[idstan][sNovac] = 
    StanInfo[idstan][sMunicija] = 0;
    StanInfo[idstan][sZatvoreno] =  
    StanInfo[idstan][sInt] = 1;    
    StanInfo[idstan][sOruzije] = -1;    
    strmid(StanInfo[idstan][sVlasnik],"Niko",0,strlen("Niko"),255);

    new szString[194];
	format(szString, charsmax(szString),"Stan na prodaju!({FFFFFF}%d{48E31C})\nAdresa :{FFFFFF} %s\n{48E31C}Cena :{FFFFFF} $%d{48E31C} | Level :{FFFFFF} %d\n{48E31C}Za kupovinu upisite {FFFFFF}/kupistan", idstan, UlicaStana(idstan), StanInfo[idstan][sCena], StanInfo[idstan][sLevel]);
 	StanLabel[idstan] = CreateDynamic3DTextLabel(szString ,0x33CCFFAA,StanInfo[idstan][sUlazX], StanInfo[idstan][sUlazY], StanInfo[idstan][sUlazZ],25,INVALID_PLAYER_ID,INVALID_VEHICLE_ID);
	StanPickup[idstan] = CreateDynamicPickup(19605, 1, StanInfo[idstan][sUlazX], StanInfo[idstan][sUlazY], StanInfo[idstan][sUlazZ]);
	format(szString, charsmax(szString), ""CRVENA"[V:RPG] "SIVA"Stan je uspesno kreiran (ID Stana: %d)!",idstan);
	SCM(playerid,-1, szString);
	SacuvajStan(idstan);
	return 1;
}



	new q[58+24+1];
	mysql_format( SQL, q, sizeof(q), "SELECT * FROM `stanovi` where `sSQLID` = '%d'", targetid);
	mysql_tquery( SQL, q, "_sqlDeleteStan", "ii", playerid, targetid);

	DestroyDynamic3DTextLabel(StanLabel[targetid]);
	DestroyDynamicPickup(StanPickup[targetid]);
	for(new i; Stan:i < Stan; i++) 
	{ 
		StanInfo[targetid][Stan:i] = -1; 		
	}



	function: _sqlDeleteStan(playerid, stanid)
{
	new rows;
	cache_get_row_count(rows);
	if(!rows) return SendClientMessage(playerid, -1, "ID tog stana nije pronadjen u bazi!");
	else 
	{
		new q[64];
		mysql_format( SQL, q, sizeof(q), "DELETE FROM `stanovi` WHERE `sSQLID` = '%d'", stanid);
		mysql_tquery(SQL, q);
		va_SendClientMessage(playerid, -1, "Obrisali ste stan id: %d", stanid);
		va_SendClientMessageToAll(-1 , "Administrator: %s je obrisao Stan ID: (%d).", GetName(playerid), stanid);
	}
	return 1;
}