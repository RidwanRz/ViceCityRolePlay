
Server <-
{
	Players = [],
	AR = 0,
	BankRobbery = 0,
	BankBomb = Vector( 0,0,0 ),
	BankRobTimer = 0,
	BankRobber = null,
	BankVault = CreateObject(4578, 0, Vector(-945.5955811, -342.62677, 7.583077908), 255),
	Restart = 21,
	EventCooldown = 0,
	Ignore = {},
	AdCooldown = 0,

	Event =
	{
		Event = 0,
		Timer = 0,
	}

	AdminPickup = {},

	EchoMessage = true,
}

MedicPos <- [ Vector( -883.101, -471.864, 13.1099 ), Vector( 493.654, 702.559, 12.1033 ), Vector( -137.176, -981.112, 10.4653 ), Vector( -137.176, -981.112, 10.4653 ), Vector( -822.674, 1140.28, 12.4111 ) ]
PolicePos <- [	Vector( 501.397, 512.665, 11.4859 ), Vector(-877.96, -678.159, 11.2101 ), Vector( -661.222, 767.597, 11.1652 ), Vector( 405.916, -477.516, 10.0662) ]

function onScriptLoad()
{
	print( "Starting Virtual Reality RolePlay" );

	dofile( "cnr/cnr_player.nut", true );
	dofile( "cnr/cnr_misc.nut", true );
	dofile( "cnr/cnr_sphere.nut", true );
	dofile( "cnr/cnr_robbery.nut", true );
	dofile( "cnr/cnr_cop.nut", true );
	dofile( "cnr/cnr_swapscreen.nut", true );
	dofile( "cnr/cnr_vehicle.nut", true );
	dofile( "cnr/cnr_items.nut", true );
	dofile( "cnr/cnr_pickup.nut", true );
	dofile( "cnr/cnr_kidnap.nut", true );
	dofile( "cnr/mfi_admin.nut", true );
	dofile( "cnr/mcf_irc.nut", true );
	dofile( "cnr/skyapi_mysql.nut", true );
	//dofile( "cnr/skyapi_sqlite.nut", true );
	dofile( "cnr/cnr_medic.nut", true );
	dofile( "cnr/cnr_house.nut", true );
	//dofile( "cnr/cnr_gang.nut", true );
	dofile( "cnr/cnr_area.nut", true );
	dofile( "cnr/cnr_msg.nut", true );
	dofile( "cnr/cnr_event.nut", true );
	dofile( "cnr/_NPCHandler.nut", true );
	dofile( "lang.nut", true );
	dofile( "cnr/cnr_object.nut", true );
	dofile( "cnr/cnr_admin_be.nut", true );
	dofile( "cnr/cnr_shop.nut", true );
	dofile( "cnr/cnr_timer.nut", true );
	//dofile( "cnr/cnr_discord_be.nut", true );
	//dofile( "cnr/cnr_discord.nut", true );
	dofile( "cnr/FBS-Echo.nut", true );
	//dofile( "cnr/Editor.nut", true );
	dofile( "cnr/cnr_group.nut", true );
	dofile( "cnr/cnr_spawn.nut", true );
	dofile( "cnr/cnr_job.nut", true );
	dofile( "cnr/cnr_trucker.nut", true );
	dofile( "cnr/cnr_radio.nut", true );
	dofile( "cnr/cnr_criminal.nut", true );

	dofile( "cnr/commands/playercmd.nut", true );
	dofile( "cnr/commands/copcmd.nut", true );
	dofile( "cnr/commands/groupcmd.nut", true );
	dofile( "cnr/commands/vehiclecmd.nut", true );
	dofile( "cnr/commands/jobcmd.nut", true );
	dofile( "cnr/commands/mediccmd.nut", true );
	dofile( "cnr/commands/rpcmd.nut", true );
	dofile( "cnr/commands/shopcmd.nut", true );
	dofile( "cnr/commands/bankcmd.nut", true );
	dofile( "cnr/commands/animcmd.nut", true );
	dofile( "cnr/commands/criminalcmd.nut", true );
	dofile( "cnr/commands/housecmd.nut", true );

	//dofile( "Json.nut", true );
	
	//mysql <- null;
   //::mysql = ::mysql_connect("localhost", "root", "test", "panel");
		//if( mysql ) ::print( "\r Connected to MySQL databse!" );
		//else ::print( "\r Could not connect to MySQL databse. Please try again later." );

	db <- ConnectSQL( "skylarks.db" );
	mmdb <- MMDB("GeoLite2-City.mmdb");
	database <- ConnectSQL( "vcmp.db" );

	//logsdb <- ConnectSQL("logs.db");
	
	//supportdb <- ConnectSQL("support.db");
	
	//rp <- ConnectSQL("report.db");
	//QuerySQL(rp, "create table if not exists report ( Plr TEXT, Name TEXT, Reason TEXT, Day VARCHAR(25), Month VARCHAR(25), Year VARCHAR(25), Hour VARCHAR(25), Min VARCHAR(25) )");

	skydb <- null;
	skydb <- ConnectSQL( "skydb.db" );
	mysqldb <- MySQLDB();
	mysqldb.ConnectMySQL();
	adminv2 <- CAdmin();

	LoadSphere();
	LoadServerInfo();
	LoadVehicle();
	LoadPickup();
//	LoadAlias();
//	LoadBans();
//	LoadGang();
	LoadArea();
	LoadObject();
	//LoadLUIRC();
	GangLoad();
	LoadRadio();
	LoadShopMarker();
	LoadAreaName();

	//SetPassword("n00bb00b$#")
	//LoadDiscord();

	ActivateEcho();

	Server.AR = time();
//	seterrorhandler( errorHandling );
	srand( time() );
	
	impoundgater <- CreateObject( 310, 1, -1176.46, -1215.73, 14.0462, 255 );
	impoundgater.RotateByEuler( Vector( 0, 0, 1.55), 0);

	HideMapObject(4578, -945.595581, -342.626770, 7.583078);

	NewTimer( "AutoRun", 1000, 0 );
	NewTimer( "CheckArea", 1500, 0 );
	//NewTimer( "RandomMessage", 300000, 0 );

	CreateMarker( 1, Vector( 501.397, 512.665, 11.4859 ), 1, RGB( 255, 255, 0 ), 100 );
	CreateMarker( 1, Vector( -877.96, -678.159, 11.2101 ), 1, RGB( 255, 255, 0 ), 100 );
	CreateMarker( 1, Vector( -661.222, 767.597, 11.1652 ), 1, RGB( 255, 255, 0 ), 100 );
	CreateMarker( 1, Vector( 405.916, -477.516, 10.0662 ), 1, RGB( 255, 255, 0 ), 100 );
	CreateMarker( 1, Vector( -935.85, -351.315, 17.8038 ), 1, RGB( 255, 255, 0 ), 101 );

	CreateMarker( 1, Vector( 458.158, 342.59, 11.8031 ), 2, RGB( 255, 0, 0 ), 0 );
	CreateMarker( 1, Vector( -691.498, 1047.32, 11.324 ), 2, RGB( 255, 0, 0 ), 0 );
	CreateMarker( 1, Vector( -1058.39, -478.524, 11.0877 ), 2, RGB( 255, 0, 0 ), 0 );
	CreateMarker( 1, Vector( -735.726, -1465.52, 11.3256 ), 2, RGB( 255, 0, 0 ), 0 );

	DeleteOldPickup();
	
	// =============================================================== MAP EDITOR STUFF ====================================================
	
	// =========================================== ARRAYS ==============================================
	//pData <- array( GetMaxPlayers(), null );
	//Object <- array( GetMaxPlayers(), null );
	
	// =========================================== DATABASE ============================================
//	Maps <- ConnectSQL( "cnr/Maps.sqlite" );
//	locdb <- ConnectSQL( "cnr/locations.sqlite" );
	
	// =========================================== GLOBAL ==============================================
	//CurrentMap <- "";
	//objCreated <- 0;
	
	// =========================================== FILES ===============================================
	//dofile( "cnr/FileHandler.addon", true );
	//dofile( "cnr/Freeview.addon", true );
	//onCamScriptLoad();
	
	// =========================================== BINDS ===============================================
	/*enter <- BindKey( true, 0x0D, 0, 0 );
	del <- BindKey( true, 0x2E, 0, 0 );
	backspace <- BindKey( true, 0x08, 0, 0 );
	R <- BindKey( true, 0x52, 0, 0 );
	one <- BindKey( true, 0x31, 0, 0 );
	two <- BindKey( true, 0x32, 0, 0 );
	ctrl <- BindKey( true, 0x11, 0, 0 );
	c <- BindKey(true, 0x43, 0, 0 );
	PageUp <- BindKey( true, 0x21, 0, 0 );
	PageDown <- BindKey( true, 0x22, 0, 0 );
	ArrowUp <- BindKey( true, 0x26, 0, 0 );
	ArrowDown <- BindKey( true, 0x28, 0, 0 );
	ArrowLeft <- BindKey( true, 0x25, 0, 0 );
	ArrowRight <- BindKey( true, 0x27, 0, 0 );*/
	
	// =========================================== TIMERS ==============================================
	//NewTimer( "AutoSave", cAutoSaveTime, 0 );
	
	// =========================================== PRINTS ==============================================
	/*print( "Map Editor successfully started!" );
	print( "Map Editor successfully running! ");*/
	// ============================================== MAP EDITOR STUFF ENDS HERE ===========================

	print( "Sucsessfully loaded." );

	/*GangCreate( "Vice City Police Department", "VCPD", "Rixardo_Gomez", "Goverment" );
	GangCreate( "Special Weapon and Tactic", "SWAT", "Rixardo_Gomez", "Goverment" );
	GangCreate( "Federal Bureau of Investigation", "FBI", "Rixardo_Gomez", "Goverment" );
	GangCreate( "Vice City Medical Department", "EMS", "Rixardo_Gomez", "Goverment" );*/	
	/*local items = "Used Computer - Weight: 82 Reward: $527 Location: TruckerVicePort"
	local splititem = split( items, "-" ),
	getpreweight = SearchAndReplace( splititem[1], "Weight:", "" ),
	getweight = split( getpreweight, "Reward" )[0],
	getprereward = SearchAndReplace( splititem[1], "Reward: $", "" ),
	getreward = split( getprereward, " " )[3],
	getpreloc = SearchAndReplace( splititem[1], "Location: ", "" ),
	getlocation = GetTok( getpreloc, " ", 6, NumTok( getpreloc, " " ) );
	 
	print( splititem[1]  );
	print( getweight );
	print( getreward );	
	print( getlocation );*/	


	//foreach( index in p ) print( index + " " + GetSkinName( index ).tolower() );

	/*AddAmmuItem( "ammu-1" );
	AddAmmuItem( "ammu-2" );
	AddAmmuItem( "ammu-3" );*/

	//for( local i = 1; i < 6; i++ ) { print( i );}
	//AddDMItem("black-market")

	/*AddToolsItem( "tools-1" );
	AddToolsItem( "tools-2" );
	AddToolsItem( "tools-3" );
*/
}

