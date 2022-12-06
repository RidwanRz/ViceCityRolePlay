pIRC	<- null;
aUser	<- {};

class IRCEcho
{
	BotName		= "CnR";
	BPass		= "";
	Address		= "94.23.61.36";
	Email		= "";
	Port		= 6667;
	
	Channel		= "#cnr";
	Staff		= "#skylarks.cnr.staff";
	
	Password	= "skyandflash2015";
	Levels		=
	{
		VOP	= 2,
		HOP	= 3,
		AOP	= 4,
		SOP	= 5,
		QOP	= 6
	};
}


class UserHandling
{
	Name		= null;
	Group		= null;
	Spam		= null;
	
	Level		= 0;
	
	constructor( szName, iLevel, szGroup )
	{
		Name	= szName;
		Level	= iLevel;
		Group	= szGroup;
		
		Spam	= { LastWord = null, ToleratedTimes = 0, LastTimeSaid = 0 };
	}
	
	function Kick( szChannel, szNick, szReason )
	{
		::pIRC.Send( "KICK " + szChannel + " " + szNick + " " + szReason + "\n" );
	}
	
}

function IRC_startProcess( )
{
	local cData = IRCEcho;
	
	pIRC = NewSocket( "onIRCRawData" );
	pIRC.Connect( cData.Address, cData.Port );
	pIRC.SetNewConnFunc( "IdentifyBot" );
	print( "\r[IRC] Connected!" );
	
	return 1;
}

function onIRCRawData( szData )
{	
	local
	cData	= IRCEcho,
	aszArgumentay	= split( szData, " " ),
	szEvent	= aszArgumentay[ 1 ];
	
	if ( aszArgumentay[ 0 ] == "PING" )
	{
		pIRC.Send( "PONG " + szEvent + "\n" );
	}
	
	/*if ( szData.find( "You have not registered" ) )
	{
		pIRC.Send( "PRIVMSG NickServ REGISTER " + cData.BPass + " " + cData.Email + "\n" );
	}*/
	
	if ( szData.find( "001" ) )
	{
		pIRC.Send( "MODE " + cData.BotName + " +B\n" );
		pIRC.Send( "PRIVMSG NickServ IDENTIFY " + cData.BPass + "\n" );
		pIRC.Send( "PRIVMSG HostServ ON\n" );
	}
	
	//if ( szData.find( "You are now identified" ) )
	//{
		pIRC.Send( "JOIN " + cData.Channel + " " + cData.Password + "\n" );
		pIRC.Send( "JOIN " + cData.Staff + " " + cData.Password + "\n" );
	//}
	
	if ( szEvent == ":Closing" )
	{
		pIRC.Send( "QUIT IRC Error\n" );
	
		print( "IRC: Connection has been lost." );
		print( "IRC: Reconnecting in 10 seconds." );
		
		NewTimer( "IRC_startProcess", 10000, 1 );
	}
	
	if ( szEvent == "MODE" || szEvent == "NICK" || szEvent == "JOIN" || szEvent == "PART" || szEvent == "QUIT" || szEvent == "KICK" )
	{
	  pIRC.Send( "NAMES " + cData.Channel + "\n" );
	}
	
	/*if ( szEvent == "JOIN" )
	{
	  local
	  aNick		        = split( szData, "!" ),
	  aChannel          = split( szData, ":");
	  if ( aChannel == "kiki.echo" ) Message(g+"[IRC] " + aNick[0].slice( 1 ) +w+ " has joined " +g+ IRCEcho.Channel );
	  EchoNotice( aNick[0].slice( 1 ), "Hello 3" + aNick[0].slice( 1 ) + " babe, Welcome to 13#" + aChannel[1].slice( 1 ) +" \x0003:D");

	}
	
		if ( szEvent == "PART" || szEvent == "QUIT" )
	{
	  local
	  aNick		        = split( szData, "!" ),
	  aChannel          = split( szData, "b");
	  Message(g+"[IRC] " + aNick[0].slice( 1 ) +w+ " has left " +g+ IRCEcho.Channel );
	}*/

	
	if ( szEvent == "KICK" )
	{
		if ( szData.find( cData.BotName ) )
		{
			pIRC.Send( "JOIN " + cData.Channel + " " + cData.Password + "\n" );
			pIRC.Send( "JOIN " + cData.Staff + " " + cData.Password + "\n" );			
		}
	}
	
	
	if ( szEvent == "353" )
	{
		aUser = {};
		
		local szList = szData.slice( szData.find( " " ) + 6 );
		
		szList		= split( szList, ":" );
		if ( szList.len() < 2 ) return;
		else
		{
			foreach( pUser in split( szList[ 1 ], " " ) )
			{
				local firstChar = pUser[ 0 ], szNick, iLevel = 0;
				
				if ( firstChar == 126 )		iLevel = 6;
				else if ( firstChar == 38 )	iLevel = 5;
				else if ( firstChar == 64 )	iLevel = 4;
				else if ( firstChar == 37 )	iLevel = 3;
				else if ( firstChar == 43 )	iLevel = 2;
				else iLevel = 1;
				
				szNick = (iLevel > 1) ? pUser.slice(1) : pUser;
				aUser[ szNick ] <- UserHandling( szNick, iLevel, IRCGroup( iLevel ) );
			}
		}
	}
	
	if ( aszArgumentay.len() >= 4 && szEvent == "PRIVMSG" )
	{
		local
		aOutput		= split( szData, "!" ),
		szNick, szCmd, szArgument;
		
		IRC_onUserTalk( null, null, aOutput, szData );
		
		if ( aOutput.len() < 3 ) return;

		szNick	= aOutput[ 0 ].slice( 1 );
		szCmd	= aOutput[ 2 ].len() > 2 ? split( aOutput[ 2 ], "\r\n" )[ 0 ] : null;
		szArgument	= ( aszArgumentay.len() > 2 && szCmd && split( szCmd, " " ).len() > 1 ) ? szCmd.slice( szCmd.find( " " ) + 1 ) : null;
		szCmd	= ( !szCmd || ( szCmd = split( szCmd, " " ) ).len() < 1 ) ? null : szCmd[ 0 ];
		
		if ( szNick && szCmd && IRC_retrieveFirstChar( szData ) == "!" )
		{	
			if ( aszArgumentay[ 2 ] == cData.Channel ) IRC_onChannelCommand( szNick, szCmd, szArgument );
			if ( aszArgumentay[ 2 ] == cData.Staff ) IRC_onStaffCommand( szNick, szCmd, szArgument );
		}
	}
}

