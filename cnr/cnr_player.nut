
playa <- array( GetMaxPlayers(), null );

class Player
{
	Logged   = false;
	Level    = 0;
	impoundgater = 0;
	Staff    = 0;
	UID      = null;
	UID2 	 = null;
	Password = null;
	Lang = 0;
	ID = 0;
	AllowLogin = true;
	
	Cash = 0;
	Bank = 0;

	XP = 0;
	Robskill = 0;
	Copskill = 0;

	JobID = "";

	Cuff = null;
	CuffTimer = null;
	CuffPlayer = null;

	KidnapVictimTimer = 0;
	KidnapTime = null;
	Kidnapper = null;
	Kidnap = null;

	Jailtime = 0;
	Jailtimer = null;
	Jailtimerr = 0;
	Wanted = 0;
	Suspect = null;

	Items = {};
	LastPos = Vector( 0, 0 ,0 );
	LastPos2 = Vector( 0, 0 ,0 );
	LastWorld = 0;
	Autospawn = false;

	RobTimer = null;
	IsRobbing = false;

	ShopCurrentID = 0;
	MaxShopItems = null;
	ShopID = null;

	House = null;
	vehicleicon = [];
	vehicleTimer = null;

	SurSphere = false;
	LastSaid = 0;
	Healing = null;
	GangReq = null;
	Gang = null;
	Area = null;
	BankCash = 0;

	ToiToiToi		=	false;

	CuffColldown = 1562559827;
	MapEdit = null;
	Spawnhouse = "";

	DM = false;
	Kills = 0;
	Deaths = 0;

	Playtime1 = 0;
	Playtime = 0;

	Editsens = 0.5;

	XPLevel = 1;

	Mute = null;

	MuteCache = null;
	BanCache = null;

	Weapon = null;

	Healing = null;

	ReadNews = true;

	ActiveMusickit = "none";

	OnSpawnMenu = false;

	AdminDuty = false;
	DevDuty = false;
	mDuty = false;
	ViewCmds = false;
	LastColor = RGB( 255, 255, 255 );

	IsHidden = false;

	MappingTimer = null;

	EditType = "xyz";

	Job = null;

	LastCivilWep = null;
	LastSkin = 0;

	JailSlot = null;

	Group = null;

	FirstJoin = true;

	LastUsedSkin = 0;

	CarryBody = null;

	GroupPending = "";

	Knocked = null;

	Paycheck = 0;
	PaycheckTimer = null;
	
	Health = 0;
	Armour = 0;
	IsKnocked = false;

	Undercover = false;

	Surrender = {};

	ReviveTimer = null;

	Chatmode = "public";
	OldChatmode = "public";
	Phone = 0;
	PhoneS = null;

	Radio = null;

	RepairVehicle = null;
	Showroom = null;

	function constructor()
	{
		this.Weapon = {};
		this.LastCivilWep = {};
		this.Suspect = {};
		this.Group = [];

		this.Knocked =
		{
			IsKnocked = false,
			BeingRevive = null,
			Timer = null,
			Corps = null,
			Time = 0,
		}

		this.CarryBody = 
		{
			Status = 0,
			CarryID = null,
		}

		this.Surrender =
		{
			Status = false,
			Pos = Vector( 0,0,0 ),
		}
		
		this.Job = 
		{
			JobID = 0,
			PDLevel = 0,
			PDRank = "Volunteer",
			SWATLevel = 0,
			SWATRank = "None",
			FBILevel = 0,
			FBIRank = "None",
			MedicLevel = 0,
			MedicRank = "Volunteer",
			PDUC = false,
		}

		this.PhoneS = 
		{
			Caller = -1,
			Called = -1,
			CallerWaiting = null,
		}

		this.Radio = {};
		for( local i = 1; i < 6; i++ ) 
		{
			this.Radio.rawset( i.tostring(),
			{
				Channel = "0",
			});
		}

		this.Showroom =
		{
			Vehicle = null,
			State = 0,
			Menu = 0,
			Price = 0,
			Shop = null,
			Model = 0,
		}
	}

