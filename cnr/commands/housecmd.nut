function onHouseCommand( player, cmd, text )
{
	switch( cmd.tolower() )
	{
		case "buyhouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( pickup[ playa[ player.ID ].House ].Owner != "100000" ) MsgPlr( 2, player, Lang.HouseNotForSale );
			else
			{
				BuyHouse( player );
			}
		}
		break;
				
		case "house":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
            MsgPlr( 3, player, Lang.Breakline );

			if( pickup[ playa[ player.ID ].House ].Owner != "100000" ) 
			{
				if( pickup[ playa[ player.ID ].House ].Owner == playa[ player.ID ].ID.tostring() ) MsgPlr( 7, player, Lang.HouseOwned );
				else 
				{
					if( pickup[ playa[ player.ID ].House ].Owner.find( "Group" ) >= 0 )
					{
						local sp = split( pickup[ playa[ player.ID ].House ].Owner, ":" );

						MsgPlr( 7, player, Lang.HouseInfo, gangv2[ sp[1] ].Name );
					}
					else MsgPlr( 7, player, Lang.HouseInfo, mysqldb.GetNameFromID( pickup[ playa[ player.ID ].House ].Owner ) );
				}
			}
			else MsgPlr( 7, player , Lang.HouseForSale, pickup[ playa[ player.ID ].House ].Quatity );
				
			if( VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) )
			{
				if( GetHouseSharerName( pickup[ playa[ player.ID ].House ].Share ) != "None" ) MsgPlr( 7, player, Lang.HouseInfo3, GetHouseSharerName( pickup[ playa[ player.ID ].House ].Share ) )
				MsgPlr( 7, player, Lang.HouseInfo1, pickup[ playa[ player.ID ].House ].Type );         
				MsgPlr( 7, player, Lang.HouseInfo2, pickup[ playa[ player.ID ].House ].Welcome );                
			}

            MsgPlr( 3, player, Lang.Breakline );
		}
		break;
		
		case "setwelcomemessage":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else if ( !text ) MsgPlr( 2, player, Lang.HWelSyntax );
			else
			{
				pickup[ playa[ player.ID ].House ].Welcome = text;
				MsgPlr( 3, player, Lang.HWelSucess, text );
				
				SavePickup( pickup[ playa[ player.ID ].House ] );
			}
		}
		break;
		
		case "sharehouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if ( !text ) MsgPlr( 2, player, Lang.ShareHouseSyntax );
		else
		{
			local plr = FindPlayer( text );
			if( pickup[ playa[ player.ID ].House ].Owner.find( "Group:" ) >= 0 ) MsgPlr( 2, player, Lang.NotInHouse );
			else if( pickup[ playa[ player.ID ].House ].Owner != playa[ player.ID ].ID.tostring() ) MsgPlr( 2, player, Lang.HouseNotOwner );
			else if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) >= 5 ) MsgPlr( 2, player, Lang.NotNearPlr );
			else if ( pickup[ playa[ player.ID ].House ].Share.rawin( playa[ plr.ID ].ID.tostring() ) ) MsgPlr( 2, player, Lang.ShareHouseAlreadyShared );
			else
			{
				pickup[ playa[ player.ID ].House ].Share.rawset( playa[ plr.ID ].ID.tostring(),
				{
					Time = time().tostring(),
				});
			
				MsgPlr( 3, player, Lang.HouseShare, pickup[ playa[ player.ID ].House ].Type, plr.Name );
				MsgPlr( 7, plr, Lang.HouseShare1, player.Name, pickup[ playa[ player.ID ].House ].Type );
				
				SavePickup( pickup[ playa[ player.ID ].House ] );
			}
		}
		break;
		
		case "delsharehouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if ( !text ) MsgPlr( 2, player, Lang.DelShareSyntax );
		else
		{
			local plr = FindPlayer( text );
			if( pickup[ playa[ player.ID ].House ].Owner.find( "Group:" ) >= 0 ) MsgPlr( 2, player, Lang.NotInHouse );
			else if( pickup[ playa[ player.ID ].House ].Owner != playa[ player.ID ].ID.tostring() ) MsgPlr( 2, player, Lang.HouseNotOwner );
			else
			{
				local plr = FindPlayer( text );
				if( plr )
				{
					if( !pickup[ playa[ player.ID ].House ].Share.rawin( playa[ plr.ID ].ID.tostring() ) ) MsgPlr( 2, player, Lang.DelShareNotInShareList );	
					else
					{
						pickup[ playa[ player.ID ].House ].Share.rawdelete( playa[ plr.ID ].ID.tostring() );
						
						MsgPlr( 3, player, Lang.DelShareSucess, pickup[ playa[ player.ID ].House ].Type, plr.Name );
						MsgPlr( 3, plr, Lang.DelShareSucess1, player.Name, pickup[ ID ].Type );
					
						SavePickup( pickup[ playa[ player.ID ].House ] );
					}
				}

				else
				{
					local getID = mysqldb.GetSimilarNameToID( text );
					if( !pickup[ playa[ player.ID ].House ].Share.rawin( getID.tostring() ) ) MsgPlr( 2, player, Lang.DelShareNotInShareList );	
					else
					{
						pickup[ playa[ player.ID ].House ].Share.rawdelete( getID.tostring() );
							
						MsgPlr( 3, player, Lang.DelShareSucess, pickup[ playa[ player.ID ].House ].Type, mysqldb.GetNameFromID( getID ) );
						
						SavePickup( pickup[ playa[ player.ID ].House ] );
					}
				}
			}
		}
		break;
		
		case "storage":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else
			{
				local getResult = null;

				foreach( index, value in pickup[ playa[ player.ID ].House ].Storage1 )
				{
					if( value.Quatity.tointeger() < 1 ) continue;
						
					if( getResult ) getResult = format( Lang.WepStorage[ playa[ player.ID ].Lang ], getResult, GetCustomWeaponName( index.tointeger() ), value.Quatity );
					else getResult = format( Lang.WepStorage1[ playa[ player.ID ].Lang ], GetCustomWeaponName( index.tointeger() ), value.Quatity );
				}
					
				foreach( index, value in pickup[ playa[ player.ID ].House ].Storage )
				{
					if( value.Quatity.tointeger() < 1 ) continue;
						
					if( getResult ) getResult = format( Lang.WepStorage[ playa[ player.ID ].Lang ], getResult, GetItemNameByID( index.tointeger() ), value.Quatity );
					else getResult = format( Lang.WepStorage1[ playa[ player.ID ].Lang ], GetItemNameByID( index.tointeger() ), value.Quatity );
				}
					
				if( getResult )	MsgPlr( 7, player, Lang.WepStorage3, getResult );
				else MsgPlr( 2, player, Lang.WepStorageNo );
			}
		}
		break;

		case "store":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( !text ) MsgPlr( 2, player, Lang.StorewepSyntax );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else
			{
				local quatity = GetTok( text, " ", 1 ), item = GetTok( text, " ", 2, NumTok( text, " " ) );
				if( !IsNum( quatity ) ) MsgPlr( 2, player, Lang.QuatityNotNum );
				else if( quatity.tointeger() < 1 ) MsgPlr( 2, player, Lang.GiveCashInvalidAmount );
				else if( !GetRobItem( item ) ) MsgPlr( 2, player, Lang.InvalidItemx2 );
				else 
				{
					if( GetRobItem( item ) == "Weapon" )
					{
						local getwep = null;
						for( local i = 0, weapon; i < 8; i++ )
						{
							weapon = player.GetWeaponAtSlot( i );

							if( weapon > 0 && weapon != 16 )
							{
								if( weapon == GetWeaponID( item ) ) getwep = i;
							}
						}

						if( getwep )
						{
							if( player.GetAmmoAtSlot( getwep ) >= quatity.tointeger() )
							{
								if( player.Weapon == player.GetWeaponAtSlot( getwep ) )
								{
									local getammo = quatity.tointeger();

									player.SetWeapon( player.GetWeaponAtSlot( getwep ), ( player.GetAmmoAtSlot( getwep ) - getammo ) );
										
									if( pickup[ playa[ player.ID ].House ].Storage1.rawin( player.GetWeaponAtSlot( getwep ).tostring() ) )
									{
										if( ( pickup[ playa[ player.ID ].House ].Storage1[ player.GetWeaponAtSlot( getwep ).tostring() ].Quatity.tointeger() + getammo.tointeger() ) >= GetHouseAmmoLimit( playa[ player.ID ].House ) ) return MsgPlr( 2, player, Lang.AmmoLimit, GetHouseAmmoLimit( playa[ player.ID ].House ) );
										else pickup[ playa[ player.ID ].House ].Storage1[ player.GetWeaponAtSlot( getwep ).tostring() ].Quatity = ( pickup[ playa[ player.ID ].House ].Storage1[ player.GetWeaponAtSlot( getwep ).tostring() ].Quatity.tointeger() + getammo.tointeger() ).tostring();
									}
										
									else
									{
										pickup[ playa[ player.ID ].House ].Storage1.rawset( player.GetWeaponAtSlot( getwep ).tostring(),
										{
											Quatity = getammo.tostring(),
										});
									}

									LocalMessage( player.Pos, "StoreItemLocal", player.Name, GetWeaponName( player.Weapon ) );

									MsgPlr( 3, player, Lang.StoreItem, GetWeaponName( player.Weapon ), getammo );

									SavePickup( pickup[ playa[ player.ID ].House ] );
								}
								else MsgPlr( 2, player, Lang.MustHoldWeapon );
							}
							else MsgPlr( 2, player, Lang.DontHaveEnoughItem );
						}
						else MsgPlr( 2, player, Lang.DontHaveSuchItem );
					}

                    else 
                    {
                        if( GetItemQuatity( player, GetItemIDByName( item ) ) >= quatity.tointeger() )
                        {
                            DecQuatity( player, GetItemIDByName( item ), quatity.tointeger() );

                            LocalMessage( player.Pos, "StoreItemLocal", player.Name, item );

                            MsgPlr( 3, player, Lang.StoreItem, item, quatity.tointeger() );

							if( pickup[ playa[ player.ID ].House ].Storage.rawin( GetItemIDByName( item ) ) )
							{
								if( ( pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity.tointeger() + quatity.tointeger() ) >= GetHouseAmmoLimit( playa[ player.ID ].House ) ) return MsgPlr( 2, player, Lang.AmmoLimit, GetHouseAmmoLimit( playa[ player.ID ].House ) );
								else pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity = ( pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity.tointeger() + quatity.tointeger() ).tostring();
							}
										
							else
							{
								pickup[ playa[ player.ID ].House ].Storage.rawset( GetItemIDByName( item ).tostring(),
								{
									Quatity = quatity.tostring(),
								});
							}

							SavePickup( pickup[ playa[ player.ID ].House ] );
                        }
                        else MsgPlr( 2, player, Lang.DontHaveEnoughItem );
					}
				}
			}
		}
		break;
		
		case "load":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( !text ) MsgPlr( 2, player, Lang.StorewepSyntax );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else
			{
				local quatity = GetTok( text, " ", 1 ), item = GetTok( text, " ", 2, NumTok( text, " " ) );
				if( !IsNum( quatity ) ) MsgPlr( 2, player, Lang.QuatityNotNum );
				else if( quatity.tointeger() < 1 ) MsgPlr( 2, player, Lang.GiveCashInvalidAmount );
				else if( !GetRobItem( item ) ) MsgPlr( 2, player, Lang.InvalidItemx2 );
				else 
				{
					if( GetRobItem( item ) == "Weapon" )
					{
						local getwep = null;

						if( pickup[ playa[ player.ID ].House ].Storage1.rawin( GetWeaponID( item ).tostring() ) )
						{
							getwep = pickup[ playa[ player.ID ].House ].Storage1[ GetWeaponID( item ).tostring() ].Quatity;
						}
						
						if( getwep )
						{
							if( getwep.tointeger() >= quatity.tointeger() )
							{
								local getammo = quatity.tointeger();
								
								player.SetWeapon( GetWeaponID( item ), ( player.GetAmmoAtSlot( GetSlotAtWeapon( GetWeaponID( item ) ) ) + getammo ) );

								if( pickup[ playa[ player.ID ].House ].Storage1.rawin( GetWeaponID( item ).tostring() ) )
								{
									pickup[ playa[ player.ID ].House ].Storage1[ GetWeaponID( item ).tostring() ].Quatity = ( pickup[ playa[ player.ID ].House ].Storage1[ GetWeaponID( item ).tostring() ].Quatity.tointeger() - getammo.tointeger() ).tostring();
								}
										
								else
								{
									pickup[ playa[ player.ID ].House ].Storage1.rawset( GetWeaponID( item ).tostring(),
									{
										Quatity = getammo.tostring(),
									});
								}

								LocalMessage( player.Pos, "LoadItemLocal", player.Name, GetWeaponName( GetWeaponID( item ) ) );

								MsgPlr( 3, player, Lang.LoadItem, GetWeaponName( GetWeaponID( item ) ), getammo );

								SavePickup( pickup[ playa[ player.ID ].House ] );
							}
							else MsgPlr( 2, player, Lang.DontHaveEnoughItemInStorage );
						}
						else MsgPlr( 2, player, Lang.DontHaveSuchItemInStorage );
					}

                    else 
                    {
						local getwep = null;

						if( pickup[ playa[ player.ID ].House ].Storage.rawin( GetItemIDByName( item ).tostring() ) )
						{
							getwep = pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity;
						}
						
						if( getwep )
						{
							if( getwep.tointeger() >= quatity.tointeger() )
							{
								AddQuatity( player, GetItemIDByName( item ), quatity.tointeger() );

								LocalMessage( player.Pos, "LoadItemLocal", player.Name, item );

								MsgPlr( 3, player, Lang.LoadItem, item, quatity.tointeger() );

								if( pickup[ playa[ player.ID ].House ].Storage.rawin( GetItemIDByName( item ).tostring() ) )
								{
									pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity = ( pickup[ playa[ player.ID ].House ].Storage[ GetItemIDByName( item ).tostring() ].Quatity.tointeger() - quatity.tointeger() ).tostring();
								}
											
								else
								{
									pickup[ playa[ player.ID ].House ].Storage.rawset( GetItemIDByName( item ).tostring(),
									{
										Quatity = quatity.tostring(),
									});
								}

								SavePickup( pickup[ playa[ player.ID ].House ] );
							}
							else MsgPlr( 2, player, Lang.DontHaveEnoughItemInStorage );
                        }
                        else MsgPlr( 2, player, Lang.DontHaveSuchItemInStorage );
					}
				}
			}
		}
		break;
		
		case "sellhouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( pickup[ playa[ player.ID ].House ].Owner.find( "Group:" ) >= 0 ) MsgPlr( 2, player, Lang.NotInHouse );
			else if( pickup[ playa[ player.ID ].House ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.NotOwnerShared );	
			else
			{
				local oldPickData = pickup[ playa[ player.ID ].House ].Pickup.ID, oldObj = null, pickupinstance = CreatePickup( 407, pickup[ playa[ player.ID ].House ].World, 0, pickup[ playa[ player.ID ].House ].Pos, 255, true );
				
				pickup[ playa[ player.ID ].House ].Owner = "100000";
				pickup[ playa[ player.ID ].House ].Model = 407;
				pickup[ playa[ player.ID ].House ].Pickup.Remove();
				pickup[ playa[ player.ID ].House ].Pickup = pickupinstance;
				
				oldObj = pickup[ playa[ player.ID ].House ];
				
				pickup.rawset( pickupinstance.ID, oldObj );
				pickup.rawdelete( oldPickData );
				
				playa[ player.ID ].House = pickupinstance.ID;
				
				ChangePlayerInterior( oldPickData, pickupinstance.ID );
				
				playa[ player.ID ].AddCash( player, pickup[ pickupinstance.ID ].Quatity );
				MsgPlr( 3, player, Lang.SellHouse, pickup[ pickupinstance.ID ].Type, pickup[ pickupinstance.ID ].Quatity );
				
				SavePickup( pickup[ pickupinstance.ID ] );
			}
		}
		break;
		
	/*	case "asellhouse":
		if( playa[ player.ID ].Level >= 4 )
		{
			if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
			else
			{
				local oldPickData = pickup[ playa[ player.ID ].House ].Pickup.ID, oldObj = null, pickupinstance = CreatePickup( 407, pickup[ playa[ player.ID ].House ].World, 0, pickup[ playa[ player.ID ].House ].Pos, 255, true );
					
				pickup[ playa[ player.ID ].House ].Owner  = 100000;
				pickup[ playa[ player.ID ].House ].Model = 407;
				pickup[ playa[ player.ID ].House ].Pickup.Remove();
				pickup[ playa[ player.ID ].House ].Pickup = pickupinstance;
					
				oldObj = pickup[ playa[ player.ID ].House ];
					
				pickup.rawset( pickupinstance.ID, oldObj );
				pickup.rawdelete( oldPickData );
					
				playa[ player.ID ].House = pickupinstance.ID;
					
				ChangePlayerInterior( oldPickData, pickupinstance.ID );
					
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has admin sold the house at coordinates [#33cc33] " + player.Pos );
					
				SavePickup( pickup[ pickupinstance.ID ] );
			}
		}
		else
		{
		MessagePlayer("[#e60000]* Unknown command. Use /help");
		}
		break;
		
		case "addhouse":
		if( playa[ player.ID ].Level >= 4 )
		{
			if( playa[ player.ID ].House != null ) MessagePlayer("[#bc0000]You are already in a house!", player);
			else
			{
				local type = GetTok( text, " ", 1), price = GetTok( text, " ", 2), int = GetTok( text, " ", 3), plrpos = Vector( ( player.Pos.x ), ( player.Pos.y ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
				local pickupinstance = CreatePickup( 407, 1, 0, plrpos, 255, true );
				if( !type ) MessagePlayer("Syntax, /addhouse [type] [price] [intid]", player);
				if( !price ) MessagePlayer("Syntax, /addhouse [type] [price] [intid]", player);
				if( !int ) MessagePlayer("Syntax, /addhouse [type] [price] [intid]", player);

				pickup.rawset( pickupinstance.ID, 
				{
					Model = 407, 
					Type = type,
					Quatity = price,
					World = 1,
					Pos = plrpos,
					Owner = 100000,
					Share = "N/A",
					Locked = false,
					Interior = int,
					Password = false,
					UID = uid,
					Welcome = "",
					Storage = "",
					GangHouse = null,
					Storage1 = "",
					Pickup = pickupinstance,
				});
					
				local ID = pickupinstance.ID;
				QuerySQL( db, "INSERT INTO Pickup VALUES ( '" + pickup[ ID ].Model + "', '" + pickup[ ID ].Type + "', '" + pickup[ ID ].Quatity + "', '" + pickup[ ID ].World + "', '" + pickup[ ID ].Pos.x + ", " + pickup[ ID ].Pos.y + ", "+ pickup[ ID ].Pos.z + "', '" + pickup[ ID ].Owner + "', '" + pickup[ ID ].Share + "', '" + pickup[ ID ].Locked + "', '0', 'false', '" + pickup[ ID ].UID + "', '0' , '0', '0' ) " );
				MessagePlayer("[#ffffff]Successfully created House!", player);
				MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has created a house type [#33cc33]" + type + " [#ffffff] at Position " + player.Pos + " [#ffffff]With price: " + price );
			}
		}
		else
		{
		MessagePlayer("[#e60000]* Unknown command. Use /help");
		}
		break;
	*/

		case "givehouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( !text ) MsgPlr( 2, player, Lang.GivehouseSyntax );
		else
		{
			if( pickup[ playa[ player.ID ].House ].Owner.find( "Group:" ) >= 0 ) MsgPlr( 2, player, Lang.NotInHouse );
			else if( pickup[ playa[ player.ID ].House ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.NotOwnerShared );	
			else
			{
				local plr = FindPlayer( text );
				if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
				else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
				else if( plr.ID == player.ID ) MsgPlr( 2, player, Lang.UnShareSelf );
				else 
				{
					pickup[ playa[ player.ID ].House ].Owner = playa[ plr.ID ].ID;

					if( pickup[ playa[ player.ID ].House ].Share.rawin( playa[ plr.ID ].ID.tostring() ) ) pickup[ playa[ player.ID ].House ].Share.rawdelete( playa[ plr.ID ].ID.tostring() );
											
					MsgPlr( 3, player, Lang.GiveHouse, pickup[ playa[ player.ID ].House ].Type, GetIngameTag( plr ) );
					MsgPlr( 7, plr, Lang.GiveHouse1, GetIngameTag( player ), pickup[ playa[ player.ID ].House ].Type );
				
					SavePickup( pickup[ playa[ player.ID ].House ] );
				}
			}
		}
		break;

		case "lockhouse":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else
			{
				switch( pickup[ playa[ player.ID ].House ].Locked )
				{
					case false:
					pickup[ playa[ player.ID ].House ].Locked = true;
					MsgPlr( 3, player, Lang.PropertyLocked );
					break;

					case true:
					pickup[ playa[ player.ID ].House ].Locked = false;
					MsgPlr( 3, player, Lang.PropertyUnLocked );
					break;
				}

				SavePickup( pickup[ playa[ player.ID ].House ] );
			}
		}
		break;

		case "housename":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( !VerifyOwnerAndSharer2( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared2 );			
			else if ( !text ) MsgPlr( 2, player, Lang.HouseRenameSyntax );
			else
			{
				pickup[ playa[ player.ID ].House ].Type = text;
				MsgPlr( 3, player, Lang.HouseRename, text );
				
				SavePickup( pickup[ playa[ player.ID ].House ] );
			}
		}
		break;

	}
}