function IRC_retrieveFirstChar( sentData )
{
	local aData = split( sentData, " " ); aData = ( aData.len() < 4 ) ? null : aData[ 3 ];
	if ( aData.len() < 5 ) return 0;
	
	return aData ? aData.slice(1,2) : null;
}

function IRC_onUserTalk( szNick, szArgument, ... )
{
	local szChannel = IRCEcho.Channel;
	if ( !szNick || !szArgument )
	{
		local input;
		if ( vargv.len() >= 1 && typeof( input = vargv[ 0 ] ) == "array" )
		{
			szNick	= input[ 0 ].slice(1);
		}
		if ( vargv.len() >= 2 && typeof( input = vargv[ 1 ] ) == "string" )
		{
			szArgument	= split( input, " " );
			szChannel	= szArgument[ 2 ]; 
			szArgument	= input.slice( szArgument[ 0 ].len() + szArgument[ 1 ].len() + szArgument[ 2 ].len() + 4 );
		}
	}
	
	if ( !aUser.rawin( szNick ) ) return;
	
	if ( szNick && szArgument )
	{
		local findSpam = aUser[ szNick ].Spam;
		
		if ( (findSpam.LastTimeSaid + 620) > GetTickCount() )
		{
			if ( ( findSpam.ToleratedTimes += 2 ) >= 3 )
			{
				findSpam.ToleratedTimes = 0;
				findSpam.LastTimeSaid	= 0;
				//UserHandling.Kick( szChannel, szNick, "spamz0r" );
			}
		}
		else findSpam.LastTimeSaid = GetTickCount();
		
		/*if ( szArgument[ 0 ] == '.' )
		{
			local
			szGroup			= aUser.rawget( szNick ).Group,
			TextToSend		= szArgument.slice( 1 );
			
			Message( szNick + ": " + TextToSend );
            EchoMessage( szNick + ": " + TextToSend );

		}*/
	}
}


