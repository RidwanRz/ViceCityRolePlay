gang <- {}

function LoadGang()
{
	
    local q = QuerySQL( db, "SELECT * FROM gang" );
	while ( GetSQLColumnData( q, 0 ) != null )
	{		
	    gang[ GetSQLColumnData( q, 0 ) ] <- {};
		gang[ GetSQLColumnData( q, 0 ) ].Tag <- GetSQLColumnData( q, 0 );
		gang[ GetSQLColumnData( q, 0 ) ].Name     <-  GetSQLColumnData( q, 1 );
		gang[ GetSQLColumnData( q, 0 ) ].Leader   <-  GetSQLColumnData( q, 2 );
		gang[ GetSQLColumnData( q, 0 ) ].Members  <-  GetSQLColumnData( q, 3 );
		gang[ GetSQLColumnData( q, 0 ) ].XP       <-  GetSQLColumnData( q, 4 ).tointeger();
		gang[ GetSQLColumnData( q, 0 ) ].Cash     <-  GetSQLColumnData( q, 5 ).tointeger();
		gang[ GetSQLColumnData( q, 0 ) ].Skin <- ( GetSQLColumnData( q, 6 ) == "no" ) ? "no" : GetSQLColumnData( q, 6 ).tointeger();
		gang[ GetSQLColumnData( q, 0 ) ].Vehicle1 <- ( GetSQLColumnData( q, 7 ) == "no" ) ? "no" : GetSQLColumnData( q, 7 );
		gang[ GetSQLColumnData( q, 0 ) ].Vehicle2 <- ( GetSQLColumnData( q, 8 ) == "no" ) ? "no" : GetSQLColumnData( q, 8 );
		gang[ GetSQLColumnData( q, 0 ) ].IRC <- ( GetSQLColumnData( q, 9 ) == "no" ) ? "no" : GetSQLColumnData( q, 9 );
		gang[ GetSQLColumnData( q, 0 ) ].IRC_ID <- false;
	    GetSQLNextRow( q );
	}
		
	FreeSQLQuery( q );
	print( "\r[Gang] " + gang.len() + " loaded." );
}

class Gangs
{
	function IncKills( player )
	{
		if( !gang.rawin( playa[ player.ID ].Gang ) ) return;
		else if( gang[ playa[ player.ID ].Gang ].Members.find( player.Name ) == null ) return;
		
		gang[ playa[ player.ID ].Gang ].Kills ++;
	}
	
	function IncDeaths( player )
	{
		if( !gang.rawin( playa[ player.ID ].Gang ) ) return;
		else if( gang[ playa[ player.ID ].Gang ].Members.find( player.Name ) == null ) return;
		
		gang[ playa[ player.ID ].Gang ].Deaths ++;
	}
	
	function GetGangMemberOnJoin( player )
	{
		local gangka = null;
		foreach( kiki in gang )
		{
			if( kiki.Members.find( player.Name ) >= 0 )
			{
				gangka = kiki.Name;
			}
		}
		return gangka;
	}
	
}		

function SaveGang()
{
	foreach( kiki in gang )
	{
		::QuerySQL( db, "UPDATE gang SET Members = '" + kiki.Members + "', Leader = '" + kiki.Leader + "', XP = '" + kiki.XP + "', Cash = '" + kiki.Cash + "', Skin = '" + kiki.Skin + "', Vehicle1 = '" + kiki.Vehicle1 + "', Vehicle2 = '" + kiki.Vehicle2 + "', Name = '" + kiki.Name + "', IRC = '" + kiki.IRC + "'  WHERE Tag = '" + kiki.Tag + "'" );
	}
}