	function LoadAcc( player )
	{
		if( ::ValidPlayerName( player.Name ) )
		{
			local getResult = mysqldb.IsRegistered( player );
			if( getResult )
			{
				this.Password = mysqldb.GetPass( getResult );
				this.ID = getResult;
				
				if( DefineDatabase( player ) )
				{
					if( !this.AllowLogin ) 
					{
						if( player.UID != this.UID || player.UID2 != this.UID2 ) 
						{
							::MsgPlr( 2, player, ::Lang.NotAllowLogin );

							print("\r[Warning] " + player.Name + " tried to login into account from diffrent location but rejected by security check." );

							player.Kick();
						}
						else ::SendDataToClient( 20, null, player );
					}
					else ::SendDataToClient( 20, null, player );
				}

				else
				{
					::SendDataToClient( 20, null, player );
				}
			}

			else
			{
				::SendDataToClient( 15, null, player );
			}
		}

		else 
		{
			::MsgPlr( 2, player, ::Lang.NotValidRPName );

			player.Kick();
		}
	}

	function Register( player, pass )
	{
		local country = ::geoip2_country_name_by_addr( player.IP ) + ", " + ::geoip2_continent_name_by_addr( player.IP );
		
		mysqldb.AddPlayer( player, pass );
		
		this.ID = mysqldb.IsRegistered( player );
		//::QuerySQL( db, "INSERT INTO cnr ( 'name', 'uid', 'uid2' ) VALUES ( '" + this.ID + "', '" + player.UID + "', '" + player.UID2 + "' )" );
		::mysql_query( mysql, "INSERT INTO stats ( ID, UID, UID2 ) VALUES ( '" + this.ID + "', '" + player.UID + "', '" + player.UID2 + "' )" );
		::mysql_query( mysql, "INSERT INTO job ( ID ) VALUES ( '" + this.ID +  "' )" );
		//::mysql_query( mysql, "UPDATE stats SET Name = '" + this.ID + "', UID = '" + player.UID + "', UID2 = '" + player.UID2 + "' WHERE Bank = '" + "100" + "' " );
		
		this.Logged = true;
		this.Level = 1;
		this.Staff = 0;
		this.UID = player.UID;
		this.Playtime1 = time();
		this.FirstJoin = false;

		::MsgAll( 1, ::Lang.JoinAll2, player.Name );
	//	::EchoMessage( "**" + player.Name + "** joined the server for the first time from **" + country + "**" );

		::MsgPlr( 3, player, ::Lang.Register );

		player.Spawn();
		player.Pos = Vector( 231.614, -1278.27, 12.0712 );

		player.Cash = this.AddCash( player, 5000 );

		this.PaycheckTimer = _Timer.Create( this, function( player ) 
		{
			playa[ player.ID ].AddXP( player, 1 );

			::GiveJobBasepaycheck( player );

			if( playa[ player.ID ].Paycheck > 0 ) ::MsgPlr( 3, player, ::Lang.PaycheckNotice, playa[ player.ID ].Paycheck );
		}, 1800000, 0, player );

		//::sendNewsToPlayer( player );
	}

	function Login( player )
	{
		local country = ::geoip2_country_name_by_addr( player.IP ) + ", " + ::geoip2_continent_name_by_addr( player.IP );

		if( !this.checkBan( player ) )
		{
			if( player.Name.tolower() == "jmm" ) country = "Sweden, Europe";
			
			if( player.Name.tolower() == "jones" )
			{
				country = "Brazil, South America";
			}

			this.Logged = true;
			player.Cash = this.Cash;
			this.UID = player.UID;
		//	this.AddWanted2( player, this.Wanted );

			//::GetGangInfo( player );

			mysqldb.UpdateDatabase( player, this.ID );	
			adminv2.AddAlias( player );
			LoadData( player );
			this.Playtime1 = time();

			::MsgAll( 1, ::Lang.JoinAll, player.Name );
			::EchoMessage( "**" + player.Name + "** joined the server from **" + country + "**" );
		//	::Discord_SetStatus( "Player Online [" + ::GetPlayers() + "/" + ::GetMaxPlayers() + "]" );

			::MsgPlr( 3, player, ::Lang.Logged );
		//	::MsgAll( 1, ::Lang.LoggedAs, ::GetIngameTag( player ), ::PInfoColor_Level( this.Level ) );

			this.SaveData( player );

			this.CheckMute( player );

		//	this.AddWanted2( player, this.Wanted );
			if( this.Jailtime ) ::JailSpawn( player );

			this.PaycheckTimer = _Timer.Create( this, function( player ) 
			{
				playa[ player.ID ].AddXP( player, 1 );

				::GiveJobBasepaycheck( player );

				if( playa[ player.ID ].Paycheck > 0 ) ::MsgPlr( 3, player, ::Lang.PaycheckNotice, playa[ player.ID ].Paycheck );
			}, 1800000, 0, player );
		}
	}