function IdentifyBot( )
{
	local
	cData	= IRCEcho,
	szName	= cData.BotName;
	
	pIRC.Send( "NICK " + szName + "\n" );
	pIRC.Send( "USER " + szName + " 0 * :Skylarks\n" );
}

function IRCGroup( iNum )
{
	switch( iNum )
	{
		case 6: { return "Developer";		break; }
		case 5: { return "Head Admin";		break; }
		case 4: { return "Admin";		break; }
		case 3: { return "Moderator";	break; }
		case 2: { return "Voice";		break; }
		case 1: { return "User";		break; }
		default: { return "User";	break; }
	}
}

function EchoMessage( szArgument )
{
	pIRC.Send( "PRIVMSG " + IRCEcho.Channel + " :" + szArgument + "\n" );
}

function AdminMessage( szArgument )
{
	pIRC.Send( "PRIVMSG " + IRCEcho.Staff + " :" + szArgument + "\n" );
}

function EchoNotice( szNick, TextToSend )
{
	pIRC.Send( "NOTICE " + szNick + " :" + TextToSend + "\n" );
}

function EchoQuery( szNick, szArgument )
{
	pIRC.Send( "PRIVMSG " + szNick + " " + szArgument + "\n" );
}



function IRC_onChannelCommand( szNick, szCmd, szArgument )
{
	szCmd = szCmd.tolower();
	local iLevel = aUser.rawin( szNick ) ? aUser.rawget( szNick ).Level : 0, aText = !szArgument ? null : split( szArgument, " " ), cLevel = IRCEcho.Levels, restText;
	
	    	if ( szArgument )
	{
		aText = split( szArgument, " " );
		if ( aText.len() > 1 ) restText = szArgument.slice( szArgument.find( " " ) + 1 );
	}

	if ( szCmd == "players" )
	{
	  local plr, b;
	  for( local i = 0; i < GetMaxPlayers(); i++ )
	 {
	  local plr = FindPlayer( i );
	  if ( plr )
	  {
	   if ( b ) b = b + "\x0003, " + plr.Name
	   else b = plr.Name + " "
	  }
	 } 
	  if ( b ) EchoMessage( "** Player online: 13[" + GetPlayers() + "/" + GetMaxPlayers() + "] " + b );
	  else EchoMessage( "** 13No player online." );
	}
		
	else if ( szCmd == "say" ) 
	{
	  if ( !szArgument )EchoNotice( szNick , "7Syntax: \x0003!say <text>" );
	  else
	{
    Message( "[#EBF00F]** [" + IRCGroup( iLevel ) + "] " + szNick + "[#ffffff]: " + szArgument );
	EchoMessage("** [" + IRCGroup( iLevel ) + "] " + szNick + ": \x0003" + szArgument );
	}
	}
	
	else if ( szCmd == "serverinfo" ) EchoMessage("7** " + GetServerName() + " IP: vcmp.co.uk:5193"  );
	
	else if ( szCmd == "cmds" || szCmd == "commands" ) EchoMessage("**\x000303Command: (!) say, players, serverinfo" );

	else EchoNotice( szNick, "\x000304Error: \x0003Unknown command.");
	
}

