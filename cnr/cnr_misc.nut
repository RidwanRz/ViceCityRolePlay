function onClientScriptData( player )
{
	local type = Stream.ReadInt(), string = Stream.ReadString();

	switch( type )
	{
		case 15:
		playa[ player.ID ].Register( player, string );
		break;

		case 69:
		playa[ player.ID ].LoadAcc( player );
		break;

		case 20:
		if( mysqldb.GetPass( playa[ player.ID ].ID ) != SHA256( string ) ) SendDataToClient( 40, "Wrong password.", player );
		else playa[ player.ID ].Login( player ), SendDataToClient( 30, null, player ); break;
		break;

		case 33: CreateBankAccount( player ); break;

		case 35: ProcessBank( player, string ); break;
		case 1000: AdminMessage( string ); break;

		case 90: Buyhouse( string, player ); break;
		case 100: BuyVehicle( string, player ); break;

		case 5000: player.PlaySound( 50000 ); break;
		case 5001: player.PlaySound( 50001 ); break;

		case 500: player.IsFrozen = false; break;

		case 320: CheckHousePass( player, string ); break;

		case 110: BuyWeapon( player, string ); break;

		case 120: BuyItem( player, string ); break;

		case 160: BuyPnS( player, string ); break;

		case 130: BuyTools( player, string ); break;

		case 6000: BuyItem( player, string, 5031, 5030 ); break;

		case 6010: EditObject( player, string ); break;

		case 6020: LoadPropertytexdrawForPlayer( player ), LoadServertexdrawForPlayer( player ), CreateCorpsTextdraw( player ); break;

		case 1060: playa[ player.ID ].ReadNews = true; break;

		case 6200: BuyBMWeapon( player, string ); break;

		case 6400: for( local i = 0; i < 4; ++i ) { player.PlaySound( string.tointeger() ); } break;

		case 6401: BuyItem( player, string, 6402, 6401 ); break;

		case 6700: 
		EnterHouseKey( player ); 
		EnterBiz( player );
		break;

		case 7200: HospitalRespawn2( player ); break;
		case 7201: CheckHouseSpawn( player ); break;
		case 7202: CheckPropSpawn( player ); break;
		case 7203: SpawnHouse2( player, string ); break;
		case 7204: SpawnProp( player, string ); break;
		case 7205: RandomSpawnForCivil( player ); break;
		case 7206: playa[ player.ID ].OnSpawnMenu = false; break;


		case 9100:
		CheckPDutyRequirement( player, "pd" );
		break;
		
		case 9101:
		CheckPDutyRequirement( player, "swat" );
		break;

		case 9102:
		CheckPDutyRequirement( player, "fbi" );
		break;

		case 9103:
		local spit = split( string, ":" );
		OnPoliceDuty( player, spit[0], spit[1].tointeger() );
		break;

		case 9200:
		QuitJob( player );
		break;

		// =========== spawn ==============
		case 9400:
		HospitalRespawn2( player );
		break;

		case 9401:
		SpawnAtJob( player );
		break;

		case 9402:
		GetHouseList( player );
		break;

		case 9403:
		GetHQList( player );
		break;

		case 9404:
		SpawnAtJobSel( player, string );
		break;

		case 9405:
		SpawnAtHouse( string, player );
		break;

		case 9406:
		SpawnAtHQ( string, player );
		break;

		// === medic ===
		case 9500:
		OnEMSDuty( player );
		break;

		// === trucker ===
		case 9600:
		AddTruckerItem( player, string );
		break;

		case 9700:
		OnTruckerDuty( player );
		break;


		// === item ===
		case 9801:
		UpdateItemInfo( player, string );
		break;

		case 9800:
		BuySelectedItem( player, string );
		break;

		case 9901:
		UpdateSkinInfo( player, string );
		break;

		case 9900:
		BuySelectedSkin( player, string );
		break;

		// ===== showroom ===
		case 12000:
		NextShowroomVehicle( player );
		break;

		case 12010:
		PreviousShowroomVehicle( player );
		break;

		case 12020:
		PurchaseVehicle( player );
		break;

		case 12030:
		DestroyShowroom( player );
		break;

		case 13000:
		CreateShowroom( player, string );
		break;

	}
}