function onGange( player, cmd, text )
{
	switch( cmd )
	{
		case "creategang":
		if( playa[ player.ID ].Gang != null ) MsgPlr( 2, player, Lang.AlreadyGang );
		else if( playa[ player.ID ].XPLevel < 6 ) MsgPlr( 2, player, Lang.NeedXP, 6 );
		else if( playa[ player.ID ].Cash < 50000 ) MessagePlayer("[#00ffff][Gang] [#ff5050]You need [#ffffff]$50000 [#ff5050]to create a gang.", player );
		else if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		//else if( playa[ player.ID ].JobID.find("cop") >= 0 ) MsgPlr( 2, player, Lang.CopNotAllow );
		else if( !text ) MsgPlr( 2, player, Lang.CreategangSyntax );
		else
		{
			if( gang.rawin( text ) == true ) MsgPlr( 2, player, Lang.GangAlreadyExist );
			else
			{
				local generate_tag = "gang-" + ( gang.len() + 1 );
				gang[ generate_tag ] <- {};
				gang[ generate_tag ].Tag <- generate_tag
				gang[ generate_tag ].Name     <-  text;
				gang[ generate_tag ].Leader   <-  player.Name;
				gang[ generate_tag ].Members  <-  player.Name;
				gang[ generate_tag ].XP       <-  20;
				gang[ generate_tag ].Cash     <-  0;
				gang[ generate_tag ].Skin <- "no";
				gang[ generate_tag ].Vehicle1 <- "no";
				gang[ generate_tag ].Vehicle2 <- "no";
				gang[ generate_tag ].IRC <- "no";
				gang[ generate_tag ].IRC_ID <- false;
				MsgPlr( 3, player, Lang.Creategang, text, generate_tag );
				::QuerySQL( db, "INSERT INTO gang VALUES ( '" + generate_tag + "', '" + text + "', '" + player.Name + "', '" + player.Name + "', '0', '0', 'no', 'no', 'no', 'no' ) " );
				playa[ player.ID ].DecCash( player, 50000 );
				playa[ player.ID ].Gang = text;
			}
		}
		break;		
		
		case "setgangirc":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( !text ) MsgPlr( 2, player, Lang.SetgangircSyntax );
		else if( IsChannelUsed( text, playa[ player.ID ].Gang  ) == true ) MsgPlr( 2, player, Lang.SetgangircUsed );
		else
		{
			if( gang[playa[ player.ID ].Gang ].IRC != "no" ) IRC_Part( LU, gang[playa[ player.ID ].Gang ].IRC );
			MsgPlr( 3, player, Lang.Setgangirc, text );
			gang[ playa[ player.ID ].Gang ].IRC_ID = true;
			gang[playa[ player.ID ].Gang ].IRC = text;
			IRC_Join( LU, text );
		}
		break;

		case "ganginfo":
		if( !text ) MsgPlr( 2, player, Lang.GanginfoSyntax );
		else
		{
			if( !gang.rawin( text ) ) MsgPlr( 2 ,player, Lang.GanginfoInvalidGangTag );
			else
			{
				MsgPlr( 8, player, Lang.Ganginfo, text, gang[ text ].Name );
				MsgPlr( 8, player, Lang.Ganginfo1, gang[ text ].Leader, gang[ text ].Members );
				if( playa[ player.ID ].Gang == text ) MsgPlr( 8, player, Lang.Ganginfo2, gang[ text ].Cash, gang[ text ].Skin );
			}
		}
		break;
		
		case "ganginvite":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if ( gang[ generate_tag ].Leader != player.Name) MsgPlr( 2, player, Lang.NotInGang );
		else if( !text ) MsgPlr( 2, player, Lang.GanginviteSyntax );
		else
		{	
			local plr = FindPlayer( text );
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( playa[ plr.ID ].Logged == false ) MsgPlr( 2, player, Lang.GanginviteNotLogged );
			else if( playa[ plr.ID ].Gang != null ) MsgPlr( 2, player, Lang.GanginviteAlreadyIngang );
			else if( playa[ plr.ID ].GangReq != null ) MsgPlr( 2, player, Lang.GanginvitePending );
			else
			{
				playa[ plr.ID ].GangReq = playa[ player.ID ].Gang;
				MsgPlr( 3, player, Lang.Ganginvite, GetIngameTag( plr ) );
				MsgPlr( 8, plr, Lang.Ganginvite1, GetIngameTag( player ), gang[ playa[ player.ID ].Gang ].Name );
				MsgPlr( 8, plr, Lang.Ganginvite2 );
			}
		}
		break;
		
		case "gangaccept":
		if( playa[ player.ID ].Gang != null ) MsgPlr( 2, player, Lang.AlreadyGang );
		else if( playa[ player.ID ].GangReq == null ) MsgPlr( 2, player, Lang.GangNotPending );
		else if( !gang.rawin( playa[ player.ID ].GangReq ) ) playa[ player.ID ].GangReq = null,MsgPlr( 2, player, Lang.GangAlreadyExist );
		else
		{
			playa[ player.ID ].Gang = playa[ player.ID ].GangReq;
			if( gang[ playa[ player.ID ].Gang ].Members.find("N/A") >= 0 ) gang[ playa[ player.ID ].Gang ].Members = player.Name;
			else gang[ playa[ player.ID ].Gang ].Members = gang[ playa[ player.ID ].Gang ].Members + ", " + player.Name;
			MsgGang( playa[ player.ID ].GangReq, Lang.GangJoin, GetIngameTag( player ) );
			SendMsgToGangIRC( "7" + player.Name + " Joined the gang.", playa[ player.ID ].GangReq );
			playa[ player.ID ].GangReq = null;
		}
		break;
		
		case "gangreject":
		if( playa[ player.ID ].Gang != null ) MsgPlr( 2, player, Lang.AlreadyGang );
		else if( playa[ player.ID ].GangReq == null ) MsgPlr( 2, player, Lang.GangNotPending );
		else if( !gang.rawin( playa[ player.ID ].GangReq ) ) playa[ player.ID ].GangReq = null,MsgPlr( 2, player, Lang.GangAlreadyExist );
		else
		{
			MsgGang( playa[ player.ID ].GangReq, Lang.GangReject, GetIngameTag( player ) );
			SendMsgToGangIRC( "7" + player.Name + " has rejected the gang request.", playa[ player.ID ].GangReq );
			playa[ player.ID ].GangReq = null
		}
		break;
		
		case "gangkick":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( !text ) MsgPlr( 2, player, Lang.GangkickSyntax );
		else
		{
			local plr = FindPlayer( text );
			if( plr )
			{
				if( plr.ID == player.ID ) MsgPlr( 2, player, Lang.GangkickSelf );
				else if( playa[ plr.ID ].Gang != playa[ player.ID ].Gang ) MsgPlr( 2, player, Lang.GangkickNonGangMember );
				else
				{
					local lol = [], l, split_mem;
					split_mem = split( gang[ playa[ player.ID ].Gang ].Members, ", " );
					foreach( kiki in split_mem )
					{
						lol.push( kiki );
					}
					if( lol.find( plr.Name ) ) lol.remove( lol.find( plr.Name ) );
						
					foreach( kiki in lol )
					{
						if( kiki.len() > 0 )
						{
							if( l ) l = l + ", " + kiki;
							else l = kiki;
						}
					}
							
					gang[ playa[ player.ID ].Gang ].Members = l;
					MsgGang( playa[ player.ID ].Gang, Lang.Gangkick, GetIngameTag( player ), GetIngameTag( plr ) );
					SendMsgToGangIRC( "7" + player.Name + " has kicked " + plr.Name + " from the gang.", playa[ player.ID ].Gang );
						
					playa[ plr.ID ].Gang = null;
				}
			}
						
			else
			{
				if( gang[ playa[ player.ID ].Gang ].Members.find( text ) ) MessagePlayer("[#00ffff][Gang] [#ff5050]This player is not gang member.", player );
				else
				{
					local lol = [], l, split_mem;
					split_mem = split( gang[ playa[ player.ID ].Gang ].Members, "," );
					foreach( kiki in split_mem )
					{
						lol.push( kiki );
					}
					if( lol.find( text ) ) lol.remove( lol.find( text ) );
								
					foreach( kiki in lol )
					{
						if( kiki.len() > 0 )
						{
							if( l ) l = l + ", " + kiki;			
							else l = kiki;
						}
					}
								
					gang[ playa[ player.ID ].Gang ].Members = l;
					MsgGang( playa[ player.ID ].Gang, Lang.Gangkick, GetIngameTag( player ), GetIngameTag( plr ) );
					SendMsgToGangIRC( "7" + player.Name + " has kicked " + plr + " from the gang.", playa[ player.ID ].Gang );
				}
			} 
		}
		break;
		
		case "setganghouse":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( pickup[ playa[ player.ID ].House ].Owner != player.Name ) MsgPlr( 2, player, Lang.HouseNotOwner );
		else
		{
			pickup[ playa[ player.ID ].House ].GangHouse = playa [ player.ID ].Gang;
			MsgGang( playa[ player.ID ].Gang, Lang.GangHouse, GetIngameTag( player ), pickup[ playa[ player.ID ].House ] .Type );
			SendMsgToGangIRC( "7" + player.Name + " has set " + pickup[ playa[ player.ID ].House ] .Type + " as gang house.", playa[ player.ID ].Gang );
		}
		break;
		
		case "storegangcash":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( pickup[ playa[ player.ID ].House ].GangHouse != playa[ player.ID ].Gang ) MsgPlr( 2, player, Lang.NotAGangHouse );
		else if ( VerifyMember( player ) == false ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !text ) MsgPlr( 2, player, Lang.StoregangcashSyntax );
		else
		{
			if( !IsNum( text ) ) MsgPlr( 2, player, Lang.CashNotInNum );
			else if( playa[ player.ID ].Cash < text.tointeger() || text.tointeger() < 0 ) MsgPlr( 2, player, Lang.CashNotEnough );
			else
			 {
				gang[ playa[ player.ID ].Gang ].Cash += text.tointeger();
				playa[ player.ID ].DecCash( player, text.tointeger() );
				MsgGang( playa[ player.ID ].Gang, Lang.Storegangcash, GetIngameTag( player ), text );
				SendMsgToGangIRC( "7" + player.Name + " has stored $" +text + " into gang house.", playa[ player.ID ].Gang );
			}
		}
		break;

		case "getgangcash":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( pickup[ playa[ player.ID ].House ].GangHouse != playa[ player.ID ].Gang ) MsgPlr( 2, player, Lang.NotAGangHouse );
		else if ( VerifyMember( player ) == false ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !text ) MsgPlr( 2, player, Lang.GetgangcashSyntax );
		else
		{
			if( !IsNum( text ) ) MsgPlr( 2, player, Lang.CashNotInNum );
			else if( gang[ playa[ player.ID ].Gang ].Cash < text.tointeger() || text.tointeger() < 0) MsgPlr( 2, player, Lang.CashNotEnough );
			else
			 {
				gang[ playa[ player.ID ].Gang ].Cash -= text.tointeger();
				if( gang[ playa[ player.ID ].Gang ].Cash < 0 )  gang[ playa[ player.ID ].Gang ].Cash = 0;
				playa[ player.ID ].AddCash( player, text.tointeger() );
				MsgGang( playa[ player.ID ].Gang, Lang.Getgangcash, GetIngameTag( player ), text );
				SendMsgToGangIRC( "7" + player.Name + " has withdraw " + text + " from gang house.", playa[ player.ID ].Gang );
			}
		}
		break;

		case "setgangskin":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( !text ) MsgPlr( 2, player, Lang.SetgangskinSyntax );
		else
		{
			if( !IsNum( text ) ) MsgPlr( 2, player, Lang.SetgangskinNoNum );
			else if( text.tointeger() > 150 || text.tointeger() < 0 ) MsgPlr( 2, player, Lang.SetgangskinInvalid );
			else
			{
				gang[ playa [ player.ID ].Gang ].Skin = text.tointeger();
				MsgGang( playa[ player.ID ].Gang, Lang.Setgangskin, GetIngameTag( player ), text );
				SendMsgToGangIRC( "7" + player.Name + " has set id " + text + " as gang skin.", playa[ player.ID ].Gang );
			}
		}
		break;

		
		
		case "setgangcar":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( !player.Vehicle ) MsgPlr( 2, player, Lang.NotInVehicle );
		else if( !text ) MsgPlr( 2, player, Lang.SetgangcarSyntax );
		else
		{
			if( vehicle[ player.Vehicle.ID ].Owner != player.Name ) MsgPlr( 3, player, Lang.NotOwner );
			else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
			else if( !IsNum( text ) ) MsgPlr( 2, player, Lang.SetgangcarSlotNoNum );
			else
			{
				switch( text )
				{
					case "1":
					gang[ playa[ player.ID ].Gang ].Vehicle1 = vehicle[ player.Vehicle.ID ].UID;
					MsgGang( playa[ player.ID ].Gang, Lang.Setgangcar, GetIngameTag( player ), GetVehicleNameFromModel( vehicle[ player.Vehicle.ID ].Model ) );
					SendMsgToGangIRC( "7" + player.Name + " has set " + GetVehicleNameFromModel( vehicle[ player.Vehicle.ID ].Model ) + " as gang vehicle.", playa[ player.ID ].Gang );
					break;
					
					case "2":
					gang[ playa[ player.ID ].Gang ].Vehicle2 = vehicle[ player.Vehicle.ID ].UID;
					MsgGang( playa[ player.ID ].Gang, Lang.Setgangcar1, GetIngameTag( player ), GetVehicleNameFromModel( vehicle[ player.Vehicle.ID ].Model ) );
					SendMsgToGangIRC( "7" + player.Name + " has set " + GetVehicleNameFromModel( vehicle[ player.Vehicle.ID ].Model ) + " as second gang vehicle.", playa[ player.ID ].Gang );
					break;
					
					default: MsgPlr( 2, player, Lang.SetgangcarSyntax ); break;
				}
			}
		}
		break;
		
		case "getgangcar":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( player.Vehicle ) MsgPlr( 2, player, Lang.GetgangcarInsideCar );
		else if( !text ) MsgPlr( 2, player, Lang.GetgangcarSyntax );
		else if( player.World > 1 ) MsgPlr( 2, player, Lang.CantUseInInterior );
		else
		{
			if( !IsNum( text ) ) MsgPlr( 2, player, Lang.SetgangcarSlotNoNum );
			else
			{
				switch( text )
				{
					case "1":
					if( gang[ playa[ player.ID ].Gang ].Vehicle1 == "no" ) MsgPlr( 2, player, Lang.GetgangcarSlotNotAva );
					else 
					{
						foreach( kiki in vehicle )
						{
							if( gang[ playa[ player.ID ].Gang ].Vehicle1 == kiki.UID )
							{
								kiki.vehicle.Pos = player.Pos;
								MsgPlr( 3, player, Lang.Getgangcar, GetVehicleNameFromModel( kiki.Model ) )
							}
						}
					}
					break;
					
					case "2":
					if( gang[ playa[ player.ID ].Gang ].Vehicle2 == "no" ) MsgPlr( 2, player, Lang.GetgangcarSlotNotAva1 );
					else 
					{
						foreach( kiki in vehicle )
						{
							if( gang[ playa[ player.ID ].Gang ].Vehicle2 == kiki.UID )
							{
								kiki.vehicle.Pos = player.Pos;
								MsgPlr( 3, player, Lang.Getgangcar, GetVehicleNameFromModel( kiki.Model ) )
							}
						}
					}
					break;

					default: MsgPlr( 2, player, Lang.GetgangcarSyntax ); break;
				}
			}
		}
		break;
		
		case "leavegang":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader == player.Name ) MsgPlr( 2, player, Lang.LeavegangLeader );
		else
		{
			local lol = [], l, split_mem;
			split_mem = split( gang[ playa[ player.ID ].Gang ].Members, ", " );
			foreach( kiki in split_mem )
			{
				lol.push( kiki );
			}
			if( lol.find( player.Name ) >= 0 ) lol.remove( lol.find( player.Name ) );
					
			foreach( kiki in lol )
			{
				if( kiki.len() > 0 )
				{
					if( l ) l = l + ", " + kiki;
					else l = kiki;
				}
			}
			
			gang[ playa[ player.ID ].Gang ].Members = l;
			
			MsgGang( playa[ player.ID ].Gang, Lang.Leavegang, GetIngameTag( player ) );			
			SendMsgToGangIRC( "7" + player.Name + " has left the gang.", playa[ player.ID ].Gang );
			
			playa[ player.ID ].Gang = null;
		}
		break;

		case "listgang":
		MsgPlr( 8, player, Lang.Listgang );
		foreach( kiki in gang )
		{
			MsgPlr( 8, player, Lang.Listgang1, kiki.Tag, kiki.Name, kiki.Leader, kiki.Members );
		}
		MsgPlr( 8, player, Lang.EndGanglist );
		break;
			
		case "changegangname":
		if( playa[ player.ID ].Gang == null ) MsgPlr( 2, player, Lang.NotInGang );
		else if( !gang.rawin( playa[ player.ID ].Gang ) ) MsgPlr( 2, player, Lang.GangNieExist );
		else if( gang[ playa[ player.ID ].Gang ].Leader != player.Name ) MsgPlr( 2, player, Lang.NotGangLeader );
		else if( !text ) MsgPlr( 2, player, Lang.ChangegangnameSyntax );
		else
		{
			gang[ playa [ player.ID ].Gang ].Name = text;
			MsgGang( playa[ player.ID ].Gang, Lang.Changegangname, GetIngameTag( player ), text );
			SendMsgToGangIRC( "7" + player.Name + " has change gang name to " + text + ".", playa[ player.ID ].Gang );
		}
		break;
	}
		
}