	function DefineDatabase( player )
	{
		local q = mysql_query( mysql, "SELECT * FROM stats WHERE ID = '" + this.ID + "' " );
		//local q = ::QuerySQL( db, "SELECT * FROM cnr WHERE Name LIKE = '" + this.ID + "' " );
		local row = mysql_fetch_assoc( q );
		if( mysql_num_rows( q ) != 0 )
		{
			local getlevel = row["AdminLevel"];
			local checkstatus = row["AllowLogin"];
			
			this.UID      = row["UID"];
			this.UID2      = row["UID2"];
			this.BanCache = ( json_decode( row["Ban"] ).len() == 0 ) ? null : json_decode( row["Ban"] );

			if( getlevel != 1 && checkstatus == "false" ) this.AllowLogin = false;
			return true;
		}

		else
		{
			return false;
		}
		::mysql_free_result( q );
	}

	function LoadData( player )
	{
		local q = mysql_query( mysql, "SELECT * FROM stats WHERE ID = '" + this.ID + "' " );
		local q1 = mysql_query( mysql, "SELECT * FROM job WHERE ID = '" + this.ID + "' " );

		//local q = ::QuerySQL( db, "SELECT * FROM cnr WHERE Name LIKE = '" + this.ID + "' " );
		local row = mysql_fetch_assoc( q );
		local row1 = mysql_fetch_assoc( q1 );
		if( mysql_num_rows( q ) != 0 )
		{
			this.Level    = row["AdminLevel"].tointeger();
			this.Robskill = row["Robskill"].tointeger();
			this.Copskill = row["Copskill"].tointeger();
			this.XP       = row["XP"].tointeger();
			this.Cash     = row["Cash"].tointeger();
			this.Bank     = ( row["Bank"] == "false" ) ? false : row["Bank"].tointeger();
			this.Jailtime = row["Jailtime"];
			this.Wanted   = row["Wanted"].tointeger();
			this.Items 	  = json_decode( row["Items"] );
			this.Spawnhouse = row["Spawnhouse"];
			this.Playtime = ( row["Playtime"] == null ) ? 0 : row["Playtime"];
			this.XPLevel     = row["XPLevel"].tointeger();
			this.Weapon 	= json_decode( row["Weapon"] );
			this.MuteCache = ( ::json_decode( row["Mute"] ).len() == 0 ) ? null : ::json_decode( row["Mute"] ),
			this.BanCache = ( ::json_decode( row["Ban"] ).len() == 0 ) ? null : ::json_decode( row["Ban"] );
			this.ReadNews = row["ReadNews"];
			this.ActiveMusickit = row["ActiveMusickit"];
			this.Staff = row["Staff"];
			this.LastPos = ::ConvertStringToPos( row["Pos"] );
			this.LastSkin = row["LastSkin"].tointeger();
			this.LastCivilWep = json_decode( row["LastCivilWep"] );
			this.Suspect 	= json_decode( row["Suspect"] );
			this.LastUsedSkin = row["Skin"].tointeger();
			this.Paycheck = row["Paycheck"].tointeger();
			this.Health = row["Health"].tointeger();
			this.Armour = row["Armour"].tointeger();
			this.IsKnocked = row["IsKnocked"];
			this.Phone = row["Phone"].tointeger();
			this.Chatmode = row["ChatMode"];
			this.Radio = ::json_decode( row["Radio"] );

			player.Score = ::getLevelAtExperience( row["XP"].tointeger() );
			player.Cash = this.Cash;
			player.Spawn();
			player.Pos = this.LastPos;
			player.Skin = row["Skin"].tointeger();
			player.Health = row["Health"].tointeger();
			player.Armour = row["Armour"].tointeger();

			this.FirstJoin = false;
			//print("TEST: " + this.MuteCache);

		//	if( this.ReadNews == "false" ) ::sendNewsToPlayer( player );

		//	::SendDataToClient( 6800, "join", player );


			this.Job.JobID = row1["LastJob"].tointeger();
			this.Job.PDLevel = row1["PDLevel"].tointeger();
			this.Job.PDRank = row1["PDRank"];
			this.Job.SWATLevel = row1["SWATLevel"].tointeger();
			this.Job.SWATRank = row1["SWATRank"];
			this.Job.FBILevel = row1["FBILevel"].tointeger();
			this.Job.FBIRank = row1["FBIRank"];
			this.Job.MedicLevel = row1["MedicLevel"].tointeger();
			this.Job.MedicRank = row1["MedicRank"];
			this.Job.PDUC = ( row1["PDUC"] == "true" ) ? true : false;

			::LoadPlayerGang( player );
			::RespawnRestoreColor( player );

			_Timer.Create( this, function() {
				::SpawnPlayerWeapon( player );
			}, 500 , 1 );

			if( this.Radio.len() == 0 )
			{
				for( local i = 1; i < 6; i++ ) 
				{
					this.Radio.rawset( i.tostring(),
					{
						Channel = "0",
					});
				}
			}

			::JoinChannel( player );

			if( playa[ player.ID ].IsKnocked == "true" )
			{
				player.Spawn();

			//	player.Pos = this.LastPos2
			//	player.World = this.LastWorld;
				player.Skin = this.LastUsedSkin;
				player.IsFrozen = true;
				player.Health = 100;

				this.Knocked.IsKnocked = true;

				player.Colour = RGB( 150, 150, 150 );

				this.Knocked.Corps = ::AddCorps( player.Pos, player.Name );
				this.Knocked.Time = ::time();

				::Announce( "You are knocked", player, 3 );
				::Announce( "After 120 seconds you can ~r~/accept death", player, 1 );		

				::MsgPlr( 3, player, ::Lang.KnockedMsg );
				::MsgPlr( 3, player, ::Lang.KnockedMsg2 );

				this.Knocked.Timer = _Timer.Create( this, function( player )
				{
					if( player.Health >= 1 )
					{
						if( ( time() - playa[ player.ID ].Knocked.Time ) < 120 )
						{
							player.SetAnim( 0, 43 );

							player.IsFrozen = true;

							::Announce( "You are knocked", player, 3 );
							::Announce( ( 120 - ( time() - playa[ player.ID ].Knocked.Time ) ) +" seconds before you can ~r~/accept death", player, 1 );
						}

						else 
						{
							player.SetAnim( 0, 43 );
							player.Health -= 1;
							
							if( player.Health < 2 ) player.IsFrozen = false;
							else player.IsFrozen = true;
							
							::Announce( "You are knocked", player, 3 );
							::Announce( " you can now ~r~/accept death", player, 1 );
						}
					}
				}, 2000, 0, player );
			}
			return true;
		}

		else
		{
			//::QuerySQL( db, "INSERT INTO cnr ( 'name', 'uid', 'uid2' ) VALUES ( '" + this.ID + "', '" + player.UID + "', '" + player.UID2 + "' )" );
			mysql_query( mysql, "INSERT INTO stats ( ID, UID, UID2 ) VALUES ( '" + this.ID + "', '" + player.UID + "', '" + player.UID2 + "' )" );
			return false;
		}
		::mysql_free_result( q );
		::mysql_free_result( q1 );
	}

