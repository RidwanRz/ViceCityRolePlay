/*
EAD Echo bot
*/
	
const ICOL_WHITE    = "\x000300";
const ICOL_BLACK    = "\x000301";
const ICOL_BLUE     = "\x000302";
const ICOL_GREEN    = "\x000303";
const ICOL_RED      = "\x000304";
const ICOL_BROWN    = "\x000305";
const ICOL_PURPLE   = "\x000306";
const ICOL_ORANGE   = "\x000307";
const ICOL_YELLOW   = "\x000308";
const ICOL_LGREEN   = "\x000309";
const ICOL_CYAN     = "\x000310";
const ICOL_LCYAN    = "\x000311";
const ICOL_LBLUE    = "\x000312";
const ICOL_PINK     = "\x000313";
const ICOL_GREY     = "\x000314";
const ICOL_LGREY    = "\x000315";
const ICOL          = "\x0003";
const ICOL_BOLD     = "\x0002";
const ICOL_ULINE    = "\x0031";

/*
	Squirrel IRC Bot - Version 1
*/

const FBS_NICK = "grhrhh"; 
const FBS_BPASS = ""; 
const FBS_SERVER = "91.121.134.5";
const FBS_PORT = 6667;	
const FBS_CHAN = "#vdsfer34dfssf"; 
const FBS_CPASS = ""; // The password for that channel, if there isnt one leave it as "".{

class FBSLIST
{
	// This is how we are going to store the user level information for each nick currently on the channel
	Name = null;
	Level = 1;
}

function FBSLIST::AddNick( szNick, iAdmin )
{
	Name = szNick;
	Level = iAdmin;
}

function ActivateEcho()
{
	FBS_BOT <- NewSocket( "FBSProcess" );

	FBS_BOT.Connect( FBS_SERVER, FBS_PORT );
	FBS_BOT.SetNewConnFunc( "FBSLogin" );
	
	FBS_NICKS <- array( 50, null );
}

function DisconnectBots()
{
	print( "Disconnecting bot from IRC..." );
	
	FBS_BOT.Send( "QUIT " + FBS_NICK + "\n" );
	FBS_BOT.Delete();
	
	print( FBS_NICK + " has succesfully disconnected from IRC." );
}

function FBSLogin()
{
	// Set the bots name and real name
	FBS_BOT.Send( "USER " + FBS_NICK + " 0 * :Attack\n" );
	// Set the nick that the bot will use on the irc server
	FBS_BOT.Send( "NICK " + FBS_NICK + "\n" );
	// Set it so that the network classes the bot as a bot
	FBS_BOT.Send( "MODE " + FBS_NICK + " +B\n" );
}

function FBSProcess( sz )
{
	// This function is used to process the raw data that the bot is recieving from the irc server	
  local raw = split( sz, "\r\n" ), a, z = raw.len(), line;
	
	for ( a = 0; a < z; a++ )
	{
		line = raw[ a ];
		
		local FBS_PING = GetTok( line, " ", 1 ), FBS_EVENT = GetTok( line, " ", 2 ), FBS_CHANEVENT = GetTok( line, " ", 3 ), 
		Count = NumTok( line, " " ), Nick, Command, Prefix, Text;

		// The most important thing is making sure that the bot stays connected to IRC
		if ( FBS_PING ) FBS_BOT.Send( "PONG " + FBS_PING + "\n" );
		
		if ( FBS_EVENT == "001" )
		{
			if ( FBS_BOT )
			{
				// Identify the bot with services, comment this line if its not registered
				FBS_BOT.Send( "PRIVMSG NickServ IDENTIFY " + FBS_BPASS + "\n" ); 
				// Set it so that the network classes the bot as a bot
				FBS_BOT.Send( "MODE " + FBS_NICK + " +B\n" );
				// Make the bot join the specified channel
				FBS_BOT.Send( "JOIN " + FBS_CHAN + " " + FBS_CPASS + "\n" ); 
								
						

                                                              // The bot now needs to collect information about users in the channel
                                                                
				print( "Succesfully joined #echo" );
			}
		}
		else if ( FBS_EVENT == "353" ) FBSSortNicks( sz );
		else if ( ( FBS_EVENT == "MODE" ) || ( FBS_EVENT == "NICK" ) || ( FBS_EVENT == "JOIN" ) || ( FBS_EVENT == "PART" ) || ( FBS_EVENT == "QUIT" ) ) FBS_BOT.Send( "NAMES :" + FBS_CHAN + "\n" );
		if ( FBS_CHANEVENT == FBS_CHAN )
		{
			// Grab the nick
			Nick = GetTok( line, "!", 1 ).slice( 1 );
			// Figure out what the command is
			Command = GetTok( line, " ", 4 );
			// Figure out what prefix was used

		         Prefix = Command.slice( 1 );
			Command = Command.slice( 1 );
			
		  // Figure out the text after the command
		  if ( NumTok( line, " " ) > 4 ) Text = GetTok( line, " ", 5, Count );
		  else Command = split( Command, "\r\n" )[ 0 ];


	        local json_data = Command + " " + ( Text == null ? "" : Text );
	        local decode_data = json_decode( json_data );

	        if( decode_data.rawin( "User" ) ) 
	        {
	        	if( decode_data.User != "CnR" )
	        	{
	        		local
	        		cmds = GetTok( decode_data.Text.slice( 1 ), " ", 1 ),
					text = GetTok( decode_data.Text, " ", 2, NumTok( decode_data.Text, " " ) ),
					text = split( decode_data.Text," " ).len() > 1 ? decode_data.Text.slice( decode_data.Text.find( " " ) + 1 ) : null;

	        		if ( decode_data.Text.slice( 0, 1 ) == "!" )
					{
						if ( text == null ) onDiscordCommand( decode_data.User, decode_data.User, cmds, null );
						else onDiscordCommand( decode_data.User, decode_data.User, cmds, text );
					}
	        	}
	        }
		}
	}
}