function SendDataToClient( num, data, player )
{
	local st = Stream();
	st.StartWrite();
	st.WriteInt( num );
	st.WriteString( data );
	st.SendStream( player );
}

function SendDataToClientToAll( num, data )
{
	foreach( index in Server.Players )
	{
		local player = FindPlayer( index );

		if( player )
		{
			SendDataToClient( num, data, player );
		}
	}
}

function ConvertStringToPos( string )
{
  	local strip_pos = split( string, "," ),
	Pos = Vector( strip_pos[ 0 ].tofloat(), strip_pos[ 1 ].tofloat(), strip_pos[ 2 ].tofloat() );

	return Pos;
}

function IsFloat( num )
{

	try
	{
		local a = num.tofloat();
		if( typeof a == "float" ) return true;
	}
	catch( _ ) _;

	return false;
}

function RGBToHex( color )
{
	return format("[#%02X%02X%02X]", color.r, color.g, color.b );
}

right_click <- BindKey( true, 0x02, 0, 0 );
F4 <- BindKey( true, 0x73, 0, 0 );
ctrl <- BindKey( true, 0xA2, 0, 0 );
H <- BindKey( true, 0x48, 0, 0 );

r <- BindKey( true, 0x52, 0, 0 );

Key_Space <- BindKey( true, 0x20, 0, 0 );
Key_Up <- BindKey( true, 0x26, 0, 0 );
Key_Down <- BindKey( true, 0x28, 0, 0 );
Key_Left <- BindKey( true, 0x25, 0, 0 );
Key_Right <- BindKey( true, 0x27, 0, 0 );
Key_4 <- BindKey( true, 0x64, 0, 0 );
Key_6 <- BindKey( true, 0x66, 0, 0 );
Key_2 <- BindKey( true, 0x61, 0, 0 );
Key_8 <- BindKey( true, 0x68, 0, 0 );
Key_7 <- BindKey( true, 0x67, 0, 0 );
Key_3 <- BindKey( true, 0x63, 0, 0 );
Key_PageUp <- BindKey( true, 0x21, 0, 0 );
Key_PageDown <- BindKey( true, 0x22, 0, 0 );
Key_Del <- BindKey( true, 0x2E, 0, 0 );
Key_Shift <- BindKey( true, 0x08, 0, 0 );
Key_F2 <- BindKey( true, 0x71, 0, 0 );


function onKeyDown( player,key )
{
	RightCuff( player, key );
	RightHeal( player, key );
//	RightKidnap( player, key );
	onPlayerEditObject( player,key );
	//F4Key( player, key );
	//GangHelp( player, key );

	//EnterHouseKey( player, key );
}

function onKeyUp( player, key )
{
	onPlayerEditObjectUp( player,key );
}

function LoadServerInfo()
{
	SetDeathMessages( false );
	SetJoinMessages( false );
	SetBackfaceCullingDisabled( true );
	SetHeliBladeDamageDisabled( true );
	SetMaxHeight( 500.0 );
	//SetSpawnPlayerPos(11.9443, -1492.89, 12.2538);
	SetTimeRate( 1000 );
	SetUseClasses( false );
	SetFriendlyFire( false );
	SetDrivebyEnabled( false );
	SetServerName( "Virtual Reality Roleplay" );
	SetGameModeName( "VRRP v1.0a" );
	SetPassword( "" )
	SetWastedSettings( 0, 0, 0, 0, RGB(0,0,0), 0, 0)
	SetKillDelay( 255 );

	Server.EventCooldown = time();
	//CreateMarker( 0, Vector( -840.633, -1480.1, 11.9289 ), 1, RGB(0, 0, 0), 23 )


	RawHideMapObject(2372,-3726,-4633,113);
    RawHideMapObject(2420,-3781,-3359,118);
    RawHideMapObject(2403,-4998,-4677,116);
    RawHideMapObject(1573,-8746,-1166,119)
    RawHideMapObject(828,-9100,-12647,124)
    RawHideMapObject(4145,3250,4311,115)
    RawHideMapObject(3031,-1043,-13332,94)

}