function onScriptUnload()
{
	::mysql_query( mysql, "delete from onlineplayers" );
	print( "Script is unloading" );
}

function onPlayerJoin( player )
{
	::mysql_query( mysql, "insert into onlineplayers values ( '" + player.Name + "', '" + "0" + "' )" );
	playa[ player.ID ] = Player();
	Server.Players.push( player.ID );
	Server.Ignore.rawset( player.ID, {} );

	adminv2.Join( player );
		
	MsgPlr( 10, player, Lang.WelcomeMessage );

//	MsgPlr( 3, player, Lang.GivePin );
//	AddQuatity( player, 4, "5");

EchoMessage( "**Players Online** [" + ( GetPlayers()-1 ) + "/" + GetMaxPlayers() + "]" );

/*onCamPlayerJoin( player )
	pData[ player.ID ] = PlayerData( player.Name );
	Object[ player.ID ] = null;*/
}

function onPlayerRequestSpawn( player )
{
	/*if( playa[ player.ID ].Logged  == false ) return;
	if( (  player.Skin == 1 || player.Skin == 120 || player.Skin == 97 || player.Skin == 98 || player.Skin == 2 || player.Skin == 3 ) && playa[ player.ID ].Wanted > 0 ) return MsgPlr( 2, player, Lang.WantedCop );
	if( ( player.Skin == 2 ) && playa[ player.ID ].Copskill < 200 ) return MsgPlr( 2, player, Lang.Cop250Skill );
	if( ( player.Skin == 3 ) && playa[ player.ID ].Copskill < 500 ) return MsgPlr( 2, player, Lang.Cop500Skill );
	if( ( player.Skin == 194 ) && playa[ player.ID ].Copskill < 500 ) return MsgPlr( 2, player, Lang.Cop500Skill );
	if( ( player.Skin == 192 ) && playa[ player.ID ].Copskill < 500 ) return MsgPlr( 2, player, Lang.Cop500Skill );
	if( ( player.Skin == 122 ) && playa[ player.ID ].Copskill < 200 ) return MsgPlr( 2, player, Lang.Cop250Skill );
	if( ( player.Skin == 4 ) && playa[ player.ID ].Copskill < 1000 ) return MsgPlr( 2, player, Lang.Cop1kSkill );
	if( playa[ player.ID ].Jailtime ) return JailSpawn( player );
	else
	{
		if( !playa[ player.ID ].OnSpawnMenu )
		{
			switch( player.Skin )
			{
				case 7:
				case 11:
				case 15:
				case 29:
				case 30:
				case 13:
				case 14:
				case 22:
				case 24:
				case 35:
				if( playa[ player.ID ].Autospawn == true ) SendDataToClient( 6800, "dead", player );
				else SendDataToClient( 6800, "join", player );

				playa[ player.ID ].OnSpawnMenu = true;
				playa[ player.ID ].JobID = "0";
				break;

				case 1:
				case 120:
				case 97:
				case 98:
				player.Spawn();

				playa[ player.ID ].JobID = "cop:1";

				player.Armour = 50;
				player.World = 0;

				_Timer.Create( this, function()
				{
					player.Pos = PolicePos[ rand()% PolicePos.len() ];
					player.SetWeapon( 17, 200 );
					player.SetWeapon( 19, 400 );
					player.SetWeapon( 4, 50 );
				}, 1000, 1 );

				MsgPlr( 10, player, Lang.CopHelp );
				MsgPlr( 10, player, Lang.CopHelp2 );
				break;

				case 5:
				player.Spawn();

				playa[ player.ID ].JobID = "3";
				
				_Timer.Create( this, function()
				{
					player.Pos = MedicPos[ rand()% MedicPos.len() ];
				}, 1000, 1 );

				MsgPlr( 10, player, Lang.Medhelp );
				MsgPlr( 10, player, Lang.MedicHelp2 );
				break;

				case 2:
				player.Spawn();

				playa[ player.ID ].JobID = "cop:2";

				player.Armour = 100;
				player.World = 0;

				_Timer.Create( this, function()
				{
					player.Pos = PolicePos[ rand()% PolicePos.len() ];
					player.SetWeapon( 17, 200 );
					player.SetWeapon( 21, 200 );
					player.SetWeapon( 24, 350 );
					player.SetWeapon( 14, 50 );
				}, 1000, 1 );

				MsgPlr( 10, player, Lang.CopHelp );
				MsgPlr( 10, player, Lang.CopHelp2 );
				break;

				case 194:
				case 192:
				case 3:
				player.Spawn();

				playa[ player.ID ].JobID = "cop:3";

				player.Armour = 100;
				player.World = 0;

				_Timer.Create( this, function()
				{
					player.Pos = PolicePos[ rand()% PolicePos.len() ];
					player.SetWeapon( 17, 500 );
					player.SetWeapon( 20, 50 );
					player.SetWeapon( 26, 200 );
				}, 1000, 1 );

				MsgPlr( 10, player, Lang.CopHelp );
				MsgPlr( 10, player, Lang.CopHelp2 );
				break;
				
				case 4:
				player.Spawn();

				playa[ player.ID ].JobID = "cop:4";

				player.Armour = 100;
				player.World = 0;

				_Timer.Create( this, function()
				{
					player.Pos = PolicePos[ rand()% PolicePos.len() ];
					player.SetWeapon( 17, 200 );
					player.SetWeapon( 21, 200 );
					player.SetWeapon( 24, 350 );
					player.SetWeapon( 14, 50 );
				}, 1000, 1 );

				MsgPlr( 10, player, Lang.CopHelp );
				MsgPlr( 10, player, Lang.CopHelp2 );
				break;
			}
		}
		return;
	}*/
}

