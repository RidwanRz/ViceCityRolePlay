area <- {}
areaname <- {}

function LoadArea()
{
	local q = SafeSelect( mysql, "SELECT * FROM `area`" );
	local result;
	while ( result = mysql_fetch_assoc( q ) )
	{		
	    area[ result["ID"] ] <- {};
		area[ result["ID"] ].ID     <-  result["ID"];
		area[ result["ID"] ].Name     <-  result["Name"];
		area[ result["ID"] ].Area   <- [];
		area[ result["ID"] ].Owner  <-  result["Owner"];
		area[ result["ID"] ].Income    <-  result["Income"].tointeger();
		area[ result["ID"] ].Price   <-  result["Price"].tointeger();
		area[ result["ID"] ].Welcome   <-  result["Welcome"];
		area[ result["ID"] ].InfoPos <- ( result["InfoPos"] == "x" ) ? "x" : ConvertStringToPos( result["InfoPos"] );
		area[ result["ID"] ].Items <- ( result["Items"] == "x" ) ? {} : ::json_decode( result["Items"] );

		ConvertStringToArea( result["ID"], result["Area"] );
	}
		
	mysql_free_result( q );
	print("\r[Area] " + area.len() + " loaded." );
}

function LoadAreaName()
{
	local q = SafeSelect( mysql, "SELECT * FROM `areaname`" );
	local result;

	while( result = mysql_fetch_assoc( q ) )
	{		
		areaname.rawset( result["name"],
		{
			Area = ConvertStringToAreav2( result["coordinates"] ),
		})
	}
		
	mysql_free_result( q );
	print("\r[Area Name] " + area.len() + " loaded." );
}

function InArea( x, y )
{
	foreach( kiki in area )
	{
		if( kiki.Area == "x" ) continue;

		if( InPoly( x, y, kiki.Area ) ) return kiki.ID;
	}
}

function Add247Item( id )
{
	area[ id ].Items.rawset( "1", { "Stock": "100", "Price": "2000" } );
	area[ id ].Items.rawset( "2", { "Stock": "1000", "Price": "500" } );
	area[ id ].Items.rawset( "3", { "Stock": "1000", "Price": "1000" } );
	area[ id ].Items.rawset( "4", { "Stock": "1000", "Price": "3000" } );
	area[ id ].Items.rawset( "5", { "Stock": "200", "Price": "350" } );
	area[ id ].Items.rawset( "6", { "Stock": "200", "Price": "2000" } );

	SaveArea( area[ id ] );
}

function AddAmmuItem( id )
{
	area[ id ].Items.rawset( "7", { "Stock": "1000", "Price": "500" } );
	area[ id ].Items.rawset( "8", { "Stock": "1000", "Price": "1000" } );
	area[ id ].Items.rawset( "9", { "Stock": "1000", "Price": "500" } );
	area[ id ].Items.rawset( "10", { "Stock": "1000", "Price": "1500" } );
	area[ id ].Items.rawset( "11", { "Stock": "1000", "Price": "700" } );
	area[ id ].Items.rawset( "12", { "Stock": "1000", "Price": "2000" } );
	area[ id ].Items.rawset( "13", { "Stock": "1000", "Price": "1500" } );
	area[ id ].Items.rawset( "14", { "Stock": "1000", "Price": "3200" } );
	area[ id ].Items.rawset( "15", { "Stock": "1000", "Price": "5000" } );

	SaveArea( area[ id ] );
}

function AddhavClothItem( id )
{
	area[ id ].Items.rawset( "101", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "102", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "103", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "104", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "105", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "106", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "107", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "108", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "109", { "Stock": "2000", "Price": "500" } );
	area[ id ].Items.rawset( "110", { "Stock": "2000", "Price": "500" } );

	SaveArea( area[ id ] );
}

function AddDtClothItem( id )
{
	area[ id ].Items.rawset( "111", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "112", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "113", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "114", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "115", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "116", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "117", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "118", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "119", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "120", { "Stock": "2000", "Price": "4000" } );
	area[ id ].Items.rawset( "121", { "Stock": "2000", "Price": "4000" } );

	SaveArea( area[ id ] );
}

function AddGOlfColothItem( id )
{
	area[ id ].Items.rawset( "122", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "123", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "124", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "125", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "126", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "127", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "128", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "129", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "130", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "131", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "132", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "133", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "134", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "135", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "136", { "Stock": "2000", "Price": "1000" } );

	SaveArea( area[ id ] );
}

