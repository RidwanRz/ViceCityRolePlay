/* mfi admin */

function onPlayerAdminCommand( player, cmd , text )
{
	local p = playa[ player.ID ];
	
	switch( cmd )
	{
		case "ban":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), dur = GetTok( text, " ", 2 ), reason = GetTok( text, " ", 3, NumTok( text, " " ) );
					if( plr )
					{
						if( reason )
						{
							if( dur )
							{	
								if( GetDuration( dur ) )
								{
									local timers =  GetDuration( dur );
									
									BanPlayer( plr, player, reason, timers );
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Duration should be xy/xd/xh/xm. x = integer",player ); 
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );  
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		break;
		
		case "fban":
		if( p.Level > 2 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), dur = GetTok( text, " ", 2 ), reason = GetTok( text, " ", 3, NumTok( text, " " ) );
					if( plr )
					{
						if( reason )
						{
							if( dur )
							{	
								if( GetDuration( dur ) )
								{
									local timers =  GetDuration( dur );
									
									FakeBanPlayer( plr, player, reason, timers );
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Duration should be xy/xd/xh/xm. x = integer",player ); 
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );  
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "oban":
		if( p.Level >= 4 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local plr = GetTok( text, " ", 1 ), dur = GetTok( text, " ", 2 ), reason = GetTok( text, " ", 3, NumTok( text, " " ) );
					if( plr )
					{
						if( reason )
						{
							if( dur )
							{	
								if( GetDuration( dur ) )
								{
									local timers =  GetDuration( dur );
									
									OfflineBan( plr, player, reason, timers );
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Duration should be xy/xd/xh/xm. x = integer",player ); 
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );  
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ban <player> <y/d/m/h> <reason>",player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "suspendcop":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( p.Level >= 3 )
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/suspendcop <player> <reason>",player );
			else
			{	
				local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
				
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
				else if( playa[ plr.ID ].JobID.find("cop") == null )MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not a cop.",player );
				else if( !reason ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/suspendcop <player> <reason>",player );
				else
				{
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has kicked [#33cc33]" + GetIngameTag( plr ) + " [#ffffff] from cop duty. Reason [#33cc33]" + reason );
					MessagePlayer("[#737373][#ff3399]Admin[#737373] " + GetIngameTag( player ) + " [#ffffff]has kicked you from cop duty. Reason:[#33cc33] " + reason, plr);
					playa[ plr.ID ].JobID = "null";
					plr.Skin = 7;
					plr.Colour = RGB( 255, 255, 255 );
					plr.Disarm();
				}
			}
		}
		break;
		
		case "setskin":
		if( p.Level >= 2 )
		{
			if( p.Logged == true )
			{
				if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setskin <player> <skinid>",player );
				else
				{	
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2 );
					if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
					else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
					else if( !reason ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setskin <player> <skinid>",player );
					else if( !IsNum( reason ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Skin ID must be in number.",player ); 
					else
					{
						MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has changed " + GetIngameTag( plr ) + "[#ffffff]'s skin to ID " + reason);
						MessagePlayer("[#42f58a]Admin " + GetIngameTag( player ) + " [#42f58a]has changed your skin.", plr );
						plr.Skin = reason;
					}
				}
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "ajail":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ajail <player> <reason>",player );
			else
			{	
				local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
				
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
				//else if( playa[ plr.ID ].JobID.find("cop") == null )MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not a cop.",player );
				else if( !reason ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ajail <player> <reason>",player );
				else
				{
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has admin jailed " + GetIngameTag( plr ) + " [#ffffff]for [#33cc33]" + reason );
					MessagePlayer("[#ff3399]You have admin jailed " + GetIngameTag( plr ) + "[#ffffff]. Use /aunjail to unjail the player.", player);
					MessagePlayer("[#737373]You have been admin jailed by " + GetIngameTag( player ) + " [#ffffff]for :[#33cc33] " + reason, plr);
					plr.Pos = Vector(-1345.84, -36.5414, 424.142);
					plr.Disarm();
				}
			}
		}
		break;
		
		case "aunjail":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/aunjail <player>",player );
			else
			{	
				local plr = FindPlayer( GetTok( text, " ", 1 ) );
				
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
				//else if( playa[ plr.ID ].JobID.find("cop") == null )MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not a cop.",player );
				//else if( !reason ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ajail <player> <reason>",player );
				else
				{
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has un admin-jailed " + GetIngameTag( plr ) );
					MessagePlayer("[#ff3399]You have removed " + GetIngameTag( plr ) + " [#ff3399]from admin jail.", player);
					MessagePlayer("[#737373]You have been removed from admin jail by " + GetIngameTag( player ), plr);
					plr.Pos = Vector(-1345.55, -33.6787, 424.142);
				}
			}
		}
		break;
		
		case "kick":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
					if( plr )
					{
						if( plr.ID != player.ID )
						{
							if( reason )
							{
								KickPlayer( plr, player, reason );
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/kick <player> <reason>",player );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You cannot kick yourself.",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/kick <player> <reason>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	
		case "drown":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
					if( plr )
					{
					//	if( plr.ID != player.ID )
					//	{
							if( plr.IsSpawned )
							{
								if( reason )
								{
									DrownPlayer( plr, player, reason );
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/drown <player> <reason>",player );
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
					//	}
					//	else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You cannot kick yourself.",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/drown <player> <reason>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "mute":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) ), dur = GetTok( text, " ", 2 ), reason = GetTok( text, " ", 3, NumTok( text, " " ) );
					if( plr )
					{
						if( reason )
						{
							if( dur )
							{	
								if( GetDuration( dur ) )
								{
									local timers =  GetDuration( dur );

									MutePlayer( plr, player, reason, timers );
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Duration should be xy/xd/xh/xm. x = integer",player );  
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/mute <player> <y/d/h/m> <reason>",player );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/mute <player> <y/d/h/m> <reason>",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/mute <player> <y/d/h/m> <reason>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "afix":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( p.Level < 3 && p.Staff != 4 ) MessagePlayer("[#bc0000]Unknown Command! Use /help", player);
		else if( !text ) MessagePlayer("[#bc0000]Syntax, /afix [player]", player);
		else
		{	
			local plr = FindPlayer( GetTok( text, " ", 1 ) );
			local veh = plr.Vehicle;
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
			else if( plr.VehicleStatus != 3 ) MessagePlayer("[#bc0000]That player is not in a vehicle!", player);
			else if( veh.Health == 1000 ) MessagePlayer("[#bc0000]That player's vehicle does not need to be fixed!", player);
			else
			{
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has admin fixed " + GetIngameTag( plr ) + "[#ffffff]'s vehicle.");
				MessagePlayer("[#ffffff]Admin " + player.Name + "[#70fa6b] has fixed your vehicle!", plr);
				veh.Fix();
			}
		}
		break;
		
		case "freeze":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( text );
					if( plr )
					{
						if( p.Staff == 4 )
						{
							MsgStaff("[#ffffff]UC Admin " + GetIngameTag( player ) + "[#ffffff] has frozen " + GetIngameTag( plr ) );
							MessagePlayer("[#42f5b0]You have been frozen.", plr ); 
							plr.IsFrozen = true;
						}
						else
						{
							MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has frozen " + GetIngameTag( plr ) );
							MessagePlayer("[#42f5b0]You have been frozen by " + GetIngameTag( player ), plr ); 
							plr.IsFrozen = true;
						}
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/freeze <player>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "unfreeze":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( text );
					if ( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
					else if ( !plr.IsFrozen ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not frozen.",player );
					else if ( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not spawned.",player );
					else 
					{
						if( p.Staff == 4 )
						{
							MsgStaff("[#ffffff]UC Admin " + GetIngameTag( player ) + "[#ffffff] has unfrozen " + GetIngameTag( plr ) );
							MessagePlayer("[#42f5b0]You have been unfrozen.", plr ); 
							plr.IsFrozen = false;
						}
						else
						{
							MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has unfrozen " + GetIngameTag( plr ) );
							MessagePlayer("[#42f5b0]You have been unfrozen by " + GetIngameTag( player ), plr ); 
							plr.IsFrozen = false;
						}
					}
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/unfreeze <player>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	
		case "unban":
		if( p.Logged == true )
		{
			if( p.Level >= 4 )
			{
				if( text )
				{
					local result = GetPlayerUIDOneAndTwo( text );
                    if( result )
                    {
                    	if( result.Ban != null )
                    	{
	                    	local getResult = null;

	                    	if( adminv2.UID.rawin( result.UID ) )
	                    	{
	                    		adminv2.UID[ result.UID ].Ban = null;

								mysql_query( mysql, "UPDATE uidinfo SET Ban = '%s' WHERE UID = '%s'", "null", result.UID  );

	                    		getResult = true;
	                    	}

	                    	if( adminv2.UID2.rawin( result.UID2 ) )
	                    	{
	                    		adminv2.UID2[ result.UID2 ].Ban = null;

								mysql_query( mysql, "UPDATE uid2info SET Ban = '%s' WHERE UID2 = '%s'",  "null", result.UID2 );

	                    		getResult = true;
	                    	}

	                    	mysql_query( mysql, "UPDATE stats SET Ban = 'none' WHERE ID = '" + result.ID + "'" );
	                    	getResult = true;

	                    	if( getResult ) MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has unbanned " + GetIngameTag( result.Name ) );
	                    	else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not banned.",player );
	                    }
                        else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not banned.",player );
                    }
                    else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/unban <full name>",player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	
		case "unmute":
		if( p.Logged == true )
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else
			{
				if( text )
				{
					local plr = FindPlayer( GetTok( text, " ", 1 ) );
					if( plr )
					{
                       if( _Timer.Exists( playa[ plr.ID ].Mute ) )
                       {                         
							adminv2.UID[ plr.UID ].Mute = null;
							adminv2.UID2[ plr.UID2 ].Mute = null;
							playa[ plr.ID ].Mute = null;

                            MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has unmuted " + GetIngameTag( plr ) );
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is not muted.",player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/unmute <player>",player );
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "restart":
		if( p.Logged == true )
		{
			if( p.Level >= 4 )
			{
				//if( Server.Restart == null )
				//{
					legacyMessage("[#e600e6][Server] [#e60000]WARNING! Server will restart in 30 seconds!" );
					//EchoMessage("4** WARNING! Server will restart in 30 seconds!" );
					Server.Restart = 30;
					NewTimer("restart_server",1000,0);
				//}
				//else MessagePlayer("#737373][[#ff3399]Admin[#737373]] [#ff5050]A countdown already in process." ,player );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "get":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/get <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( plr.World != player.World ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is on another world.",player );
			else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not spawned.",player );
			else
			{
				local oldworld = plr.World;

				plr.Pos = player.Pos;
				plr.World = player.World;

				if( playa[ plr.ID ].House ) onPlayerExitWorld( oldworld );
				playa[ plr.ID ].House = null;
				playa[ plr.ID ].Area = null;
				SaveObj( plr );
								
				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has brought " + GetIngameTag( plr ) );
			}
		}
		break;
		
		case "goto":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/goto <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			//else if( plr.World != player.World ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is on another world.",player );
			else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not spawned.",player );
			else
			{
				player.Pos = plr.Pos;
				player.World = plr.World;

				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has teleported to " + GetIngameTag( plr ) );
			}
		}
		break;
		
		case "setwep":
		if( playa[ player.ID ].Level < 3 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setwep <player> <weapon>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not spawned.",player );
			else if( !world ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setwep <player> <weapon>",player ); 
			else
			{
				local wep = ( ::IsNum( world ) ) ? world.tointeger() : ::GetWeaponID( world );
				plr.SetWeapon( wep, 200 );

				MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has equipped " + GetIngameTag( plr ) + " [#ffffff]with [#33cc33]" + GetCustomWeaponName( wep ) );
			}
		}
		break;
		
		case "cwep":
		if( playa[ player.ID ].Level < 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/cwep <weapon>",player ); 
		else
		{
			if ( text == "ak" )
			{
			MessagePlayer( "You have been given AK-47", player );
			player.SetWeapon( 102,999);
			}
			else if ( text == "kurz" )
			{
			MessagePlayer( "You have been given Kurz MP5", player );
			player.SetWeapon( 107,999);
			}
			else if ( text == "m14" )
			{
			MessagePlayer( "You have been given M14", player );
			player.SetWeapon( 104,999);
			}
			else if ( text == "bulldog" )
			{
			MessagePlayer( "You have been given Bulldog Shotgun", player );
			player.SetWeapon( 103,999);
			}
		}
		break;
		
		case "disarm":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/disarm <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( plr.World != player.World ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Player is on another world.",player );
			else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not spawned.",player );
			else
			{
				if( p.Staff == 4 )
				{
				plr.Disarm();
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has disarmed " + GetIngameTag( plr ) + "." );
				MessagePlayer("[#70fa6b]You have been disarmed.", plr);
				//EchoMessage("4** Admin [ " + player.Name + " ] has disarm [ " + plr.Name + " ] ");
				}
				else
				{
				plr.Disarm();
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has disarmed " + GetIngameTag( plr ) + "." );
				MessagePlayer("[#ffffff]Admin " + player.Name + "[#70fa6b] has disarmed you.", plr);
				//EchoMessage("4** Admin [ " + player.Name + " ] has disarm [ " + plr.Name + " ] ");
				}
			}
		}
		break;
		
		case "createvehicle":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/createvehicle <vehicleid> <color1> <color2>",player ); 
		else
		{
			local model = GetTok(text," ",1), color1 = GetTok(text," ",2), color2 = GetTok(text," ",3);
			if ( !model || !color1 || !color2 ) MessagePlayer( ">> Use /" + cmd + " <Model> <Col1> <Col2>", player );
			else
			{
				player.Vehicle = CreateVehicle( model.tointeger(), player.World, Vector( player.Pos.x.tofloat(), player.Pos.y.tofloat(), player.Pos.z.tofloat() ), player.Angle.tofloat(), color1.tointeger(), color2.tointeger() );
			
				local GenerateUID = playa[ player.ID ].Password +""+ time();
				local AddID = player.Vehicle.ID;

				vehicle.rawset( player.Vehicle.ID,
				{
					Model = model.tointeger(),
					Owner = "100000",
					Share = {},
					Pos =  Vector( player.Pos.x.tofloat(), player.Pos.y.tofloat(), player.Pos.z.tofloat() ),
					PosString = player.Pos.x.tofloat() + ", " + player.Pos.y.tofloat() + "," + player.Pos.z.tofloat(),
					Angle = player.Angle.tofloat(),
					Locked = false,
					Col1 = color1.tointeger(),
					Col2 = color2.tointeger(),
					UID = GenerateUID,
					UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9,
					Price = 0,
					Body = 0,
					TruckerInvent = {},
					vehicle = player.Vehicle,
				})

				mysql_query( mysql, "insert into vehicles ( Model, Owner, Share, Pos, Angle, Locked, Col1, Col2, UID, UID2, World, Price ) VALUES ( '" + vehicle[ AddID ].Model + "', '" + playa[ player.ID ].ID + "', 'N/A', '" + vehicle[ AddID ].PosString + "', '" + vehicle[ AddID ].Angle + "', 'false', '0', '0', '" + vehicle[ AddID ].UID + "', '" + vehicle[ AddID ].UID2 + "', '0', '0' )" );			
			}
		}
		break;
		
		case "respawnthiscar":
		case "rtc":
		if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
		//else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/(r)espawn(t)his(c)ar <vehicleid> <color1> <color2>",player ); 
		else
		{
			local veh = player.Vehicle;
			veh.Respawn();
			MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has respawned their vehicle.");
			MessagePlayer("[#ff3399]You have respawned your vehicle!", player);
		}
		break;
		
		case "forcespawn":
		case "spawn":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff](/)force(spawn) <player>",player ); 
		else
		{
			local plr = FindPlayer( text );
			plr.Spawn();
			MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has force-spawned " + plr);
			MessagePlayer("[#ff3399]You have been force-spawned by " + player.Name, plr);
		}
		break;
		
		case "deletevehicle":
		case "delveh":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		//else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/(r)espawn(t)his(c)ar <vehicleid> <color1> <color2>",player ); 
		else
		{
			local veh = player.Vehicle;
			veh.Delete();
			MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has deleted their spawned vehicle.");
			MessagePlayer("[#ff3399]You have deleted your vehicle!", player);
		}
		break;

		case "acmds":
		if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else 
		{
			switch( playa[ player.ID ].Level )
			{
				case 2: return MessagePlayer("[#737373][[#ff3399]Moderator[#737373]] [#33cc33](/) [#ffffff]say, mute, checkafk, changename, freeze, unfreeze, spec, unmute, slap, ac, drown, goto, get, disarm, alias, ann, aheal, getuid, alias, accinfo, banlist, aduty",player ); break; 
				case 3: return MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#33cc33](/) [#ffffff]say, d, spawn, fban(fakeban), mute, checkafk, changename, suspendcop, unmute, banip, slap, ac, drown, setwep, goto, get, disarm, reward, alias, ann, aheal, ban, unban, uncrime, unjail, genpass, changename, getuid, accinfo, banlist, aparkcar, adropwep, removeadminpickup, aduty",player ); break; 
				case 4: return MessagePlayer("[#737373][[#ff3399]Manager[#737373]] [#33cc33](/) [#ffffff]say, d, spawn, fban(fakeban), delveh, asellcar, asellhouse, asellprop, addstaff, checkafk, mute, changename, suspendcop, createvehicle, respawnthiscar, unmute, slap, ac, addrobpoint, drown, setwep, goto, get, disarm, reward, alias, ann, aheal, ban, unban, uncrime, unjail, exe, e, setlevel, genpass, changename, getuid, accinfo, banlist, aparkcar, adropwep, removeadminpickup, aduty",player );
				case 5: return MessagePlayer("[#737373][[#ff3399]Owner[#737373]] [#33cc33](/) [#ffffff]say, d, spawn, fban(fakeban), delveh, asellcar, asellhouse, asellprop, addstaff, checkafk, mute, changename, suspendcop, createvehicle, respawnthiscar, unmute, slap, ac, addrobpoint, drown, setwep, goto, get, disarm, reward, alias, ann, aheal, ban, unban, uncrime, unjail, exe, e, setlevel, genpass, changename, getuid, accinfo, banlist, aparkcar, asellcar, adropwep, removeadminpickup, aduty",player ); 
				case 6: return MessagePlayer("[#737373][[#ff3399]Developer[#737373]] [#33cc33](/) [#ffffff]say, d, spawn, fban(fakeban), delveh, devduty, asellcar, asellhouse, asellprop addstaff, checkafk, mute, changename, suspendcop, createvehicle, respawnthiscar, unmute, slap, ac, addrobpoint, drown, setwep, goto, get, disarm, reward, alias, ann, aheal, ban, unban, uncrime, unjail, exe, e, setlevel, genpass, changename, getuid, allowaccess, accinfo, banlist, asellcar, aparkcar, adropwep, removeadminpickup, aduty",player ); 
				break;
			}
		}
		break;
		
		case "addrobpoint":
		
			if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <maxcash> <name>",player ); 
			else if( NumTok( text, " " ) < 2 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <maxcash> <name>",player ); 
			else if( !IsNum( GetTok( text, " ", 1 ) ) ) MessagePlayer("[#e600e6][Server] [#ff5050]Max cash must be an integer.", player );
			else {
			
				local
					intID			=	sphere.len( ),
					intMaxCash		=	GetTok( text, " ", 1 ).tointeger( ),
					szName			=	GetTok( text, " ", 2, NumTok( text, " " ) ),
					szInsertFormat	=	format( "INSERT INTO `sphere` VALUES ( '%s', '%s', %i, '%s', '%s', %i )", escapeSQLString( szName ), "" + player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z + "", intMaxCash, "robbery", "red", 0 );
				
				sphere[ intID ]          <- { };
				sphere[ intID ].Place    <- szName;
				sphere[ intID ].Pos      <- player.Pos;
				sphere[ intID ].MaxCash  <- intMaxCash;
				sphere[ intID ].Type     <- "robbery";
				sphere[ intID ].timer    <- 1453631537;
				sphere[ intID ].World    <- 0;
				sphere[ intID ].Rob      <- CreateCheckpoint( null, sphere[ intID ].World, true, sphere[ intID ].Pos, GetRGBColorFromString( "red" ), GetSphereSize( sphere[ intID ].Type ) );
				sphere[ intID ].Count    <- 0;
				
				QuerySQL( db, szInsertFormat );
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] [#ffffff] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has added a robbery point at [#ffffff]" + player.Pos + " with Name [#33cc33]" + szName + " [#ffffff]and MaxCash [#33cc33]" + intMaxCash );
				MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#ffffff]Robbery sphere added. Name: " + szName + ". MaxCash: " + intMaxCash + ".", player );
			
			};
		
		break;
		
		case "slap":
		
			if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <player> <reason>",player ); 
			else if( NumTok( text, " " ) < 2 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <player> <reason>",player ); 
			else if( !FindPlayer( GetTok( text, " ", 1 ) ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else {
			
				local
					iPlr			=	FindPlayer( GetTok( text, " ", 1 ) ),
					szReason		=	GetTok( text, " ", 2, NumTok( text, " " ) );
				
				if ( iPlr.Vehicle ) iPlr.Eject( );
				iPlr.Speed.z += 20;
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] [#ffffff] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has slapped [#33cc33]" + GetIngameTag( iPlr ) + " [#ffffff]. Reason: [#33cc33]" + szReason );
				EchoMessage("** Admin [ " + player.Name + " ] has slapped [ " + iPlr.Name + " ] Reason [ " + szReason + " ]");
				
			};
		
		break;
		
		case "ac":
		case "achat":
		case "adminc":
		case "adminchat":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <text>",player ); 
		else
		{
			/*if( playa[ player.ID ].Level == 2 )
			{
				MsgStaff( "[#f54269][Admin] Moderator " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
			else if( playa[ player.ID ].Level == 3 )
			{
				MsgStaff( "[#f54269][Admin] Admin " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
			else if( playa[ player.ID ].Level == 4 )
			{
				MsgStaff( "[#f54269][Admin] Manager " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
			else if( playa[ player.ID ].Level == 5 )
			{
				MsgStaff( "[#f54269][Admin] Owner " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
			else if( playa[ player.ID ].Level == 6 )
			{
				MsgStaff( "[#f54269][Admin] Lead Developer " + GetIngameTag( player ) + ": [#f54269]" + text );
			}*/
			if( playa[ player.ID ].Staff == 4 )
			{
				MsgStaff( "[#f54269][Admin] UC Admin " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
			else
			{
				MsgStaff( "[#f54269][Admin] " + PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + ": [#f54269]" + text );
			}
		}
		break;
		
		case "dev":
		case "mc":
		case "d":
		case "devchat":
		if( playa[ player.ID ].Level < 3 && playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/" + cmd + " <text>",player ); 
		else
		{
			if( playa[ player.ID ].Staff == 3 )
			{
				MsgDevs( "[#f5c842][DEV] Lead Mapper " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}
			/*else if( playa[ player.ID ].Level == 6 )
			{
				MsgDevs( "[#f5c842][DEV] Lead Developer " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}
			else if( playa[ player.ID ].Level == 3 )
			{
				MsgDevs( "[#f5c842][DEV] Admin " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}
			else if( playa[ player.ID ].Level == 4 )
			{
				MsgDevs( "[#f5c842][DEV] Manager " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}
			else if( playa[ player.ID ].Level == 5 )
			{
				MsgDevs( "[#f5c842][DEV] Owner " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}*/
			else
			{
				MsgDevs( "[#f5c842][DEV] " + PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + ": [#f5c842]" + text );
			}
		}
		break;
		
		case "setlevel":
		if( playa[ player.ID ].Level >= 4 )
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setlevel <player> <1-4>",player ); 
			else
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( playa[ plr.ID ].Logged == false ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not logged.",player );
				else if( !world ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/setlevel <player> <1-4>",player ); 
				else if( !IsNum( world ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Level must be in number.",player ); 
				else if( world.tointeger() > 5 || world.tointeger() < 0 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Level must between 1 and 4.",player ); 
				else
				{
					playa[ plr.ID ].Level = world.tointeger();
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] [#ffffff] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has changed [#33cc33]" + GetIngameTag( plr ) + " [#ffffff]level to [#33cc33]" + PInfoColor_Level( playa[ plr.ID ].Level ) );
					MessagePlayer( PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]changed your rank to " + PInfoColor_Level( playa[ plr.ID ].Level ), plr );
					////EchoMessage("4** Admin [ " + player.Name + " ] has change [ " + plr.Name + " ] level to [ " + GetLevelName( world ) + " ]");		
				}
			}
		}
		else
		{
			MsgPlr( 2, player, Lang.InvalidCmd );
		}
		break;
		
		case "addstaff":
		if( playa[ player.ID ].Level >= 4 )
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/addstaff <player> <mapper/tester/ucadmin>",player ); 
			else
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( playa[ plr.ID ].Logged == false ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not logged.",player );
				else if( !world ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/addstaff <player> <mapper/tester/ucadmin>",player ); 
				//else if( !IsNum( world ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Level must be in number.",player ); 
				//else if( world != "mapper" || world != "tester" || world != "ucadmin") MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Rank must be mapper, tester or ucadmin.",player ); 
				else
				{
					if( world == "mapper")
					{
					playa[ plr.ID ].Staff = 3;
					MsgStaff( GetIngameTag( player ) + " [#ffffff]has added [#33cc33]" + GetIngameTag( plr ) + " [#ffffff]to staff as a [#33cc33]Mapper.");
					MessagePlayer( GetIngameTag( player ) + " [#ffffff]changed your rank to [#70fa6b]Mapper.", plr );
					////EchoMessage("4** Admin [ " + player.Name + " ] has change [ " + plr.Name + " ] level to [ " + GetLevelName( world ) + " ]");	
					}
					if( world == "tester")
					{
					playa[ plr.ID ].Staff = 2;
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] [#ffffff] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has added [#33cc33]" + GetIngameTag( plr ) + " [#ffffff]to staff as a [#33cc33]Tester.");
					MessagePlayer( PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]changed your rank to [#70fa6b]Tester.", plr );
					////EchoMessage("4** Admin [ " + player.Name + " ] has change [ " + plr.Name + " ] level to [ " + GetLevelName( world ) + " ]");	
					}
					if( world == "ucadmin")
					{
					playa[ plr.ID ].Staff = 4;
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] [#ffffff] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has added [#33cc33]" + GetIngameTag( plr ) + " [#ffffff]to staff as a [#33cc33]Undercover Administrator.");
					MessagePlayer( PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]changed your rank to [#70fa6b]UC Admin.", plr );
					////EchoMessage("4** Admin [ " + player.Name + " ] has change [ " + plr.Name + " ] level to [ " + GetLevelName( world ) + " ]");	
					}
				}
			}
		}
		else
		{
			MsgPlr( 2, player, Lang.InvalidCmd );
		}
		break;
		
		case "viewcmds":
		if( playa[ player.ID ].Level >= 3 )
		{
			if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first lol.",player );
			else
			{
				switch( playa[ player.ID ].ViewCmds )
				{
					case true:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is no longer viewing live cmd logs." );
					playa[ player.ID ].ViewCmds = false;
					break;

					case false:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is now viewing live cmd logs." );
					playa[ player.ID ].ViewCmds = true;
					break;
				}
			}
		}
		else
		{
			MsgPlr( 2, player, Lang.InvalidCmd );
		}
		break;

		case "uncrime":
		if( playa[ player.ID ].Level < 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/uncrime <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( playa[ plr.ID ].Logged == false ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not logged.",player );
			else if( playa[ plr.ID ].Wanted == 0 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not wanted.",player );
			else
			{
				playa[ plr.ID ].ClearWanted( player ); 
				MsgStaff( GetIngameTag( player ) + "[#ffffff] has uncrimed " + GetIngameTag( plr ) + "." );
				MessagePlayer("[#ff3399] " + PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]has uncrimed you!", plr);
				//EchoMessage("4** Admin [ " + player.Name + " ] has uncrime [ " + plr.Name + " ] ");
			}
		}
		break;

		case "unjail":
		if( playa[ player.ID ].Level < 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/uncrime <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( playa[ plr.ID ].Logged == false ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not logged.",player );
			else if( playa[ plr.ID ].Jailtimer == 0 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not jailed.",player );
			else
			{
				playa[ plr.ID ].Jailtimer.Stop();
				playa[ plr.ID ].Jailtimer = null;
				playa[ plr.ID ].Jailtimerr = 0;
				playa[ plr.ID ].Jailtime = 0;
				playa[ plr.ID ].ClearWanted( player ); 
				plr.Pos = Vector(-1137.49, 882.349, 996.047);
				SendDataToClient( 70, null, plr );
				MsgStaff( GetIngameTag( player ) + "[#ffffff] has unjailed " + GetIngameTag( plr ) + "." );
				EchoMessage("** Admin** [ " + player.Name + " ] has unjail [ " + plr.Name + " ] ");
			}
		}
		break;
		
		case "reward":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/reward <player> <amount>",player ); 
		else
		{
			local plr = GetTok( text, " ", 1 ), world = GetTok( text, " ", 2 );

			switch( plr )
			{
				case "all":
				if( playa[ player.ID ].Level < 4 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player ); 
				else if( !world ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/reward <player/all> <amount>",player ); 
				else if( !IsNum( world ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Amount must be in number.",player ); 
				else
				{
					local plr1;

					for( local i = 0; i < GetMaxPlayers(); i ++ )
					{
						plr1 = FindPlayer( i );
						if ( plr1 )
						{
							if( playa[ plr1.ID ].Logged )
							{	
								playa[ plr1.ID ].AddCash( plr1, world.tointeger() );
							}
						}
					}

					MsgAll( 2, Lang.ARewardAll, GetIngameTag( player ), world );
				}
				break;

				default:
				plr = FindPlayer( GetTok( text, " ", 1 ) );
				if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
				else if( playa[ plr.ID ].Logged == false ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not logged.",player );
				else if( !world ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/reward <player> <amount>",player ); 
				else if( !IsNum( world ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Amount must be in number.",player ); 
				else if( playa[ player.ID ].Level == 2 && world.tointeger() > 10000 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Amount cannot more that 10000.",player ); 
				else
				{
					playa[ plr.ID ].AddCash( plr, world.tointeger() );
					MsgStaff( GetIngameTag( player ) + " [#ffffff]has rewarded [#33cc33]" + GetIngameTag( plr ) + " [#ffffff]$[#33cc33]" + world );
					//EchoMessage("4** Admin [ " + player.Name + " ] has reward [ " + plr.Name + " ] $[ " + world + " ]");
					MessagePlayer("[#ffffff]" + PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + "[#70fa6b] has rewarded you $" + world, plr);					
				}
				break;
			}
		}
		break;

		case "ann":
		if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ann <player/all> <text>",player ); 
		else
		{
			local plr = GetTok( text, " ", 1 ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( reason == null ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/ann <player/all> <text>",player ); 
			else 
			{
				switch( plr )
				{
					case "all":
					AnnounceToAll( reason );

					MsgStaff( GetIngameTag( player ) + " [#ffffff]has sending ann [#33cc33]" + reason + "  [#ffffff]to all players." );
					break;

					default:
					if( !FindPlayer( plr ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
					else
					{
						local p = FindPlayer( plr );
						SendDataToClient( 6080, reason, plr );

						MsgStaff( GetIngameTag( player ) + " [#ffffff]has sending ann [#33cc33]" + reason + "  [#ffffff]to " + GetIngameTag( p )  );
					}
					break;
				}
			}
		}
		break;

		case "aheal":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/aheal <player>",player ); 
		else
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), world = GetTok( text, " ", 2 );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( !plr.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not spawned.",player )
			else
			{
				if( p.Staff == 4 )
				{
				plr.Health=100;
				MsgStaff("UC Admin " + GetIngameTag( player ) + "[#ffffff] has healed " + GetIngameTag( plr ) + "." );
				MessagePlayer( "[#ffffff]You have been healed!", plr );
				//EchoMessage("4** Admin [ " + player.Name + " ] has healed [ " + plr.Name + " ] ");
				}
				else
				{
				plr.Health=100;
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + "[#ffffff] has healed " + GetIngameTag( plr ) + "." );
				MessagePlayer( PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]has healed you!", plr );
				//EchoMessage("4** Admin [ " + player.Name + " ] has healed [ " + plr.Name + " ] ");
				}
			}
		}
		break;

		case "genpass":
		if( playa[ player.ID ].Level < 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/genpass <player>",player ); 
		else
		{		
			local plr = FindPlayer( text );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			//else if( playa[ plr.ID ].Level == 0 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not registered.",player );
			else if( playa[ plr.ID ].Logged ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player already logged.",player );
			else 
			{
				local genpass = ( rand() % 10 ) + "" + ( rand() % 10 ) + "" + ( rand() % 10 ) + "" + ( rand() % 10 );

				MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Sending 4 digit password to " + GetIngameTag( plr ), player );
				MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Type [#ffffff] " + genpass + " [#33cc33]to login. You need to change your password with /changepass" , plr );
				
				mysqldb.UpdatePassword( ::SHA256( genpass ), playa[ plr.ID ].ID );
			}
		}
		break;

		case "exe":
		if( playa[ player.ID ].Level >= 4 ) 
		{
			if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/exe <code>",player ); 
			else
			{		
				try 
				{
					local script = compilestring( text ); 
					script();

					MsgStaff( GetIngameTag( player ) + " [#ffffff]has executed code[#33cc33] " + text);
				}
				catch( e ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Error, code " + e ,player ); 
			}
		}
		else MsgPlr( 2, player, Lang.InvalidCmd );
		break;

		case "e":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/e <code>",player ); 
		else
		{		
			SendDataToClient( 456, text, player );
		}
		break;
		
	/*	case "say":
		if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/say <text>",player ); 
		else
		{
			//if( playa[ player.ID ].Level == 6 )
			//{
				//Message("[#ffffff]Developer " + GetIngameTag( player ) + " [#bc0000]says: [#ffffff]" + text);
			//}
			//else
			//{
				Message("[#ffffff]" + PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#bc0000]says: [#ffffff]" + text);
			//}
		}
		break;
	*/
		case "allowaccess":
		if( playa[ player.ID ].Level < 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/allowaccess [account]", player ); 
		else
		{		
			local getAccount = mysqldb.isExist( text );
			if( !getAccount ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This account does not exist.", player ); 
			else
			{
				local q = ::mysql_query( mysql, "SELECT * FROM stats WHERE Name = '" + getAccount + "' " );
				local row = mysql_fetch_assoc( q );
				if( row["Name"] )
				{
					if( row["AllowLogin"] == "true" ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This account does not need to allow access.", player ); 
					else if( row["AdminLevel"] < 1 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This account does not need to allow access.", player ); 
					else 
					{
						local getname = mysqldb.GetNameFromID( getAccount );

						MsgStaff( GetIngameTag( player ) + " [#ffffff]has allow login of account[#33cc33] " + GetIngameTag( getname ) );

						print( "\r[Alert] Account " + getname + " now can login." );

						mysql_query( mysql, "UPDATE stats SET AllowLogin = 'true' WHERE Name = '" + getAccount + "'" );
					}
				}
			}
		}
		break;

		case "changename":
		if( playa[ player.ID ].Level < 3 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/changename <player> <newname>",player );
		else
		{		
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), newname = GetTok( text, " ", 2 );
			if( !plr ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Unknown player.",player );
			else if( !newname ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/changename <player> <newname>",player );
			else 
			{
				if( mysqldb.isExist( newname ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]New name already exist.",player );
				else
				{
					MsgStaff( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has changed " + GetIngameTag( plr ) + "[#ffffff]'s name to [#33cc33]" + newname );
					plr.Name = newname;
					mysqldb.UpdateName( newname, playa[ plr.ID ].ID );
					MessagePlayer( PInfoColor_Level( playa[ player.ID ].Level ) + " " + GetIngameTag( player ) + " [#ffffff]changed your name to [#70fa6b]" + newname, plr );
				}
			}
		}
		break;

		case "getuid":
		if( playa[ player.ID ].Level > 1 )
		{
			if( text )
			{	
				local plr2 = GetTok( text, " ", 1 ), type = GetTok( text, " ", 2 );
				if( type )
				{
					local plr = FindPlayer( plr2 );
					if( plr )
					{
						switch( type )
						{
							case "uid1":
							MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( plr ) + " [#33cc33]UID1 address [#ffffff]" + plr.UID + "", player );
							MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Address copied to clipboard.", player );
							
							SendDataToClient( 267, plr.UID, player );
							break;

							case "uid2":
							MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( plr ) + " [#33cc33]UID2 address [#ffffff]" + plr.UID2 + "", player );
							MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Address copied to clipboard.", player );
							
							SendDataToClient( 267, plr.UID2, player );
							break;

							default:
							MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>",player );
							break;
						}
					}

					else 
					{
						local result = GetPlayerUIDOneAndTwo( plr2 );
		                if( result )
		                {
							switch( type )
							{
								case "uid1":
								MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( result.Name ) + " [#33cc33]UID1 address [#ffffff]" + result.UID + "", player );
								MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Address copied to clipboard.", player );
								
								SendDataToClient( 267, result.UID, player );
								break;

								case "uid2":
								MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( result.Name ) + " [#33cc33]UID2 address [#ffffff]" + result.UID2 + "", player );
								MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Address copied to clipboard.", player );
								
								SendDataToClient( 267, result.UID2, player );
								break;

								default:
								MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>", player );
								break;
							}
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Account not found.",player );
					}
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>",player );
			}
			else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>",player );
		}
		else MsgPlr( 2, player, Lang.InvalidCmd );
		break;

		case "accinfo":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			if( text )
			{	
				local plr2 = GetTok( text, " ", 1 );
				local plr = FindPlayer( plr2 );
				if( plr )
				{
					if( playa[ plr.ID ].Level > 0 )
					{
		               	local getInfo = mysqldb.GetAccountInfo( playa[ plr.ID ].ID );
		               	local country = ::geoip2_country_name_by_addr( getInfo.RegIP ) + ", " + ::geoip2_continent_name_by_addr( getInfo.RegIP );
		               	local country2 = ::geoip2_country_name_by_addr( getInfo.IP ) + ", " + ::geoip2_continent_name_by_addr( getInfo.IP );

						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( plr ) + " [#33cc33]account info", player );
						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Register IP [#ffffff]" + getInfo.RegIP + " (" + country + ") [#33cc33]Register date [#ffffff]" + GetDate( getInfo.RegDate ), player );
						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Last login IP [#ffffff]" + getInfo.IP + " (" + country2 + ") [#33cc33]Last login date [#ffffff]" + GetDate( getInfo.LogTime ), player );
					}
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]This player is not registered.",player );
				}

				else 
				{
					local result = GetPlayerUIDOneAndTwo( plr2 );
		             if( result )
		            {
		                local getInfo = mysqldb.GetAccountInfo( result.ID );
		                local country = ::geoip2_country_name_by_addr( getInfo.RegIP ) + ", " + ::geoip2_continent_name_by_addr( getInfo.RegIP );
		                local country2 = ::geoip2_country_name_by_addr( getInfo.IP ) + ", " + ::geoip2_continent_name_by_addr( getInfo.IP );

						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( result.Name ) + " [#33cc33]account info", player );
						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Register IP [#ffffff]" + getInfo.RegIP + " (" + country + ") [#33cc33]Register date [#ffffff]" + GetDate( getInfo.RegDate ), player );
						MessagePlayer( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]Last login IP [#ffffff]" + getInfo.IP + " (" + country2 + ") [#33cc33]Last login date [#ffffff]" + GetDate( getInfo.LogTime ), player );
		            }
		            else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Account not found.",player );
				}
			}
			else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/accinfo <player/full name>",player );
		}
		break;

		case "alias":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			if( text )
			{	
				local plr2 = GetTok( text, " ", 1 ), type = GetTok( text, " ", 2 );
				if( type )
				{
					local plr = FindPlayer( plr2 );
					if( plr )
					{
						switch( type )
						{
							case "uid1":
							if( adminv2.UID[ plr.UID ].Alias.len() > 0 )
							{
								SendDataToClient( 6090, plr.Name + "'s UID Alias", player );

								foreach( index, value in adminv2.UID[ plr.UID ].Alias )
								{
									SendDataToClient( 6092, "[#33cc33]Name [#ffffff]" + index + " [#33cc33]Used time [#ffffff]" + value.UsedTimes + " [#33cc33]Last used [#ffffff]" + GetDate( value.LastUsed.tointeger() ), player );
								}
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Could not find player alias.",player );
							break;

							case "uid2":
							if( adminv2.UID2[ plr.UID2 ].Alias.len() > 0 )
							{
								SendDataToClient( 6090, plr.Name + "'s UID2 Alias", player );

								foreach( index, value in adminv2.UID2[ plr.UID2 ].Alias )
								{
									SendDataToClient( 6092, "[#33cc33]Name [#ffffff]" + index + " [#33cc33]Used time [#ffffff]" + value.UsedTimes + " [#33cc33]Last used [#ffffff]" + GetDate( value.LastUsed.tointeger() ), player );
								}
							}
							else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Could not find player alias.",player );
							break;

							default:
							MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/alias <player/full name> <uid1/uid2>",player );
							break;
						}
					}

					else 
					{
						local result = GetPlayerUIDOneAndTwo( plr2 );
		                if( result )
		                {
							switch( type )
							{
								case "uid1":
								if( adminv2.UID[ result.UID ].Alias.len() > 0 )
								{
									SendDataToClient( 6090, result.Name + "'s UID Alias", player );

									foreach( index, value in adminv2.UID[ result.UID ].Alias )
									{
										SendDataToClient( 6092, "[#33cc33]Name [#ffffff]" + index + " [#33cc33]Used time [#ffffff]" + value.UsedTimes + " [#33cc33]Last used [#ffffff]" + GetDate( value.LastUsed.tointeger() ), player );
									}
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Could not find player alias.",player );
								break;

								case "uid2":
								if( adminv2.UID2[ result.UID2 ].Alias.len() > 0 )
								{
									SendDataToClient( 6090, result.Name + "'s UID2 Alias", player );

									foreach( index, value in adminv2.UID2[ result.UID2 ].Alias )
									{
										SendDataToClient( 6092, "[#33cc33]Name [#ffffff]" + index + " [#33cc33]Used time [#ffffff]" + value.UsedTimes + " [#33cc33]Last used [#ffffff]" + GetDate( value.LastUsed.tointeger() ), player );
									}
								}
								else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Could not find player alias.",player );
								break;

								default:
								MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/alias <player/full name> <uid1/uid2>",player );
								break;
							}
						}
						else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Account not found.",player );
					}
				}
				else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>",player );
			}
			else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/getuid <player/full name> <uid1/uid2>",player );
		}
		break;

		case "banlist":
		if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else
		{
			local q = mysql_query( mysql, "SELECT Name, Ban FROM stats" );
			local row = mysql_fetch_assoc( q );

			SendDataToClient( 6090, "Ban Lists", player );

			while ( row["Name"] != null )
			{		
				local getBan = json_decode( row["Ban"] );
				if( getBan.len() > 0 )
				{
					local getexpire = ( getBan.Duration.tointeger() > ( time() - getBan.Time.tointeger() ) ) ? GetTiming( ( getBan.Duration.tointeger() - ( time() - getBan.Time.tointeger() ) ) ) : "Expired";

					SendDataToClient( 6092, "[#33cc33]Name [#ffffff]" + mysqldb.GetNameFromID( row["ID"] ) + " [#33cc33]Date [#ffffff]" + GetDate( getBan.Time.tointeger() ) + " [#33cc33]Reason [#ffffff]" + getBan.Reason + " [#33cc33]By [#ffffff]" + getBan.Admin + " [#33cc33]Timeleft [#ffffff]" + getexpire, player );
				}
				//GetSQLNextRow( q );
			}
			mysql_free_result( q );
		}
		break;

		/*case "gotoprop":
		if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/gotoprop [id]",player ); 
		else
		*/		

		case "adropwep":
		{
			if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first lol.",player );
			else if( !player.Weapon ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You cannot drop fist.",player );
			else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/adropwep <ammo>",player );
			else
			{
				if( !IsNum( text ) ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Ammo must be in integer.",player );
				else if( text.tointeger() < 0 || text.tointeger() == 0 ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Invalid value.",player );
				else
				{
					local model = GetWeaponModel( player.Weapon ), plrworld = player.World, plrname = playa[ player.ID ].ID, plrpos = Vector( ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
					local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );

					pickup.rawset( pickupinstance.ID, 
					{
						Model = model, 
						Type = "AWeapon:" + player.Weapon,
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
						GangHouse = null,
						Storage1 = "",
						Pickup = pickupinstance,
					});
					
					local ID = pickupinstance.ID;
					local ammo = ( player.Ammo - text.tointeger() );
					local count = ( Server.AdminPickup.len() + 1 );

					MsgPlr( 3, player, Lang.WepDrop, GetCustomWeaponName( player.Weapon ), text );

					MsgStaff( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has placed weapon pickup [#33cc33]" + GetCustomWeaponName( player.Weapon ) + "[#ffffff] on [#33cc33]" + GetDistrictName( player.Pos.x, player.Pos.y ) + "[#ffffff]. ID [#33cc33]" + count );
					
					Server.AdminPickup.rawset( count, 
					{ 
						ID = pickupinstance.ID,
						Admin = playa[ player.ID ].ID,
					});
				}
			}
		}
		break;

		case "removeadminpickup":
		{
			if( playa[ player.ID ].Level < 2 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first lol.",player );
			else if( !text ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/removeadminpickup <me/all>",player );
			else
			{
				switch( text )
				{
					case "me":
					local count = 0;
					foreach( index, value in Server.AdminPickup )
					{
						if( value.Admin == playa[ player.ID ].ID )
						{
							pickup[ value.ID ].Pickup.Remove();
							pickup.rawdelete( value.ID );

							Server.AdminPickup.rawdelete( index );

							count ++;
						}
					}

					if( count > 0 ) MsgStaff( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has removed all admin pickup created by him/her." );
					else  MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]No admin picked created by you.",player );
					break;

					case "all":
					local count = 0;
					foreach( index, value in Server.AdminPickup )
					{
						if( value.Admin == playa[ player.ID ].ID )
						{
							pickup[ value.ID ].Pickup.Remove();
							pickup.rawdelete( value.ID );

							Server.AdminPickup.rawdelete( index );

							count ++;
						}
					}

					if( count > 0 ) MsgStaff( "[#737373][[#ff3399]Admin[#737373]] [#33cc33]" + GetIngameTag( player ) + " [#ffffff]has removed all admin pickup." );
					else MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]No admin pickup found.",player );
					break;

					default:
					MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]Syntax, [#ffffff]/removeadminpickup <me/all>",player );
					break;
				}
			}
		}
		break;

		case "aduty":
		{
			if( playa[ player.ID ].Level < 2 && p.Staff != 4 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first lol.",player );
			else
			{
				switch( playa[ player.ID ].AdminDuty )
				{
					case true:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]has deactivated admin duty mode." );
					MessagePlayer( "[#70fa6b]You are no longer on admin duty.", player );
					player.Immunity = 0;
				//	player.ShowMarkers = true;
					player.SetMarker();
					
					playa[ player.ID ].AdminDuty = false;

					player.Colour = playa[ player.ID ].LastColor
					break;

					case false:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]has activated admin duty mode." );
					MessagePlayer( "[#70fa6b]You are now on admin duty.", player );
					player.Immunity = 31;
				//	player.ShowMarkers = false;
					player.RemoveMarker();

					playa[ player.ID ].AdminDuty = true;
					playa[ player.ID ].LastColor = player.Colour;

					player.Colour = RGB( 255, 0, 0 );
					break;
				}
			}
		}
		break;
		
		case "devduty":
		{
			if( playa[ player.ID ].Level < 6 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else
			{
				switch( playa[ player.ID ].DevDuty )
				{
					case true:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is no longer on Developer duty." );
					MessagePlayer( "[#70fa6b]You are now off developer duty.", player );
					player.Immunity = 0;
				//	player.ShowMarkers = true;
					player.SetMarker();
					
					playa[ player.ID ].DevDuty = false;

					player.Colour = playa[ player.ID ].LastColor
					break;

					case false:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is now on Developer duty." );
					MessagePlayer( "[#70fa6b]You are now on developer duty.", player );
					player.Immunity = 100;
				//	player.ShowMarkers = false;
					player.RemoveMarker();

					playa[ player.ID ].DevDuty = true;
					playa[ player.ID ].LastColor = player.Colour;

					player.Colour = RGB( 50, 168, 155 );
					break;
				}
			}
		}
		break;
		
		case "mduty":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else
			{
				switch( playa[ player.ID ].mDuty )
				{
					case true:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is no longer on Mapper duty." );
					MessagePlayer( "[#70fa6b]You are now off mapper duty.", player );
					player.Immunity = 0;
				//	player.ShowMarkers = true;
					player.SetMarker();
					
					playa[ player.ID ].mDuty = false;

					player.Colour = playa[ player.ID ].LastColor
					break;

					case false:
					MsgStaff( GetIngameTag( player ) + " [#ffffff]is now on Mapper duty." );
					MessagePlayer( "[#70fa6b]You are now on mapper duty.", player );
					player.Immunity = 100;
				//	player.ShowMarkers = false;
					player.RemoveMarker();

					playa[ player.ID ].mDuty = true;
					playa[ player.ID ].LastColor = player.Colour;

					player.Colour = RGB( 245, 0, 69 );
					
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]These are the keys used to interact with the editor!", player );
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]Arrow LEFT | RIGHT | UP | DOWN - Movement & Rotations", player );
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]Page UP | DOWN - Z Movement/Rotation.", player );
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]CTRL + C - Clone Object | R - Reset Object rotations | Delete - Delete object", player );
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]1 - Switch between Rotation & Position Mode | 2 - Speed variation", player );
					MessagePlayer( "[#00CC00][KEYS]: [#FFFFFF]Backspace - Stop controlling an object", player );
					MessagePlayer( "[#00CC00][COMMAND]: [#FFFFFF]/cam - To enable/disable free-view.", player );
					break;
				}
			}
		}
		break;
		
		case "cam":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( pData[ player.ID ].lastPos != null )
			{
				return null;
			}
			else if ( !pCamera[ player.ID ].IsEnabled() )
			{
				pCamera[ player.ID ].Enable();
				pData[ player.ID ].Editing = false;
				Object[ player.ID ] = null;
				MessagePlayer( "[#00CC00][CAM]: [#ffffff]Free view camera [#00CC00]enabled[#ffffff]. Type '/cam' to disable.", player );
			}
			else
			{
				pCamera[ player.ID ].Disable();
				MessagePlayer( "[#00CC00][CAM]: [#ffffff]Free view camera [#00CC00]disabled[#ffffff].", player );
			}
		}
		break;
		
		case "save":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( !text ) { print( "Pos: " + player.Pos ); return MessagePlayer( "Position saved!", player ); }
			print( "Pos: " + player.Pos + " //" + text );
			MessagePlayer( "Position " + text + "saved!", player );
		}
		break;
		
		case "newmap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( text && CurrentMap == "" )
			{
				if( text == "default" ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]The name [#00CC00]default [#FFFFFF]cannot be used to create a map", player );
				local check_map;
				try { check_map = QuerySQL( Maps, "SELECT * FROM sqlite_master WHERE type='table' AND name='" + CurrentMap.tolower() + "'"); } catch( e ) return MessagePlayer( "[#00CC00][MAP]: [#ffffff]A map with that name already exists!", player );
				QuerySQL( Maps, "CREATE TABLE '" + text.tolower() + "'( model INT, x INT, y INT, z INT, rotx FLOAT, roty FLOAT, rotz FLOAT )" );
				CurrentMap = "" + text.tolower();
				MsgStaff( "[#ffffff][New-Map]: [#00CC00]A new map [#ffffff]" + CurrentMap + " [#00CC00]was started by [#ffffff]" + player.Name + "." );
				if( check_map != null ) FreeSQLQuery( check_map );
			}
			else if( text && CurrentMap != "" )
			{ 
				MessagePlayer( "[#00CC00][NEWMAP]: [#ffffff]The map [#00CC00]" + CurrentMap + " [#ffffff]is still loaded, please close this map before proceeding. /savemap to save & close!" );
			}
		}
		break;
		
		case "addobject":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			if( CurrentMap == "" ) return MessagePlayer( "[#00CC00][MAP]: [#ffffff]You must open a map to add objects!", player );
			else if( !text )
			{
				pData[ player.ID ].Editing = false;
				Object[ player.ID ] = null;
				MessagePlayer( "[#00CC00][EDIT]: [#ffffff]You have finished editing the object.", player );
				player.IsFrozen = true;
				player.World = 100 + player.ID;
				pData[ player.ID ].viewObject = CreateObject( pData[ player.ID ].viewModel, player.World, C_VIEWLOC.x, C_VIEWLOC.y, C_VIEWLOC.z, 255 );
				pData[ player.ID ].motionTimer = NewTimer( "onObjectRender", 100, 0, player.ID );
				pData[ player.ID ].lastPos = player.Pos;
				player.Pos = C_PLOC; //Vector( -1351.37, 1275.35, 91.1706 );
				player.SetCameraPos( C_PLOC, C_VIEWLOC ); //( Vector( -1351.37, 1275.35, 91.1706 ), Vector( -1372.88, 1282.51, 83.8704 ) );
			}
			else if( text && text != "" && IsNum( text ) )
			{
				Object[ player.ID ] = CreateObject( text.tointeger(), 0, player.Pos.x, player.Pos.y, player.Pos.z, 255 );
				Object[ player.ID ].TrackingShots = true;
				objCreated++;
				player.Pos = Vector( player.Pos.x, player.Pos.y, player.Pos.z + 3 );
				pData[ player.ID ].Editing = true;
				//mapSave.Saved = false;
				//mapSave.unsavedObjects.append( Object[ player.ID ] );
				MsgStaff( "[#00CC00][MAP]: [#ffffff]Created object " + text );
			}
		}
		break;
		
		case "view":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			if( !text ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]/view [Object ID]", player );
			else if( text && !IsNum( text ) ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]/view [Object ID] [ Use Number! ]", player );
			else if( text && IsNum( text ) && pData[ player.ID ].viewObject != null ) 
			{
				pData[ player.ID ].viewObject.Delete();
				pData[ player.ID ].viewObject = null;
				pData[ player.ID ].viewModel = text.tointeger();
				pData[ player.ID ].viewObject = CreateObject( pData[ player.ID ].viewModel, player.World, C_VIEWLOC.x, C_VIEWLOC.y, C_VIEWLOC.z, 255 );
			}
			else if( pData[ player.ID ].viewObject == null ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]You must be in map selection menu to use this!", player );
		}
		break;
		
		case "map":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			if( CurrentMap != "" ) MessagePlayer( "[#00CC00][MAP]: [#ffffff]" + CurrentMap, player );
			else MessagePlayer( "[#00CC00][MAP]: [#ffffff]None", player );
		}
		break;
		
		case "savemap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( CurrentMap != "" )
			{
				if( objCreated == 0 )
				{
					QuerySQL( Maps, "DROP TABLE " + CurrentMap.tolower() + "" );
					CurrentMap = "";
					return MessagePlayer( "[#ffffff][Map]: [#00CC00]The map has been [#ffffff]closed & deleted [#00CC00]as no objects were created.", player );
				}
				
				QuerySQL( Maps, "DELETE FROM '" + CurrentMap.tolower() + "'" );
				pData[ player.ID ].Editing = false;
				for( local i = 0; i < objCreated; i++ )
				{
					local obj = FindObject(i);
					if( obj )
					{
						QuerySQL( Maps, "INSERT INTO '" + CurrentMap.tolower() + "' VALUES ( '" + obj.Model + "', '" + obj.Pos.x + "', '" + obj.Pos.y + "', '" + obj.Pos.z + "', '" + obj.RotationEuler.x + "', '" + obj.RotationEuler.y + "', '" + obj.RotationEuler.z + "');" );
					}
				}
				mapSave.Saved = true;
				mapSave.unsavedObjects = [];
				Message( "[#00CC00][MAP]: [#ffffff]" + player.Name + " has saved the map" );
			}
		}
		break;
		
		case "closemap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			if( CurrentMap != "" )
			{
				if( objCreated == 0 )
				{
					QuerySQL( Maps, "DROP TABLE " + CurrentMap.tolower() );
					CurrentMap = "";
					return MessagePlayer( "[#ffffff][Map]: [#00CC00]The map has been [#ffffff]closed & deleted [#00CC00]as no objects were created.", player );
				}
				
				pData[ player.ID ].Editing = false;
				Object[ player.ID ] = null;
					
				if( mapSave.Saved ) {
					for( local i = 0; i < objCreated; i++ )
					{
						local obj = FindObject(i);
						if( obj ) obj.Delete();
					}
				}
				else {
					//print( "Unsaved Objects -> " + mapSave.unsavedObjects.len() );
					//print( "Objects Created -> " + objCreated );
					
					if( mapSave.unsavedObjects.len() == objCreated ) { // If none of the objects were saved at all after map creations
						foreach( index, value in mapSave.unsavedObjects ) {
							if( !value ) continue;
							value.Delete();
							objCreated--;
						}
						QuerySQL( Maps, "DROP TABLE " + CurrentMap.tolower() );
						CurrentMap = "";
						objCreated = 0;
						return MessagePlayer( "[#ffffff][Map]: [#00CC00]The map has been [#ffffff]closed & deleted [#00CC00]as the created objects were not saved!", player );
					}
					else {
						for( local i = 0; i < objCreated; i++ )
						{
							local obj = FindObject(i);
							if( obj ) obj.Delete();
							objCreated--;
						}
					}
				}
				
				CurrentMap = "";
				objCreated = 0;
				MsgStaff( "[#00CC00][MAP]: [#ffffff]" + player.Name + " has closed the map" );
			}
		}
		break;
		
		case "exportmap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			if( CurrentMap != "" )
			{
				if( objCreated == 0 )
				{
					QuerySQL( Maps, "DROP TABLE " + CurrentMap.tolower() + "" );
					CurrentMap = "";
					return MessagePlayer( "[#ffffff][Map]: [#00CC00]The map has been [#ffffff]closed & deleted [#00CC00]as no objects were created.", player );
				}
				
				QuerySQL( Maps, "DELETE FROM '" + CurrentMap.tolower() + "'" );
				pData[ player.ID ].Editing = false;
				local mapData = "";
				setXMLBase( CurrentMap );
				for( local i = 0; i < objCreated; i++ )
				{
					local obj = FindObject(i);
					if( obj )
					{
						QuerySQL( Maps, "INSERT INTO '" + CurrentMap.tolower() + "' VALUES ( '" + obj.Model + "', '" + obj.Pos.x + "', '" + obj.Pos.y + "', '" + obj.Pos.z + "', '" + obj.RotationEuler.x + "', '" + obj.RotationEuler.y + "', '" + obj.RotationEuler.z + "');" );
						print( "CreateObject( " + obj.Model + ", 1, Vector( " + obj.Pos.x + ", " + obj.Pos.y + ", " + obj.Pos.z + "), 255 ).RotateByEuler( Vector( " + obj.RotationEuler.x + ", " + obj.RotationEuler.y + ", " + obj.RotationEuler.z + "), 0);" );
						mapData = mapData + "CreateObject( " + obj.Model + ", 1, Vector( " + obj.Pos.x + ", " + obj.Pos.y + ", " + obj.Pos.z + "), 255 ).RotateByEuler( Vector( " + obj.RotationEuler.x + ", " + obj.RotationEuler.y + ", " + obj.RotationEuler.z + "), 0);\r\n"
						addXMLObjectItem( CurrentMap, obj.ID, obj.Model, obj.Pos.x, obj.Pos.y, obj.Pos.z, obj.Rotation.x, obj.Rotation.y, obj.Rotation.z, -obj.Rotation.w );
						//print( "-- DEBUG -- " + obj.RotationEuler );
						//print( "-- DEBUG -- " + obj.Rotation );
						obj.Delete();
					}
				}
				setXMLEnd( CurrentMap );
				exportMapToFile( CurrentMap, mapData );
				CurrentMap = "";
				objCreated = 0;
				Object[ player.ID ] = null;
				MsgStaff( "[#00CC00][MAP]: [#ffffff]" + player.Name + " has exported the map!" );
			}
		}
		break;
		
		case "deletemap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( CurrentMap != "" ) return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Please close any opened maps before proceeding!", player );
			else if( !text ) return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Enter map name to delete!", player );
			else 
			{
				local map;
				try {
				map = QuerySQL( Maps, "SELECT * FROM '" + text.tolower() + "'" );
				}
				catch( error ) return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Map not found!", player );
			
				if( map != null ) FreeSQLQuery( map );
				QuerySQL( Maps, "DROP TABLE " + text.tolower() );
			
				MsgStaff( "[#00CC00][Map]: [#FFFFFF]'" + text.tolower() + "' has been [#00CC00]deleted [#FFFFFF]by " + player.Name + "!" );
			}
		}
		break;
		
		case "loadmap":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( CurrentMap != "" ) MessagePlayer( "[#00CC00][MAP]: [#ffffff]A map is already opened!", player );
			else
			{
				if( !text ) return MessagePlayer( "[#00CC00][MAP]: [#ffffff]Enter map name to load!", player );
				else
				{
					local map;
					try
					{
						map = QuerySQL( Maps, "SELECT * FROM '" + text.tolower() + "'" );
					}
					catch( e ) return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Map not found!", player );
					
					if( map == null ) {
						QuerySQL( Maps, "DROP TABLE " + text.tolower() );
						return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Map not found!", player );
						//return MessagePlayer( "[#00CC00][ERROR]: [#ffffff]Map '" + text.tolower() + "' was deleted since it was corrupted!", player );
					}
					
					do
					{
						local model = GetSQLColumnData( map, 0 );
						local x = GetSQLColumnData( map, 1 );
						local y = GetSQLColumnData( map, 2 );
						local z = GetSQLColumnData( map, 3 );
						local rotx = GetSQLColumnData( map, 4 );
						local roty = GetSQLColumnData( map, 5 );
						local rotz = GetSQLColumnData( map, 6 );
						local _obj = CreateObject( model, 1, x, y, z, 255 );
						_obj.RotationEuler.x = rotx.tofloat();
						_obj.RotationEuler.y = roty.tofloat();
						_obj.RotationEuler.z = rotz.tofloat();
						objCreated++;
						_obj.TrackingShots = true;
						Object[ player.ID ] = null;
						//Object[ player.ID ] = _obj;
						//Message( "[#00CC00][LOAD]: [#ffffff]Created Object at " + x + ", " + y + ", z with rotation " + rotx + ", " + roty + ", " + rotz );
					}
					while ( GetSQLNextRow( map ) );
					FreeSQLQuery( map );
				}
				CurrentMap = "" + text.tolower(); 
				MsgStaff( "[#00CC00][MAP]: [#ffffff]" + text + " [#00CC00]has been loaded by [#ffffff]" + player.Name + "." );
			}
		}
		break;
		
		case "desall":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else 
			{
			if( CurrentMap != "" ) RemoveObjects( CurrentMap );
			}
		}
		break;
		
		case "selectobject":
		case "editobject":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( !text ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]/" + cmd + " [Object ID]", player );
			else if( text && !IsNum( text ) ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]ID must be positive integer!", player );
			else
			{
			text = text.tointeger();
			local object = FindObject( text );
			if( !object ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]Invalid object ID!", player );
			onObjectShot( object, player, WEP_M60 );
			}
		}
		break;
		
		case "delobj":
		{
			if( playa[ player.ID ].Staff != 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
			else if( !player.IsSpawned ) MessagePlayer("[#737373][[#ff3399]Admin[#737373]] [#ff5050]You must spawn first.",player );
			else if( !pData[ player.ID ].MapDelete )
			{
			pData[ player.ID ].MapDelete = true;
			MessagePlayer( "[#00CC00][DELETE]: [#ffffff]Map delete mode is [#00ff00]ON[#ffffff]! Touch object to delete it!", player );
			EnableBumpTracks();
			}
		
			else if( pData[ player.ID ].MapDelete )
			{
				pData[ player.ID ].MapDelete = false;
				MessagePlayer( "[#00CC00][DELETE]: [#ffffff]Map delete mode is [#ff0000]OFF[#ffffff]!", player );
				DisableBumpTracks();
			}
		}
		break;
	}
}

function restart_server()
{
	Server.Restart--;
	switch( Server.Restart )
	{
		case 20:
		case 10:
		legacyMessage("[#e600e6][Server] [#e60000]WARNING! Server will restart in " + Server.Restart + " seconds!" ); 
		//EchoMessage("4** WARNING! Server will restart in " + Server.Restart + " seconds!" );
		break;
		case 0:
		foreach( kaki, kiki in Server.Players )
		{
			local player = FindPlayer( kiki )
			{
				if( player )
				{
					if( playa[ player.ID ].Level != 0 && playa[ player.ID ].Logged == true )
					{
						playa[ player.ID ].SaveData( player );
					}
				}
			}
		}
		legacyMessage("[#e600e6][Server] [#e60000]WARNING! Server is RESTARTING!" ); 
		EchoMessage("**The Server is RESTARTING!**" ); 
		break;
		case -5:
		ShutdownServer();
		break;
	}
}

function KickPlayer( player, admin, reason )
{

	if( admin == "Server" )
	{
		legacyMessage("[#737373][[#ff3399]Admin[#737373]] [#ffffff]Auto kicked [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason: [#33cc33]" + reason );
		EchoMessage("** Auto kicked** " + player.Name + " **Reason:** " + reason);
	}
	
	else if( playa[ admin.ID ].Staff == 4 )
	{
		legacyMessage( GetIngameTag( player ) + " [#ffffff]has been kicked from the server. Reason: [#33cc33]" + reason );
	}
	
	else
	{
		legacyMessage(" " + PInfoColor_Level( playa[ admin.ID ].Level ) + " " + GetIngameTag( admin ) + " [#ffffff]has kicked [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason [#33cc33]" + reason );
		EchoMessage("**" + PInfoColor_Level( playa[ admin.ID ].Level ) + "** " + admin + " **has kicked** " + player.Name + " **Reason:** " + reason);
		//MsgAll( 2, Lang.AKickAll, GetIngameTag( admin ), GetIngameTag( player ), reason );
	}
	player.Kick();

}

function DrownPlayer( player, admin, reason )
{
	if( admin == "Server" )
	{
		legacyMessage("[#737373][[#ff3399]Admin[#737373]] [#ffffff]Auto drowned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason [#33cc33]" + reason );
		EchoMessage("**Auto drowned** " + player.Name + " **Reason:** " + reason);
	}

	else if( playa[ admin.ID ].Staff == 4 )
	{
	legacyMessage( GetIngameTag( player ) + " [#ffffff]has been drowned. Reason [#33cc33]" + reason );
	}

	else 
	{
		legacyMessage(" " + PInfoColor_Level( playa[ admin.ID ].Level ) + " " + GetIngameTag( admin ) + " [#ffffff]has drowned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason [#33cc33]" + reason );
		EchoMessage("**" + PInfoColor_Level( playa[ admin.ID ].Level ) + "** " + admin + " **has drowned** " + player.Name + " **Reason:** " + reason);
		//MsgAll( 2, Lang.ADrownAll, GetIngameTag( admin ), GetIngameTag( player ), reason );
	}
	
	player.Eject();
	player.Pos = Vector( 277.9985, -1608.2971, 10.4889 );

}

function MutePlayer( player, admin, reason, math )
{
    if( admin == "Server" )
	{
		legacyMessage("[#ffffff]Auto muted [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason: [#33cc33]" + reason + " [#ffffff]Duration: [#33cc33]" + GetTiming( math ) );
		EchoMessage("** Auto muted** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
	}
	
	else if( playa[ admin.ID ].Staff == 4 )
	{
		legacyMessage( GetIngameTag( player ) + " [#ffffff]has been muted. Reason: [#33cc33]" + reason + " [#ffffff]Duration: [#33cc33]" + GetTiming( math ) );
	}
	
	else
	{
		legacyMessage(" " + PInfoColor_Level( playa[ admin.ID ].Level ) + " " + GetIngameTag( admin ) + " [#ffffff]has muted [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason: [#33cc33]" + reason + " [#ffffff]Duration: [#33cc33]" + GetTiming( math ) );
		EchoMessage("** Admin** " + admin + " **has muted** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
	
		//MsgAll( 2, Lang.AMuteAll, GetIngameTag( admin ), GetIngameTag( player ), reason, GetTiming( math ) );
	}
	
	adminv2.AddMute( player, admin, reason, math );

	_Timer.Destroy( playa[ player.ID ].Mute );

	playa[ player.ID ].Mute = _Timer.Create( this, function( player ) 
	{
		adminv2.UID[ player.UID ].Mute = null;
		adminv2.UID2[ player.UID2 ].Mute = null;
		playa[ player.ID ].Mute = null;
	}, ( math*60 ), 1, player );
}

function BanPlayer( player, admin, reason, math )
{
    if( admin == "Server" )
	{
		legacyMessage("[#737373][[#ff3399]Admin[#737373]] [#ffffff]Auto banned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason [#33cc33]" + reason + " [#ffffff]Duration [#33cc33]" + GetTiming( math ) );
		EchoMessage("** Auto Banned** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
	}
	
	else if( playa[ admin.ID ].Staff == 4 )
	{
		legacyMessage( GetIngameTag( player ) + " [#bc0000]has been banned from the server for [#33cc33]" + reason + " [#ffffff]Duration [#33cc33]" + GetTiming( math ) );
		EchoMessage("**Banned** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
	}
	
	else
	{
		legacyMessage("[#ff3399] " + PInfoColor_Level( playa[ admin.ID ].Level ) + " " + GetIngameTag( admin ) + " [#ffffff]has banned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason: [#33cc33]" + reason + " [#ffffff]Duration: [#33cc33]" + GetTiming( math ) );
		EchoMessage("** Admin** " + admin + " **has banned** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
	
		//MsgAll( 2, Lang.ABanAll, GetIngameTag( admin ), GetIngameTag( player ), reason, GetTiming( math ) );
	}
	
	adminv2.AddBan( player, admin.Name, reason, math );

	player.Kick();
}

function FakeBanPlayer( player, admin, reason, math )
{
	legacyMessage("[#ff3399] " + PInfoColor_Level( playa[ admin.ID ].Level ) + " " + GetIngameTag( admin ) + " [#ffffff]has banned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason: [#33cc33]" + reason + " [#ffffff]Duration: [#33cc33]" + GetTiming( math ) );
	EchoMessage("** Admin** " + admin + " **has fake banned** " + player.Name + " **Reason:** " + reason + " **Duration:** " + GetTiming( math ));		
}

function OfflineBan( player, admin, reason, math )
{
	MsgStaff("[#ff3399][ADMIN] " + GetIngameTag( admin ) + " [#ffffff]has offline banned [#33cc33]" + GetIngameTag( player ) + " [#ffffff]Reason [#33cc33]" + reason + " [#ffffff]Duration [#33cc33]" + GetTiming( math ) );
	
	//MsgAll( 2, Lang.ABanAll, GetIngameTag( admin ), GetIngameTag( player ), reason, GetTiming( math ) );
	
	adminv2.AddBan( player, admin.Name, reason, math );
}