function onPlayerRequestClass( player, classID, team, skin )
{
	/*if( playa[ player.ID ].Logged )
	{
		if( playa[ player.ID ].Autospawn == true ) SendDataToClient( 6800, "dead", player );
		else SendDataToClient( 6800, "join", player );
	}*/

//	if( playa[ player.ID ].Autospawn ) return player.Spawn();
  //  player.SetCameraPos( Vector(6.38734+4, -1488.87-1, 13.4632-1.5),Vector(11.9443, -1492.89, 12.2538) );
/*	player.Angle = -0.00565672;
	switch( skin )
	{
		case 7:
		case 11:
		case 15:
		case 29:
		case 30:
		case 13:
		case 14:
		case 22:
		case 24:
		case 35:
		Announce("~h~Civilian", player, 1 );
		break;

		case 1:
		case 120:
		case 97:
		case 98:
		Announce("~b~Cop", player, 1 );
		break;

		case 2:
		case 122:
		Announce("~b~SWAT", player ,1 );
		break;

		case 194:
		case 192:
		case 3:
		Announce("~b~FBI", player, 1 );
		break;
		
		case 4:
		Announce("~b~ARMY", player, 1 );
		break;

		case 5:
		Announce("~p~Medic", player, 1 );
		break;

	}*/

	JailSpawn( player );

	if( !playa[ player.ID ].FirstJoin ) 
	{
		if( !playa[ player.ID ].Knocked.IsKnocked )
		{
			local hasjob = "false", hasprop = "false", hashq = "false";

			if( playa[ player.ID ].Job.JobID > 0 ) hasjob = "true";
			if( playa[ player.ID ].Group.len() > 0 ) hashq = "true";
			if( GetOwnedHouseCount( player ) > 0 ) hasprop = "true"

			SendDataToClient( 9400, hasjob + ";" + hasprop + ";" + hashq, player );
		}

		else 
		{
			player.Spawn();

		 	player.Pos = playa[ player.ID ].LastPos2
			player.World = playa[ player.ID ].LastWorld;
			player.Skin = playa[ player.ID ].LastUsedSkin;
			player.IsFrozen = true;
			player.Health = 100;

			_Timer.Create( this, function() 
			{
				SpawnCivilWeaponSilent( player );
			}, 500 , 1 );
			
			playa[ player.ID ].Knocked.Timer = _Timer.Create( this, function()
			{
				if( ( time() - playa[ player.ID ].Knocked.Time ) < 120 )
				{
					player.SetAnim( 0, 43 );

					player.IsFrozen = true;

					Announce( "You are knocked", player, 3 );
					Announce( ( 120 - ( time() - playa[ player.ID ].Knocked.Time ) ) +" seconds before you can ~r~/accept death", player, 1 );
				}

				else 
				{
					player.SetAnim( 0, 43 );
					player.Health -= 1;
					
					if( player.Health < 2 ) player.IsFrozen = false;
					else player.IsFrozen = true;
					
					Announce( "You are knocked", player, 3 );
					Announce( " you can now ~r~/accept death", player, 1 );
				}
			}, 2000, 0 );
		}
	}


}

function onPlayerSpawn( player )
{
	onPlayerExitWorld( playa[ player.ID ].LastWorld );

	//HandleSpawn( player );

	if( playa[ player.ID ].Autospawn == false ) playa[ player.ID ].Autospawn = true;

	//if( playa[ player.ID ].JobID.find("cop") == null ) SpawnPlayerWeapon( player );

	player.SetWantedLevel( playa[ player.ID ].Suspect.len() );
    if ( player.WantedLevel > 5 ) player.SetWantedLevel( 6 );

	player.CanAttack = true;
	

		
	
	// =================================================
	//NewTimer( "ClientRender", 1000, 0, player.ID );
}

function onPlayerPart( player, reason )
{
	::mysql_query( mysql, "delete from onlineplayers where player = '" + player.Name + "' " );
	local oldworld = player.World;

	FindCuffedPlayer( player, playa[ player.ID ].Cuff );
	FindCuffPlayer( player );
	CancelReviveVictim( player );
	CancelRevive( player );
	CancelCaller( player );
	CancelCalled( player );
	DestroyFixVehicle( player );

	_Timer.Destroy( playa[ player.ID ].RobTimer );
	_Timer.Destroy( playa[ player.ID ].CuffTimer );
	_Timer.Destroy( playa[ player.ID ].Mute );
	_Timer.Destroy( playa[ player.ID ].Healing );
	_Timer.Destroy( playa[ player.ID ].Knocked.Timer );
	_Timer.Destroy( playa[ player.ID ].PaycheckTimer );

	if( playa[ player.ID ].Jailtimer )  playa[ player.ID ].Jailtimer.Stop();
	if( playa[ player.ID ].JobID.find("cop") == null ) SavePlayerWeapon( player );
	if( playa[ player.ID ].House == null && !noPolyZone( player ) ) playa[ player.ID ].LastPos = player.Pos;
	if( playa[ player.ID ].Knocked.Corps ) RemoveCorps2( playa[ player.ID ].Knocked.Corps );
	
	SaveObj( player );
	ClearJailSlot( player );
	
	//	if( playa[ player.ID ].Kidnapper ) FindKinapper( playa[ player.ID ].Kidnapper.Name );
	//	if( playa[ player.ID ].Kidnapper ) FindVictim( playa[ player.ID ].Kidnapper.Name, 1 );
//		if( playa[ player.ID ].vehicleTimer ) DelMarker( player );

	playa[ player.ID ].SaveData( player );

//	if( playa[ player.ID ].Logged ) MsgAll( 1, Lang.PartAll, GetIngameTag( player ), PartReason( reason ).Game );
	EchoMessage( "**" + player.Name + "** has **" + PartReason( reason ).IRC + "**." );
	
    local result = null, getCount = 0;
    foreach( index, value in Server.Players )
    {
        local player = FindPlayer( value )
        {
            if( result ) result = result + ", " + player.Name;
            else result = player.Name;
        }
        getCount ++;
    }

    EchoMessage( "**Players Online** [" + ( GetPlayers()-1 ) + "/" + GetMaxPlayers() + "]" );

	adminv2.Save( player.UID, player.UID2 );

	
	if( Server.Players.find( player.ID ) >= 0 ) Server.Players.remove( Server.Players.find( player.ID ) );
    playa[ player.ID ] = null;

    onPlayerExitWorld( oldworld );

    //Discord_SetStatus( "Players Online [" + ( GetPlayers()-1 ) + "/" + GetMaxPlayers() + "]" );
	
	//onCamPlayerPart( player, reason )
	//pData[ player.ID ].Editing = false;
	//pData[ player.ID ] = null;
	//Object[ player.ID ] = null;
}