function GetTiming(secs)
{
	local ret = "";
	local hr = 0;
	local mn = 0;
	local dy = 0;

	mn = secs / 60;
	secs = secs - mn*60;
	hr = mn / 60;
	mn = mn - hr*60;
	dy = hr / 24;
	hr = hr - dy*24

	if (dy>0) ret = dy+" Days ";
	if (hr>0) ret = ret+hr+" Hours ";
	if (mn>0) ret = ret+mn+" Minutes ";
	ret = ret+secs+" Seconds";

	return ret;
}

function GetDate( time )
{
	return date( time ).day + "/" + date( time ).month + "/" + date( time ).year + " " + format( "%02d", date( time ).hour ) + ":" + format( "%02d", date( time ).min );
}

function GetTok(string, separator, n, ...)
{
	local m = vargv.len() > 0 ? vargv[0] : n,
		  tokenized = split(string, separator),
		  text = "";

	if (n > tokenized.len() || n < 1) return null;
	for (; n <= m; n++)
	{
		text += text == "" ? tokenized[n-1] : separator + tokenized[n-1];
	}
	return text;
}

function NumTok(string, separator)
{
	local tokenized = split(string, separator);
	return tokenized.len();
}

function GetIngameTag( player )
{
	if( player == null ) return "";

	/*if( typeof( player ) != "instance" ) return "[#33cc33]" + player
	if( playa[ player.ID ].Gang != null && gang.rawin( playa[ player.ID ].Gang ) == true ) return "[#FFFFFF][[#00ffff]" + gang.rawget( playa[ player.ID ].Gang ).Name + "[#FFFFFF]|[#FFAA00]" + player.Name + "[#FFFFFF]]";

	switch( playa[ player.ID ].Level )
	{
		case 2: return "[#FFFFFF][[#00ffff]Mode[#79ff4d]rator[#FFFFFF]|[#FFAA00]" + player.Name + "[#FFFFFF]]"; break;
		case 3: return "[#FFFFFF][#FF55FF][[#FF5555]ii[#55FFFF]S[#AAAAAA]u[#55FFFF]p[#AAAAAA]e[#55FFFF]r[#AAAAAA]A[#55FFFF]d[#AAAAAA]m[#55FFFF]i[#55FFFF]n[#FF5555]ii[#FF55FF]]~[#FFAA00]" + player.Name + "[#FFFFFF]"; break;
		case 4: return "[#FFFFFF][#000000][[#FF55FF],,[#55FFFF]Owner[#FF55FF],,[#000000]][#AA0000]~" + player.Name + "[#FFFFFF]"; break;
		default: return "[#FFFFFF][[#FFAA00]User[#FFFFFF]|[#FFAA00]" + player.Name + "[#FFFFFF]]"; break;
	}*/
	if ( typeof( player ) != "instance" )
	{
		if( !FindPlayer( player ) ) return "[#595959]" + player;
		else player = FindPlayer( player );
	}

	if ( !player.IsSpawned ) return "[#FFFFFF]" + player.Name;
	else if( playa[ player.ID ].AdminDuty ) return "[#ff6666]" + player.Name;
	else if( playa[ player.ID ].DevDuty ) return "[#32a89b]" + player.Name;
	else if( playa[ player.ID ].mDuty ) return "[#f50045]" + player.Name;
	else if ( playa[ player.ID ].JobID.find("cop") >= 0 ) return "[#0000FF]" + player.Name;
	else if ( playa[ player.ID ].JobID.find("cop") >= 0 && playa[ player.ID ].Copskill == 250 ) return "[#0000FF]S.W.A.T Operative " + player.Name;
	else if ( playa[ player.ID ].JobID.find("cop") >= 0 && playa[ player.ID ].Copskill >= 500 ) return "[#0000FF]FBI Agent " + player.Name;
	else if ( playa[ player.ID ].JobID == "3" ) return "[#00FFFF]" + player.Name;
	else if ( playa[ player.ID ].Wanted == 0 ) return "[#FFFF00]" + player.Name;
	else if ( playa[ player.ID ].Wanted >= 1 && playa[ player.ID ].Wanted <= 5 ) return "[#FF8C00]" + player.Name;
	else if ( playa[ player.ID ].Wanted >= 5 ) return "[#FF0000]" + player.Name;
	else return "[#FFFFFF]" + player.Name;
}