function MsgGang( gang , element, ... )
{
	local c = "[#93a5c1]";
	
	foreach( kiki in Server.Players )
	{
		local player = FindPlayer( kiki );
		if( player )
		{
			if( playa[ player.ID ].Gang == gang )
			{
				switch( vargv.len() )
				{
					case 1: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring() ), player ); break;
					case 2: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring() ), player ); break;
					case 3: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring(), vargv[2].tostring() ), player ); break;
					case 4: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring(), vargv[2].tostring(), vargv[3].tostring() ), player ); break;
					case 5: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring(), vargv[2].tostring(), vargv[3].tostring(), vargv[4].tostring() ), player ); break;
					case 6: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring(), vargv[2].tostring(), vargv[3].tostring(), vargv[4].tostring(), vargv[5].tostring() ), player ); break;
					case 7: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ], vargv[0].tostring(), vargv[1].tostring(), vargv[2].tostring(), vargv[3].tostring(), vargv[4].tostring(), vargv[5].tostring(), vargv[6].tostring() ), player ); break;
					default: MessagePlayer( c + "** " + format( element[ playa[ player.ID ].Lang ] ), player ); break;
				}
			}
		}
	}
}


function VerifyMember( player )
{
	if( playa[ player.ID ].Gang == null ) return false;
	if( gang.rawin( playa[ player.ID ].Gang ) == false ) return false;
	if( pickup[ playa[ player.ID ].House ].GangHouse != playa[ player.ID ].Gang ) return false;
	
	return true;
}
	
