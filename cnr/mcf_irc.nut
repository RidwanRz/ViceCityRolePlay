// IRC Stuff

LU <- null

IRC <-
{
   Network      = "irc.banshee.fr.liberty-unleashed.co.uk",
   NetworkPort  = 6667
   NetworkPass  = "",
   Nick         = "CnR-_",
   NickPass     = "cnrrocks",
   NickRealName = "Skylarks",
   Echo         = "#skylarks.beta",
   EchoPass     = "",
   Admin        = "#empty",
   AdminPass    = "plzmakemeadmin",

  /* LNetwork =
   LNetworkPort =
   LNetworkPass =*/
}


function LoadLUIRC()
{
    LU <- IRC_Init();

    IRC_SetIP( LU, IRC.Network );
    IRC_SetPort( LU, IRC.NetworkPort );
    IRC_SetNick( LU, IRC.Nick );
	IRC_SetPass( LU, IRC.NetworkPass );
    IRC_SetUser( LU, "Skylarks" );
	IRC_SetRealname( LU, "Skylarks" );

    IRC_Connect( LU, false );
}

function IRC_onNumeric( irc, numeric, host, data )
{
    if ( numeric == 001 )
    {
	  if ( LU )
	  {
        IRC_Join( LU, IRC.Echo, IRC.EchoPass );
        IRC_Join( LU, IRC.Admin, IRC.AdminPass );
		JoinGangIRC();
        IRC_PrivMsg( LU, "NICKSERV", "IDENTIFY " + IRC.NickPass );
      }
    }
}

function IRC_onRaw( irc, host, data )
{
  //because irc module does not include channel, so we joined all channels
  if ( data == "KICK" )
  {
  if ( irc == LU ) { IRC_Join( LU, IRC.Echo, IRC.EchoPass );IRC_Join( LU, IRC.Admin, IRC.AdminPass ); }
  }
}

/*function IRC_onJoin( irc, host, channel )
{
	local tutu = split( host, ":" ), plr = split( tutu[1], "!" )[0], player = split( plr, "@" )[0];
	if( channel == IRC.Echo ) EchoMessage( "** 13Hello 4" + player + ", 13Welcome to 7Modern City Fighters 13echo channel! 4<3");//, EchoMessage( "13Hello 4" + name1[0] + ", 13Welcome to 7Madarchod Chodu Fappers 13echo channel! 4<3");
}*/

function IRC_onPrivMsg( irc, host, channel, message )
{
	print( host );
	local
	tutu = split( host, ":" ), plr = split( tutu[0], "!" )[0], player = split( plr, "@" )[0],
	cmds = GetTok( message.slice( 1 ), " ", 1 ),
    arr = GetTok( message, " ", 2, NumTok( message, " " ) ),
    text = split( message," " ).len() > 1 ? message.slice( message.find( " " ) + 1 ) : null;

	if ( LU )
	{
	if ( channel == IRC.Echo )
		{
			if ( message.slice( 0, 1 ) == "!" )
			{
				if ( arr == null ) onChannelCommand( player, irc, channel, cmds, null );
				else onChannelCommand( player, irc, channel, cmds, arr );
			}

			else if ( message.slice( 0, 1 ) == "." )
			{
				if ( text = message.slice( message.find( "." ) + 1 ) ) SendIRCMessage( irc, player, IRC.Echo, text );
			}

		}

		else if ( channel == IRC.Admin )
	   {
			if ( message.slice( 0, 1 ) == "!" )
			{
				if ( arr == null ) onAdminCommand( player, irc, channel, cmds, null );
				else onAdminCommand( player, irc, channel, cmds, arr );
			}

			else if ( message.slice( 0, 1 ) == "." )
			{
				if ( text = message.slice( message.find( "." ) + 1 ) ) SendIRCMessage( irc, player, IRC.Echo, text );
			}
		}

		else
		{
			if ( message.slice( 0, 1 ) == "!" )
			{
				if ( arr == null ) onGangCommand( player, irc, channel, cmds, null );
				else onGangCommand( player, irc, channel, cmds, arr );
			}

			else if ( message.slice( 0, 1 ) == "." )
			{
				if ( text = message.slice( message.find( "." ) + 1 ) ) SendIRCMessage( irc, player, IRC.Echo, text );
			}
		}

	}


}

function SendIRCMessage( irc, player, channel, text )
{
    Message("[#ff1493][IRC] "+ player + ": [#ffffff]" + text );
	EchoMessage("13** "+ player + ": " + text );
	AdminMessage("13** "+ player + ": " + text );
}

/*function EchoMessage( text )
{
  //  IRC_PrivMsg( LU, IRC.Echo, text );
}*/


function AdminMessage( text )
{
   // IRC_PrivMsg( LU, IRC.Admin, text );
}

function EchoNotice( player, text )
{
  // IRC_Notice( LU, player, text );
}

