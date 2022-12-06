function MsgPlr( colrid, player, element, ... )
{
	local c = "";
	
	switch( colrid )
	{
		case 1: c = "[#00cc99]"; break;// all
		case 2: c = "[#ff4d4d]"; break;// error
		case 3: c = "[#99ff99]"; break;// sucess
		case 4: c = "[#ff3399]"; break;// robbery
		case 5: c = "[#66ccff]"; break;// medic
		case 6: c = "[#3366ff]"; break;// cop
		case 7: c = "[#e6e600]"; break;// house/prop
		case 8: c = "[#93a5c1]"; break;// gang
		case 9: c = "[#ff9933]"; break;// event
		case 10: c = "[#00ffff]"; break; 
		case 11: c = "[#999999]"; break; // kill
	}
	
	local st = [];
	st.push( element[ playa[ player.ID ].Lang ] );
	foreach( a in vargv )
	{
		if( a != null ) st.push( a );
	}

	st.insert(0, this);

	MessagePlayer( c + "" + format.acall(st), player );

}

function MsgAll( colrid, element, ... )
{
	local c = "";
	
	switch( colrid )
	{
		case 1: c = "[#00cc99]"; break;// all
		case 2: c = "[#ff4d4d]"; break;// error
		case 3: c = "[#99ff99]"; break;// sucess
		case 4: c = "[#ff3399]"; break;// robbery
		case 5: c = "[#66ccff]"; break;// medic
		case 6: c = "[#3366ff]"; break;// cop
		case 7: c = "[#e6e600]"; break;// house/prop
		case 8: c = "[#93a5c1]"; break;// gang
		case 9: c = "[#ff9933]"; break;// event
		case 10: c = "[#00ffff]"; break; 
		case 11: c = "[#999999]"; break; // kill
	}
	
	local player;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		player = FindPlayer( i );
		if ( player )
		{
			if( playa[ player.ID ].Logged )
			{
				local st = [];
				st.push( element[ playa[ player.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				MessagePlayer( c + "" + format.acall(st), player );
			}
		}
	}
}

function MsgStaff( text )
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Level >= 2 || playa[ playar.ID ].Staff == 4 ) MessagePlayer( text, playar );
		}	
	}
}

function MsgDevs( text )
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Level >= 3 || playa[ playar.ID ].Staff == 3 ) MessagePlayer( text, playar );
		}	
	}
}

function legacyMessage( text )
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Logged ) MessagePlayer( text, playar );
		}	
	}
}

function AnnounceToAll( text )
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Logged ) SendDataToClient( 6080, text, playar );
		}
	}
}

function EscapeJSONString( string )
{
	local getInvalidChar = [ "\"", "'", "\\", ]

	if( !string ) return;

	foreach( index, value in getInvalidChar )
	{
		if( string.find( value ) >= 0 ) string = SearchAndReplace( string, value, " " );
	}

	return string;
}

function SearchAndReplace( str, search, replace ) 
{
    local li = 0, ci = str.find(search, li), res = "";
    while(ci != null) 
    {
        if(ci > 0) 
        {
            res += str.slice(li, ci);
            res += replace;
        }
        else res += replace;
        li = ci + search.len(), ci = str.find(search, li);
    }
    if (str.len() > 0) res += str.slice(li);
    return res;
}

function RandomMessage()
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Logged ) MessagePlayer( "[#ff9933]" + RandomMsg.Text[ RandomMsg.Count ], playar );
		}
	}	

	RandomMsg.Count ++;

	if( RandomMsg.Count > ( RandomMsg.Text.len()-1 ) ) RandomMsg.Count = 0;
}

function EchoMessage( text )
{
	if( Server.EchoMessage )
	{
		local urlName = "CnR";
		local urlType = "";

		urlType = Weebhook.URL[ Weebhook.Count ];

		Weebhook.Count ++;

		if( Weebhook.Count > ( Weebhook.URL.len()-1 ) ) Weebhook.Count = 0;

		return system("curl -H \"Accept: application/json\" -H \"Content-type: application/json\" -X POST -d '{\"content\":\"" + EscapeJSONString( StripCol( text ) ) + "\", \"username\":\"" + urlName + "\"}' " + urlType );
	}
}

