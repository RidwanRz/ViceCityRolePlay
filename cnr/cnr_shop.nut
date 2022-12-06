function BuyWeapon( player, string )
{
	local cash = split( string, ":" );
	if( playa[ player.ID ].XPLevel < 1 ) SendDataToClient( 1010, "You need at least level 1 to buy this weapon.", player );
	else if( cash[1].tointeger() > playa[ player.ID ].Cash )
	{
		if( playa[ player.ID ].Bank == false ) SendDataToClient( 1010, "You dont have enough cash.", player );
		else if( cash[1].tointeger() > playa[ player.ID ].Bank ) SendDataToClient( 1010, "You dont have enough cash.", player );
		else
		{
			if( cash[0] == "bomb" )
			{
				if( playa[ player.ID ].XPLevel < 2 ) SendDataToClient( 1010, "You need at least level 2 to buy this bomb.", player );
				else
				{
					SendDataToClient( 1011, "You purchased Bomb.", player );
					
					playa[ player.ID ].DecBank( player, cash[1].tointeger() );
					AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
					AddQuatity( player, 3, "1" );
				}
			}
			
			else
			{
				player.SetWeapon( GetCustomWeaponID( cash[0] ), player.GetAmmoAtSlot( cash[2].tointeger() ) + 200  );
				playa[ player.ID ].DecBank( player, cash[1].tointeger() );
				AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
				
				SendDataToClient( 1011, "You purchased " + GetCustomWeaponName( GetCustomWeaponID( cash[0] ) ), player );
				print( cash[0] + " " +  GetCustomWeaponID( cash[0] ) + " " + GetCustomWeaponName( GetCustomWeaponID( cash[0] ) ) );
			}
		}
	}

	else
	{
		if( cash[0] == "bomb" )
		{
			if( playa[ player.ID ].XPLevel < 2 ) SendDataToClient( 1010, "You need at least level 2 to buy this bomb.", player );
			else
			{
				SendDataToClient( 1011, "You purchased Bomb.", player );
				
				playa[ player.ID ].DecCash( player, cash[1].tointeger() );
				AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
				AddQuatity( player, 3, "1" );
			}
		}
		
		else
		{
			player.SetWeapon( GetCustomWeaponID( cash[0] ), player.GetAmmoAtSlot( cash[2].tointeger() ) + 200  );
			playa[ player.ID ].DecBank( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
				
			SendDataToClient( 1011, "You purchased " + GetCustomWeaponName( GetCustomWeaponID( cash[0] ) ), player );
		}
	}
}

function BuyTools( player, string )
{
	local cash = split( string, ":" );
	if( cash[1].tointeger() > playa[ player.ID ].Cash )
	{
		if( playa[ player.ID ].Bank == false ) SendDataToClient( 5000, "You dont have enough cash.", player );
		else if( cash[1].tointeger() > playa[ player.ID ].Bank ) SendDataToClient( 5000, "You dont have enough cash.", player );
		else
		{
			SendDataToClient( 5001, "You purchased " + GetCustomWeaponName( GetWeaponID( cash[0] ) ), player );

			player.SetWeapon( GetWeaponID( cash[0] ), player.GetAmmoAtSlot( cash[2].tointeger() ) + 200  );
			playa[ player.ID ].DecBank( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );		
		}
	}

	else
	{
		SendDataToClient( 5001, "You purchased " + GetCustomWeaponName( GetWeaponID( cash[0] ) ), player );

		player.SetWeapon( GetWeaponID( cash[0] ), player.GetAmmoAtSlot( cash[2].tointeger() ) + 200  );
		playa[ player.ID ].DecCash( player, cash[1].tointeger() );
		AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );		
	}
}

