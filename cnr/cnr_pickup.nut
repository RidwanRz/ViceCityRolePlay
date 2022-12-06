pickup <- {}
function LoadPickup()
{
	
    local q = SafeSelect( mysql, "SELECT * FROM `pickup`" ) ,ID = 0;
	local row;
	while( row = mysql_fetch_assoc( q ) )
	{				
		local pickupinstance = CreatePickup( row["Model"].tointeger(), row["World"].tointeger(), 0, ConvertStringToPos( row["Pos"] ), 255, true );
		
		pickup.rawset( pickupinstance.ID, 
		{
			ID = row["ID"].tointeger(),
			Model = row["Model"].tointeger(), 
			Type = row["Type"],
			Quatity = row["Quatity"].tointeger(),
			World = row["World"].tointeger(),
			Pos = ConvertStringToPos( row["Pos"] ),
			//Pos = row["Pos"],
			Owner = row["Owner"],
			Share = json_decode( row["Share"] ),
			Locked = ( row["Locked"] == "true" ) ? true : false,
			Interior = row["Interior"].tointeger(),
			Password = row["Passworded"],
			UID = row["UID"],
			Welcome = row["Welcome"],
			Storage = json_decode( row["Storage"] ),
			GangHouse = row["Ganghouse"],
			Storage1 = json_decode( row["Storage1"] ),
			Pickup = pickupinstance,
		});

	//	mysql_query( mysql, format( "INSERT INTO `pickup2` (`Model`, `Type`, `Quatity`, `World`, `Pos`, `Owner`, `Share`, `Locked`, `Interior`, `Passworded`, `UID`, `Welcome`, `Storage`, `Ganghouse`, `Storage1`) VALUES ( '%d', '%s', '%d', '%d', '%s', '%s', '%s', '%s', '%d', '%s', '%s', '%s', '%s', '%s', '%s' )", row["Model"].tointeger(), row["Type"], 1, 1, row["Pos"], "100000", "{}", "false", row["Interior"].tointeger(), "false", row["UID"], "null", "{}", "null", "{}" ) );


	//	pickup[ pickupinstance.ID ].Pickup.Timer = 10000;

	    //GetSQLNextRow( q );
	}
		
	mysql_free_result( q );
	print( "\r[Pickup] " + pickup.len() + " pickup loaded.");
}

function insertpickupdb()
{
}
/*function SavePickup()
{
	foreach( kiki in pickup )
	{
		QuerySQL( db, "UPDATE Pickup SET Storage1 = '" + kiki.Storage1 + "', Model = '" + kiki.Model + "', Type = '" + kiki.Type + "', Quatity = '" + kiki.Quatity + "', World = '" + kiki.World + "', Pos = '" + kiki.Pos.x + ", " + kiki.Pos.y + ", " + kiki.Pos.z + "', Owner = '" + kiki.Owner + "', Share = '" + kiki.Share + "', Locked = '" + kiki.Locked + "', Interior = '" + kiki.Interior + "', Passworded = '" + kiki.Password + "', Welcome = '" + kiki.Welcome + "', Storage = '" + kiki.Storage + "', Ganghouse = '" + kiki.GangHouse + "' WHERE UID = '" + kiki.UID + "'" );
	}
}*/

function SavePickup( kiki )
{
    mysql_query( mysql, "BEGIN TRANSACTION" );
	mysql_query( mysql, "UPDATE pickup SET Storage1 = '" + json_encode( kiki.Storage1 ) + "', Model = '" + kiki.Model + "', Type = '" + kiki.Type + "', Quatity = '" + kiki.Quatity + "', World = '" + kiki.World + "', Pos = '" + kiki.Pos.x + ", " + kiki.Pos.y + ", " + kiki.Pos.z + "', Owner = '" + kiki.Owner + "', Share = '" + json_encode( kiki.Share ) + "', Locked = '" + kiki.Locked + "', Interior = '" + kiki.Interior + "', Passworded = '" + kiki.Password + "', Welcome = '" + kiki.Welcome + "', Storage = '" + json_encode( kiki.Storage ) + "', Ganghouse = '" + kiki.GangHouse + "' WHERE UID = '" + kiki.UID + "'" );
	mysql_query( mysql, "END TRANSACTION" );	
}