Weebhook <-
{
	Count = 0,

	URL =
	[
		"https://discordapp.com/api/webhooks/625167743607504916/gYg-sKTV-pyOarO3dWC9fpdbc_KoMZppk06a6tNP-0YgjmSeFJVxN8CvV65tL9YzyGgk"
		"https://discordapp.com/api/webhooks/625179609297846293/tY89i6y_aK7-7IdbPYrF_GFZXiWJXm_daTwoFUs36VQR_FDWja-bH5iTP7-A-dQbudbs"
		"https://discordapp.com/api/webhooks/625179949740982282/uUjOIpHzhMKk1L0moaL8swDxE6khRBMu-0IZfsmMqT0xW27d2MYnCwPkr7ijgB2E4HB4"
		"https://discordapp.com/api/webhooks/625180000647249960/t0MHMxH6PxxQquDEgYFO3moSWt0wt-lbjjHYcFWK8PgpUNdWZMVgjVf79KYu8gkcDZtf"
		"https://discordapp.com/api/webhooks/625180064224641029/_vglAi5ku8I4KwX1BxZEXWCK520T89TbUMPXyieeO3s15tQUCKTiHbAPgJuHxcsSR6Jf"
		"https://discordapp.com/api/webhooks/625180136760672266/PYXlNkMyWDHURMqiGE5v0B-hyV-2LVszX7vk46x14QXHmxK8-13c35i5KuDh6DVLpYxn"
		"https://discordapp.com/api/webhooks/625180204142166026/WkO1U7ca6kOcNksSz6xD9nKJhg8_bZkZnYzxA6FkFi1J00LhlpxTQWpoLz24Tu6AS70r"
		"https://discordapp.com/api/webhooks/625180263043039262/mxs1Pa9r4YC8Z6UeGoyb48zQClAiXB8rXa_y5t3jgnnNUAhb_VUecN_8XYRNmOG3-I3X"
		"https://discordapp.com/api/webhooks/625180316780199938/neZf71qFQYDjQ0FpGd_TZjCZ9BcB4s_Qef4UXeJTvBvJCEVQwNEzl73GG24tBMZpV3JU"
		"https://discordapp.com/api/webhooks/625180385617117201/CedFL8-8hmjZJHmxwuQc7IW2y0wnYhFvpmXTlTCI50JGLFp4UEh4GxUdrwwaAankdXnz"


	]
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


function MessageToAllLaw( prefix, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local plr = FindPlayer( i );
		if( plr )
		{
			if( playa[ plr.ID ].Logged )
			{
				local st = [];
				st.push( Lang[ element ][ playa[ plr.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				if( IsLawE( plr ) ) 
				{
					MessagePlayer( "[#3366ff][" + prefix + "] " + format.acall(st), plr );
				}
				
			}
		}
	}
}

function LocalMessage( issuepos, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local player = FindPlayer( i );
		if( player )
		{
			if( playa[ player.ID ].Logged )
			{
				if( DistanceFromPoint( player.Pos.x, player.Pos.y, issuepos.x, issuepos.y ) <= 12 )
				{
					local st = [];
					st.push( Lang[ element ][ playa[ player.ID ].Lang ] );
					foreach( a in vargv )
					{
						if( a != null ) st.push( a );
					}

					st.insert(0, this);

					MessagePlayer( "[#d580ff]" + format.acall(st), player );
				}
			}
		}
	}
}

function LocalMessage3D( id, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local player = FindPlayer( i );
		if( player )
		{
			if( playa[ player.ID ].Logged )
			{
				local st = [];
				st.push( Lang[ element ][ playa[ player.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				SendDataToClientToAll( 15000, id + ";" + format.acall(st) );
			}
		}
	}
}

function MsgGangAll( group, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local player = FindPlayer( i );
		if( player )
		{
			if( playa[ player.ID ].Logged )
			{
				if( playa[ player.ID ].Group.find( group ) >= 0 )
				{
					local st = [];
					st.push( element[ playa[ player.ID ].Lang ] );
					foreach( a in vargv )
					{
						if( a != null ) st.push( a );
					}

					st.insert(0, this);

					MessagePlayer( "[#99bbff][" + group + "] " + format.acall(st), player );
				}
			}
		}
	}
}

function MessageToAllEMS( prefix, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local plr = FindPlayer( i );
		if( plr )
		{
			if( playa[ plr.ID ].Logged )
			{
				local st = [];
				st.push( Lang[ element ][ playa[ plr.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				if( playa[ plr.ID ].Job.JobID == 2 ) 
				{
					MessagePlayer( "[#ff99ff][" + prefix + "] " + format.acall(st), plr );
				}
			//	break;
			}
		}
	}
}

function PlaySoundForNearest( pos, id )
{
	local playar;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		playar = FindPlayer( i );
		if( playar )
		{
			if( playa[ playar.ID ].Logged ) 
			{
				if( DistanceFromPoint( playar.Pos.x, playar.Pos.y, pos.x, pos.y ) <= 10 ) playar.PlaySound( id );
			}
		}	
	}
}

function MessageToAllE( element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local plr = FindPlayer( i );
		if( plr )
		{
			if( playa[ plr.ID ].Logged )
			{
				local st = [];
				st.push( element[ playa[ plr.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				if( playa[ plr.ID ].Job.JobID == 2 || playa[ plr.ID ].Job.JobID == 3 || playa[ plr.ID ].Job.JobID == 4 || playa[ plr.ID ].Job.JobID == 5 ) 
				{
					MessagePlayer( "[#ffffb3][DEP] " + format.acall(st), plr );
				}
			}
		}
	}
}

function MsgRadio( channel, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local plr = FindPlayer( i );
		if( plr )
		{
			if( playa[ plr.ID ].Logged )
			{
				local st = [];
				st.push( element[ playa[ plr.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				if( GetPlayerJoinedChannel( channel, plr ) == channel ) 
				{
					MessagePlayer( "[#00ffff]** [" + GetPlayerJoinedChannel2( channel, plr ) + " | " + channel + "] " + format.acall(st), plr );
				}
			}
		}
	}
}

function MsgRadioLocal( channel, pos, element, ... )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local plr = FindPlayer( i );
		if( plr )
		{
			if( playa[ plr.ID ].Logged )
			{
				local st = [];
				st.push( element[ playa[ plr.ID ].Lang ] );
				foreach( a in vargv )
				{
					if( a != null ) st.push( a );
				}

				st.insert(0, this);

				if( GetPlayerJoinedChannel( channel, plr ) != channel ) 
				{
					if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, pos.x, pos.y ) <= 12 ) MessagePlayer( format.acall(st), plr );
				}
			}
		}
	}
}