function AddODClothItem( id )
{
	area[ id ].Items.rawset( "137", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "138", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "139", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "140", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "141", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "142", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "143", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "144", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "145", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "146", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "147", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "148", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "149", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "150", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "151", { "Stock": "2000", "Price": "1000" } );
	area[ id ].Items.rawset( "152", { "Stock": "2000", "Price": "1000" } );
	
	SaveArea( area[ id ] );
}

function AddDMItem( id )
{
	area[ id ].Items.rawset( "16", { "Stock": "1000000", "Price": "45000" } );
	area[ id ].Items.rawset( "17", { "Stock": "1000000", "Price": "35000" } );
	area[ id ].Items.rawset( "18", { "Stock": "1000000", "Price": "15000" } );
	area[ id ].Items.rawset( "19", { "Stock": "1000000", "Price": "65000" } );
	area[ id ].Items.rawset( "20", { "Stock": "1000000", "Price": "35000" } );
	area[ id ].Items.rawset( "21", { "Stock": "1000000", "Price": "200000" } );
	area[ id ].Items.rawset( "22", { "Stock": "1000000", "Price": "25" } );

	SaveArea( area[ id ] );
}

function AddPNSItem( id )
{
	area[ id ].Items.rawset( "24", { "Stock": "5000", "Price": "1500" } );
	SaveArea( area[ id ] );
}

function AddToolsItem( id )
{
	area[ id ].Items.rawset( "25", { "Stock": "5000", "Price": "1500" } );
	SaveArea( area[ id ] );
}


function InitShopItem()
{
	foreach( index, value in area )
	{
		switch( index )
		{
			case "store-1":
			case "store-2":
			case "store-3":
			case "store-4":
			case "store-5":
			Add247Item( index );		
			break;
		}
	}

}

function noPolyZone( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "store-1":
		case "store-2":
		case "store-3":
		case "store-4":
		case "store-5":
		//case "biker-1":

		case "hospital-1":
		case "hospital-2":
		case "hospital-3":
		case "hospital-4":
		
		case "black-market":
	
		return true;
	}
}

function IsClothShop( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "cloth-1":
		case "cloth-2":
		case "cloth-3":
		case "cloth-4":
	
		return true;
	}

}

function IsPD( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "HavanaPD":
		case "DowntownPD":
		case "WashPD":
		case "fbi-1":
		
		return true;
	}

}

function IsHospital( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "Hospital-1":
		case "Hospital-2":
		case "Hospital-3":
		case "Hospital-4":
	
		return true;
	}

}

function IsWeedField( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "weed-1":
		case "weed-2":
		case "weed-3":
		case "weed-4":
		case "weed-5":
		case "weed-6":
		case "weed-7":
		case "weed-8":
		return true;
	}

}

function IsPNS( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "pns-1":
		case "pns-2":
		case "pns-3":
		case "pns-4":
	
		return true;
	}

}

function IsPNS2( type )
{
	switch( type )
	{
		case "pns-1":
		case "pns-2":
		case "pns-3":
		case "pns-4":
	
		return true;
	}

}

function IsVehDealership( player )
{
	switch( playa[ player.ID ].Area )
	{
		case "sunshine-1":
		case "biker-1":
		case "heli-1":
	
		return true;
	}

}

/*function SaveArea()
{
	foreach( kiki in area )
	{
		::QuerySQL( db, "UPDATE area SET Name = '" + kiki.Name + "', Owner = '" + kiki.Owner + "', Income = '" + kiki.Income + "', Price = '" + kiki.Price + "', Welcome = '" + kiki.Welcome + "' WHERE ID = '" + kiki.ID + "'" );
	}
}*/

function SaveArea( data )
{
	SafeSelect( mysql, "UPDATE area SET Name = '" + data.Name + "', Owner = '" + data.Owner + "', Income = '" + data.Income + "', Price = '" + data.Price + "', Welcome = '" + data.Welcome + "', Items = '" + json_encode( data.Items ) + "' WHERE ID = '" + data.ID + "'" );
}