function PartReason( id )
{
	switch( id )
	{
		case 1: return { Game = "disconnected [#ffffff]from the server.", IRC = "quit" };
		case 0: return { Game = "lost connection [#ffffff]from the server.", IRC = "timed-out" };
		case 2: return { Game = "[#ffffff]been [#33cc33]kicked [#ffffff]from the server.", IRC = "been kicked" };
		case 3: return { Game = "Crashed.", IRC = "crashed" };
	}
}

function AutoRun()
{
	//AutoAdmin();
	//UpdatePlayerInfo();
	//AutoEndEvent();
	RemoveObject();
	RemoveCorps();
	CheckHandsup();
	CheckWeedStatus();
	CheckVehicles();
	
	if( ( Server.EventCooldown - time() ) > 1800 && Server.Event.Event == 0 )
	{
		E1_StartMilitaryEvent();
	}

	/*if( ( time() - Server.AR ) > 3600 )
	{
		VSaveData();
		SaveAlias();
		SavePickup();
		SavePlayerStats();
		SaveGang();
		SaveArea();
		SaveObject();
		Server.AR = time();
	}*/

	else if( ( time() - Server.BankRobTimer ) > 300 )
	{
		Server.BankVault.Delete();
		Server.BankVault = CreateObject(4578, 0, Vector(-945.5955811, -342.62677, 7.583077908), 255);
		Server.BankRobbery = 0;
		Server.BankRobber = null;
	}

		//	-------------------------------------------------------
	//
	//					NPC STUFF | DONT TOUCH
	//
	//	-------------------------------------------------------

	/*if ( GetPlayers( ) > 0 )
	{

		if ( NPCs.len( ) > 0 )
		{

			foreach( id, iNPC in NPCs )
			{

				if ( iNPC.iInstance )
				{

					if ( !iNPC.bStandBy )
					{

						if ( !iNPC.Cuff )
						{

							if ( iNPC.FollowPlayer )
							{

								if ( GetDistrictName( iNPC.iInstance.Pos.x, iNPC.iInstance.Pos.y ) == GetDistrictName( iNPC.FollowPlayer.Pos.x, iNPC.FollowPlayer.Pos.y ) ) iNPC.CuffAPlayer( iNPC.FollowPlayer );
								else
								{

									local
										intTime					=	( iNPC.FollowPlayer.Pos.Distance( iNPC.iInstance.Pos ) * 300 ).tointeger( );


									iNPC.Follow( iNPC.FollowPlayer, intTime );

								}

							};
							else if ( PlayerNearPoint( iNPC.iInstance.Pos.x, iNPC.iInstance.Pos.y, iNPC.iInstance.Pos.z ) )
							{

								local
									iFollowPlayer			=	PlayerNearPoint( iNPC.iInstance.Pos.x, iNPC.iInstance.Pos.y, iNPC.iInstance.Pos.z ),
									intTime					=	( iFollowPlayer.Pos.Distance( iNPC.iInstance.Pos ) * 300 ).tointeger( );


								iNPC.FollowPlayer			=	iFollowPlayer;
								iNPC.Follow( iNPC.FollowPlayer, intTime );

							};
							else
							{

								iNPC.iInstance.Delete( );
								NPCs.rawdelete( id );

							};

						};

					};

				};

			};

		};

	};
*/

};