function onPlayerDeath( player, reason )
{
//	::mysql_query( mysql, "INSERT INTO killlogs ( Target, Reason ) VALUES ( '" + player.Name + "', '" + reason + "' )" );
	//QuerySQL( logsdb, "INSERT INTO logs ( Name, reason ) VALUES ( '" + player + "', '" + reason + "' )");
	FindCuffedPlayer( player, playa[ player.ID ].Cuff );
	FindCuffPlayer1( player );
	CancelReviveVictim( player );
	CancelRevive( player );
	CancelCaller( player );
	CancelCalled( player );
	SavePlayerWeapon( player );
	DestroyFixVehicle( player );
	
	_Timer.Destroy( playa[ player.ID ].RobTimer );
	_Timer.Destroy( playa[ player.ID ].CuffTimer );
	_Timer.Destroy( playa[ player.ID ].Healing );
	if( playa[ player.ID ].Kidnapper ) FindVictim( playa[ player.ID ].Kidnapper.Name, 2 );
	if( playa [player.ID ].House != null ) playa[ player.ID ].House = null;
//	if( playa[ player.ID ].JobID.find("cop") == null ) SavePlayerWeapon( player );

	playa[ player.ID ].LastPos = GetNearestHospital( player.Pos );
	playa[ player.ID ].LastPos2 = player.Pos;
	playa[ player.ID ].LastWorld = player.World;
	playa[ player.ID ].LastUsedSkin = player.Skin;

	if( !playa[ player.ID ].Knocked.IsKnocked ) 
	{
		playa[ player.ID ].Knocked.IsKnocked = true;

		player.Colour = RGB( 140, 140, 140 );

		playa[ player.ID ].Knocked.Corps = AddCorps( player.Pos, player.Name );
		playa[ player.ID ].Knocked.Time = time();

		MsgPlr( 3, player, Lang.KnockedMsg );
		MsgPlr( 3, player, Lang.KnockedMsg2 );

		Announce( "You are knocked", player, 3 );
		Announce( ( 120 - ( time() - playa[ player.ID ].Knocked.Time ) ) +" seconds before you can ~r~/accept death", player, 1 );
	}

	else 
	{
		playa[ player.ID ].Knocked.IsKnocked = false;
		_Timer.Destroy( playa[ player.ID ].Knocked.Timer );
		playa[ player.ID ].Weapon = {};
		playa[ player.ID ].Suspect = {};
        playa[ player.ID ].CarryBody.Status = 0;
        playa[ player.ID ].CarryBody.CarryID = null;

		player.SetWantedLevel( 0 );
		UpdateCorps2( playa[ player.ID ].Knocked.Corps );

		Announce( "", player, 3 );
		Announce( "", player, 1 );

        MessageToAllEMS( "Dispatch", "BodySpot", IsPlayerInArea( player.Pos.x, player.Pos.y ) );
        MessageToAllLaw( "Dispatch", "BodySpot1", IsPlayerInArea( player.Pos.x, player.Pos.y ) );
	}
	
	//MsgAll( 11, Lang.DeathMsg, GetIngameTag( player ) );

	//Message( "[#ff8888]" + player.Name + " [#ffffff]has died. Possible cause: [#33cc33]" + GetCustomWeaponName( reason ) + "." );
	EchoMessage( "**" + player.Name + "** has died. Possible cause **" + GetCustomWeaponName( reason ) + "**" );

	ClearJail( player );
	SaveObj( player );

	SendDataToClient( 6043, null, player );

	//AddCorps( player.Pos );
}