function BuyItem( player, string, code = 5011, errorcode = 5010 )
{
	local cash = split( string, ":" );
	if( cash[1].tointeger() > playa[ player.ID ].Cash )
	{
		if( playa[ player.ID ].Bank == false ) SendDataToClient( errorcode, "You dont have enough cash.", player );
		else if( cash[1].tointeger() > playa[ player.ID ].Bank ) SendDataToClient( errorcode, "You dont have enough cash.", player );
		else
		{
			SendDataToClient( code, "You purchased " + GetItemNameByID( cash[0].tointeger() ), player );

			AddQuatity( player, cash[0].tointeger(), "1");
			playa[ player.ID ].DecBank( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
		}
	}

	else
	{
		SendDataToClient( code, "You purchased " + GetItemNameByID( cash[0].tointeger() ), player );

		AddQuatity( player, cash[0].tointeger(), "1");
		playa[ player.ID ].DecCash( player, cash[1].tointeger() );
		AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
	}
}

function BuyVehicle( string, player )
{

	local cash = split( string, ":" );
	if( cash[1].tointeger() > playa[ player.ID ].Cash )
	{
		if( getPlayerVehicleCount( playa[ player.ID ].ID ) ) SendDataToClient( 5020, "You cannot buy more than 5 vehicles.", player );
		else if( playa[ player.ID ].Bank == false ) SendDataToClient( 5020, "You dont have enough cash.", player );
		else if( cash[1].tointeger() > playa[ player.ID ].Bank ) SendDataToClient( 5020, "You dont have enough cash.", player );
		else
		{
			player.World = 0;
			playa[ player.ID ].DecBank( player, cash[1].tointeger() );
			local instance = CreateVehicle( GetVehicleModelFromName( cash[0] ), 1, DefaultVehicleSpawn( GetVehicleType( GetVehicleModelFromName( cash[0] ) ) ).Pos, DefaultVehicleSpawn( GetVehicleType( GetVehicleModelFromName( cash[0] ) ) ).Angle, 0, 0 ),
			
			AddID = instance.ID,
			GenerateUID = playa[ player.ID ].Password +""+ time() , st = split( string, ":" );
			vehicle[ AddID ] <- {};
			vehicle[ AddID ].Model <- GetVehicleModelFromName( cash[0] );
			vehicle[ AddID ].Owner <- playa[ player.ID ].ID;
			vehicle[ AddID ].Share <- {};
			vehicle[ AddID ].PosString <- DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model ) ).Pos.x + ", " + DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model  )).Pos.y + ", " + DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model )).Pos.z;
			vehicle[ AddID ].Angle <- DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model ) ).Angle;
			vehicle[ AddID ].Locked <- false;
			vehicle[ AddID ].Col1 <- 0;
			vehicle[ AddID ].Col2 <- 0;
			vehicle[ AddID ].UID <- MD5( GenerateUID );
			vehicle[ AddID ].UID2 <- "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9;
			vehicle[ AddID ].Price <- cash[1].tointeger();
			vehicle[ AddID ].vehicle <- instance;
			player.Vehicle = vehicle[ AddID ].vehicle;
			mysql_query( mysql, "insert into vehicles ( Model, Owner, Share, Pos, Angle, Locked, Col1, Col2, UID, UID2, World, Price ) VALUES ( '" + vehicle[ AddID ].Model + "', '" + playa[ player.ID ].ID + "', 'N/A', '" + vehicle[ AddID ].PosString + "', '" + vehicle[ AddID ].Angle + "', 'false', '0', '0', '" + vehicle[ AddID ].UID + "', '" + vehicle[ AddID ].UID2 + "', '0', '" + cash[1].tointeger() + "' )" );
			MsgPlr( 3, player, Lang.VehicleBuyed, GetVehicleNameFromModel( vehicle[ AddID ].Model ) );
			SendDataToClient( 5022, null, player );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );

			print( "\r[Purchase] " + player.Name + "(ID " + playa[ player.ID ].ID + ") has purchased vehicle " + GetVehicleNameFromModel( vehicle[ AddID ].Model ) + "(ID " + vehicle[ AddID ].UID2 + ") using bank balance $" + cash[1].tointeger() );
		//	Arc( player, 6 );
		}
	}

	else
	{
		player.World = 0;
		playa[ player.ID ].DecCash( player, cash[1].tointeger() );
		local instance = CreateVehicle( GetVehicleModelFromName( cash[0] ), 1, DefaultVehicleSpawn( GetVehicleType( GetVehicleModelFromName( cash[0] ) ) ).Pos, DefaultVehicleSpawn( GetVehicleType( GetVehicleModelFromName( cash[0] ) ) ).Angle, 0, 0 );
		local AddID = instance.ID,GenerateUID = playa[ player.ID ].Password +"" + time() , st = split( string, ":" );
		
		vehicle[ AddID ] <- {};
		vehicle[ AddID ].Model <- GetVehicleModelFromName( cash[0] );
		vehicle[ AddID ].Owner <- playa[ player.ID ].ID;
		vehicle[ AddID ].Share <- {};
		vehicle[ AddID ].PosString <- DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model ) ).Pos.x + ", " + DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model  )).Pos.y + ", " + DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model )).Pos.z;
		vehicle[ AddID ].Angle <- DefaultVehicleSpawn( GetVehicleType( vehicle[ AddID ].Model ) ).Angle;
		vehicle[ AddID ].Locked <- false;
		vehicle[ AddID ].Col1 <- 0;
		vehicle[ AddID ].Col2 <- 0;
		vehicle[ AddID ].UID <- MD5( GenerateUID );
		vehicle[ AddID ].UID2 <- "VC-" + ( vehicle.len()+1 );
		vehicle[ AddID ].Price <- cash[1].tointeger();
		vehicle[ AddID ].vehicle <- instance;
		mysql_query( mysql, "insert into vehicles ( Model, Owner, Share, Pos, Angle, Locked, Col1, Col2, UID, UID2, World, Price ) VALUES ( '" + vehicle[ AddID ].Model + "', '" + playa[ player.ID ].ID + "', 'N/A', '" + vehicle[ AddID ].PosString + "', '" + vehicle[ AddID ].Angle + "', 'false', '0', '0', '" + vehicle[ AddID ].UID + "', '" + vehicle[ AddID ].UID2 + "', '0', '" + cash[1].tointeger() + "' )" );
		
		MsgPlr( 3, player, Lang.VehicleBuyed, GetVehicleNameFromModel( vehicle[ AddID ].Model ) );
		SendDataToClient( 5022, null, player );

		player.Vehicle = vehicle[ AddID ].vehicle;

		print( "\r[Purchase] " + player.Name + "(ID " + playa[ player.ID ].ID + ") has purchased vehicle " + GetVehicleNameFromModel( vehicle[ AddID ].Model ) + "(ID " + vehicle[ AddID ].UID2 + ") using cash balance $" + cash[1].tointeger() );

		AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
	}

}