function PlayerNearPoint( PosX, PosY, PosZ )
{

	local
		myArray			=	[ ];

	foreach( iPlayer in Server.Players )
	{

		iPlayer			=	FindPlayer( iPlayer );

		if ( iPlayer )
		{

			if ( GetDistrictName( PosX, PosY ) == GetDistrictName( iPlayer.Pos.x, iPlayer.Pos.y ) )
			{

				if ( playa[ iPlayer.ID ].Wanted >= 1 ) myArray.push( iPlayer );

			};

		};

	};

	if ( myArray.len( ) == 0 ) return false;
	else if ( myArray.len( ) == 1 ) return myArray[ 0 ];
	else
	{

		local
			ThingToReturn			=	null;

		ThingToReturn				=	myArray[ rand( ) % myArray.len( ) ];

		return ThingToReturn;

	};

};

function errorHandling( obj )
{
	local callingStack = getstackinfos( 2 );
	local cDate = date();
	local seed = ( ( time() + rand() ) / 17 ).tointeger();

	seed += ( cDate.sec * cDate.hour );
	srand( seed );
	local ID = cDate.sec + "-" + rand();
	local funcName = callingStack.func;
	local origin   = callingStack.src;
	local lineNo   = callingStack.line;
	local locals   = "";
	foreach( index, value in callingStack.locals )
	{
		if( index != "this" )
			locals = locals + "\t[" + index + "]: " + value + "\n";
	}

	AdminMessage("4** Error: " + origin + " line: " + lineNo + " function: " + funcName + " reason: " + obj );
	print( "** Error: " + origin + " line: " + lineNo + " function: " + funcName + " reason: " + obj );
}

function F4Key( player, key )
{
	if( key == F4 )
	{
		if( playa[ player.ID ].Autospawn ) MsgPlr( 3, player, Lang.F4Dis ), playa[ player.ID ].Autospawn = false;
		else MsgPlr( 3, player, Lang.F4Ena ), playa[ player.ID ].Autospawn = true;
	}
}

function GetWeaponModel( id )
{
	switch( id )
	{
		case 1: return 259;
		case 2: return 260;
		case 3: return 261;
		case 4: return 262;
		case 5: return 263;
		case 6: return 264;
		case 7: return 265;
		case 8: return 266;
		case 9: return 267;
		case 10: return 268;
		case 11: return 269;
		case 12: return 270;
		case 13: return 291;
		case 14: return 271;
		case 15: return 272;
		case 16: return 273;
		case 17: return 274;
		case 18: return 275;
		case 19: return 277;
		case 20: return 278;
		case 21: return 279;
		case 22: return 281;
		case 23: return 282;
		case 24: return 283;
		case 25: return 284;
		case 26: return 280;
		case 27: return 276;
		case 28: return 285;
		case 29: return 286;
		case 30: return 287;
		case 31: return 288;
		case 32: return 289;
		case 33: return 290;
		case 34: return 291;
		case 35: return 294;
		case 102: return 6002;
		case 103: return 6005;
		case 104: return 6003;
		case 107: return 6004;
	}
}

function GetSlotAtWeapon( id )
{
	switch( id )
	{
		case 0:
		case 1:
		return 0;

		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
		case 11:
		return 1;

		case 12:
		case 13:
		case 14:
		case 15:
		case 16:
		return 2;

		case 17:
		case 18:
		return 3;

		case 19:
		case 20:
		case 21:
		return 4;

		case 22:
		case 23:
		case 24:
		case 25:
		return 5;

		case 26:
		case 27:
		return 6;

		case 30:
		case 31:
		case 32:
		case 33:
		return 7;

		case 28:
		case 29:
		return 8;

		case 34:
		case 36:
		return 9;
	}
}

function GetLevelName( lvl )
{
	return PInfoColor_Level( lvl );
}

function SavePlayerStats()
{
	local ss = 0;
	foreach( kiki in Server.Players )
	{
		local plr = FindPlayer( kiki );
		if( plr )
		{
			playa[ plr.ID ].SaveData( plr );
			ss ++;
		}
	}
}

