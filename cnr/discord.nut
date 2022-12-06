/*
	LU Discord bot by Rhytz (https://github.com/Rhytz/lu-discord)
	Modified for VCMP by KingOfVC
*/

ScriptConfig		<- {};
DiscordSocket 		<- false;
ssds <- 0;
Discord_Check <- null;

Discord_cfg <-
{
	Channel = "echo",
	Hostname = "37.148.209.249",
	Port = 8100,
	Adminrole = "Moderator",
	Pass = "key",
}


/*
	Utility function(s)
*/
function lineSplit(string){
	local find = true;
	local strings = [];

	do {
		find = string.find("\r\n");
		strings.push(string.slice(0, find));
		string = string.slice(find, string.len());
	} while (find)

	return strings;
}

function LoadDiscord(){

	createSocketFromConfig();
	addEvent("onDiscordMessage");
	addEvent("onDiscordCommand");

}

function CheckDiscordTimeout()
{
	if( ssds != 0 && ( time() - ssds ) > 1780 )
	{
		StopDiscord();
		NewTimer( "LoadDiscord", 500, 1 );
	}

}

function StopDiscord()
{
	print("[discord] Discord echo script unloaded");
	DiscordSocket.Stop();
	DiscordSocket.Delete();
	ssds = 0;
}

function createSocketFromConfig(){

	DiscordSocket = ::NewSocket("handleSocketData");
	DiscordSocket.SetLostConnFunc("socketDisconnected");
	DiscordSocket.SetNewConnFunc("socketConnected");
	socketConnect( Discord_cfg.Hostname, Discord_cfg.Port );
}

function socketConnect(host, port){
	print("[lu-discord] Attempting to connect to " + Discord_cfg.Hostname + ":" + Discord_cfg.Port );
	DiscordSocket.Connect(host, port);
}

function socketDisconnected(){
	print("[lu-discord] Disconnected from " + Discord_cfg.Hostname + ":" + Discord_cfg.Port );
	Discord_Check.Stop();
	Discord_Check.Delete();
	NewTimer("createSocketFromConfig", 15000, 1, Discord_cfg.Hostname, Discord_cfg.Port );
}

function socketConnected(){
	print("[lu-discord] Connected to server " + Discord_cfg.Hostname + ":" + Discord_cfg.Port );
	sendAuthPacket( DiscordSocket );
	ssds = time();
	//Discord_Check <- NewTimer( "CheckDiscordTimeout", 1000, 0 );
}

function sendSocketData(socket, data){
	socket.Send(base64_encode(data) + "\r\n");
};

function handleSocketData(data){
	local lines = lineSplit(data);
	foreach(index, line in lines){
		line = base64_decode(line);
		local json = json_decode(line);
		if(typeof(json) == "table"){
			if(typeof(json.type) == "string"){
				handleDiscordPacket(DiscordSocket, json.type, (json.rawin("payload") && typeof(json.payload) == "table" ? json.payload : {}));
			}
		}
	}
}

function sendAuthPacket(socket){
	local number = GetTickCount()+time();
	local salt = MD5(number.tostring()).tolower();
	local data = json_encode({
		type = "auth",
		payload = {
			salt = salt,
			passphrase = SHA256(salt + SHA512( Discord_cfg.Pass ).tolower()).tolower()
		}
	});
	sendSocketData(socket, data);
}

function handlePingPacket(socket){
	sendSocketData(socket, json_encode({ type = "pong" }));
}

function handleAuthPacket(socket, payload){
	if(payload.rawin("authenticated") && payload.authenticated){
		print("[lu-discord] Succesfully authenticated");
		sendSocketData(socket, json_encode({
			type = "select-channel",
			payload = {
				channel = Discord_cfg.Channel
			}
		}));
	}else{
		local error = (payload.rawin("error") ? payload.error.tostring() : "Unknown error");
		print("[lu-discord] Failed to authenticate: " + error);
		socket.Stop();
	}
}

function handleSelectChannelPacket(socket, payload){
	if(payload.rawin("success") && payload.success){
		if(payload.rawin("wait") && payload.wait){
			print("[lu-discord] Bot isn't ready");
		}else{
			print("[lu-discord] Channel has been bound");
	/*		sendSocketData(socket, json_encode({
				type = "chat.message.text",
				payload = {
					author 	= "Console",
					text	= "Hello :wave:"
				}
			}));*/
			handlePingPacket( socket );
		}
	}else{
		local error = (payload.rawin("error") ? payload.rawin("error").tostring() : "Unknown error");
		print("[lu-discord] Failed to bind channel: " + error);
	}
}

function handleDisconnectPacket(socket){
	print("[lu-discord] Server has closed the connection");
	socket.Stop();
	DiscordSocket = null;
}

function handleDiscordPacket(socket, packet, payload){
	switch(packet){
		case "ping":
			return handlePingPacket(socket);
			break;
		case "auth":
			return handleAuthPacket(socket, payload);
			break;
		case "select-channel":
			return handleSelectChannelPacket(socket, payload);
			break;
		case "disconnect":
			return handleDisconnectPacket(socket);
			break;
		default:
			return handleDiscordDefaultPacket(socket, packet, payload);
	}
}