function BuyBMWeapon( player, string )
{
	local cash = split( string, ":" );
	if( playa[ player.ID ].XPLevel < 1 ) SendDataToClient( 6210, "You need at least level 1 to buy this weapon.", player );
	else if( cash[1].tointeger() > playa[ player.ID ].Cash ) SendDataToClient( 6210, "You dont have enough cash.", player );
	else
	{
		switch( cash[0] )
		{
			case "bomb":
			SendDataToClient( 6212, "You purchased Bomb.", player );
					
			playa[ player.ID ].DecCash( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
			AddQuatity( player, 3, "1" );
			break;

			case "bulldog":
			SendDataToClient( 6212, "You purchased " + GetCustomWeaponName( 103 ), player );
				
			playa[ player.ID ].DecCash( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
			player.SetWeapon( 103, player.GetAmmoAtSlot( cash[2].tointeger() ) + 200  );
			break;

			case "rpg":
			if( playa[ player.ID ].XPLevel < 5 ) SendDataToClient( 6210, "You need at least level 5 to buy this weapon.", player );
			else 
			{
				player.SetWeapon( 30, player.GetAmmoAtSlot( cash[2].tointeger() ) + 2 );
				playa[ player.ID ].DecCash( player, cash[1].tointeger() );
				AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
			
				SendDataToClient( 6212, "You purchased " + GetCustomWeaponName( 30 ), player );
			}
			break;

			default:
			local getslot = player.GetAmmoAtSlot( cash[2].tointeger() );
			switch( cash[2].tointeger() )
			{
				case 2:
				getslot += 15;
				break;

				case 7:
				switch( GetCustomWeaponID( cash[0] ) )
				{
					default: 
					getslot += 200;
					break;
				}
				break;

				default:
				getslot += 200;
				break;
			}

			player.SetWeapon( GetCustomWeaponID( cash[0] ), getslot );
			playa[ player.ID ].DecCash( player, cash[1].tointeger() );
			AddIncome( playa[ player.ID ].Area, cash[1].tointeger() );
			
			SendDataToClient( 6212, "You purchased " + GetCustomWeaponName( GetCustomWeaponID( cash[0] ) ), player );
			break;
		}
	}
}

/* 
	"ID":
	{
		"Stock": "122",
		"Price": "500",
	}
*/

function GetShopCatalogue( player )
{
	if( playa[ player.ID ].Area )
	{
		if( area[ playa[ player.ID ].Area ].Items.len() > 0 )
		{
			SendDataToClient( 9800, "", player );

			foreach( index, value in area[ playa[ player.ID ].Area ].Items )
			{
				SendDataToClient( 9804, GetItemNameByID( index.tointeger() ), player );
			}
		}
	}
}

function GetClothShopCatalogue( player )
{
	if( playa[ player.ID ].Area )
	{
		if( area[ playa[ player.ID ].Area ].Items.len() > 0 )
		{
			SendDataToClient( 9900, "", player );

			foreach( index, value in area[ playa[ player.ID ].Area ].Items )
			{
				SendDataToClient( 9904, GetItemNameByID( index.tointeger(), GetSkinNameByItemID( index.tointeger() ) ), player );
			}
		}
	}
}

function BuySelectedItem( player, item )
{
	if( playa[ player.ID ].Area )
	{
		if( area[ playa[ player.ID ].Area ].Items.rawin( GetItemIDByName( item ).tostring() ) )
		{
			local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ];

			if( playa[ player.ID ].Cash >= getitem.Price.tointeger() )
			{
				switch( GetItemIDByName( item ) )
				{
					case 1:
					case 3:
					case 4:
					if( getitem.Stock.tointeger() > 0 )
					{
						if( GetItemQuatity( player, GetItemIDByName( item ) ) == 0 )
						{
							AddQuatity( player, GetItemIDByName( item ), "1" );

							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
						
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9801, "You already have this item.", player );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;

					case 2:
					if( getitem.Stock.tointeger() > 0 )
					{
						if( playa[ player.ID ].Phone == 0 )
						{
							local generatePhone = ( rand() % 9 ) + "" + ( rand() % 9 ) + "" + ( rand() % 9 ) + "" + ( rand() % 9 ) + "" + ( rand() % 9 );

							AddQuatity( player, GetItemIDByName( item ), "2" );

							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
						
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							playa[ player.ID ].Phone = generatePhone.tointeger();

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9801, "You already have this item.", player );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;

					case 5:
					case 16:
					case 17:
					case 18:
					case 19:
					case 20:
					case 21:
					case 22:
					case 23:
					if( getitem.Stock.tointeger() > 0 )
					{
						if( GetItemQuatity( player, GetItemIDByName( item ) ) <= 8 )
						{
							AddQuatity( player, GetItemIDByName( item ), "1" );

							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
						
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9801, "You cannot purchase this item as you would exceed item carry limit.", player );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;

					case 6:
					if( getitem.Stock.tointeger() > 0 )
					{
						if( GetItemQuatity( player, GetItemIDByName( item ) ) <= 5 )
						{
							AddQuatity( player, GetItemIDByName( item ), "1" );

							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
						
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9801, "You cannot purchase this item as you would exceed item carry limit.", player );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;

					case 7:
					case 8:
					case 9:
					case 10:
					case 11:
					case 12:
					case 13:
					case 14:
					if( getitem.Stock.tointeger() > 0 )
					{
						playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

						SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

						area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

						SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
						
						area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

						player.SetWeapon( GetWeaponIDByItem( GetItemIDByName( item ) ), ( player.GetAmmoAtSlot( GetSlotAtWeapon( GetWeaponIDByItem( GetItemIDByName( item ) ) ) ) + 50 ) );

						SaveArea( area[ playa[ player.ID ].Area ] );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;

					case 15:
					if( getitem.Stock.tointeger() > 0 )
					{
						if( player.Armour < 99 )
						{
							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9805, "You bought " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9803, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock player );
							
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							player.Armour = 100;

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9801, "You already have full armour.", player );
					}
					else SendDataToClient( 9801, "This item is currently out of stock.", player );
					break;


				}
			}
			else SendDataToClient( 9801, "You need $" + ( getitem.Price.tointeger() - playa[ player.ID ].Cash ) + " to buy this item.", player );
		}
		else SendDataToClient( 9801, "This item does not exist.", player );
	}
	else SendDataToClient( 9802, "", player );
}

function UpdateItemInfo( player, item )
{
	if( area[ playa[ player.ID ].Area ].Items.rawin( GetItemIDByName( item ).tostring() ) )
	{
		local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ];

		SendDataToClient( 9803, "Price: $" + getitem.Price + " Stock: " + getitem.Stock, player );
	}
}

function UpdateSkinInfo( player, item )
{
	if( area[ playa[ player.ID ].Area ].Items.rawin( GetItemIDByName( item ).tostring() ) )
	{
		local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ];

		SendDataToClient( 9903, "Price: $" + getitem.Price + " Stock: " + getitem.Stock + ";" + GetSkinNameByItemID( GetItemIDByName( item ) ), player );
	}
}

function BuySelectedSkin( player, item )
{
	
	if( playa[ player.ID ].Area )
	{
		if( area[ playa[ player.ID ].Area ].Items.rawin( GetItemIDByName( item ).tostring() ) )
		{
			local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ];

			if( playa[ player.ID ].Job.JobID < 2 )
			{
				if( playa[ player.ID ].Cash >= getitem.Price.tointeger() )
				{
					if( getitem.Stock.tointeger() > 0 )
					{
						if( GetItemQuatity( player, GetItemIDByName( item ) ) == 0 )
						{
							player.Skin = GetSkinNameByItemID( GetItemIDByName( item ) );

							playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

							SendDataToClient( 9905, "You bought skin " + item + " for $" + getitem.Price + ".", player );

							area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() - 1 );

							SendDataToClient( 9903, "Price: $" + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price + " Stock: " + area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock + ";" +  GetSkinNameByItemID( GetItemIDByName( item ) ), player );
							
							area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

							SaveArea( area[ playa[ player.ID ].Area ] );
						}
						else SendDataToClient( 9901, "You already have this item.", player );
					}
					else SendDataToClient( 9901, "This item is currently out of stock.", player );
				}
				else SendDataToClient( 9901, "You need $" + ( getitem.Price.tointeger() - playa[ player.ID ].Cash ) + " to buy this item.", player );
			}
			else SendDataToClient( 9901, "You cannot buy skin while on duty.", player );
		}
		else SendDataToClient( 9901, "This item does not exist.", player );
	}
	else SendDataToClient( 9902, "", player );
}