/*  The following functions below are to do with parsing nick information and levels
	DO NOT TOUCH ANYTHING BELOW THIS LINE.......EVER!
*/

function FBSSortNicks( szList )
{
	local a = NumTok( szList, " " );
	local NickList = GetTok( szList, " ", 6, a ), i = 1;
	
	FBS_NICKS <- array( 50, null );
	
	while( GetTok( NickList, " ", i ) != "366" )
	{
		local levelnick = GetTok( NickList, " ", i ), nick = levelnick.slice( 1 ), level = levelnick.slice( 0, 1 );
		
		if ( level == ":" ) { level = nick.slice( 0, 1 ); nick = nick.slice( 1 ); }
				
		if ( level == "+" ) AddNewNick( nick, 2 );
		else if ( level == "%" ) AddNewNick( nick, 3 );
		else if ( level == "@" ) AddNewNick( nick, 4 );
		else if ( level == "&" ) AddNewNick( nick, 5 );
		else if ( level == "~" ) AddNewNick( nick, 6 );
		else AddNewNick( nick, 1 );
		i ++;
	}
}

function AddNewNick( szName, iLevel )
{
	local i = FindFreeNickSlot();
	
	if ( i != -1 ) 
	{
		FBS_NICKS[ i ] = FBSLIST();
		FBS_NICKS[ i ].AddNick( szName, iLevel );
	}
}

function FindFreeNickSlot()
{
	for ( local i = 0; i < FBS_NICKS.len(); i++ )
	{
		if ( !FBS_NICKS[ i ] ) return i;
	}
	return -1;
}

function FindNick( szName )
{	
	for ( local i = 0; i < FBS_NICKS.len(); i++ )
	{
		if ( FBS_NICKS[ i ] )
		{
			if ( FBS_NICKS[ i ].Name == szName ) return FBS_NICKS[ i ];
		}
	}
	return null;
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
	local s = split(string, separator); 
    return s.len();
}

function onDiscordCommand( author, nick, cmds, arr )
{
	switch( cmds )
	{
		case "players":
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

        if( result ) EchoMessage( format( "**Players online** %s", result ) ), EchoMessage( format( "**Total players** %d", getCount ) )
        else EchoMessage( format( "**No player online T_T**" ) );
        break;

        case "say":
        if( arr )
        {
            local nick2 = ( nick == "" ) ? author : nick;

            legacyMessage("[#ff1493][Discord] [#ffffff]"+ nick2 + ": " + arr );

        	EchoMessage( format( "**%s** [Discord]: %s", nick2, arr ) ); 
    	}
    	else EchoMessage( format( "**Syntax,** !say [text] " ) ); 
        break;

    /*    case "serverinfo":
		local embed = SqDiscord.Embed.Embed();
        embed.SetTitle( "Miami Cops and Robbers" );
        embed.SetColor( 16711680 );

		local embedField1 = SqDiscord.Embed.EmbedField();
        embedField1.SetName( "IP" );
        embedField1.SetValue( "51.83.32.20:1234" );
        embedField1.SetInline( true );

		local embedField2 = SqDiscord.Embed.EmbedField();
		embedField2.SetName( "Forum" );
        embedField2.SetValue( "-" );
        embedField2.SetInline( true );
		
        embed.AddField( embedField1 );
        embed.AddField( embedField2 );
		
		EchoBot.session.MessageEmbed( DiscordBot.Echo.Channel, embed );                   
        break;
	*/
        case "cmds":
        EchoMessage( format( "**Commands (!)** players, say" ) );
        break;

        default:
       	EchoMessage( format( "**Error**, Unknown command, use !cmds to check available commands." ) );
       	break;
    }
}