function onPlayerKill( killer, player, reason , body )
{
	::mysql_query( mysql, "INSERT INTO killlogs ( Target, Killer, Bodypart, Reason ) VALUES ( '" + player.Name + "', '" + killer.Name + "', '" + body + "', '" + reason + "' )" );
	//QuerySQL( logsdb, "INSERT INTO logs ( Name, killer, reason ) VALUES ( '" + player + "', '" + killer + "', '" + reason + "' )");
	
	FindCuffedPlayer( player, playa[ player.ID ].Cuff );
	FindCuffPlayer1( player );
	CancelReviveVictim( player );
	CancelRevive( player );
	CancelCaller( player );
	CancelCalled( player );
	SavePlayerWeapon( player );
	//DropPlayerItem( player );
	DestroyFixVehicle( player );

	_Timer.Destroy( playa[ player.ID ].RobTimer );
	_Timer.Destroy( playa[ player.ID ].CuffTimer );
	_Timer.Destroy( playa[ player.ID ].Healing );
	if( playa[ player.ID ].Kidnapper ) FindVictim( playa[ player.ID ].Kidnapper.Name, 2 );
	if( playa[ killer.ID ].JobID.find("cop") == null && playa[ player.ID ].JobID.find("cop") >= 0 ) playa[ killer.ID ].AddWanted( killer, 2 );
	//if( playa[ player.ID ].Wanted > 0 && playa[ player.ID ].Jailtimer == null ) playa[ player.ID ].ClearWanted( player );
	if( playa [ player.ID ].House != null ) playa[ player.ID ].House = null;
//	if( playa[ player.ID ].JobID.find("cop") == null ) SavePlayerWeapon( player );

	playa[ player.ID ].LastPos = GetNearestHospital( player.Pos );
	playa[ player.ID ].LastPos2 = player.Pos;
	playa[ player.ID ].LastWorld = player.World;
	playa[ player.ID ].LastUsedSkin = player.Skin;

	if( !playa[ player.ID ].Knocked.IsKnocked ) 
	{
		playa[ player.ID ].Knocked.IsKnocked = true;

		player.Colour = RGB( 140, 140, 140 );

		playa[ player.ID ].Knocked.Corps = AddCorps( player.Pos, player.Name );
		playa[ player.ID ].Knocked.Time = time();

		MsgPlr( 3, player, Lang.KnockedMsg );
		MsgPlr( 3, player, Lang.KnockedMsg2 );

		Announce( "You are knocked", player, 3 );
		Announce( ( 120 - ( time() - playa[ player.ID ].Knocked.Time ) ) +" seconds before you can ~r~/accept death", player, 1 );
	}

	else 
	{
		if( !IsLawE( killer ) )
		{
			playa[ killer.ID ].Suspect.rawset( ( playa[ killer.ID ].Suspect.len() + 1 ), { "Reason": "Murder of " + player.Name, "Author": "Server", "Date": time().tostring() } );
			killer.SetWantedLevel( ( playa[ killer.ID ].Suspect.len() + 1 ) );
			if ( killer.WantedLevel > 5 ) killer.SetWantedLevel( 6 );
		}

		playa[ player.ID ].Knocked.IsKnocked = false;
		_Timer.Destroy( playa[ player.ID ].Knocked.Timer );
		playa[ player.ID ].Weapon = {};
		playa[ player.ID ].Suspect = {};
    	playa[ player.ID ].CarryBody.Status = 0;
        playa[ player.ID ].CarryBody.CarryID = null;

		player.SetWantedLevel( 0 );
		UpdateCorps2( playa[ player.ID ].Knocked.Corps );

		Announce( "", player, 3 );
		Announce( "", player, 1 );

        MessageToAllEMS( "Dispatch", "BodySpot", IsPlayerInArea( player.Pos.x, player.Pos.y ) );
        MessageToAllLaw( "Dispatch", "BodySpot1", IsPlayerInArea( player.Pos.x, player.Pos.y ) );
	}
	//else 
	//Message( "[#990000][Kill] " + ::GetIngameTag( killer ) + " [#ffffff]killed " + ::GetIngameTag( player ) + " [#ffffff]with [#33cc33]" + ::GetCustomWeaponName( reason ) );

	ClearJail( player );
	SaveObj( player );

	SendDataToClient( 6043, null, player );
	//AddCorps( player.Pos );

/*	if( playa[ killer.ID ].JobID.find("cop") == null )
	{
		MsgAll( 11, Lang.KillAll, GetIngameTag( killer ), GetIngameTag( player ), GetCustomWeaponName( reason ) );

		return;
	}*/

	if( ( playa[ killer.ID ].JobID.find("cop") >= 0 ) && ( playa[ player.ID ].JobID.find("cop") >= 0 ) )
	{
		local getCash = ( playa[ killer.ID ].Cash > 10 ) ? ( playa[ killer.ID ].Cash / 2 ) : 0;

		MsgAll( 11, Lang.KillAllTeam, GetIngameTag( killer ), GetIngameTag( player ), GetCustomWeaponName( reason ) );
		EchoMessage( "**" + killer.Name + "** team-killed **" + player.Name + "** with **" + GetCustomWeaponName( reason ) + "**"  );

		if( getCash != 0 )
		{
			playa[ killer.ID ].DecCash( killer, 1 );

			MsgPlr( 2, killer, Lang.WarningTeamKill, getCash ); 
		}

		return;
	}

/*	if( playa[ killer.ID ].JobID.find("cop") == null && playa[ player.ID ].JobID.find("cop") == null )
	{
		MsgAll( 11, Lang.KillAll, GetIngameTag( killer ), GetIngameTag( player ), GetCustomWeaponName( reason ) );
		EchoMessage( "**" + killer.Name + "** killed **" + player.Name + "** with **" + GetCustomWeaponName( reason ) + "**"  );

		playa[ killer.ID ].AddWanted( killer, 2 );
	}

	else 
	{
		if( playa[ player.ID ].Wanted > 0 )
		{
			MsgAll( 11, Lang.KillAllC, GetIngameTag( killer ), GetIngameTag( player ), GetCustomWeaponName( reason ) );
			EchoMessage( "**" + killer.Name + "** killed suspect **" + player.Name + "** with **" + GetCustomWeaponName( reason ) + "**"  );

			local getCash = ( playa[ killer.ID ].Cash > 10 ) ? ( playa[ killer.ID ].Cash / 2 ) : 0;
			local rewards = ( getCash == 0 ) ? 1000 : getCash;

			if( getCash > 0 ) 
			{
				MsgPlr( 3, killer, Lang.CopKillReward, GetIngameTag( player ), rewards, 1 );
				//MsgPlr( 2, plr, Lang.JailPlr2, rewards );
			}

			else MsgPlr( 3, killer, Lang.CopKillReward2, GetIngameTag( player ), rewards, 1 );

			playa[ killer.ID ].Copskill += 1;
			playa[ killer.ID ].AddCash( killer, rewards );
			
			playa[ player.ID ].ClearWanted( player );
		}
		else 
		{
			MsgAll( 11, Lang.KillAll, GetIngameTag( killer ), GetIngameTag( player ), GetCustomWeaponName( reason ) );
			EchoMessage( "**" + killer.Name + "** killed **" + player.Name + "** with **" + GetCustomWeaponName( reason ) + "**"  );
		}
	}*/
}

function onPlayerTeamKill( killer, player, reason, body )
{
	return onPlayerKill( killer, player, reason , body )
}