function GetGangInfo( player )
{
	local gangka = null;
	foreach( kiki in gang )
	{
		if( kiki.Members.find( player.Name ) >= 0 )
		{
			gangka = kiki.Tag;
		}
	}
	playa[ player.ID ].Gang = gangka;
	SendMsgToGangIRC( "7" + player.Name + " joined the server.", playa[ player.ID ].Gang );
}

function SpawnGangSkin( player )
{
	if( playa[ player.ID ].Gang == null ) return;
	if( gang.rawin( playa[ player.ID ].Gang ) == false ) return;
	if( gang[ playa[ player.ID ].Gang ].Skin == "no" ) return;
	if( playa[ player.ID ].JobID.find("cop") >= 0 || playa[ player.ID ].JobID == 3 ) return;

	player.Skin = gang[ playa[ player.ID ].Gang ].Skin;
}

function GangHelp( player, key )
{
	if( key != H ) return;
	if( playa[ player.ID ].Gang == null ) return;
	if( gang.rawin( playa[ player.ID ].Gang ) == false ) return;
	if( playa[ player.ID ].JobID.find("cop") >= 0 || playa[ player.ID ].JobID == 3 ) return;
	
	foreach( kiki in Server.Players )
	{
		local plr = FindPlayer( kiki )
		if( plr )
		{
			if( playa[ plr.ID ].Gang == playa[ player.ID ].Gang )
			{
				MsgGang( playa[ player.ID ].Gang, Lang.GangNeedHelp, GetIngameTag( player ), GetDistrictName( player.Pos.x, player.Pos.y ), player.Pos.Distance( plr.Pos ) );
				SendMsgToGangIRC( "7" + player.Name + " need help at " + GetDistrictName( player.Pos.x, player.Pos.y )  + ".", playa[ player.ID ].Gang );
			}
		}
	}
}

