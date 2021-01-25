function: _SQLLoadFirme()
{
	if(cache_num_rows()) 
	{
		for(new i; i < cache_num_rows(); i++)
		{
			cache_get_value_name_int(i,"fSQLID", FirmaInfo[i][fSQLID]);
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
			new b = i
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

	mysql_format(SQL, q, sizeof(q), "UPDATE `firme` SET `Neaktivnost`  = '%d', `Level` = '%d', `Cena` = '%d', `Kasa` = '%d', `Int` = '%d', `Zatvoreno` = '%d', `Proizvodi` = '%d', `MaxProizvodi` = '%d', `VW` = '%d' WHERE `fSQLID` = '%d' LIMIT 1",
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



CMD:kreirajfirmu(playerid, params[])
{
    //#pragma unused help
    //if(PlayerInfo[playerid][pSuspendovan] == 1) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "BELA"VI STE SUSSPENDOVANI VAMA SU KOMANDE ZABRANJENE ");
	if(PlayerInfo[playerid][pAdmin] < 6) return SCM(playerid,-1,""SPLAVA"[V:RPG] "SIVA"Samo Vlasnik!");
	if(AdminDuty[playerid] == 0) return SCM(playerid,-1,""SRWBOJA"[V:RPG] "SIVA"Morate biti na Administrator duznosti!");
    new vrsta,cena,lvl, firmaid; 
    
    if(sscanf(params, "iii", vrsta, lvl , cena))
	{
    	SCM(playerid, -1, "[V:RPG] Pomoc | "SPLAVA"/kreirajfirmu [vrsta] [level] [cena]");
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