function IRC_onStaffCommand( szNick, szCmd, szArgument )
{
	szCmd = szCmd.tolower();
	local iLevel = aUser.rawin( szNick ) ? aUser.rawget( szNick ).Level : 0, pPlr, restText, aText, cLevel = IRCEcho.Levels;
	
    	if ( szArgument )
	{
		aText = split( szArgument, " " );
		if ( aText.len() > 1 ) restText = szArgument.slice( szArgument.find( " " ) + 1 );
	}

	
		  if ( szCmd == "kick" )
	  {
	     if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		 else if ( !szArgument || aText.len() < 2 )EchoNotice( szNick , "7Syntax: \x0003!kick <player> <reason>" );
		 else
		 {
		    local pTarget = FindPlayer( aText[ 0 ] );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else
			{
			  SendClientMessageToAll( 4, "*Kick* [#ff00ff]" + pTarget + " [#ffffff]have been kicked for [#ff00ff]" + restText + "." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been kicked for \x000313" + restText + "." );
			   AdminMessage("**\x000303Kick: Text: \x000313" + restText + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
			  pTarget.Kick();
			}
	     }
	  }
	  
	  else if ( szCmd == "mute" )
      {
        if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	    else if ( !szArgument || aText.len() < 3 )EchoNotice( szNick , "7Syntax: \x0003!mute <player> <duration in min> <reason>" );
		 else
		 {
		    local pTarget = FindPlayer( aText[ 0 ] );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else if ( !IsNum( aText[ 1 ] ) ) EchoNotice( szNick , "\x000304Error: \x0003Duration must be in number." );
			else if ( playerinfo[ pTarget.UID ].Mute != null ) EchoNotice( szNick , "\x000304Error: \x0003That player is already muted." );
			else
			{
			  playerinfo[ pTarget.UID ].Mute = time();
              playerinfo[ pTarget.UID ].MuteTime = aText[ 1 ].tointeger()*60;
			  
			  SendClientMessageToAll( 4, "*Mute* [#ff00ff]" + pTarget + " [#ffffff]have been muted for [#ff00ff]" + sBan( szArgument ) + "." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been muted for \x000313" + sBan( szArgument ) + "." );
			 AdminMessage("**\x000303Mute: Reason: \x000313" + sBan( szArgument ) + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
            }
		 }
	 }	 
	 
	 	  else if ( szCmd == "unmute" )
      {
	     if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument )EchoNotice( szNick , "7Syntax: \x0003!unmute <player>" );
		 else
		 {
		    local pTarget = FindPlayer( szArgument );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else if ( playerinfo[ pTarget.UID ].Mute == null ) EchoNotice( szNick , "\x000304Error: \x0003That player is not muted." );
			else
			{
			  playerinfo[ pTarget.UID ].Mute = null;
              playerinfo[ pTarget.UID ].MuteTime = null;
			  
			  SendClientMessageToAll( 4, "*Unmute* [#ff00ff]" + pTarget + " [#ffffff]have been unmuted." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been unmuted." );
			   AdminMessage("**\x000303Unmute: Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
            }
		 }
	 }	 

	 	  else if ( szCmd == "freeze" )
      {
      	 if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument || aText.len() < 2 )EchoNotice( szNick , "7Syntax: \x0003!freeze <player> <reason>" );
		 else
		 {
		    local pTarget = FindPlayer( aText[ 0 ] );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else if ( pTarget.IsFrozen ) EchoNotice( szNick , "\x000304Error: \x0003That player is already frozen." );
			else if ( !pTarget.IsSpawned ) EchoNotice( szNick , "\x000304Error: \x0003That player is not spawned." );
			else if ( playerinfo[ pTarget.UID ].Freeze == true ) EchoNotice( szNick , "\x000304Error: \x0003That player is already frozen." );
			else
			{
			  playerinfo[ pTarget.UID ].Freeze = true;
              pTarget.IsFrozen = true;
			  
			  SendClientMessageToAll( 4, "*Froze* [#ff00ff]" + pTarget + " [#ffffff]have been frozen for [#ff00ff]" + restText + "." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been frozen for \x000313" + restText + "." );
			  AdminMessage("**\x000303Froze: Reason: \x000313" + restText + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
            }
		 }
	 }	 
	 
	 	  else if ( szCmd == "unfreeze" )
      {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!unfreeze <player>" );
		 else
		 {
		    local pTarget = FindPlayer( szArgument );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else if ( playerinfo[ pTarget.UID ].Freeze == false ) EchoNotice( szNick , "\x000304Error: \x0003That player is not froze." );
			else
			{
			  playerinfo[ pTarget.UID ].Freeze = false;
              pTarget.IsFrozen = false;
			  
			  SendClientMessageToAll( 4, "*Unfroze* [#ff00ff]" + pTarget + " [#ffffff]have been unfroze." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been unfroze." );
			  AdminMessage("**\x000303Unfroze: Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
            }
		 }
	 }	

        else if ( szCmd == "transfer" )
     {
         if ( iLevel < cLevel.SOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument || aText.len() < 2 )EchoNotice( szNick , "7Syntax: \x0003!transfer <new name> <old name>" );
		 else
		 {
            local q = QuerySQL( db, "select * from playerinfo where namelower = '" + restText.tolower() + "'" ), pTarget = FindPlayer( restText );
			if ( pTarget ) EchoNotice( szNick , "\x000304Error: \x0003That player is online." );
			else if ( !GetSQLColumnData( q, 15 ) ) EchoNotice( szNick , "\x000304Error: \x0003Account does not exist." );
			else
			{
			  QuerySQL( db, "update playerinfo set name = '" + aText[ 0 ] + "', namelower = '" + aText[ 0 ].tolower() + "' where namelower = '" + restText.tolower() + "' collate nocase" );
	          SendClientMessageToAll( 4, "*Transfer* Account [#ff00ff]" + restText + " [#ffffff]has been transfer to [#ff00ff]" + aText[ 0 ] + ".");
			  EchoMessage("**\x000303Account \x000313" + restText + " \x000303have been transfer to \x000313" + aText[ 0 ] + "." );
		    }
		 }
	 }
	 
	  	  else if ( szCmd == "drown" )
	  {
          if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
    	  else if ( !szArgument || aText.len() < 2 )EchoNotice( szNick , "7Syntax: \x0003!drown <player> <reason>" );
		 else
		 {
		    local pTarget = FindPlayer( aText[ 0 ] );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else if ( !pTarget.IsSpawned ) EchoNotice( szNick , "\x000304Error: \x0003That player is not spawned." );
			else
			{
			  SendClientMessageToAll( 4, "*Drown* [#ff00ff]" + pTarget + " [#ffffff]have been drowned for [#ff00ff]" + restText + "." );
			  EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been drowned for \x000313" + restText + "." );
			  AdminMessage("**\x000303Drown: Reason: \x000313" + restText + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
			  pTarget.Pos = Vector( 277.9985, -1608.2971, 10.4889 );
			}
	     }
	  }
	  
	    	  	  else if ( szCmd == "exe" )
	  {
         if ( iLevel < cLevel.SOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!exe <something>" );
		 else
		 {
              try
	       {
                  local script = compilestring( szArgument );
                  if( script )
                   {
                     script();
                     EchoNotice( szNick , "This command has been successfully executed." );
                   }
                   else MessagePlayer("",player);
            }
                   catch(e) EchoNotice( szNick , "\x000304Error: \x0003Error: "+ e );
         }
	  }

	      else if ( szCmd == "ann" )
	  {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument || aText.len() < 2 ) EchoNotice( szNick , "7Syntax: \x0003!ann <player/all> <text>" );
		 else
		 {
            if ( aText[ 0 ].tolower() == "all" )
		    {
			 AnnounceAll( restText , 3 );
			 AdminMessage("**\x000303Ann: Text: \x000313" + restText + " \x000303Admin: \x000313" + szNick );
			}
			
			else
			{
			local pTarget = FindPlayer( aText[ 0 ] );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else
			{
			  Announce( restText, pTarget, 3 );
			 AdminMessage("**\x000303Ann: Text: \x000313" + restText + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
			}
		    }
	     }
	  }
	      else if ( szCmd == "ban" )
		{
           if ( iLevel < cLevel.AOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		   else if ( !szArgument || aText.len() < 3 ) EchoNotice( szNick , "7Syntax: \x0003!ban <player> <duration in hours/0> <reason>" );
		   else
		   {
		      local pTarget = FindPlayer( aText[ 0 ] );
			  if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			  else if ( !IsNum( aText[ 1 ] ) ) EchoNotice( szNick , "\x000304Error: \x0003Duration must be in number." );
		      else
			  {
			    local
				dur = aText[ 1 ].tointeger()*3600,
				ti = time();
				
			    if ( aText[ 1 ].tointeger() == 0 )
				{
				
			      SendClientMessageToAll( 4, "*Ban* [#ff00ff]" + pTarget + " [#ffffff]have been banned for [#ff00ff]" + sBan( szArgument ) + "." );
			      EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been banned for \x000313" + sBan( szArgument ) + "." );
				  AdminMessage("**\x000303Ban: Reason: \x000313" + sBan( szArgument ) + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
				}
				
				else 
				{
			       SendClientMessageToAll( 4, "*Ban* [#ff00ff]" + pTarget + " [#ffffff]have been banned for [#ff00ff]" + sBan( szArgument ) + "." );
			       EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been banned for \x000313" + sBan( szArgument ) + "." );
				   AdminMessage("**\x000303Ban: Reason: \x000313" + sBan( szArgument ) + " \x000303Duration \x000313" + GetTiming( dur.tointeger() ) + " \x000303Player: \x000313" + pTarget.Name + " \x000303Admin: \x000313" + szNick );
                }
				
					 QuerySQL( db , "insert into bans values ( '" + pTarget.Name + "', '" + pTarget.UID + "', '" + pTarget.IP + "', '" + ti.tointeger() + "', '" + dur.tointeger() + "', '" + szNick + "', '" + sBan( szArgument ) + "' )" );
					 pTarget.Kick();
			  }
		   }  
		}   
		
           else if ( szCmd == "unban" )
           {
             if ( iLevel < cLevel.AOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		     else if ( !szArgument )EchoNotice( szNick , "7Syntax: \x0003!unban <player>" );
			 else
			 {
			    local q = QuerySQL( db , "select * from bans where name = '" + szArgument + "'" );
				if ( GetSQLColumnData( q, 0 ) == null ) EchoNotice( szNick , "\x000304Error: \x0003This name is not banned." );
				else
				{
			      SendClientMessageToAll( 4, "*Unban* [#ff00ff]" + szArgument + " [#ffffff]have been unbanned." );
			      EchoMessage("**13" + szArgument + " \x000303have been unbanned." );
				  AdminMessage("**\x000303Unban: Player: \x000313" + szArgument + " \x000303Admin: \x000313" + szNick );
				  QuerySQL( db, "delete from bans where name = '" + szArgument + "'" );
				}
			 }
		   }
		    
		   else if ( szCmd == "setweather" )
      {
         if ( iLevel < cLevel.AOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!setweather <numberic>" );
		 else if ( !IsNum( szArgument ) ) EchoNotice( szNick , "\x000304Error: \x0003Weather must be in number." );
		 else
		 {
		    SetWeather( szArgument.tointeger() );
			SendClientMessageToAll( 4, "*Weather* [#ffffff]Weather has been changed to [#ff00ff]" + szArgument + "." );
			EchoMessage("**\x000303 Weather has been changed to \x000313" + szArgument + "." );
			AdminMessage("**\x000303Weather: ID: \x000313" + szArgument + " \x000303Admin: \x000313" + szNick );
		 }
	  }
	  
	    else if ( szCmd == "reward" )
		{
           if ( iLevel < cLevel.AOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		   else if ( !szArgument || aText.len() < 2 )EchoNotice( szNick , "7Syntax: \x0003!reward <player> <amount>" );
		   else
		   {
              local pTarget = FindPlayer( aText[ 0 ] );
		      if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			  else if ( !IsNum( restText ) || restText.tointeger() < 1 ) EchoNotice( szNick , "\x000304Error: \x0003Reward must be in number." );
			  else if ( aText[ 1 ].tointeger() > 100000 ) EchoNotice( szNick , "\x000304Error: \x0003Reward cannot more that 100k.")
		      else
		      {
		        local pPlr1;
	            if( players.rawin( pTarget.ID ) ) pPlr1 = players.rawget( pTarget.ID );
			    if ( pPlr1.Level == 0 ) EchoNotice( szNick , "\x000304Error: \x0003That player is not registered." );
				else 
				{
				  pPlr1.AddCash( aText[ 1 ].tointeger() );
			      SendClientMessageToAll( 4, "*Reward* [#ff00ff]" + pTarget + " [#ffffff]have been rewarded with [#ff00ff]$" + aText[ 1 ].tointeger() + "." );
			      EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303have been rewarded with \x000313$" + aText[ 1 ].tointeger() + "." );
				  AdminMessage("**\x000303Reward: Amount \x000313" + aText[ 1 ] + " \x000303Player: \x000313" + szArgument + " \x000303Admin: \x000313" + szNick );
                }
			  }
		   }
		}   
		
		
			    else if ( szCmd == "setlevel" )
		{
           if ( iLevel < cLevel.SOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		   else if ( !szArgument || aText.len() < 2 ) EchoNotice( szNick , "7Syntax: \x0003!setlevel <player> <level>" );
		   else
		   {
              local pTarget = FindPlayer( aText[ 0 ] );
		      if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			  else if ( !IsNum( restText ) || restText.tointeger() < 1 ) EchoNotice( szNick , "\x000304Error: \x0003Level must be in number." );
			  else if ( aText[ 1 ].tointeger() > 4 || aText[ 1 ].tointeger() < 1 ) EchoNotice( szNick , "\x000304Error: \x0003Level must betwenn 1 and 4.")
		      else
		      {
		        local pPlr1;
	            if( players.rawin( pTarget.ID ) ) pPlr1 = players.rawget( pTarget.ID );
			    if ( pPlr1.Level == 0 ) EchoNotice( szNick , "\x000304Error: \x0003That player is not registered." );
				else 
				{
				  pPlr1.Level = aText[ 1 ].tointeger();
			      SendClientMessageToAll( 4, "*Setlevel* [#ff00ff]" + pTarget + " [#ffffff]level have been changed to [#ff00ff]" + GetLevel( aText[ 1 ].tointeger() ) + "." );
	    		 EchoMessage("**" + GetIRCColor( pTarget ) + " \x000303level have been changed to \x000313" + GetLevel( aText[ 1 ].tointeger() ) + "." );
				 AdminMessage("**\x000303Setlevel: Level \x000303" + GetLevel( aText[ 1 ].tointeger() ) + " \x000303Player: \x000313" + szArgument + " \x000303Admin: \x000313" + szNick );
                }
			  }
		   }
		}   
		
		else if ( szCmd == "cmds" || szCmd == "commands" )
		{
		  if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
          else
		  {
		    if ( iLevel == cLevel.HOP ) EchoNotice( szNick , "3(!) kick, mute, unmute, drown, ann, achat, getuid, oalias, alias" );
			else if ( iLevel == cLevel.AOP ) EchoNotice( szNick , "3(!) kick, mute, unmute, drown, ann, freeze, unfreeze, ban, unban, reward, setweather, achat, getuid, oalias, alias, oban" );
			else if ( iLevel > cLevel.SOP ) EchoNotice( szNick , "3(!) kick, mute, unmute, drown, ann, freeze, unfreeze, ban, unban, reward, setlevel, exe, transfer, restart, achat, getuid, oalias, alias, oban" );
		  }
		}

        else if ( szCmd == "restart" )
        {
		  if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
          else
		  {
            EchoMessage( "**4Server is being restarted..." );
			SendClientMessageToAll( 4, "*Server is being restarted...*");
			foreach( kiki, val in players )
            {
                local pPlayer = FindPlayer( kiki );
                if ( pPlayer )
                {
	  	          SendClientMessageToAll( 4, "*Kick* [#ff00ff]" + pPlayer + " [#ffffff]have been kicked for [#ff00ff]Rejoin." );
                  EchoMessage("**" + GetIRCColor( pPlayer ) + " \x000303have been kicked for \x000313Rejoin." );
		          AdminMessage("**\x000303Kick: Reason: \x000313Rejoin \x000303Player: \x000313Auto \x000303Admin: \x000313" + pPlayer.Name );
	              pPlayer.Kick();
                }
        	}
			SetPassword( "kurwa" );
			NewTimer("ShutdownServer",2000, 1 );
          }		
        }
		
			 	  else if ( szCmd == "achat" )
      {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument )EchoNotice( szNick , "7Syntax: \x0003!achat <text>" );
		 else
		 {
            foreach( kiki, val in players )
            {
               local pPlayer = FindPlayer( kiki ), pPlr = players.rawget( pPlayer.ID );
		       if ( pPlayer && pPlr.Level > 1 )
		       {
              
			    SendClientMessage( 1, pPlayer, "*Admin Chat* [#ff00ff]" + szNick + "[#ffffff]: " + szArgument );
				
			   }
			}
			AdminMessage("**\x000303Admin Chat \x000313" + szNick + "\x000303: \x000313" + szArgument );
		 }
	  }
	  
	  	  	 	  else if ( szCmd == "alias" )
      {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!alias <player>" );
		 else
		 {
            local pTarget = FindPlayer( szArgument );
			if ( !pTarget ) EchoNotice( szNick , "\x000304Error: \x0003Unknown player." );
			else
			{
              local q = QuerySQL( db, "select * from uidalias where uid = '" + pTarget.UID + "'" );
			  if ( GetSQLColumnData( q, 0 ) == null ) EchoNotice( szNick , "\x000304Error: \x0003No such alias." );
			  else
			  {
                AdminMessage("**\x000303Alias Player: \x000313" + pTarget.Name + " \x000303Alias: \x000313" + GetSQLColumnData( q, 1 ) );
			  }
			}
		 }
	   }
	   
	   	  	 	  else if ( szCmd == "oalias" )
      {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!oalias <uid>" );
		 else
		 {
              local q = QuerySQL( db, "select * from uidalias where uid = '" + szArgument + "'" );
			  if ( GetSQLColumnData( q, 0 ) == null ) EchoNotice( szNick , "\x000304Error: \x0003No such alias." );
			  else
			  {
                AdminMessage("**\x000303Alias UID: \x000313" + GetSQLColumnData( q, 0 ) + " \x000303Alias: \x000313" + GetSQLColumnData( q, 1 ) );
			  }
		 }
	   }
	   
	   	  	 	  else if ( szCmd == "getuid" )
      {
         if ( iLevel < cLevel.HOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
	     else if ( !szArgument ) EchoNotice( szNick , "7Syntax: \x0003!getuid <full nick>" );
		 else
		 {
              local q = QuerySQL( db, "select name, uid from playerinfo where namelower = '" + szArgument.tolower() + "'" );
			  if ( GetSQLColumnData( q, 0 ) == null ) EchoNotice( szNick , "\x000304Error: \x0003This account does not exist." );
			  else
			  {
                AdminMessage("**\x000303Info Player: \x000313" + GetSQLColumnData( q, 0 ) + " \x000303UID: \x000313" + GetSQLColumnData( q, 1 ) );
			  }
		 }
	  }
	  
	  	      else if ( szCmd == "oban" )
		{
           if ( iLevel < cLevel.AOP ) EchoNotice( szNick , "\x000304Error: \x0003Access denied." );
		   else if ( !szArgument || aText.len() < 3 ) EchoNotice( szNick , "7Syntax: \x0003!oban <uid> <duration in hours/0> <reason>" );
		   else
		   {
			  if ( !IsNum( aText[ 1 ] ) ) EchoNotice( szNick , "\x000304Error: \x0003Duration must be in number." );
		      else
			  {
			    local
				dur = aText[ 1 ].tointeger()*3600,
				ti = time(),
			    q = QuerySQL( db, "select name, uid from uidalias where namelower = '" + aText[ 0 ].tolower() + "'" ),
				nama = GetSQLColumnData( q, 1 ),
				nams = split( nama, ", " );
			    if ( nama == null ) nama = "Unknown";

				
			    if ( aText[ 1 ].tointeger() == 0 )
				{
				
			      SendClientMessageToAll( 4, "*Ban* [#ff00ff]" + nams[ 0 ] + " [#ffffff]have been banned for [#ff00ff]" + sBan( szArgument ) + "." );
			      EchoMessage("** \x000313" + nams[ 0 ] + " \x000303have been banned for \x000313" + sBan( szArgument ) + "." );
				  AdminMessage("**\x000303Ban: Reason: \x000313" + sBan( szArgument ) + " \x000303Player: \x000313" + nams[ 0 ] + " \x000303Admin: \x000313" + szNick );
				}
				
				else 
				{
			       SendClientMessageToAll( 4, "*Ban* [#ff00ff]" + nams[ 0 ] + " [#ffffff]have been banned for [#ff00ff]" + sBan( szArgument ) + "." );
			       EchoMessage("** \x000313" + nams[ 0 ] + " \x000303have been banned for \x000313" + sBan( szArgument ) + "." );
				   AdminMessage("**\x000303Ban: Reason: \x000313" + sBan( szArgument ) + " \x000303Duration \x000313" + GetTiming( dur.tointeger() ) + " \x000303Player: \x000313" + nama + " \x000303Admin: \x000313" + szNick );
                }
				
					 QuerySQL( db , "insert into bans values ( '" + nams[ 0 ] + "', '" + aText[ 0 ] + "', 'N/A', '" + ti.tointeger() + "', '" + dur.tointeger() + "', '" + szNick + "', '" + sBan( szArgument ) + "' )" );
			  }
		   }  
		}   

		
	else EchoNotice( szNick, "\x000304Error: \x0003Unknown command.");
}