function CheckArea()
{
	local plr = null;
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		plr = FindPlayer( i );
		if ( plr )
		{
			if( !noPolyZone( plr ) )
			{
				if( InArea( plr.Pos.x, plr.Pos.y ) != null ) 
				{
					if( playa[ plr.ID ].Area == null && InArea( plr.Pos.x, plr.Pos.y ) != "bank" && area.rawget( InArea( plr.Pos.x, plr.Pos.y ) ).Welcome != "null" ) MsgPlr( 7, plr, Lang.PropWel, area.rawget( InArea( plr.Pos.x, plr.Pos.y ) ).Welcome );
					playa[ plr.ID ].Area = InArea( plr.Pos.x, plr.Pos.y );
				}
						
				else
				{
					if( playa[ plr.ID ].Area == "bank" && Server.BankRobbery == 1 && plr.ID == Server.BankRobber ) MsgPlr( 2, plr, Lang.NotInVault );
					if( playa[ plr.ID ].Area == "bank" && Server.BankRobbery == 2 && playa[ plr.ID ].JobID.find("cop") == null && playa[ plr.ID ].BankCash > 0 ) playa[ plr.ID ].AddCash( plr, playa[ plr.ID ].BankCash*20000 ), MsgPlr( 3, plr, Lang.RobReward, ( playa[ plr.ID ].BankCash*20000 ) ), playa[ plr.ID ].BankCash = 0;
					playa[ plr.ID ].Area = null;
				}
			}
		}
	}
}

function ConvertStringToArea( t, string )
{
	if( string == "x" ) return area[ t ].Area = "x";

	local a = split( string, "," )
	
	foreach( kiki in a )
	{
		area[ t ].Area.push( kiki.tofloat() );
	}
}

function ConvertStringToAreav2( string )
{
	local result = [];

	local a = split( string, "," )
	
	foreach( kiki in a )
	{
		result.push( kiki.tofloat() );
	}

	return result;
}