function onPlayerChat( player , text )
{
	//::mysql_query( mysql, "INSERT INTO chatlog ( Name, Time, Chat ) VALUES ( '" + player.Name + "', '" + time() + "', '" + text + "' )" );
	if( !playa[ player.ID ].Logged ) return MsgPlr( 2, player, Lang.CantChatNotLogged );
	if( playa[ player.ID ].Mute ) return MsgPlr( 2, player, Lang.MutedCantChat );

	/*if ( text.slice( 0, 1 ) == "!" && playa[ player.ID ].Gang )
	{
		MsgGang( playa[ player.ID ].Gang , Lang.GangChat, GetIngameTag( player ), text.slice( 1 ) );
		SendMsgToGangIRC( "" + player.Name + ": " + text.slice( 1 ), playa[ player.ID ].Gang );
		return 0;
	}*/

	//legacyMessage( GetIngameTag( player ) + "[#ffffff]: " + text );
	//EchoMessage( ( ( gang.rawin( playa[ player.ID ].Gang ) == true ) ? "[" + gang.rawget( playa[ player.ID ].Gang ).Name + "] " : "" ) + "**" + player.Name + "**: " + text );

/*	if( ( time() - playa[ player.ID ].LastSaid ) < 1 && playa[ player.ID ].Level < 2 )
	{
		MutePlayer( player , "Server", "Spamming", "0:30" );
	}
	else playa[ player.ID ].LastSaid = time();*/

	switch( playa[ player.ID ].Chatmode )
	{
		case "public":
		local getIgnorePlayer = Server.Ignore.rawget( player.ID );
		local plr;
		for( local i = 0; i < GetMaxPlayers(); i ++ )
		{
			plr = FindPlayer( i );
			if ( plr )
			{
				local getIgnorePlr = Server.Ignore.rawget( plr.ID );

			//	if( getIgnorePlayer.rawin( plr.ID ) ) continue;
				if( getIgnorePlr.rawin( playa[ player.ID ].ID ) ) continue;

				if( playa[ plr.ID ].Logged )
				{
					MessagePlayer( RGBToHex( player.Colour ) + player.Name + "[#ffffff]: " + text, plr );
				}
					
				else
				{
					if( playa[ plr.ID ].Logged )
					{
						MessagePlayer( RGBToHex( player.Colour ) + player.Name + "[#ffffff]: " + text, plr );
					}
				}
			}
		}
		break;

		case "local":
		if( !playa[ player.ID ].Knocked.IsKnocked )
		{
			for( local i = 0; i < GetMaxPlayers(); i ++ )
			{
				local plr = FindPlayer( i );
				if( plr )
				{
					if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
					{
						MessagePlayer( format( Lang.LocalChat[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
					}
				}
			}
		}
		else MsgPlr( 2, player, Lang.CantChatKnocked );
		break;

		case "phone":
		local plr2 = null;
		if( playa[ player.ID ].PhoneS.Caller != -1 )
		{
			local plr = FindPlayer( playa[ player.ID ].PhoneS.Caller ), plr2 = plr.ID;

			MsgPlr( 3, plr, Lang.OnPhoneTarget, playa[ plr.ID ].Phone, text );

		}

		if( playa[ player.ID ].PhoneS.Called != -1 )
		{
			local plr = FindPlayer( playa[ player.ID ].PhoneS.Called ), plr2 = plr.ID;

			MsgPlr( 3, plr, Lang.OnPhoneTarget, playa[ plr.ID ].Phone, text );
			
		}

		MsgPlr( 3, player, Lang.OnPhone, text );

        for( local i = 0; i < GetMaxPlayers(); i ++ )
        {
        	local plr = FindPlayer( i );
            if( plr )
            {
                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
				{
                	if( plr.ID != player.ID ) continue;
                	if( plr.ID != plr2 ) continue;
					
					MessagePlayer( format( Lang.OnPhoneLocal[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                }
            }
        }
		break;
	}

	//QuerySQL( logsdb, "INSERT INTO logs ( Name, chat ) VALUES ( '" + player.Name + "', '" + text + "' )");
	
}

function onPlayerCommand( player, cmd, text )
{
	::mysql_query( mysql, "INSERT INTO commandlog ( Name, Time, Command ) VALUES ( '" + player.Name + "', '" + time() + "', '" + text + "' )" );
	//QuerySQL( logsdb, "INSERT INTO logs ( Name, cmd ) VALUES ( '" + player.Name + "', '" + cmd + " " + text + "'  )");
	print( "[" + player.Name + "] Command used: " + cmd + " " + ( ( text == null ) ? "" : text ) );
	
	local p = playa[ player.ID ];
	
	//if( playa[ player.ID ].ViewCmds == true )
	//{
	//if( playa[ player.ID ].Level < 5 )
	//{
	//MsgStaff( GetIngameTag( player ) + " [#42f595]used command: [#ffffff](/" + cmd + ") " + text );
	//}
	//}
/*
	if( ( time() - playa[ player.ID ].LastSaid ) < 1 && playa[ player.ID ].Level < 2 )
	{
		MutePlayer( player , "Server", "CMD Spam", "0:30" );
	}
	else playa[ player.ID ].LastSaid = time();*/


	switch( cmd.tolower() )
	{
		case "spec":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				if( text != "off" )
				{
					local plr = FindPlayer( text );
					MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]is now spectating " + GetIngameTag( plr ) );
					MessagePlayer("[#42f58a]You are now spectating " + GetIngameTag( plr ) + ". [#ffffff]Use /spec off to stop spectating.", player );
					player.SpectateTarget = plr;
				}
				if( text == "off" )
				{
					MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]is no longer spectating.");
					MessagePlayer("[#42f58a]You have stopped spectating.", player );
					player.SpectateTarget = player;
				}
				else if (!text) MessagePlayer("[#e600e6][Server] [#ff5050]Syntax, [#ffffff]/spec <player>", player ); break;
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "adminarea":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has teleported to Admin Area.");
				MessagePlayer("[#42f58a]Welcome to Admin Area!", player );
				player.World = 1;
				player.Pos = Vector(-1353.35, -34.3619, 424.409);
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "gotobank":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has teleported to the Bank.");
				//MessagePlayer("[#42f58a]Welcome to Admin Area!", player );
				player.World = 1;
				player.Pos = Vector(-894.418, -340.858, 13.4576);
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "gotoss":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has teleported to Sunshine Autos.");
				player.World = 1;
				player.Pos = Vector(-1028.97, -897.854, 14.0508);
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "gotohospital":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has teleported to Hospital Interior.");
				player.World = 1;
				player.Pos = Vector(-159.469, -930.054, 608.302);
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
	/*	case "support":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					MsgStaff( "[#ff3399][SUPPORT] Player " + GetIngameTag( player ) + " [#ffffff]has opened a support ticket. Use /tickets to view the support ticket.");
					MessagePlayer("[#42f58a]You have opened a support ticket for [#ffffff]" + text, player );
					local now = date();
					local reason = GetTok( text, " ", 2 NumTok( text, " " ) );
					//local id = 0;
					//id++;
					//QuerySQL( supportdb, "INSERT INTO tickets ( Player, Text, Day, Month, Year, Hour, Min ) VALUES ( '" + player.Name + "', '" + text + "', '" + now.day + "/', '" + now.month + "/', '" + now.year + "/', '" + now.hour + ":', '" + now.min + "' )" );
					//QuerySQL( rp, "INSERT INTO report ( Plr, Name, Reason, Day, Month, Year, Hour, Min ) VALUES ( '" + plr.Name + "', '" + player.Name + "', '" + reason + "', '" + now.day + "/', '" + now.month + "/', '" + now.year + "/', '" + now.hour + ":', '" + now.min + "' )" );
				}
				else MessagePlayer("[#e600e6][Server] [#ff5050]Syntax, [#ffffff]/support <text>", player ); break;
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/	
		/*case "tickets":
		if( p.Level >= 2 )
		{
			local query = QuerySQL( supportdb, "SELECT * FROM tickets" ), b=0;
			if ( !query ) MessagePlayer("[#bc0000]** No support tickets found in Database.",player);
			else 
			{
				while ( GetSQLColumnData( query, 0 ) != null )
				{ 
				MessagePlayer("[#42f58a]** Name:[ "+GetSQLColumnData( query, 0 )+" ] Text:[ "+GetSQLColumnData( query, 2 )+"] " + "[#ffffff]Date: " +GetSQLColumnData( query, 3 )+ ", Month: " + GetSQLColumnData( query, 4 ) + ", Year: " + GetSQLColumnData( query, 5 ) + ", Hour: " + GetSQLColumnData( query, 6 ) + ", Minute: " + GetSQLColumnData( query, 7 ) ,player );
				GetSQLNextRow( query );
				b++;
				}
			}
			FreeSQLQuery( query );
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;*/
		
	/*	case "usegate":
		if( p.Logged == true )
		{
			if( DistanceFromPoint(player.Pos.x, player.Pos.y, -1178.83, -1208.61 ) <= 10 )
			{
				if( p.Level >= 3 )
				{
					if( p.impoundgater == 0 )
					{
						impoundgater.MoveTo( Vector(-1176.56, -1206.48, 14.0462), 1000 );
						MessagePlayer("[#42f58a]You have opened the Admin Impound gate.", player );
						playa[ player.ID ].impoundgater = 1;
					}
					else
					{
						impoundgater.MoveTo( Vector(-1176.46, -1215.73, 14.0462), 1000 );
						MessagePlayer("[#42f58a]You have closed the Admin Impound gate.", player );
						playa[ player.ID ].impoundgater = 0;
					}
				}
				else
				{
					MessagePlayer("[#f5426c]You do not have permission to use this gate!", player);
				}
			}
			else
			{
				MessagePlayer("[#f5426c]You are not close enough to a gate!", player);
			}
			//if( text == "off" )
			//{
				//MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]is no longer spectating.");
				//MessagePlayer("[#42f58a]You have stopped spectating.", player );
				//player.SpectateTarget = player;
			//}
			//else MessagePlayer("[#e600e6][Server] [#ff5050]Syntax, [#ffffff]/spec <player>", player ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "cd":
		case "countdown":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				Message( "[#ffffff]" + player.Name + " has started a countdown" );
				NewTimer( "ClientMessageToAll", 1000, 1, "->     3",28, 255, 11 );
				NewTimer( "ClientMessageToAll", 2000, 1, "->     2",24, 255, 241 );
				NewTimer( "ClientMessageToAll", 3000, 1, "->     1",249, 57, 56 );
				NewTimer( "ClientMessageToAll", 4000, 1, "-----> GO <------",1000, 1500, 300 );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "gpshelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.GPSHELP );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		/*case "report":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if(!text) MessagePlayer("[#bc0000]/report <Player> <Reason>",player);
				else {
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					if ( !plr ) MessagePlayer( "Unknown Player.", player );
					{
						local reason = GetTok( text, " ", 2 NumTok( text, " " ) );
						if ( !reason ) MessagePlayer( "Give Reason.", player );
						else {
							local now = date();
							QuerySQL( rp, "INSERT INTO report ( Plr, Name, Reason, Day, Month, Year, Hour, Min ) VALUES ( '" + plr.Name + "', '" + player.Name + "', '" + reason + "', '" + now.day + "/', '" + now.month + "/', '" + now.year + "/', '" + now.hour + ":', '" + now.min + "' )" );
							MessagePlayer("[#23a300]Player has been reported successfully", player);
							MsgStaff( "[#737373][[#ff3399]Admin[#737373]] Player " + player.Name + " has reported " + GetIngameTag( plr ) + " Reason: " + reason + "");
						}
					}
				}
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "reportlist":
		if( p.Level >= 2 )
		{
			local query = QuerySQL( rp, "SELECT * FROM report" ), a=0;
			if ( !query ) MessagePlayer("[#bc0000]** No Players Are Reported.",player);
			else 
			{
				while ( GetSQLColumnData( query, 0 ) != null )
				{ 
				MessagePlayer("[#bc0000]** Player:[ "+GetSQLColumnData( query, 0 )+" ] Reported-Player:[ "+GetSQLColumnData( query, 1 )+"] " + "[#ffffff]Reason:[ "+GetSQLColumnData( query, 2 )+"], Date: " +GetSQLColumnData( query, 3 )+ ", Month: " + GetSQLColumnData( query, 4 ) + ", Year: " + GetSQLColumnData( query, 5 ) + ", Hour: " + GetSQLColumnData( query, 6 ) + ", Minute: " + GetSQLColumnData( query, 7 ) ,player );
				GetSQLNextRow( query );
				a++;
				}
			}
			FreeSQLQuery( query );
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;*/
		
	/*	case "loc":
		if( !GetItem( player, 5, 1 ) == true || !GetItem( player, 6, 1 ) == true || !GetItem( player, 7, 1 ) == true) MsgPlr( 2, player, Lang.NoGPS1 );
		else
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
					else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
					else
					{
						MessagePlayer(GetIngameTag( plr ) + "'s [#42e3f5]Location: " + "[#42f5aa]" + GetDistrictName(plr.Pos.y, plr.Pos.x) + ".", player);
					}
				}
				else
				{
				MessagePlayer("[#bc0000]Syntax, /loc [playername]", player);
				}
			}
		}
		break;
		
		case "dis":
		if( !GetItem( player, 6, 1 ) == true || !GetItem( player, 7, 1 ) == true ) MsgPlr( 2, player, Lang.NoGPS2 );
		else
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
					else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
					else
					{
						MessagePlayer(GetIngameTag( plr ) + "'s [#42e3f5]distance from you is: " + "[#42f5aa]" + DistanceFromPoint(player.Pos.x, player.Pos.y, plr.Pos.x, plr.Pos.y) + ".", player);
					}
				}
				else
				{
				MessagePlayer("[#bc0000]Syntax, /dis [playername]", player);
				}
			}
		}
		break;
		
		case "checkcar":
		if( !GetItem( player, 7, 1 ) == true ) MsgPlr( 2, player, Lang.NoGPS3 );
		else
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
					else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
					else
					{
						if(plr.Vehicle.Model)
						{
							MessagePlayer(GetIngameTag( plr ) + "'s [#42e3f5]vehicle is: " + "[#42f5aa]" + GetVehicleNameFromModel(plr.Vehicle.Model) + ".", player);
						}
						else
						{
						MessagePlayer("[#bc0000]That player is not in any vehicle!", player);
						}
					}
				}
				else
				{
				MessagePlayer("[#bc0000]Syntax, /checkcar [playername]", player);
				}
			}
		}
		break;

		case "sur":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( p.SurSphere )
				{
					Sur( player );
				}
				else MsgPlr( 2, player, Lang.SurNotInSphere );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "dropcash":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					if( IsNum( text ) )
					{
						if( text.tointeger() >= 1 && p.Cash >= text.tointeger() )
						{							
							local model = 337, plrworld = player.World, plrname = playa[ player.ID ].ID, plrpos = Vector( ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
							local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );

							pickup.rawset( pickupinstance.ID, 
							{
								Model = model, 
								Type = "cash",
								Quatity = text.tointeger(),
								World = plrworld,
								Pos = plrpos,
								Owner = plrname,
								Share = "N/A",
								Locked = false,
								Interior = 0,
								Password = false,
								UID = uid,
								Welcome = "",
								Storage = "",
								GanngHouse = null,
								Storage1 = "",
								Pickup = pickupinstance,
								Pickup = pickupinstance,
								Timeout = time(),
							});
								
							local ID = pickupinstance.ID;
							p.DecCash( player, text.tointeger() );
							MsgPlr( 3, player, Lang.CashDropped, text );
						}
						else MsgPlr( 2, player, Lang.DropNotEnoughCash );
					}
					else MsgPlr( 2, player, Lang.CashNotInNum );
				}
				else MsgPlr( 2, player, Lang.DropCashSyntax );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/
		case "cmd":
		case "commands":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.HelpCmd );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

	/*	case "propcmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.PropHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/
		case "gencmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.GenHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "discord": MsgPlr( 3, player, Lang.IRCLink ); break;
	//	case "server": MsgPlr( 3, player, Lang.ServerInfo ); break;
	//	case "credits": MsgPlr( 3, player, Lang.ServerCredits ); break;
	//	case "forum": MsgPlr( 3, player, Lang.ForumURL ); break;
		
	/*	case "rules":
		SendDataToClient( 6050, null, player );
		break;
	*/	
	/*	case "coprules":
		SendDataToClient( 6051, null, player );
		break;

		case "playercmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.PHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "vehiclecmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.VehHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "jobhelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.JobHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "househelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.HouseHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/
		case "groupcmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.GangHelp );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;


	/*	case "cophelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.CopHelp1 );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "crimecmds":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MessagePlayer("[#e600e6][Server] [#33cc33]R key [#ffffff]- Rob any nearest non cop player(NOT WORKING).", player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/

	/*	case "medichelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.Medhelp1 );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	*/
		case "msghelp":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				MsgPlr( 3, player, Lang.RPCmd );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "wanted":
		case "sus":
		case "unsus":
		case "asus":
		case "equip":
		case "unequip":
		case "panic":
		case "tg":
		case "jail":
		case "su":
		case "crime":
		case "sb":
		case "pdsetlevel":
		case "pdsetrank":
		case "swatsetlevel":
		case "swatsetrank":
		case "ucright":
		return onCopCommand( player, cmd, text ); break;

		case "myveh":
		case "parkveh":
		case "findveh":
		case "veh":
		case "aparkcar":
		case "sellveh":
		case "lockveh":
		case "asellcar":
		case "addcar":
		case "sharevehkey":
		case "removevehkey":
		case "giveveh":
		case "givevehtogroup":
		case "browse":
	/*	case "impound":
		case "unimpound":*/
		case "repair":
		case "changevehcolor":
		case "towveh":
		case "towgroupveh":
		case "listgroupveh":
		return onVehicleCommand( player, cmd, text ); break;

		case "kick":
	/*	case "banip":
		case "addstaff":
		case "oban":
		case "setpermission":*/
		case "freeze":
		case "unfreeze":
	/*	case "suspendcop":*/
		case "createvehicle":
		case "rtc":
		case "respawnthiscar":
		case "delveh":
		case "spec":
		case "cwep":
	/*	case "ban":*/
		case "drown":
		case "mute":
		case "unmute":
		case "unban":
	/*	case "restart":
		case "alias":*/
		case "get":
		case "goto":
		case "setwep":
		case "disarm":
	/*	case "acmds":
		case "setlevel":
		case "uncrime":
		case "unjail":*/
		case "ann":
	/*	case "reward":*/
		case "aheal":
		case "ac":
		case "slap":
	//	case "addrobpoint":
		case "e":
		case "exe":
	//	case "genpass":
	//	case "allowaccess":
	//	case "changename":
	/*	case "getuid":
		case "accinfo":
		case "banlist":
	///	case "adropwep":
		case "removeadminpickup":*/
		case "aduty":
		case "viewcmds":
	//	case "forcespawn":
	//	case "dev":
	//	case "mc":
	//	case "d":
	///	case "devchat":
	//	case "spawn":
	//	case "fban":
	//	case "devduty":
	//	case "say":*/
		case "afix":
	/*	case "ajail":
		case "aunjail":
		case "setskin":
		case "delobj":
		case "editobject":
		case "selectobject":
		case "desall":
		case "loadmap":
		case "deletemap":
		case "exportmap":
		case "closemap":
		case "savemap":
		case "map":
		case "view":
		case "addobject":
		case "newmap":
	//	case "s":
		case "cam":
		case "mduty":*/
		onPlayerAdminCommand( player, cmd, text );
		break;

		case "bagbody":
		case "carrybody":
		case "storebody":
		case "unloadbody":
		case "cremate":
		case "revive":
		onMedicCmd( player, cmd , text );
		break;

		case "buyhouse":
		case "sharehouse":
		case "delsharehouse":
		case "setwelcomemessage":
		case "house":
		case "storage":
		case "store":
		case "load":
		case "sellhouse":
	//	case "asellhouse":
		case "storeall":
		case "givehouse":
	//	case "addhouse":
		case "lockhouse":
		case "housename":
		case "houseupgrade":
		onHouseCommand( player, cmd , text );
		break;

	//	case "dropwep":
	//	case "me":
	//	case "plantbomb":
	//	case "items":
		case "admin":
		case "admins":
	//	case "developers":
	//	case "scripters":
	//	case "mappers":
	//	case "testers":
	//	case "breakcuff":
	//	case "stats":
	//	case "forsale":
		case "changepass":
	//	case "news":
		case "use":
		case "invent":
		case "inventory":
	//	case "usemusickit":
	//	case "ignore":
	//	case "unignore":
	//	case "fps":
	//	case "pick":
	//	case "checkafk":
	//	case "hide":
		case "p":
		case "ask":
		case "cmds":
		case "commands":
		case "stats":
		case "jobcmd":
		case "faq":
		onPlayerCmd( player, cmd , text );
		break;

	/*	case "creategang":
		case "ganginfo":
		case "ganginvite":
		case "gangaccept":
		case "gangreject":
		case "gangkick":
		case "setganghouse":
		case "setgangskin":
		case "leavegang":
		case "setgangcar":
		case "getgangcar":
		case "listgang":
		case "changegangname":
		case "getgangcash":
		case "storegangcash":
		case "setgangirc":
		onGange( player, cmd, text );
		break;*/

	/*	case "buyprop":
		case "property":
		case "collect":
		case "setpropmsg":
		case "sellprop":
		case "spawnprop":
		case "asellprop":
		onBizz( player, cmd, text );*/
		break;

	/*	case "addobject":
		case "objectlist":
		case "editsens":
		onObjCmd( player, cmd, text );*/
		break;

		case "groups":
		case "groupinfo":
		case "groupmembers":
		case "groupranks":
		case "groupjoin":
		case "groupinvite":
		case "groupkick":
		case "groupleave":
		case "groupaddrank":
		case "groupdelrank":
		case "groupeditranklevel":
		case "groupeditperm":
		case "groupeditpermission":
		case "groupsetplayerrank":
		case "groupdescription":
		onGroupCommand( player, cmd, text );
		break;

		case "psa":
		case "r":
		case "radio":
		case "dep":
		onJobCommand( player, cmd, text );
		break;

		case "l":
		case "s":
		case "w":
		case "m":
		case "lw":
		case "me":
		case "b":
		case "ad":
		case "call":
		case "sms":
		case "pickup":
		case "hangup":
		case "chatmode":
		case "accent":
		case "rob":
		case "frisk":
		case "accept":
		case "do":
		case "em":
		case "send":
		case "give":
		case "setfreq":
		case "cr":
		case "crpanic":
		case "cralert":
		case "crkick":
		case "crban":
		case "crlock":
		case "crdescription":
		case "crregister":
		case "crsetlevel":
		case "crmembers":
		onRPCmd( player, cmd, text );
		break;

		case "buy":
		case "restock":
		case "setstockprice":
		case "buybiz":
		case "sellbiz":
		case "income":
		case "collectincome":
		case "bizname":
		case "bizwelcomemessage":
		case "setpnsfee":
		case "restockpns":
		onBizCmd( player, cmd, text );
		break;

		case "deposit":
		case "withdraw":
		case "cash":
		case "bank":
		case "paycheck":
		case "groupbank":
		onBankCmd( player, cmd, text );
		break;

		case "sit":
		case "talk":
		case "buy":
		case "sur":
		onAnimCmd( player, cmd , text );
		break;

		case "plantseed":
		case "harvestweed":
		case "destroyweed":
		case "sell":
		onCriminalCmd( player, cmd, text );
		break;
		
		default: MsgPlr( 2, player, Lang.InvalidCmd ); break;
	}
}

function onConsoleInput( cmd,text )
{
	switch( cmd.tolower() )
	{
		case "exe":
		if(text)
		{
			try
			{
				local t = compilestring(text);
				t();
			}
			catch(e) print( e );
		}
		else print( "use !exe <text>" );
		break;

		case "ecs":
		if( text )
		{
			SendDataToClient( 1000, text, FindPlayer(0) );
		}
		else print( "use !ecs <text>" );
		break;

	}
}

function onPlayerPM( player, plr, text )
{
	MsgPlr( 2, player, Lang.InvalidCmd );
	return 0;
}