	function AddCash( player, int )
	{
		this.Cash = ( this.Cash + int );
		player.Cash = this.Cash;
	}

	function DecCash( player, int )
	{
		this.Cash = ( this.Cash - int );
		if( this.Cash < 0 ) this.Cash = 0;
		player.Cash = this.Cash;
	}

	function AddBank( player, int )
	{
		this.Bank = ( this.Bank + int );
	}

	function DecBank( player, int )
	{
		this.Bank = ( this.Bank - int.tointeger() );
		if( this.Bank < 0 ) this.Bank = 0;
	}

	function AddXP( player, xp )
	{
		this.XP += xp

		if( ::getLevelAtExperience( this.XP ) > this.XPLevel )
		{
			this.XPLevel = ::getLevelAtExperience( this.XP );
			player.Score = ::getLevelAtExperience( this.XP );
			::MsgPlr( 3, player, ::Lang.AnnounceLevelUp, ::getLevelAtExperience( this.XP ) );
		}
	}

	function AddWanted( player, int )
	{
		this.Wanted = ( this.Wanted + int );
		player.SetWantedLevel( this.Wanted );
		
		if ( player.WantedLevel > 5 ) player.SetWantedLevel( 6 ), player.Colour = RGB( 255, 0, 0 );
		else player.Colour = RGB( 255, 153, 0 );
	}

	function AddWanted2( player, int )
	{
		if( int != 0 )
		{
			player.SetWantedLevel( this.Wanted );
			
			if ( player.WantedLevel > 5 ) player.SetWantedLevel( 6 ), player.Colour = RGB( 255, 0, 0 );
			else player.Colour = RGB( 255, 153, 0 );
		}
	}

	function ClearWanted( player )
	{
		this.Wanted = 0;
		player.SetWantedLevel( 0 );
		player.Colour = RGB( 255, 255, 255 );
	}

