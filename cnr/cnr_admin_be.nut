class CAdmin
{
	UID 	= {};
	UID2	= {};

	function constructor()
	{		
		this.LoadUID1();
		this.LoadUID2();
	}

	function LoadUID1()
	{
		local result = SafeSelect( mysql, " SELECT * FROM uidinfo " ), count = 0;
		local row;
		while( row = mysql_fetch_assoc( result ) )
		{
			//print( "\r[UID] JM TEST");
			this.UID.rawset( row["UID"] ,
			{
				Ban 			= ( ::json_decode( row["Ban"] ).len() == 0 ) ? null : ::json_decode( row["Ban"] ),
				Mute 			= ( ::json_decode( row["Mute"] ).len() == 0 ) ? null : ::json_decode( row["Mute"] ),
				Alias 			= json_decode( row["Alias"] ),
				AllowedInstance	= row["AllowedInstance"],
				Comment			= row["Comment"],
			});
			count ++;
			//::GetSQLNextRow( result );
		}

		print( "\r[UID] Total UID1 loaded in table: " + count );
		
		::mysql_free_result( result );
	}

	function LoadUID2()
	{
		local result = SafeSelect( mysql, " SELECT * FROM uid2info " ), count = 0;
		local row;
		while( row = mysql_fetch_assoc( result ) )
		{
			this.UID2.rawset( row["UID"] ,
			{
				Ban 			= ( ::json_decode( row["Ban"] ).len() == 0 ) ? null : ::json_decode( row["Ban"] ),
				Mute 			= ( ::json_decode( row["Mute"] ) == 0 ) ? null : ::json_decode( row["Mute"] ),
				Alias 			= json_decode( row["Alias"] ),
				AllowedInstance	= row["AllowedInstance"],
				Comment			= row["Comment"],
			});

			count ++;
			//::GetSQLNextRow( result );
		}

		print( "\r[UID] Total UID2 loaded in table: " + count );

		::mysql_free_result( result );
	}

	function Join( player )
	{
		if( this.UID.rawin( player.UID ) )
		{
		//	try 
		//	{
				if( this.UID[ player.UID ].Ban != null )
				{
					if( this.UID[ player.UID ].Ban.Duration == 5000000 )
					{						
						::MsgPlr( 2, player, Lang.Kickban, this.UID[ player.UID ].Ban.Admin, this.UID[ player.UID ].Ban.Reason, ::GetDate( this.UID[ player.UID ].Ban.Time ) );
						
						::MsgPlr( 2, player, Lang.UnbanForum, "http://cnr.pl-community.com/" );
						
						player.Kick();

						return true;
					}

					else 
					{
						if( this.UID[ player.UID ].Ban.Duration > ( time() - this.UID[ player.UID ].Ban.Time ) )
						{
							::MsgPlr( 2, player, Lang.Kickban, this.UID[ player.UID ].Ban.Admin, this.UID[ player.UID ].Ban.Reason, ::GetDate( this.UID[ player.UID ].Ban.Time ) );

							::MsgPlr( 2, player, Lang.KickbanTimered, ::GetTiming( ( this.UID[ player.UID ].Ban.Duration - ( time() - this.UID[ player.UID ].Ban.Time ) ) ) );
							
							player.Kick();

							return true;
						}

						else this.UID[ player.UID ].Ban = null;
					}
				}

				if( this.UID[ player.UID ].Mute != null )
				{
					//if( this.UID[ player.UID ].Mute != null )
					//{
						if( this.UID[ player.UID ].Mute.Duration.len() == 5000000 )
						{
							::MsgPlr( 2, player, Lang.MuteNotice, this.UID[ player.UID ].Mute.Admin, this.UID[ player.UID ].Mute.Reason, ::GetDate( this.UID[ player.UID ].Mute.Time ) );
						
							::MsgPlr( 2, player, Lang.UnbanForum, "http://cnr.pl-community.com/" );
						}

						else 
						{
							if( this.UID[ player.UID ].Mute.Duration > ( time() - this.UID[ player.UID ].Mute.Time ) )
							{
								local gettiming = ( this.UID[ player.UID ].Mute.Duration - ( time() - this.UID[ player.UID ].Mute.Time ) );

								::MsgPlr( 2, player, Lang.MuteNotice, this.UID[ player.UID ].Mute.Admin, this.UID[ player.UID ].Mute.Reason, ::GetDate( this.UID[ player.UID ].Mute.Time.tointeger() ) );

								::MsgPlr( 2, player, Lang.UnmuteDuration, ::GetTiming( gettiming ) );
							
								playa[ player.ID ].Mute = _Timer.Create( this, function( player ) 
								{
									this.UID[ player.UID ].Mute = null;
									playa[ player.ID ].Mute = null;
								}, ( gettiming*60 ), 1, player );
							}
							else this.UID[ player.UID ].Mute = null;		
						}
					//}
				}
		//	}
		//	catch( e ) print( e );
		}
		else 
		{
			mysql_query( mysql, "INSERT INTO uidinfo ( 'UID', 'Ban', 'Mute', 'Comment', 'AllowedInstance', 'Alias' ) VALUES ( '%s', '%s', '%s', '%s', '%d', '%s' )", player.UID, "N/A", "N/A", "N/A", 2, "N/A" );

			this.UID.rawset( player.UID,
			{
				Ban				= null,
				Mute 			= null,
				Alias 			= {},
				AllowedInstance	= 2,
				Comment			= "N/A",
			});

			this.UID[ player.UID ].Alias.rawset( player.Name, 
			{
				UsedTimes	= "1",
				LastUsed	= time().tostring(),
			});
		}

		if( this.UID2.rawin( player.UID2 ) )
		{
		//	try 
		//	{
				if( this.UID2[ player.UID2 ].Ban != null )
				{
					if( this.UID2[ player.UID2 ].Ban.Duration == 5000000 )
					{
						::MsgPlr( 2, player, Lang.Kickban, this.UID2[ player.UID2 ].Ban.Admin, this.UID2[ player.UID2 ].Ban.Reason, ::GetDate( this.UID2[ player.UID2 ].Ban.Time ) );
						
						::MsgPlr( 2, player, Lang.UnbanForum, "http://cnr.pl-community.com/" );
						
						player.Kick();

						return true;
					}

					else 
					{
						if( this.UID2[ player.UID2 ].Ban.Duration > ( time() - this.UID2[ player.UID2 ].Ban.Time ) )
						{
							::MsgPlr( 2, player, Lang.Kickban, this.UID2[ player.UID2 ].Ban.Admin, this.UID2[ player.UID2 ].Ban.Reason, ::GetDate( this.UID2[ player.UID2 ].Ban.Time ) );

							::MsgPlr( 2, player, Lang.KickbanTimered, ::GetTiming( ( this.UID2[ player.UID2 ].Ban.Duration - ( time() - this.UID2[ player.UID2 ].Ban.Time ) ) ) );
									
							player.Kick();

							return true;
						}

						else this.UID2[ player.UID2 ].Ban = null;
					}
				}

				if( this.UID2[ player.UID2 ].Mute != null )
				{
					if( this.UID[ player.UID ].Mute != null )
					{
						if( this.UID2[ player.UID2 ].Mute.Duration == 5000000 )
						{
							::MsgPlr( 2, player, Lang.MuteNotice, this.UID2[ player.UID2 ].Mute.Admin, this.UID2[ player.UID2 ].Mute.Reason, ::GetDate( this.UID2[ player.UID2 ].Mute.Time ) );
						
							::MsgPlr( 2, player, Lang.UnbanForum, "http://cnr.pl-community.com/" );
						}

						else 
						{
							if( this.UID2[ player.UID2 ].Mute.Duration > ( time() - this.UID2[ player.UID2 ].Mute.Time ) )
							{
								local gettiming = ( this.UID[ player.UID ].Mute.Duration - ( time() - this.UID[ player.UID ].Mute.Time ) );

								::MsgPlr( 2, player, Lang.MuteNotice, this.UID2[ player.UID2 ].Mute.Admin, this.UID2[ player.UID2 ].Mute.Reason, ::GetDate( this.UID2[ player.UID2 ].Mute.Time ) );

								::MsgPlr( 2, player, Lang.UnmuteDuration, ::GetTiming( ( this.UID2[ player.UID2 ].Mute.Duration - ( time() - this.UID2[ player.UID2 ].Mute.Time ) ) ) );
							
								playa[ player.ID ].Mute = _Timer.Create( this, function( player ) 
								{
									this.UID2[ player.UID2 ].Mute = null;
									playa[ player.ID ].Mute = null;
								}, ( gettiming*60 ), 1, player );
							}
							else this.UID2[ player.UID2 ].Mute = null;						
						}
					}
				}
		//	}
		//	catch( e ) print(e);
		}
		else 
		{
			mysql_query( mysql, "INSERT INTO uid2info ( 'UID', 'Ban', 'Mute', 'Comment', 'AllowedInstance', 'Alias' ) VALUES ( '%s', '%s', '%s', '%s', '%d', '%s' )", player.UID2, "N/A", "N/A", "N/A", 2, "N/A" );

			this.UID2.rawset( player.UID2,
			{
				Ban				= null,
				Mute 			= null,
				Alias 			= {},
				AllowedInstance	= 2,
				Comment			= "N/A",
			});

			this.UID2[ player.UID2 ].Alias.rawset( player.Name, 
			{
				UsedTimes	= "1",
				LastUsed	= time(),
			});
		}		
	}

	function AddAlias( player )
	{
		local findUID = false, findUID2 = false;

		if( this.UID[ player.UID ].Alias == null ) this.UID[ player.UID ].Alias = {};

		foreach( index, value in this.UID[ player.UID ].Alias )
		{
			if( index.tolower() == player.Name.tolower() )
			{
				value.UsedTimes	= ( value.UsedTimes + 1 );
				value.LastUsed	= time();
				findUID		= true;
			} 
		}

		if( !findUID )
		{
			this.UID[ player.UID ].Alias.rawset( player.Name, 
			{
				UsedTimes	= "1",
				LastUsed	= time(),
			});
		}

		if( this.UID2[ player.UID2 ].Alias == null ) this.UID2[ player.UID2 ].Alias = {};
		
		foreach( index, value in this.UID2[ player.UID2 ].Alias )
		{
			if( index.tolower() == player.Name.tolower() )
			{
				value.UsedTimes	= ( value.UsedTimes + 1 );
				value.LastUsed	= time();
				findUID2	= true;
			} 
		}

		if( !findUID2 )
		{
			this.UID2[ player.UID2 ].Alias.rawset( player.Name, 
			{
				UsedTimes	= "1",
				LastUsed	= time(),
			});
		}
	}

	function CheckMute( uid1, uid2 )
	{
		if( this.UID[ uid1 ].Mute != null ) return true;
		if( this.UID2[ uid2 ].Mute != null ) return true;		
	}

	function Save( uid1, uid2 )
	{
		local getUID1 = ( uid1 == false ) ? "" : this.UID[ uid1 ];
		local getUID2 = ( uid2 == false ) ? "" : this.UID2[ uid2 ];

		try 
		{
			if( getUID1 ) mysql_query( mysql, "UPDATE uidinfo SET Ban = '%s', Mute = '%s', AllowedInstance = '%d', Alias = '%s' WHERE UID = '%s'", json_encode( getUID1.Ban ), json_encode( getUID1.Mute ), getUID1.AllowedInstance, json_encode( getUID1.Alias ), uid1 );
			if( getUID2 ) mysql_query( mysql, "UPDATE uid2info SET Ban = '%s', Mute = '%s', AllowedInstance = '%d', Alias = '%s' WHERE UID = '%s'", json_encode( getUID2.Ban ), json_encode( getUID2.Mute ), getUID2.AllowedInstance, json_encode( getUID2.Alias ), uid2 );	
		}
		catch( e ) 
		{
			print( "An error occurred while saving uid info: " + e );
			print( "Field 1 " + ::json_encode( getUID1.Ban ) + ", " + ::json_encode( getUID1.Mute ) + ", " + getUID1.AllowedInstance + ", " + ::json_encode( getUID1.Alias ) + ", " + uid1 );
			print( "Field 2 " + ::json_encode( getUID2.Ban ) + ", " + ::json_encode( getUID2.Mute ) + ", " + getUID2.AllowedInstance + ", " + ::json_encode( getUID2.Alias ) + ", " + uid2 );
		}
	}

	function AddMute( victim, admin, reason, duration )
	{
		this.UID[ victim.UID ].Mute = {};
		this.UID[ victim.UID ].Mute.rawset( "Admin", admin );
		this.UID[ victim.UID ].Mute.rawset( "Reason", reason );
		this.UID[ victim.UID ].Mute.rawset( "Duration", duration.tostring() );
		this.UID[ victim.UID ].Mute.rawset( "Time", time().tostring() );

		this.UID2[ victim.UID2 ].Mute = {};
		this.UID2[ victim.UID2 ].Mute.rawset( "Admin", admin );
		this.UID2[ victim.UID2 ].Mute.rawset( "Reason", reason );
		this.UID2[ victim.UID2 ].Mute.rawset( "Duration", duration.tostring() );
		this.UID2[ victim.UID2 ].Mute.rawset( "Time", time().tostring() );

		playa[ victim.ID ].MuteCache = {};
		playa[ victim.ID ].MuteCache.rawset( "Admin", admin );
		playa[ victim.ID ].MuteCache.rawset( "Reason", reason );
		playa[ victim.ID ].MuteCache.rawset( "Duration", duration.tostring() );
		playa[ victim.ID ].MuteCache.rawset( "Time", time().tostring() );
	}

	function AddBan( victim, admin, reason, duration )
	{
		this.UID[ victim.UID ].Ban = {};
		this.UID[ victim.UID ].Ban.rawset( "Admin", admin );
		this.UID[ victim.UID ].Ban.rawset( "Reason", reason );
		this.UID[ victim.UID ].Ban.rawset( "Duration", duration.tostring() );
		this.UID[ victim.UID ].Ban.rawset( "Time", time().tostring() );

		this.UID2[ victim.UID2 ].Ban = {};
		this.UID2[ victim.UID2 ].Ban.rawset( "Admin", admin );
		this.UID2[ victim.UID2 ].Ban.rawset( "Reason", reason );
		this.UID2[ victim.UID2 ].Ban.rawset( "Duration", duration.tostring() );
		this.UID2[ victim.UID2 ].Ban.rawset( "Time", time().tostring() );

		playa[ victim.ID ].BanCache = {};
		//playa[ victim.ID ].Banned = "true";
		playa[ victim.ID ].BanCache.rawset( "Admin", admin );
		playa[ victim.ID ].BanCache.rawset( "Reason", reason );
		playa[ victim.ID ].BanCache.rawset( "Duration", duration.tostring() );
		playa[ victim.ID ].BanCache.rawset( "Time", time().tostring() );
	}

	function IsAllowMapping( player )
	{
		if( SqWorld.GetPrivateWorld( player.World ) )
		{
			if( SqMath.IsGreaterEqual( SqWorld.GetPlayerLevelInWorld( player.Data.AccID, player.World ), SqWorld.World[ player.World ].Permissions.mapping.tointeger() ) )
			{
				return true;
			}
		}

		else 
		{
			if( player.Data.Player.Permission.Mapper.Position.tointeger() > 0 ) return true;
		}
	}

	function IsTimedMuted( player )
	{
		try
		{
			return player.FindTask( "Mute" );
		}
		catch( _ ) _;
	
		return null;
	}

	function ForceVehicleCommand( player )
	{
		if( player.Vehicle )
		{
			if( player.Data.Player.Permission.Mapper.Position.tointeger() > 4 ) return true;
	
			else 
			{
				if( SqVehicles.Vehicles[ player.Vehicle.Tag ].Prop.Owner == player.Data.AccID ) return true;
			}
		}
	}
}

	function GetDuration( duration )
	{
		local ban_time = null, duration_type = null;
		
		try 
		{
			switch( duration.len() )
			{
				case 2:
				ban_time = duration.slice(0,1);
				duration_type = duration.slice(1,2);
				break;

				case 3:
				ban_time = duration.slice(0,2);
				duration_type = duration.slice(2,3);
				break;

				case 4:
				ban_time = duration.slice(0,3);
				duration_type = duration.slice(3,4);
				break;
			}
			 
			switch( duration_type )
			{
				case "d":
				ban_time = ban_time.tointeger() * 86400;
				break;

				case "w":
				ban_time = ban_time.tointeger() * 604800;
				break;

				case "y":
				ban_time = ban_time.tointeger() * 31536000;
				break;

				case "m":
				ban_time = ban_time.tointeger() * 60;
				break;

				case "h":
				ban_time = ban_time.tointeger() * 3600;
				break;

			//	default:
			//	return null;
			}
		}
		catch( _ ) return false;

		return ban_time;
	}