/*
	Event and chat functions
*/

function handleDiscordDefaultPacket(socket, packet, payload){
	if(packet == "text.message")
	{
		local
		player = payload.author.name,
		role = payload.author.roles[1],
		cmds = GetTok( payload.message.text.slice( 1 ), " ", 1 ),
		text = GetTok( payload.message.text, " ", 2, NumTok( payload.message.text, " " ) ),
		text = split( payload.message.text," " ).len() > 1 ? payload.message.text.slice( payload.message.text.find( " " ) + 1 ) : null;


		if ( payload.message.text.slice( 0, 1 ) == "!" )
		{
			if ( text == null ) onDiscordCommand( player, cmds, null, role );
			else onDiscordCommand( player, cmds, text, role );
		}
	}
	//	Discord_onConnect("**[" + payload.author.roles[1] + "]** " + payload.author.name + ": " + payload.message.text );

	/*	triggerEvent("onDiscordMessage", payload.author.name, payload.message.text);

		local data = json_encode({
			type = "chat.confirm.message",
			payload = {
				author = payload.author.name,
				message = payload.message
			}
		});
		sendSocketData(socket, data);
	}*/

}

function EchoMessage(plr)
{

	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "player.join",
		payload = {
			param1 = plr,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;

}

function AdminMessage(plr)
{
	/*if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "player.join",
		payload = {
			param1 = plr,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;*/
}

function Discord_onPlayerPart(plr, reason)
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.part",
		payload = {
			param1 = plr.Name,
			param2 = reason,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_onPlayerChat(plr, message)
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.chat",
		payload = {
			param1 = plr.Name,
			param2 = message
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_onPlayerDeath(plr, reason)
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.death",
		payload = {
			param1 = plr.Name,
			param2 = reason
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_onPlayerKill(killer, plr, reason )
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.kill",
		payload = {
			param1 = killer.Name,
			param2 = plr.Name,
			param3 = reason
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_AnnounceWinner( side )
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.result",
		payload = {
			param1 = side,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_BaseStart( b )
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.start",
		payload = {
			param1 = b,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_Top( b )
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.top",
		payload = {
			param1 = b,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function Discord_IRCChat( user, text )
{
	if( DiscordSocket == null ) return;

	local data = json_encode({
		type = "ad.irc",
		payload = {
			param1 = user,
			param2 = text,
		}
	});
	sendSocketData(DiscordSocket, data);
	return 1;
}

function onDiscordCommand( plr, cmd, text, role )
{
	switch( cmd.tolower() )
	{
		/*case "serverinfo":
		EchoMessage("**" + GetServerName() + "**"  );
		EchoMessage("**IP** play.vl-vcmp.com **or** 178.62.198.107:8192"  );
		break;*/

		case "players":
		local plr, b;
		foreach( kiki in Server.Players )
		{
			if( plr = FindPlayer( kiki ) )
			{
				if ( b ) b = b + ", " + playa[ plr.ID ].Rank + " **" + plr.Name + "**"
				else b = playa[ plr.ID ].Rank + " **" + plr.Name + "**"
			}
		}
		if ( b ) EchoMessage( "Player online **" + GetPlayers() + "/" + GetMaxPlayers() + "** " ),
		EchoMessage( "List of player: " + b );
		else EchoMessage( "No player online." );
		break;


	/*	case "playerinfo":
		if( !text ) EchoMessage( "Usage, **!playerinfo [Full name]**" );
		else
		{
			local q = QuerySQL( IsDB, "SELECT * FROM mcf_acc WHERE NameLower = '" + text.tolower() + "'" );
			if( GetSQLColumnData( q, 0 ) == null ) EchoMessage( "Error, This player does not exist." );
			else
			{
				local a = QuerySQL( IsDB, "SELECT * FROM mcf_dm WHERE NameLower = '" + text.tolower() + "'" );
				local g = QuerySQL( IsDB, "SELECT * FROM mcf_archivement WHERE Name = '" + GetSQLColumnData( q, 0 ) + "'" );
				EchoMessage( "**" + text + "** Player info:" )
				EchoMessage( "Last login **" + ConvertTimeToDate( GetSQLColumnData( q, 9 ) ) + "** Total player time **" + GetTiming( GetSQLColumnData( q, 10 ) ) + "**" );
				EchoMessage( "Kills **" + GetSQLColumnData( a, 2 ) + "** Death **" + GetSQLColumnData( a, 3 ) + "** Achievement complete **" + GetSQLColumnData( g, 10 ) + "/35**" );
			}
		}
		break;*/

		case "say":
		if( !text ) EchoMessage( "Usage, **!say [text]**" )
		else
		{
			Message("[#ff8000]** "+ plr + " on Discord[#ffffff]: " + text );
			EchoMessage( "**" + plr + "(Discord)**: " + text );
		}
		break;

		case "commands":
		case "cmds":
		EchoMessage( "(!) **players, say** " );
		break;
	}
}