	function IncreasePlayerXP( player, level )
	{
	    playa[ player.ID ].XP += level;
		
	    if( getLevelAtExperience( playa[ player.ID ].XP ) > playa[ player.ID ].XPLevel )
	    {
	        playa[ player.ID ].XPLevel = getLevelAtExperience( playa[ player.ID ].XP );
			
		//	broadcast.messageplayer( player, color.Notice, player.Language, "LevelUpNotice", [ getLevelAtExperience( player.XP ) ] );
	    }
	}

	function SaveData( player )
	{
		if( this.Logged == true && this.Level != 0 )
		{
			local 
			calculate_time1 = ( ::time() - this.Playtime1.tointeger() ),
			calculate_time = ( calculate_time1 + this.Playtime.tointeger() );

			mysql_query( mysql, "UPDATE stats SET Playtime = '" + calculate_time + "', AdminLevel = '" + this.Level + "', UID = '" + player.UID + "', UID2 = '" + player.UID2 + "', Robskill = '" + this.Robskill + "', Copskill = '" + this.Copskill + "', XP = '" + this.XP + "', Cash = '" + this.Cash + "', Bank = '" + this.Bank + "', Jailtime = '" + this.Jailtime + "', Wanted = '" + this.Wanted + "', Spawnhouse = '" + this.Spawnhouse + "', Items = '" + ::json_encode( this.Items ) + "', XPLevel = '" + this.XPLevel + "', AllowLogin = 'false', Weapon = '" + ::json_encode( this.Weapon ) + "', Mute = '" + ::json_encode( this.MuteCache ) + "', Ban = '" + ::json_encode( this.BanCache ) + "', ReadNews = '" + this.ReadNews + "', ActiveMusickit = '" + this.ActiveMusickit + "', Staff = '" + this.Staff + "', Pos = '" + this.LastPos.x + ", " + this.LastPos.y + "," + this.LastPos.z + "', Skin = '" + player.Skin + "', LastCivilWep = '" + ::json_encode( this.LastCivilWep ) + "', LastSkin = '" + this.LastSkin + "', Suspect = '" + ::json_encode( this.Suspect ) + "', Paycheck = '" + this.Paycheck + "', Health = '" + player.Health + "', Armour = '" + player.Armour + "', IsKnocked = '" + this.Knocked.IsKnocked.tostring() + "', Phone = '" + this.Phone + "', ChatMode = '" + this.Chatmode + "', Radio = '" + ::json_encode( this.Radio ) +"' WHERE ID = '" + this.ID + "' " );			
			mysql_query( mysql, format( "UPDATE job SET LastJob = '%d', PDLevel = '%d', PDRank = '%s', SWATLevel = '%d', SWATRank = '%s', FBILevel = '%d', FBIRank = '%s', MedicLevel = '%d', MedicRank = '%s', PDUC = '%s' WHERE ID = '%d'", this.Job.JobID, this.Job.PDLevel, this.Job.PDRank, this.Job.SWATLevel, this.Job.SWATRank, this.Job.FBILevel, this.Job.FBIRank, this.Job.MedicLevel, this.Job.MedicRank, this.Job.PDUC.tostring(), this.ID ) );
	
			//::QuerySQL( db, "UPDATE cnr SET playtime = '" + calculate_time + "', level = '" + this.Level + "', uid = '" + player.UID + "', uid2 = '" + player.UID2 + "', robskill = '" + this.Robskill + "', copskill = '" + this.Copskill + "', xp = '" + this.XP + "', cash = '" + this.Cash + "', bank = '" + this.Bank + "', jailtime = '" + this.Jailtime + "', wantedlevel = '" + this.Wanted + "', spawn = '" + this.Spawnhouse + "', items = '" + ::json_encode( this.Items ) + "', xplevel = '" + this.XPLevel + "', allowlogin = 'false', weapons = '" + ::json_encode( this.Weapon ) + "', mute = '" + ::json_encode( this.MuteCache ) + "', ban = '" + ::json_encode( this.BanCache ) + "', readnews = '" + this.ReadNews + "', musickit = '" + this.ActiveMusickit + "', staff = '" + this.Staff + "' WHERE Name LIKE = '" + this.ID + "'" );
		}
	}