function PInfoColor_FPS( player )
{
	local s = "";
	if( player.FPS < 21 ) s = "[#cc0000]" + player.FPS;
	else if( player.FPS > 20 && player.FPS < 31 ) s = "[#e68a00]" + player.FPS;
	else if( player.FPS > 30 ) s = "[#009933]" + player.FPS;

	return s;
}

function PInfoColor_Ping( player )
{
	local s = "";
	if( player.Ping < 100 ) s = "[#009933]" + player.Ping;
	else if( player.Ping > 100 && player.Ping < 300 ) s = "[#e68a00]" + player.Ping;
	else if( player.Ping > 300 ) s = "[#cc0000]" + player.Ping;

	return s;
}

function PInfoColor_Level( level )
{
	local s = "";
	switch( level )
	{
		case 2: s = "Moderator"; break;
		case 3: s = "Administrator"; break;
		case 4: s = "Manager"; break;
		case 5: s = "Manager"; break;
		case 6:
		case 7: s = "Lead Developer"; break;
		case 8:
		s = ""; break;
		default: s = "Player"; break;
	}
	return s;
}

function UpdatePlayerInfo()
{
	foreach( kiki in Server.Players )
	{
		local plr = FindPlayer( kiki );
		if( plr )
		{
			local gangy = ( gang.rawin( playa[ plr.ID ].Gang ) == false ) ? "None" : gang.rawget( playa[ plr.ID ].Gang).Name;
			SendDataToClient( 210, plr.Name + ":" + PInfoColor_Level( playa[ plr.ID ].Level ) + ":" + gangy + ":" + PInfoColor_FPS( plr ) + ":" + PInfoColor_Ping( plr ) + ":" + playa[ plr.ID ].XP + ":" + playa[ plr.ID ].Wanted + ":" + playa[ plr.ID ].Cash, plr );
		}
	}
}

function geoip2_country_code_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.country.iso_code;
    }
    catch(e) {}
    return res;
}

function geoip2_country_name_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.country.names.en;
    }
    catch(e) {}
    return res;
}

function geoip2_city_name_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.city.names.en;
    }
    catch(e) {}
    return res;
}

function geoip2_subdivision_code_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.subdivisions[0].iso_code;
    }
    catch(e) {}
    return res;
}

function geoip2_subdivision_name_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.subdivisions[0].names.en;
    }
    catch(e) {}
    return res;
}

function geoip2_continent_code_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.continent.code;
    }
    catch(e) {}
    return res;
}

function geoip2_continent_name_by_addr(ip_address)
{
    local data = mmdb.get(ip_address);
    local res = null;
    try
    {
        res = data.continent.names.en;
    }
    catch(e) {}
    return res;
}

function SearchAndReplace( str, search, replace ) 
{
    local li = 0, ci = str.find( search, li ), res = "";
    while( ci != null ) 
    {
        if( ci > 0 ) 
        {
            res += str.slice( li, ci );
            res += replace;
        }
        else res += replace;
        li = ci + search.len(), ci = str.find( search, li );
    }
    if ( str.len() > 0 ) res += str.slice( li );
    return res;
}

function ValidPlayerName( player )
{
/*	local regex = regexp(@"^[A-Za-z]|[A-Za-z][A-Za-z\s]*[A-Za-z]*_[A-Za-z]|[A-Za-z][A-Za-z\s]*[A-Za-z]$");

	return regex.capture(player) != null;*/

	return true;
}

function StripCol( text )
{
	try
	{
		if ( !text ) return text;
		local coltrig, output = "";
		foreach( idx, chr in text )
		{
			switch (chr)
			{
				case '[':
				if ( text[idx + 1] == '#' )
				{
					coltrig = true;
					break;
				}

				case ']':
				if ( coltrig )
				{
					coltrig = false;
					break;
				}

				default:
				if ( !coltrig ) output += chr.tochar();
			}
		}
		return output;
	}
	catch(e) return text;
}


function FindPlayerByAccID( id )
{
	for( local i = 0; i < 100; i++ )
	{
		local player = FindPlayer( i );

		if( player )
		{
			if( playa[ player.ID ].ID == id.tointeger() ) return player; 
		}
	}
}