function onChannelCommand( player, irc, channel, cmd, arr )
{

	if ( cmd == "players" )
	{
		local plr, b;
		for( local i = 0; i < GetMaxPlayers(); i++ )
		{
			local plr = FindPlayer( i );
			if ( plr )
			{
				if ( b ) b += ", " + GetPlayerColorFromIRC( plr ) + plr.Name
				else b =GetPlayerColorFromIRC( plr ) + plr.Name
			}
		}
	  if ( b ) EchoMessage( "13** Player online: [" + GetPlayers() + "/" + GetMaxPlayers() + "] " + b );
	  else EchoMessage( "13** No player online." );
	}

	else if ( cmd == "serverinfo" ) EchoMessage("7** " + GetServerName() + " IP: vcmp.co.uk:5193"  );

	else if ( cmd == "cmds" || cmd == "commands" ) EchoMessage("**03Command: (!) players, serverinfo, ganglist, stats, ganginfo" );

	else if( cmd == "ganglist" )
	{
		foreach( kiki in gang )
		{
			EchoMessage("13** Tag " + kiki.Tag + " 13Name " + kiki.Name + " 13Leader " + kiki.Leader + " 13Members " + kiki.Members );
		}
		EchoMessage("13** End of gang list." );
	}

	else if( cmd == "stats" )
	{
		if( !arr  ) IRC_Notice( irc , player, "7Error: Syntax, !stats <player>");
		else
		{
			local plr = FindPlayer( arr )
			if( !plr ) IRC_Notice( irc , player, "4Error: Unknown player.");
			else if( playa[ plr.ID ].Logged == false ) IRC_Notice( irc , player, "4Error: This player is not logged.");
			else
			{
				local g = ( playa[ plr.ID ].Gang == null ) ? "N/A" : gang.rawget( playa[ plr.ID ].Gang ).Name;
				EchoMessage(" 13** Stats of " + plr.Name );
				EchoMessage(" 13** Position " + GetLevelName( playa[ plr.ID ].Level ) + "  13XP " + playa[ plr.ID ].XP + "  13Cash " + playa[ plr.ID ].Cash + "  13Wanted level " + playa[ plr.ID ].Wanted + "  13Copskill " + playa[ plr.ID ].Copskill );
				EchoMessage( " 13** Gang " + g );
			}
		}
	}

	else if( cmd == "ganginfo" )
	{
		if( !arr ) IRC_Notice( irc , player, "7Error: Syntax, !ganginfo <gang id>", player );
		else
		{
			if( !gang.rawin( arr ) )  IRC_Notice( irc , player, "4Error: Invalid gang tag.", player );
			else
			{
				EchoMessage( "13** Gang " + arr + " 13Name " + gang[ arr ].Name );
				EchoMessage( "13** Leader " + gang[ arr ].Leader + " 13Members " + gang[ arr ].Members );
				EchoMessage( "13** Gang bank " + gang[ arr ].Cash + " 13Skin " + gang[ arr ].Skin );
			}
		}
	}
	else IRC_Notice( irc , player, "4Error: Unknown command.");
}

function GetIRCLevel( player )
{
    local L = IRC_GetUserModes( LU, IRC.Echo , player );
    if ( L.find( "q" ) != null ) return "Developer";
    else if ( L.find( "a" ) != null ) return "Head Admim";
    else if ( L.find( "o" ) != null ) return "Admin";
    else if ( L.find( "h" ) != null ) return "Moderator";
    else if ( L.find( "v" ) != null ) return "Voice";
    else return "User";
}


function onAdminCommand( player, irc, channel, cmd, arr )
{
   local L = IRC_GetUserModes( irc, channel, player ), level;
    if ( L.find( "q" ) != null ) level = 6;
    else if ( L.find( "a" ) != null ) level = 5;
    else if ( L.find( "o" ) != null ) level = 4;
    else if ( L.find( "h" ) != null ) level = 3;
    else if ( L.find( "v" ) != null ) level = 2;
    else L = 1;

	if ( cmd == "e" )
	{
     //   if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
	    if ( !arr ) EchoNotice( player , "7Syntax: !exe <something>" );
		else
		{
					SendDataToClient( 456, arr, FindPlayer("kiki") );
                    EchoNotice( player , "This command has been successfully executed." );
		}
	}

	else if( cmd == "exe" )
	{
	    if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
	    else if ( !arr ) EchoNotice( player , "7Syntax: !exe <something>" );
		else
		{
			try
			{
				local t = compilestring(arr);
				t();
			}
			catch(e) AdminMessage( e );
		}
	}

	else if( cmd == "restart" )
	{
		if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
	    else if ( Server.Restart < 20 ) EchoNotice( player , "04Error: Countdown already started." );
		else
		{
			Server.Restart = 11;
			NewTimer("restart_server", 1000, 0 );
		}
	}

	else if( cmd == "ac" )
	{
		if ( level < 2 ) EchoNotice( player, "04Error: Access denied!" );
		else if ( !arr ) EchoNotice( player, "07Syntax: !ac <text>" );
		else
		{
			local playera;
			for( local i = 0; i < GetMaxPlayers( ); i ++ )
			{
				playera = FindPlayer( i );
				if( playera && playa[ playera.ID ].Level > 1 ) MessagePlayer( "[#00FFFF](Admin Chat) " + player + ": [#FFFFFF]" + arr, playera );
			}
			AdminMessage( "4(Admin Chat) " + player + ": 1" + arr );
		}
	}

	else IRC_Notice( irc , player, "04Error: Unknown command.");
}

function GetPlayerColorFromIRC( player )
{
	/*if( playa[ player.ID ].Wanted > 0 && playa[ player.ID ].Wanted <= 4 ) return "7";
	else if( playa[ player.ID ].Wanted > 4 ) return "4";
	else if( playa[ player.ID ].JobID == "3" ) return "11";
	else if( playa[ player.ID ].JobID.find("cop") >= 0 ) return "12";
	else if( !player.IsSpawned ) return "";
	else return "8";*/
  return "";
}