	function CheckMute( player )
	{
		if( this.MuteCache != null )
		{
			local getData = this.MuteCache;

			if( adminv2.UID[ player.UID ].Mute != null )
			{
				if( getData.Duration.tointeger() == 5000000 )
				{
					::MsgPlr( 2, player, ::Lang.MuteNotice, getData.Admin, getData.Reason, ::GetDate( getData.Time.tointeger() ) );
						
					::MsgPlr( 2, player, ::Lang.UnbanForum, "http://cnr.pl-community.com/" );
				}

				else 
				{
					if( getData.Duration.tointeger() > ( time() - getData.Time.tointeger() ) )
					{
						local gettiming = ( getData.Duration.tointeger() - ( time() - getData.Time.tointeger() ) );

						::MsgPlr( 2, player, ::Lang.MuteNotice, getData.Admin, getData.Reason, ::GetDate( getData.Time.tointeger() ) );

						::MsgPlr( 2, player, ::Lang.UnmuteDuration, ::GetTiming( ( getData.Duration.tointeger() - ( time() - getData.Time.tointeger() ) ) ) );
						
						this.Mute = _Timer.Create( this, function( player ) 
						{
							playa[ player.ID ].Mute = null;
						}, ( gettiming*60 ), 1, player );
					}
					else this.MuteCache = null;						
				}
			}
		}	
	}

	function checkBan( player )
	{
		/*if( this.BanCache != null )
		{
			local getBan = this.BanCache;

			if( getBan.Duration.len() == 5000000 )
			{
				::MsgPlr( 2, player, ::Lang.Kickban, getBan.Admin, getBan.Reason, ::GetDate( getBan.Time.tointeger() ) );
						
				::MsgPlr( 2, player, ::Lang.UnbanForum, "http://cnr.pl-community.com/" );
				
				player.Kick();

				return true;
			}

			else 
			{

				if( getBan.Duration.tointeger() > ( time() - getBan.Time.tointeger() ) )
				{
					::MsgPlr( 2, player, ::Lang.Kickban, getBan.Admin, getBan.Reason, ::GetDate( getBan.Time.tointeger() ) );

					::MsgPlr( 2, player, ::Lang.KickbanTimered, ::GetTiming( ( getBan.Duration.tointeger() - ( time() - getBan.Time.tointeger() ) ) ) );

					adminv2.AddBan( player, "Server", "Attempt to login banned account", ( getBan.Duration.tointeger() - ( time() - getBan.Time.tointeger() ) ) );
									
					player.Kick();

					return true;
				}
				else this.BanCache = null;
			}
		}*/	
	}
}

DM_Spawn <-
[
  Vector( 5.00792, -1000.05, 10.4633 ),
  Vector( -1166.1410, -620.6473, 11.8277 ),
  Vector( -1003.7244, 197.7314, 11.4306 ),
  Vector( -63.6423, 946.9459, 10.9402 ),
  Vector( -379.0713, -538.9711, 18.2835 ),
  Vector( -599.2484, 632.0645, 11.6765 ),
  Vector( 218.0042, -346.6602, 10.8721 ),
]

function HospitalRespawn( player )
{
	player.Spawn();
	player.World = 0;
	Announce("",player,1);

	local hospital = [ Vector( -883.101, -471.864, 13.1099 ), Vector( -822.674, 1140.28, 12.4111 ), Vector( 493.654, 702.559, 12.1033 ), Vector( -137.186, -981.112, 10.4653 ) ]
	local nearest = 1000000;
	local result = 0;

	foreach( index, value in hospital )
	{
		if( DistanceFromPoint( value.x, value.y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) <= playa[ player.ID ].LastPos.Distance( value ) && ( DistanceFromPoint( value.x, value.y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) < DistanceFromPoint( hospital[ result ].x, hospital[ result ].y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) ) ) result = index;
	}

	player.Pos = hospital[ result ];

	NewTimer( "CorrectSpawn", 1000, 1, player.ID );
}

function CorrectSpawn( id )
{
	local player = FindPlayer( id );
	if( player )
	{
		Medicspawn( player );
		Housespawn( player );
		JailSpawn( player );
		PoliceSpawn( player );
		SpawnGangSkin( player );
		playa[ player.ID ].AddWanted2( player, playa[ player.ID ].Wanted );
	}
}

function PoliceSpawn( player )
{
	if( playa[ player.ID ].JobID.find("cop") == null ) return;
	local evil = split( playa[ player.ID ].JobID, ":");

	switch( evil[1] )
	{
		case "1":
		player.SetWeapon( 18, 200 );
		player.SetWeapon( 19, 400 );
		player.SetWeapon( 4, 50 );
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		break;

		case "2":
		player.SetWeapon( 18, 200 );
		player.SetWeapon( 21, 200 );
		player.SetWeapon( 24, 350 );
		player.SetWeapon( 14, 50 );
		player.Armour = 25;
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		break;

		case "3":
		player.SetWeapon( 18, 500 );
		player.SetWeapon( 20, 50 );
		player.SetWeapon( 26, 200 );
		player.Armour = 50;
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		break;

	}
}