function onBizz( player, cmd, text )
{
	switch( cmd )
	{
	
		case "buyprop":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
			else
			{
				if( area[ playa[ player.ID ].Area ].Owner != "100000" ) MsgPlr( 2, player, Lang.PropNotForSale );
				else if( playa[ player.ID ].Cash < area[ playa[ player.ID ].Area ].Price ) MessagePlayer("[#ffff00][Property] [#ff5050]You need [#ffffff]$" + area[ playa[ player.ID ].Area ].Price + " [#ff5050]to buy this property.", player );
				else
				{
					if( playa[ player.ID ].Area == "bankvault" || playa[ player.ID ].Area == "bank" ) return MsgPlr( 2, player, Lang.NotInProperty );
					BuyProp( player );
				}
			}
		}
		break;
		
		case "property":
		if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
		else
		{
			if( playa[ player.ID ].Area == "bankvault" ) return MsgPlr( 2, player, Lang.NotInProperty );
			
			MsgPlr( 7, player, Lang.PropInfo, area[ playa[ player.ID ].Area ].ID, area[ playa[ player.ID ].Area ].Name );
			if( area[ playa[ player.ID ].Area ].Owner == 100000 ) MsgPlr( 7, player, Lang.PropForSale, area[ playa[ player.ID ].Area ].Price );
			else MsgPlr( 7, player, Lang.PropHelp1, mysqldb.GetNameFromID( area[ playa[ player.ID ].Area ].Owner ), area[ playa[ player.ID ].Area ].Income );
			if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID ) MsgPlr( 7, player, Lang.PropHelp2, area[ playa[ player.ID ].Area ].Welcome );
		}
		break;
		
		case "setpropmsg":
		if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
		else
		{
			if( area[ playa[ player.ID ].Area ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.PropNotOwner );
			else if ( !text ) MsgPlr( 2, player, Lang.SetMsgPropSyntax );
			else
			{
				area[ playa[ player.ID ].Area ].Welcome = text;
				MsgPlr( 3, player, Lang.SetMsgProp, text );

				SaveArea( area[ playa[ player.ID ].Area ] );
			}
		}
		break;

		case "collect":
		if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
		else
		{
			if( area[ playa[ player.ID ].Area ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.PropNotOwner );
			else if( area[ playa[ player.ID ].Area ].Income == 0 ) MsgPlr( 2, player, Lang.NotIncome );
			else
			{
				playa[ player.ID ].AddCash( player, area[ playa[ player.ID ].Area ].Income );
				MsgPlr( 3, player, Lang.CollectIncome, area[ playa[ player.ID ].Area ].Income );
				area[ playa[ player.ID ].Area ].Income = 0;

				SaveArea( area[ playa[ player.ID ].Area ] );
			}
		}
		break;
		
		case "sellprop":
		if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
		else
		{
			if( area[ playa[ player.ID ].Area ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.PropNotOwner );
			else
			{
				area[ playa[ player.ID ].Area ].Owner = 100000;
				area[ playa[ player.ID ].Area ].Welcome = "null";
				playa[ player.ID ].AddCash( player, area[ playa[ player.ID ].Area ].Price/2 );
				MsgPlr( 3, player, Lang.SellProp, area[ playa[ player.ID ].Area ].Name, area[ playa[ player.ID ].Area ].Price/2 );

				SendDataToClientToAll( 6020, area[ playa[ player.ID ].Area ].ID + ";[#e6e600]Type [#ffffff]" + area[ playa[ player.ID ].Area ].Name + ";[#e6e600]This property is for sale for [#ffffff]$" + area[ playa[ player.ID ].Area ].Price + ";0;0;0" );

				SaveArea( area[ playa[ player.ID ].Area ] );
			}
		}
		break;
		
		case "asellprop":
		if( playa[ player.ID ].Level >= 4 )
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( playa[ player.ID ].Area == null ) MsgPlr( 2, player, Lang.NotInProperty );
			else
			{
				//if( area[ playa[ player.ID ].Area ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.PropNotOwner );
				//else
				//{
					area[ playa[ player.ID ].Area ].Owner = 100000;
					area[ playa[ player.ID ].Area ].Welcome = "null";
					//playa[ player.ID ].AddCash( player, area[ playa[ player.ID ].Area ].Price/2 );
					//MsgPlr( 3, player, Lang.SellProp, area[ playa[ player.ID ].Area ].Name, area[ playa[ player.ID ].Area ].Price/2 );
					MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has admin sold the property at coordinates [#33cc33] " + player.Pos );
					SendDataToClientToAll( 6020, area[ playa[ player.ID ].Area ].ID + ";[#e6e600]Type [#ffffff]" + area[ playa[ player.ID ].Area ].Name + ";[#e6e600]This property is for sale for [#ffffff]$" + area[ playa[ player.ID ].Area ].Price + ";0;0;0" );

					SaveArea( area[ playa[ player.ID ].Area ] );
				//}
			}
		}
		break;
	}
}

function AddIncome( areas, amount )
{	
	local ident = area.rawin( areas );
	if( !ident ) return;
	
	area[ areas ].Income += ( amount/2 );

	SendDataToClientToAll( 6020, area[ areas ].ID + ";[#e6e600]Type [#ffffff]" + area[ areas ].Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( area[ areas ].Owner )  + " [#e6e600]Income [#ffffff]$" + area[ areas ].Income + ";" + area[ areas ].InfoPos.x + ";" + area[ areas ].InfoPos.y + ";" + area[ areas ].InfoPos.z );

	SaveArea( area[ areas ] );
}

function BuyProp( player )
{
	if( playa[ player.ID ].XPLevel < 2 ) MsgPlr( 2, player, Lang.NeedXP, 2 );
	else if( playa[ player.ID ].Cash < area[ playa[ player.ID ].Area ].Price )
	{
		if( playa[ player.ID ].Bank == false ) MsgPlr( 2, player, Lang.PropNotEnoughCash, area[ playa[ player.ID ].Area ].Price );
		else if( playa[ player.ID ].Cash < area[ playa[ player.ID ].Area ].Price ) MsgPlr( 2, player, Lang.PropNotEnoughCash, area[ playa[ player.ID ].Area ].Price );
		else
		{
			area[ playa[ player.ID ].Area ].Owner = playa[ player.ID ].ID;
			area[ playa[ player.ID ].Area ].Income = 0;
			playa[ player.ID ].DecBank( player, area[ playa[ player.ID ].Area ].Price );
			MsgPlr( 3, player, Lang.BuyProp, area[ playa[ player.ID ].Area ].Name );
			MsgPlr( 3, player, Lang.BuyProp1 );

			SendDataToClientToAll( 6020, area[ playa[ player.ID ].Area ].ID + ";[#e6e600]Type [#ffffff]" + area[ playa[ player.ID ].Area ].Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( area[ playa[ player.ID ].Area ].Owner )  + " [#e6e600]Income [#ffffff]$" + area[ playa[ player.ID ].Area ].Income + ";" + area[ playa[ player.ID ].Area ].InfoPos.x + ";" + area[ playa[ player.ID ].Area ].InfoPos.y + ";" + area[ playa[ player.ID ].Area ].InfoPos.z );
	
			print( "\r[Purchase] " + player.Name + "(ID " + playa[ player.ID ].ID + ") has purchased property " + area[ playa[ player.ID ].Area ].Name + "(ID " + playa[ player.ID ].Area + ") using bank balance $" + area[ playa[ player.ID ].Area ].Price );
		
			SaveArea( area[ playa[ player.ID ].Area ] );			
		}
	}
		
	else
	{
		area[ playa[ player.ID ].Area ].Owner = playa[ player.ID ].ID;
		area[ playa[ player.ID ].Area ].Income = 0;
		playa[ player.ID ].DecCash( player, area[ playa[ player.ID ].Area ].Price );
		MsgPlr( 3, player, Lang.BuyProp, area[ playa[ player.ID ].Area ].Name );
		MsgPlr( 3, player, Lang.BuyProp1 );

		SendDataToClientToAll( 6020, area[ playa[ player.ID ].Area ].ID + ";[#e6e600]Type [#ffffff]" + area[ playa[ player.ID ].Area ].Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( area[ playa[ player.ID ].Area ].Owner )  + " [#e6e600]Income [#ffffff]$" + area[ playa[ player.ID ].Area ].Income + ";" + area[ playa[ player.ID ].Area ].InfoPos.x + ";" + area[ playa[ player.ID ].Area ].InfoPos.y + ";" + area[ playa[ player.ID ].Area ].InfoPos.z );

		print( "\r[Purchase] " + player.Name + "(ID " + playa[ player.ID ].ID + ") has purchased property " + area[ playa[ player.ID ].Area ].Name + "(ID " + playa[ player.ID ].Area + ") using cash balance $" + area[ playa[ player.ID ].Area ].Price );

		SaveArea( area[ playa[ player.ID ].Area ] );
	}
}

function LoadPropertytexdrawForPlayer( player )
{
	foreach( index, value in area )
	{
		if( value.InfoPos != "x" )
		{
			if( value.Owner == "100000" ) 
			{
				if( IsPNS2( value.ID ) ) SendDataToClient( 6020, value.ID + ";" + value.Name + ";[#e6e600]This property is for sale for [#ffffff]$" + value.Price + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
				else SendDataToClient( 6020, value.ID + ";" + value.Name + ";[#e6e600]This property is for sale for [#ffffff]$" + value.Price + "; ;" + GetText3Type( value.ID ) + "; ; ;" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
			}

			else 
			{
				if( IsPNS2( value.ID ) ) SendDataToClient( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
				else SendDataToClient( 6020, value.ID + ";[#ffffff]" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner )  + ";[#e6e600]Value [#ffffff]$" + value.Price + "; ; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
			}
		}
	}

	SendDataToClient( 6021, null, player );
}

function GetText3Type( type )
{
	switch( type )
	{

		case "store-1":
		case "store-2":
		case "store-3":
		case "store-4":
		case "store-5":

		case "cloth-1":
		case "cloth-2":
		case "cloth-3":
		case "cloth-4":

		case "ammu-1":
		case "ammu-2":
		case "ammu-3":

		case "tools-1":
		case "tools-2":
		case "tools-3":

		return "(( /buy ))";

		case "pns-1":
		case "pns-2":
		case "pns-3":
		case "pns-4":

		return "(( /repair ))";

		default: 
		return "";
	}
}

function ListOwnedProp( player )
{
	foreach( index, value in area ) 
	{ 
		if( value.Owner == playa[ player.ID ].ID )
		{
			SendDataToClient( 6830, index + " " + value.Name, player );
		}
	}
}

function CountOwnedProp( player )
{
	local count = 0;
	foreach( index, value in area ) 
	{ 
	if( value.Owner == playa[ player.ID ].ID ) count ++;
	}

	return count;
}

function CheckPropSpawn( player )
{
	if( CountOwnedProp( player ) > 0 )
	{
		ListOwnedProp( player );
	}
	else SendDataToClient( 6810, "You dont own any property.", player );
}

function SpawnProp( player, index )
{
	if( area.rawin( index ) )
	{
		player.Spawn();

		player.World = 0;
		playa[ player.ID ].OnSpawnMenu = false;
		SendDataToClient( 6820, null, player );

		player.Spawn();
		
		_Timer.Create( this, function() 
		{
			if( area[ index ].InfoPos != "x" ) player.Pos = area[ index ].InfoPos;
			else SendDataToClient( 6810, "An error has occured.", player );
		}, 500, 1 );
	}
	else SendDataToClient( 6810, "An error has occured.", player );
}

Server_TD <-
[
	{
		"Text": "[#ffcc66]=== Vitual Reality RolePlay ===",
		"Text2": "If you are new here, your most important commands are: [#ff0000]/faq /ask and /cmds",
		"Pos": Vector( 238.503, -1280.27, 11.0712 )
	}

	{
		"Text": "Police Duty",
		"Text2": "",
		"Pos": Vector( 401.957, -483.118, 12.3432 )
	}

	{
		"Text": "Police Duty",
		"Text2": "",
		"Pos": Vector( -874.059, -683.4, 11.2705 )
	}

	{
		"Text": "Police Duty",
		"Text2": "",
		"Pos": Vector( -656.485, 762.112, 11.5993 )
	}

	{
		"Text": "Police Duty",
		"Text2": "",
		"Pos": Vector( 509.695, 513.728, 12.0998 )
	}

	{
		"Text": "EMS Duty",
		"Text2": "",
		"Pos": Vector( 496.219, 701.098, 12.1033 )
	}

	{
		"Text": "EMS Duty",
		"Text2": "",
		"Pos": Vector( -818.763, 1144.4, 12.4111 )
	}

	{
		"Text": "EMS Duty",
		"Text2": "",
		"Pos": Vector( -885.115, -461.859, 13.1106 )
	}

	{
		"Text": "EMS Duty",
		"Text2": "",
		"Pos": Vector( -137.774, -985.083, 10.4672 )
	}

	{
		"Text": "Trucker Duty",
		"Text2": "",
		"Pos": Vector( -1056.89, -484.728, 11.1385 )
	}

	{
		"Text": "Trucker Duty",
		"Text2": "",
		"Pos": Vector( 465.179, 342.232, 11.8618 )
	}

	{
		"Text": "Trucker Duty",
		"Text2": "",
		"Pos": Vector( -734.695, -1470.46, 11.9592 )
	}

	{
		"Text": "Trucker Duty",
		"Text2": "",
		"Pos": Vector( -691.561, 1040.62, 11.3218 )
	}

	{
		"Text": "Use /browse to browse vehicles.",
		"Text2": "",
		"Pos": Vector( -1031.31, -849.668, 13.5224 )		
	}

	{
		"Text": "Use /browse to browse vehicles.",
		"Text2": "",
		"Pos": Vector( -584.624, 653.44, 11.3995 )		
	}

]

function LoadServertexdrawForPlayer( player )
{
	foreach( index, value in Server_TD )
	{
		SendDataToClient( 9000, index + ";" + value.Text + ";" + value.Text2 + ";" + value.Pos.x + ";" + value.Pos.y + ";" + value.Pos.z, player );
	}
}

function LoadShopMarker()
{
	foreach( index, value in area )
	{
		if( value.InfoPos != "x" )
		{
			CreateMarker( 1, value.InfoPos, 2, RGB( 255, 255, 0 ), 0 );
		}
	}
}

function IsPlayerInArea( x, y )
{
	local q = QuerySQL( database, "SELECT * FROM area" );

	if ( ( x ) && ( y ) )
	{
		// Iterate the rows in a loop until there are no more rows
		while ( GetSQLColumnData( q, 0 ) != null )
		{
			// Grab the data in the first (0) and second (1) column of the current row
			local
			     t = ConvertStringToAreav2( GetSQLColumnData( q, 0 ) ),
			     p = GetSQLColumnData( q, 1 );
	
			// Check if the point x y is inside the polygon.
			if ( ( t ) && ( InPoly(x, y, t ) ) ) return p;

			// Read the next row available
     			q = GetSQLNextRow( q );	

			// terminate loop when no rows are available
			if ( !q ) break;
		}

		return "Vice City";
	}
}

function IsPlayerInArea( x, y )
{
	foreach( index, value in areaname )
	{
		if( value.Area == "x" ) continue;

		if( InPoly( x, y, value.Area ) ) return index;
	}
}
