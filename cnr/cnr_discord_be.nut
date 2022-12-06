

DiscordBot <-
{
    Token = "NTY2ODEzOTM2NzQ2MjMzODY2.XR6-pQ.Z1NUgQVN5GDvbHXfoFsTpo7Pajs",

    Echo = 
    {
        Channel = "593134646657679490",
    }
}

sessions <- {};

class CDiscord
{
    session         = null;
    connID          = null;
    
    channels        = null; 
    
    function constructor()
    {
        session         = ::SqDiscord.CSession();
        connID          = session.ConnID;
                
        ::sessions.rawset(connID, this);
    }
    
    function Connect(token)
    {
        session.Connect(token);
    }

	function onReady() 
	{
	   session.SetActivity( "Miami Cops and Robbers [0/100]" );	
	}
	
	function onLoaded() 
	{
		
	}
	
	function onMessage(channelID, author, authorNick, authorID, roles, message)
	{
        try 
        {
    		if( author != "CnR™" )
    		{
    		    if( channelID == DiscordBot.Echo.Channel.tostring() )
    			{
    				local
    				cmds = ( message == "" ) ? "" : split( message.slice( 1 ), " " )[0],
    	    		arr = split( message," " ).len() > 1 ? message.slice( message.find( " " ) + 1 ) : null;

    				if ( message.slice( 0, 1 ) == "!" )
    				{
    					if ( arr == null ) ::onDiscordCommand( author, authorNick, cmds, null );
    					else ::onDiscordCommand( author, authorNick, cmds, arr );
    				}
    			}
    		}
        }
        catch( _ ) _;
	}
	
	function SendMessage( text )
	{
		session.Message( DiscordBot.Echo.Channel.tostring(), text );
	}
}

EchoBot <- CDiscord();
EchoBot.Connect( DiscordBot.Token );

function onDiscord_Ready(session)
{
    if(sessions.rawin(session.ConnID))
    {
        local session_s = sessions.rawget(session.ConnID);
        session_s.onReady();
    }
}

function onDiscord_Message(session, channelID, author, authorNick, authorID, roles, message)
{
    if(sessions.rawin(session.ConnID))
    {
        local session_s = sessions.rawget(session.ConnID);
        session_s.onMessage(channelID, author, authorNick, authorID, roles, message);
    }
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

        if( result ) EchoBot.SendMessage( format( "**Players online** %s", result ) ), EchoBot.SendMessage( format( "**Total players** %d", getCount ) )
        else EchoBot.SendMessage( format( "**No player online T_T**" ) );
        break;

        case "say":
        if( arr )
        {
            local nick2 = ( nick == "" ) ? author : nick;

            Message("[#ff1493][Discord] [#ffffff]"+ nick2 + ": " + arr );

        	EchoBot.SendMessage( format( "**%s** [Discord]: %s", nick2, arr ) ); 
    	}
    	else EchoBot.SendMessage( format( "**Syntax,** !say [text] " ) ); 
        break;

        case "serverinfo":
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

        case "cmds":
        EchoBot.SendMessage( format( "**Commands (!)** players, say, serverinfo" ) );
        break;

        default:
       	EchoBot.SendMessage( format( "**Error**, Unknown command, use !cmds to check available commands." ) );
       	break;
    }
}