function ShowBankInfo( player )
{
	player.IsFrozen = true;
	if( playa[ player.ID ].Bank == false )
	{
		SendDataToClient( 75, null, player );
	}

	else SendDataToClient( 11, playa[player.ID].Cash+":"+playa[player.ID].Bank, player );
}

function CreateBankAccount( player )
{
	if( playa[ player.ID ].Cash > 999 )
	{
		MsgPlr( 3, player, Lang.BankCreated );
		SendDataToClient( 80 , null, player );
		playa[ player.ID ].Bank = 0;
		playa[ player.ID ].DecCash( player, 1000 );
	}
	else MsgPlr( 2, player, Lang.BankCantCreate );
}

function ProcessBank( player, data )
{
	local type = split( data, ":" );
	switch( type[0] )
	{
		case "Deposit":
		if( !IsNum( type[1] ) ) MsgPlr( 2, player, Lang.CashNotInNum );
		else if( type[1].tointeger() < 0  || type[1].tointeger() > playa[ player.ID ].Cash ) MsgPlr( 2, player, Lang.CashNotEnough );
		else
		{
			playa[ player.ID ].AddBank( player, type[1].tointeger() );
			MsgPlr( 3, player, Lang.CashDeposit, type[1], playa[ player.ID ].Bank );
			playa[ player.ID ].DecCash( player, type[1].tointeger() );
			SendDataToClient( 12, playa[player.ID].Cash+":"+playa[player.ID].Bank, player );
		}
		break;

		case "Withdraw":
		if( !IsNum( type[1] ) ) MsgPlr( 2, player, Lang.CashNotInNum );
		else if( type[1].tointeger() < 0  || type[1].tointeger() > playa[ player.ID ].Bank ) MsgPlr( 2, player, Lang.BankNotEnough );
		else
		{
			playa[ player.ID ].DecBank( player, type[1].tointeger() );
			MsgPlr( 3, player, Lang.BankWithdraw, type[1], playa[ player.ID ].Bank );
			playa[ player.ID ].AddCash( player, type[1].tointeger() );
			SendDataToClient( 12, playa[player.ID].Cash+":"+playa[player.ID].Bank, player );
		}
		break;
	}
}

function getExperienceAtLevel( level )
{
    local total = 0;
    for( local i = 1; i < level; i++ )
    {
        total += floor( ( i + 500 ) * pow(2, i / 7.0));
    }

    return floor(total / 4);
}

function getLevelAtExperience( experience ) 
{
    local index;

    for( index = 0; index < 120; index++ ) 
    {
        if ( getExperienceAtLevel(index + 1 ) > experience )
        break;
    }

    return index;
}


function getUIDByName( text )
{
	local result = mysqldb.GetSimilarNameToID( text );
	if( result )
	{
		local q = mysql_query( mysql, "SELECT UID, UID2 FROM stats WHERE Lower(Name) = '" + result + "' " );
		local row = mysql_fetch_assoc( q );
		//local q = ::QuerySQL( db, "SELECT uid1, uid2 FROM cnr WHERE Name LIKE = '" + result + "' " );
		if( mysql_num_rows( q ) == 1 )
		{
			return [ row["Name"], row["AdminLevel"] ];
		}
	}
	
	else
	{
		return false;
	}
	::mysql_free_result( q );
}

function SavePlayerWeapon( player )
{
	playa[ player.ID ].Weapon = {};

	for( local i = 0, weapon; i < 8; i++ )
	{
		weapon = player.GetWeaponAtSlot( i );

		if ( weapon > 0 && weapon != 16 )
		{
		   	playa[ player.ID ].Weapon.rawset( weapon, 
		   	{
		   		Ammo = player.GetAmmoAtSlot( i ),
		   	});
		}
	}
}

function SaveCivilWep( player )
{
	playa[ player.ID ].LastCivilWep = {};

	for( local i = 0, weapon; i < 8; i++ )
	{
		weapon = player.GetWeaponAtSlot( i );

		if ( weapon > 0 && weapon != 16 )
		{
		   	playa[ player.ID ].LastCivilWep.rawset( weapon, 
		   	{
		   		Ammo = player.GetAmmoAtSlot( i ),
		   	});
		}
	}
}

function SpawnPlayerWeapon( player )
{
	local getwep = null;
	foreach( index, value in playa[ player.ID ].Weapon )
	{
		player.SetWeapon( index.tointeger(), value.Ammo.tointeger() );

		if( getwep ) getwep = getwep + ", " + GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
		else getwep = GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
	}

	if( playa[ player.ID ].Weapon.len() > 0 ) MsgPlr( 3, player, Lang.WeaponRestore, getwep );
}