function JoinGangIRC()
{
	foreach( kiki in gang )
	{
		if( kiki.IRC != "no" )
		{
			IRC_Join( LU, kiki.IRC );
		}
	}
}

function SendMsgToGangIRC( text , gangy )
{
	local ident = gang.rawin( gangy )
	if( !ident ) return;
	
	if( gang[ gangy ].IRC_ID == false && gang[ gangy ].IRC != "no" ) IRC_PrivMsg( LU, gang[ gangy ].IRC, "7** " + text  );
}
	
function onGangCommand( player, irc, channel, cmd, arr )
{
	local L = IRC_GetUserModes( irc, channel, player ), level;
    if ( L.find( "q" ) != null ) level = 6;
    else if ( L.find( "a" ) != null ) level = 5;
    else if ( L.find( "o" ) != null ) level = 4;
    else if ( L.find( "h" ) != null ) level = 3;
    else if ( L.find( "v" ) != null ) level = 2;
    else L = 1;

	if( cmd == "verifygang" )
	{
	    if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
		else
		{
			local toi = null;
			foreach( kiki in gang )
			{
				if( kiki.IRC == channel && kiki.IRC_ID == true ) toi = kiki.Tag;
			}
			
			if( toi )
			{
				IRC_PrivMsg( LU, channel, "You has successfully verify your gang echo." );
				gang[ toi ].IRC_ID = false;
			}
			
			else
			{
			
			}
		}
	}
	
	else if( cmd == "ganginfo" )
	{
		local toi = null;
		foreach( kiki in gang )
		{
			if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
		}

		if( toi )
		{
			SendMsgToGangIRC( "13Gang " + gang[ toi ].Tag + " 13Name " + gang[ toi ].Name, toi );
			SendMsgToGangIRC( "13 Leader " + gang[ toi ].Leader + " 13Members " + gang[ toi ].Members, toi );
			SendMsgToGangIRC( "13Gang cash " + gang[ toi ].Cash + " 13Skin " + gang[ toi ].Skin, toi );
		}
	}
	
	else if( cmd == "gchat" )
	{
		if ( level < 2 ) EchoNotice( player , "04Error: Access denied!" );
		else if( !arr ) IRC_Notice( irc , player, "7Error: Syntax, !gangchat <text>" );
		else
		{
			local toi = null;
			foreach( kiki in gang )
			{
				if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
			}

			if( toi )
			{
				MessageGang( GetIngameTag( player ) + "[#ffffff]: " + arr, toi );
				SendMsgToGangIRC( "7" + player + ": " + arr, toi );
			}
		}
	}

	else if( cmd == "players" )
	{
		local s = null, toi
		foreach( kiki in gang )
		{
			if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
		}

		foreach( kiki in Server.Players )
		{
			local plr = FindPlayer( kiki );
			if( plr )
			{
				if( playa[ plr.ID ].Gang == toi )
				{
					if( s ) s = s + ", " + plr.Name;
					else s = plr.Name;
				}
				
			}			
		}
		
		if( toi )
		{
			if( s ) SendMsgToGangIRC( "7Gang member online: " + s , toi );
			else SendMsgToGangIRC( "7No gang member online. " , toi );
		}
		
	}
	
	else if( cmd == "cmds" )
	{
		local toi = null;
		foreach( kiki in gang )
		{
			if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
		}

		if( toi )
		{
			SendMsgToGangIRC( "7(!) ganginfo, players, gchat, gangkick, invite " , toi );
		}
	}

	else if ( cmd == "gangkick" )
	{
		if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
		else if( !arr ) IRC_Notice( irc , player, "7Error: Syntax, !gangkick <player>" );
		else
		{
			local toi = null;
			foreach( kiki in gang )
			{
				if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
			}

			if( toi )
			{
				local plr = FindPlayer( arr );
				if( plr )
				{
					if( playa[ plr.ID ].Gang != toi )  EchoNotice( player , "04Error: This player is not gang member." );
					else if( gang[ toi ].Leader == plr.Name ) EchoNotice( player , "04Error: You cannot kick gang leader." );
					else
					{
						local lol = [], l, split_mem;
						split_mem = split( gang[ playa[ player.ID ].Gang ].Members, ", " );
						foreach( kiki in split_mem )
						{
							lol.push( kiki );
						}
						if( lol.find( plr.Name ) ) lol.remove( lol.find( plr.Name ) );
							
						foreach( kiki in lol )
						{
							if( kiki.len() > 0 )
							{
								if( l ) l = l + ", " + kiki;
								else l = kiki;
							}
						}
								
						gang[ playa[ player.ID ].Gang ].Members = l;
						MessageGang( "Leader " + GetIngameTag( player ) + " [#33cc33]has kicked " + GetIngameTag( plr ) + " [#33cc33]from the gang.", toi );
						SendMsgToGangIRC( "7" + player + " has kicked " + plr.Name + " from the gang.", toi);
							
						playa[ plr.ID ].Gang = null;
					}
				}
				else EchoNotice( player , "04Error: Unknown player." );
			} 
		}
	}
	
	else if ( cmd == "invite" )
	{
		if ( level < 5 ) EchoNotice( player , "04Error: Access denied!" );
		else if( !arr ) IRC_Notice( irc , player, "7Error: Syntax, !invite <player>" );
		else
		{
			local toi = null;
			foreach( kiki in gang )
			{
				if( kiki.IRC == channel && kiki.IRC_ID == false ) toi = kiki.Tag;
			}

			if( toi )
			{
				local plr = FindPlayer( arr );
				if( !plr ) EchoNotice( player , "04Error: Unknown player." );
				else if( playa[ plr.ID ].Logged == false ) EchoNotice( player , "04Error: This player is not logged." );
				else if( playa[ plr.ID ].Gang != null ) EchoNotice( player , "04Error: This player already in a gang." );
				else if( playa[ plr.ID ].GangReq != null ) EchoNotice( player , "04Error: This player already had pending request." );
				else
				{
					playa[ plr.ID ].GangReq = toi;
					SendMsgToGangIRC( "7" + player + " has invite " + plr.Name + " to the gang.", toi);
					MessagePlayer("[#00ffff][Gang] " + GetIngameTag( player ) + " [#33cc33]are invite you to gang [#ffffff]" + gang[ toi ].Name, plr );
					MessagePlayer("[#00ffff][Gang] [#33cc33]Type /gangaccept to join OR /gangreject to deny request.", plr );
				}
			}
		}
	}


}

function IsChannelUsed( channel, gangy )
{
	local ident = gang.rawin( gangy )
	if( !ident ) return;

	foreach( kiki in gang )
	{
		if( kiki.IRC == channel ) return true;
	}
}