function onPickupPickedUp( player, picky )
{
	local id = pickup.rawin( picky.ID );
	if( id  == false ) return;
	
	
/*	if( pickup[ picky.ID ].Type.find( "Haiti Hut" ) >= 0 || pickup[ picky.ID ].Type.find( "Mansion" ) >= 0 || pickup[ picky.ID ].Type.find( "Apartment" ) >= 0 )
	{
		if( !player.Vehicle ) SendDataToClient( 7000, "Press [H] to enter.", player );
	}
*/
	
	else if( pickup[ picky.ID ].Type == "cash" )
	{
		MsgPlr( 3, player , Lang.CashPickup, pickup[ picky.ID ].Quatity, GetIngameTag( mysqldb.GetNameFromID( pickup[ picky.ID ].Owner ) ) );
		playa[ player.ID ].AddCash( player, pickup[ picky.ID ].Quatity );
		
		mysql_query( mysql, "DELETE FROM Pickup WHERE UID = '" + pickup[ picky.ID ].UID + "'" );
		pickup[ picky.ID ].Pickup.Remove();
		pickup.rawdelete( picky.ID );
	}
	
	else if( pickup[ picky.ID ].Type.find("AWeapon") >= 0 )
	{
		local getwep = split( pickup[ picky.ID ].Type, ":" );
		MsgPlr( 3, player, Lang.WeaponPickup4, GetCustomWeaponName( getwep[1].tointeger() ), pickup[ picky.ID ].Quatity );

		player.SetWeapon( getwep[1].tointeger(), ( player.GetAmmoAtSlot( GetSlotFromWeapon( player.Weapon ) ) + pickup[ picky.ID ].Quatity ) );		
	}

	else if( pickup[ picky.ID ].Type.find("Weapon") >= 0 )
	{
		local getwep = split( pickup[ picky.ID ].Type, ":" );
		MsgPlr( 3, player, Lang.WeaponPickup, GetCustomWeaponName( getwep[1].tointeger() ), pickup[ picky.ID ].Quatity, mysqldb.GetNameFromID( pickup[ picky.ID ].Owner ) );
		player.SetWeapon( getwep[1].tointeger(), ( player.GetAmmoAtSlot( GetSlotFromWeapon( player.Weapon ) ) + pickup[ picky.ID ].Quatity ) );
		
		mysql_query( mysql, "DELETE FROM Pickup WHERE UID = '" + pickup[ picky.ID ].UID + "'" );
		pickup[ picky.ID ].Pickup.Remove();
		pickup.rawdelete( picky.ID );
	}

	else if( pickup[ picky.ID ].Type == "bank" )
	{
		playa[ player.ID ].BankCash += 1;
		pickup[ picky.ID ].Pickup.Remove();
		MsgPlr( 4, player, Lang.BankPickup, pickup[ picky.ID ].Quatity, ( playa[ player.ID ].BankCash*5000 ) );
		MsgPlr( 4, player, Lang.BankPickup2 );
		
		pickup.rawdelete( picky.ID );
	}

	else if( pickup[ picky.ID ].Type == "deaddrop" )
	{
		MsgPlr( 3, player, Lang.PickupHeader, GetIngameTag( mysqldb.GetNameFromID( pickup[ picky.ID ].Owner ) ) );

		foreach( index, value in pickup[ picky.ID ].Quatity )
		{
			MsgPlr( 3, player, Lang.PickList, index, GiveItemTypeToName( value.Type, value.ID ), value.Quatity );
		}

		MsgPlr( 3, player, Lang.PickAlert );
	}
	
	else if( pickup[ picky.ID ].Type == "PoliceDutyPoint" )
	{
		if( player.Vehicle ) return;

		if( playa[ player.ID ].Job.JobID >= 3 ) return SendDataToClient( 9200, "", player );	
		if( playa[ player.ID ].Job.JobID == 0 ) return SendDataToClient( 9100, "", player );		
		else return MsgPlr( 2, player, Lang.AlreadyInJob );
	}

	else if( pickup[ picky.ID ].Type == "EMSDutyPoint" )
	{
		if( player.Vehicle ) return;

		if( playa[ player.ID ].Job.JobID == 2 ) return SendDataToClient( 9200, "", player );	
		if( playa[ player.ID ].Job.JobID == 0 ) return SendDataToClient( 9500, "", player );		
		else return MsgPlr( 2, player, Lang.AlreadyInJob );
	}

	else if( pickup[ picky.ID ].Type == "TruckerDuty" )
	{
		if( player.Vehicle ) return;

		if( playa[ player.ID ].Job.JobID == 1 ) return SendDataToClient( 9200, "", player );	
		if( playa[ player.ID ].Job.JobID == 0 ) return SendDataToClient( 9700, "", player );		
		else return MsgPlr( 2, player, Lang.AlreadyInJob );
	}

	if( pickup[ picky.ID ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( pickup[ picky.ID ].Owner, ":" );

		if( !player.Vehicle ) SendDataToClient( 11000, pickup[ picky.ID ].Type + ";Value: $" + pickup[ picky.ID ].Quatity + ";Group Owner: " + getname[1], player );
	}

	if( pickup[ picky.ID ].Model == 407 )
	{
		local getname = split( pickup[ picky.ID ].Owner.tostring(), ":" );

		if( !player.Vehicle ) SendDataToClient( 11000, pickup[ picky.ID ].Type + ";Value: $" + pickup[ picky.ID ].Quatity + "; ", player );
	}

	if( pickup[ picky.ID ].Model == 406 )
	{
		local getname = split( pickup[ picky.ID ].Owner.tostring(), ":" );

		if( !player.Vehicle ) SendDataToClient( 11000, pickup[ picky.ID ].Type + ";Value: $" + pickup[ picky.ID ].Quatity + ";Owner: " + mysqldb.GetNameFromID( pickup[ picky.ID ].Owner ), player );
	}

}

function GiveItemTypeToName( name, id )
{
	switch( name )
	{
		case "Item": return GetItemNameByID( id );

		case "Weapon": return GetCustomWeaponName( id );

		case "Cash": return "Cash";

		default: return "Unknown";
	}
}

function EnterInt( id , player )
{
	switch( id )
	{
		case 1: player.Pos = Vector( 979.016, -1028.94, 2003.35 ); break;
		case 3: player.Pos = Vector( -402.055, -867.254, 2020.6 ); break;
		case 2: player.Pos = Vector(-2205.66, -214.661, 2059.19 ); break;
		case 4: player.Pos = Vector( 448.507, 144.476, 1005 ); break;
		default: return;
	}
}

function Buyhouse( string, player )		
{
	if( playa[ player.ID ].House == null ) return;
	
	if( pickup[ playa[ player.ID ].House ].Owner != 100000 ) return;
	
	local cash = split( string, "$" );
	if( cash[0].tointeger() > playa[ player.ID ].Cash )
	{
		if( playa[ player.ID ].Bank == false ) MsgPlr( 2, player, Lang.NotEnoughHouse, cash[0] );
		else if( cash[0].tointeger() > playa[ player.ID ].Bank ) MsgPlr( 2, player, Lang.NotEnoughHouse, cash[0] );
		else
		{
			MsgPlr( 3, player, Lang.HouseBrough );
			playa[ player.ID ].DecBank( player, cash[0].tointeger() );
			pickup[ playa[ player.ID ].House ].Owner = playa[ player.ID ].ID;
			pickup[ playa[ player.ID ].House ].Pickup.Remove();
			pickup[ playa[ player.ID ].House ].Pickup = CreatePickup( pickup[ playa[ player.ID ].House ].Model = 406, pickup[ playa[ player.ID ].House ].World, 0, pickup[ playa[ player.ID ].House ].Pos, 255, true );
		
			SavePickup( pickup[ playa[ player.ID ].House ] );
		}
	}

	else
	{
		MsgPlr( 3, player, Lang.HouseBrough );
		playa[ player.ID ].DecCash( player, cash[0].tointeger() );
		pickup[ playa[ player.ID ].House ].Owner = playa[ player.ID ].ID;
		pickup[ playa[ player.ID ].House ].Pickup.Remove();
		pickup[ playa[ player.ID ].House ].Pickup = CreatePickup( pickup[ playa[ player.ID ].House ].Model = 406, pickup[ playa[ player.ID ].House ].World, 0, pickup[ playa[ player.ID ].House ].Pos, 255, true );
	
		SavePickup( pickup[ playa[ player.ID ].House ] );
	}
}

function GetPickupIndexFromType( type )
{
	foreach( index, value in pickup )
	{
		if( value.Type.find( type ) >= 0 ) return index;
	}
}
	
home <- [ "-951.514, 136.408, 9.30485",
"-965.582, 127.573, 9.23838",
"-965.088, 111.298, 9.23144",
"-965.482, 104.752, 9.26095",
"-949.106, 87.1243, 10.2626",
"-955.012, 88.0563, 10.2209",
"-960.772, 87.9244, 10.2142",
"-967.355, 87.6965, 10.1868",
"-979.62, 87.8402, 10.0828",
"-985.662, 87.8604, 10.1189",
"-992.941, 87.7579, 10.1406",
"-1006.1, 88.2316, 10.1502",
"-1000.78, 78.9453, 10.5006",
"-981.443, 103.95, 9.31521",
"-994.202, 104.095, 9.38553",
"-994.453, 123.441, 9.28347",
"-998.414, 142.814, 9.26836",
"-992.463, 142.695, 9.24512",
"-985.181, 142.759, 9.21605",
"-979.081, 142.21, 9.19351",
"-981.665, 132.082, 9.26537" ]
	
function insertdick()
{
	foreach( id, kiki in home )
	{
		local a = "Haiti Hut #" + id;
		mysql_query( mysql, "INSERT INTO Pickup ( Model, Type, Quatity, World, Pos, Owner, Share, Locked, Interior, Passworded, UID ) VALUES ( '407', '" + a + "', '100000', '0', '" + kiki + "', 'N/A', 'N/A', 'false', '1', 'false', '" + MD5( time()+kiki ) + "' )" );
	}
}

function DeleteOldPickup()
{
	_Timer.Create( this, function()
	{
		foreach( index, value in pickup )
		{
			if( value.rawin( "Timeout" ) )
			{
				if( ( time() - value.Timeout ) > 300 )
				{
					mysql_query( mysql, "DELETE FROM Pickup WHERE UID = '" + value.UID + "'" );
					pickup[ index ].Pickup.Remove();
					pickup.rawdelete( index );
				}
			}
		}
	}, 1000, 0 );
}

function DropVictimCash( player )
{
	if( playa[ player.ID ].Cash < 10 ) return;

	local model = 337, plrworld = player.World, plrname = playa[ player.ID ].ID, plrpos = Vector( ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
	local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );
	local getDiscount = ( ( playa[ player.ID ].Cash/100 ) * 5 ), getCash = getDiscount;

	pickup.rawset( pickupinstance.ID, 
	{
		Model = model, 
		Type = "cash",
		Quatity = getCash,
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
		GanngHouse = null,
		Storage1 = "",
		Pickup = pickupinstance,
		Timeout = time(),
	});

	playa[ player.ID ].DecCash( player, getCash );

	MsgPlr( 2, player, Lang.DropCashKilled, getCash ); 
}

function DropPlayerItem( player )
{
	local model = 507, plrworld = player.World, plrname = playa[ player.ID ].ID, plrpos = Vector( ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
	local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );
	local getDiscount = ( ( playa[ player.ID ].Cash/100 ) * 15 ), getCash = ( playa[ player.ID ].Cash - getDiscount );
	local getCount = 0;

	pickup.rawset( pickupinstance.ID, 
	{
		Model = model, 
		Type = "deaddrop",
		Quatity = {},
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
		GanngHouse = null,
		Storage1 = "",
		Pickup = pickupinstance,
		Timeout = time(),
	});

	foreach( index, value in playa[ player.ID ].Items )
	{
		if( !GetAllowedItemDrop( index ) ) continue;

		if( value.Quatity.tointeger() > 0 )
		{
			pickup[ pickupinstance.ID ].Quatity.rawset( getCount++, 
			{
				Type = "Item",
				ID = index.tointeger(),
				Quatity = value.Quatity.tointeger(),
			});

			DecQuatity( player, index, value.Quatity.tointeger() );
		}
	}
	
	for( local i = 0, weapon; i < 8; i++ )
	{
		weapon = player.GetWeaponAtSlot( i );

		if ( weapon > 0 && weapon != 16 )
		{
			if( player.GetAmmoAtSlot( i ) < 10 ) 
			{
				pickup[ pickupinstance.ID ].Quatity.rawset( getCount++, 
				{
					Type = "Weapon",
					ID = weapon.tointeger(),
					Quatity = player.GetAmmoAtSlot( i ),
				});

				player.SetWeapon( weapon, 0 );
			}

			else 
			{
				local getDiscount = ( ( player.GetAmmoAtSlot( i )/100 ) * 50 ), getAmmo = getDiscount;
				local getAmmo1 = ( player.GetAmmoAtSlot( i ) - getAmmo );

				pickup[ pickupinstance.ID ].Quatity.rawset( getCount++, 
				{
					Type = "Weapon",
					ID = weapon.tointeger(),
					Quatity = getAmmo1,
				});

				player.SetWeapon( weapon, getAmmo1 );
		   	}
		}
	}

	local getDiscount = ( ( playa[ player.ID ].Cash/100 ) * 5 ), getCash = getDiscount;

	if( getCash > 1 )
	{
		pickup[ pickupinstance.ID ].Quatity.rawset( getCount++, 
		{
			Type = "Cash",
			ID = 0,
			Quatity = getCash,
		});	

		playa[ player.ID ].DecCash( player, getCash );
	}
}