function SpawnCivilWeapon( player )
{
	local getwep = null;
	foreach( index, value in playa[ player.ID ].LastCivilWep )
	{
		player.SetWeapon( index.tointeger(), value.Ammo.tointeger() );

		if( getwep ) getwep = getwep + ", " + GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
		else getwep = GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
	}

	if( playa[ player.ID ].LastCivilWep.len() > 0 ) MsgPlr( 3, player, Lang.WeaponRestore, getwep );
}

function SpawnCivilWeaponSilent( player )
{
	local getwep = null;
	foreach( index, value in playa[ player.ID ].Weapon )
	{
		player.SetWeapon( index.tointeger(), value.Ammo.tointeger() );

		if( getwep ) getwep = getwep + ", " + GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
		else getwep = GetWeaponName( index.tointeger() ) + "(ammo: " + value.Ammo.tointeger() + ")";
	}
}


function GetPlayerUIDOneAndTwo( acc )
{
	local getID = mysqldb.isExist( acc ), result1, result2, result3;

	if( getID )
	{
		local q = mysql_query( mysql, "SELECT * FROM stats WHERE Lower(Name) = '" + getID + "' " );
		local row = mysql_fetch_assoc( q );
		//local q = ::QuerySQL( db, "SELECT * FROM cnr WHERE Name LIKE = '" + getID + "' " );
		if( mysql_num_rows( q ) == 1 )
		{
			result1 = row["UID"];
			result2 = row["UID2"];
			result3 = ( json_decode( row["Ban"] ) == 0 ) ? null : json_decode( row["Ban"] );

			return { "UID": result1, "UID2": result2, "Ban": result3, "Name": getID  };
		}

		else
		{
			return false;
		}
		::mysql_free_result( q );
	}

	return false;
}

function sendNewsToPlayer( player )
{
	SendDataToClient( 2100, null, player );

	foreach( index in split( UpdateLog, "\n" ) )
	{
		SendDataToClient( 2102 index, player );
	}
}

function FindPlayerPhone( text )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
        local plr = FindPlayer( i );
        if( plr )
        {
			if( playa[ plr.ID ].Phone == text ) return plr;
		}
	}
}

function CancelCaller( player )
{
	if( _Timer.Exists( playa[ player.ID ].PhoneS.CallerWaiting ) )
	{
		local getcaller = FindPlayer( playa[ player.ID ].PhoneS.Caller );
        
        playa[ getcaller.ID ].PhoneS.Called = -1;

    //    MsgPlr( 2, getcaller, Lang.CalledFailedToPickup );

        _Timer.Destroy( playa[ player.ID ].PhoneS.CallerWaiting );
	}
}

function CancelCalled( player )
{
	if( playa[ player.ID ].PhoneS.Called != -1 )
	{
		//print( typeof playa[ player.ID ].PhoneS.Caller + " " + playa[ player.ID ].PhoneS.Caller );

		local getcalled = FindPlayer( playa[ player.ID ].PhoneS.Called );

		if( getcalled )
		{
			if( _Timer.Exists( playa[ getcalled.ID ].PhoneS.CallerWaiting ) )
			{
				_Timer.Destroy( playa[ getcalled.ID ].PhoneS.CallerWaiting );

				MsgPlr( 2, getcalled, Lang.CallerHangup2 );
			}

			else 
			{
				MsgPlr( 2, getcalled, Lang.CallerHangup2 );

                playa[ getcalled.ID ].Chatmode =  playa[ getcalled.ID ].OldChatmode;

			}

			playa[ getcalled.ID ].PhoneS.Caller = -1;
		}
	}

	if( playa[ player.ID ].PhoneS.Caller != -1  )
	{
		local getcalled =  FindPlayer( playa[ player.ID ].PhoneS.Caller );

		if( getcalled )
		{
			if( _Timer.Exists( playa[ getcalled.ID ].PhoneS.CallerWaiting ) ) _Timer.Destroy( playa[ getcalled.ID ].PhoneS.CallerWaiting );
			else 
			{
				MsgPlr( 2, getcalled, Lang.CallerHangup2 );

                playa[ getcalled.ID ].Chatmode =  playa[ getcalled.ID ].OldChatmode;
				
				getcalled.SetAnim( 0, 164 );
			}

			playa[ getcalled.ID ].PhoneS.Caller = -1;
		}
	}

}