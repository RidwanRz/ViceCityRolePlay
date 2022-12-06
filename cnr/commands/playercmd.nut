function onPlayerCmd( player, cmd , text )
{
	if( playa[ player.ID ].Logged == false ) return MsgPlr( 2, player, Lang.InvalidCmd );
	else switch( cmd.tolower( ) )
	{

		case "dropwep":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( !player.Weapon )  MsgPlr( 2, player, Lang.WepCantDrop );
			else if( !text ) MsgPlr( 2, player, Lang.WepDropSyntax );
			else if( playa[ player.ID ].JobID.find("cop") >= 0 ) MsgPlr( 2, player, Lang.WepDropDuty );
			else
			{
				if( !IsNum( text ) ) MsgPlr( 2, player, Lang.StorewepNoNum );
				else if( text.tointeger() > player.Ammo || text.tointeger() < 0 || text.tointeger() == 0 ) MsgPlr( 2, player, Lang.WepDropNoAmmo );
				else
				{
					local model = GetWeaponModel( player.Weapon ), plrworld = player.World, plrname = playa[ player.ID ].ID, plrpos = Vector( ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), ( player.Pos.z ) ), uid = MD5( time().tostring() );
					local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );

					pickup.rawset( pickupinstance.ID, 
					{
						Model = model, 
						Type = "Weapon:" + player.Weapon,
						Quatity = text.tointeger(),
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
						GangHouse = null,
						Storage1 = "",
						Pickup = pickupinstance,
					});
					
					local ID = pickupinstance.ID;
					local ammo = ( player.Ammo - text.tointeger() );
					//QuerySQL( db, "INSERT INTO Pickup VALUES ( '" + pickup[ ID ].Model + "', '" + pickup[ ID ].Type + "', '" + pickup[ ID ].Quatity + "', '" + pickup[ ID ].World + "', '" + pickup[ ID ].Pos.x + ", " + pickup[ ID ].Pos.y + ", "+ pickup[ ID ].Pos.z + "', '" + pickup[ ID ].Owner + "', '" + pickup[ ID ].Share + "', '" + pickup[ ID ].Locked + "', '0', 'false', '" + pickup[ ID ].UID + "', '0' , '0', '0' ) " );
					if( GetSlotAtWeapon( player.Weapon ) == 1 ) player.SetWeapon( player.Weapon, 0 );
					else player.SetWeapon( player.Weapon, ammo );

					MsgPlr( 3, player, Lang.WepDrop, GetCustomWeaponName( player.Weapon ), text );
				}
			}
		}
		break;

	/*	case "me":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( playa[ player.ID ].Mute ) return MsgPlr( 2, player, Lang.MutedCantChat );
			else if( playa[ player.ID ].Cash <= 100 ) MsgPlr( 2, player, Lang.MeNeedCash );
			else if( !text ) MsgPlr( 2, player, Lang.MeSyntax );
			else
			{
				Message("[#00cc99]** " + GetIngameTag( player ) + "[#ffffff] " + text );
				playa[ player.ID ].DecCash( player, 100 );
			}
		}
		break;*/

		case "sms":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( playa[ player.ID ].Mute ) return MsgPlr( 2, player, Lang.MutedCantChat );
			else if( playa[ player.ID ].Cash <= 10 ) MsgPlr( 2, player, Lang.SmsNeedCash );
			else if( !text ) MsgPlr( 2, player, Lang.SmsSyntax );
			else
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) ), arr = GetTok( text, " ", 2, NumTok( text, " " ) );
				if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
				else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
				else
				{
					MsgPlr( 3, player, Lang.SmsTo, plr.Name, arr );
					MsgPlr( 1, plr, Lang.SmsRev, GetIngameTag( player ), arr );
					playa[ player.ID ].DecCash( player, 10 );
					PlaySound( plr.World, 267, plr.Pos );
				}
			}
		}
		break;

		case "plantbomb":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else if( !GetItem( player, 3, 1 ) ) MsgPlr( 2, player, Lang.NoBomb );
			else if( playa[ player.ID ].JobID.find("cop") >= 0 ) MsgPlr( 2, player, Lang.CopCantUse );
		//	else if( InArea( player.Pos.x, player.Pos.y ) == "bankvault" )
			else if( InPoly( player.Pos.x, player.Pos.y, -937.312, -342.077, -946.333, -342.084, -946.333, -345.528, -937.438, -345.53 ) )
			{
			//	if( Server.BankRobbery != 0 ) MsgPlr( 2, player, Lang.BankRobInProcess );
				if( ( time() - Server.BankRobTimer ) < 1800 ) MsgPlr( 2, player, Lang.BankRobWait, GetTiming( (1800 - ( time() - Server.BankRobTimer ) ) ) );
				else
				{
					DecQuatity( player, 3, "1" );
					MsgPlr( 3, player, Lang.Plantbomb );
					Server.BankRobbery = 1;
					Server.BankRobber = player.ID;
					Server.BankRobTimer = time();

					player.SetAnim( 24, 214 );
					player.PlaySound( 50002 );

					NewTimer("ExplodeVault", 15000, 1, player.Pos.x, player.Pos.y,player.Pos.z, player.ID );
				}
			}

			else 
			{
				local getPos = player.Pos, world = player.World;

				player.SetAnim( 24, 214 );
				player.PlaySound( 50002 );

				DecQuatity( player, 3, "1" );

				MsgPlr( 3, player, Lang.Plantbomb2 );

				_Timer.Create( this, function()
				{
					CreateExplosion( world, 6, getPos, -1, true );
				}, 15000, 1);
			}
		}
		break;

		case "items":
		case "invent":
		case "inventory":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else
			{
				if( playa[ player.ID ].Items.len() < 0 ) MsgPlr( 2, player, Lang.NoItem );
				else 
				{
					SendDataToClient( 10000, "Your Inventory", player );

					foreach( index, value in playa[ player.ID ].Items )
					{
						if( value.Quatity.tointeger() > 0 ) SendDataToClient( 10030, GetItemNameByID2( index.tointeger() ) + " (" + value.Quatity + ")", player );
					}
				}
			}
		}
		break;

		case "admin":
		case "admins":
		{
			local plr;
			local mod = null, admin = null, man = null, owner = null, dev = null, mapper = null, tester = null, ucadmin = null;

			for( local i = 0; i < GetMaxPlayers(); i ++ )
			{
				plr = FindPlayer( i );
				if ( plr )
				{
					switch( playa[ plr.ID ].Level )
					{
						case 2:
						if( mod ) mod = mod + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].AdminDuty == true)
						{
						mod = plr.Name + " [#ffffff]- Admin Duty \n";
						}
						else mod = plr.Name;
						break;

						case 3:
						if( admin ) admin = admin + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].AdminDuty == true)
						{
						admin = plr.Name + " [#ffffff]- Admin Duty \n";
						}
						else admin = plr.Name;
						break;
						
						case 4:
						if( man ) man = man + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].AdminDuty == true)
						{
						man = plr.Name + " [#ffffff]- Admin Duty \n";
						}
						else man = plr.Name;
						break;
						
						case 5:
						case 7:
						if( owner ) owner = owner + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].AdminDuty == true)
						{
						owner = plr.Name + " [#ffffff]- Admin Duty \n";
						}
						else owner = plr.Name;
						break;
						
						/*case 6:
						if( dev ) dev = dev + "[#ffffff], " + plr.Name;
						else dev = plr.Name;
						break;*/
					}
				}	
			}

			if( man ) MsgPlr( 3, player, Lang.OnlineMan, man );
			if( owner ) MsgPlr( 3, player, Lang.OnlineOwner, owner );
			//if( dev ) MsgPlr( 3, player, Lang.OnlineDev, dev );
			if( admin ) MsgPlr( 3, player, Lang.OnlineAdmin, admin );
			if( mod ) MsgPlr( 3, player, Lang.OnlineMod, mod );
			if( !man && !admin && !mod && !owner ) MsgPlr( 2, player, Lang.OnlineGhost );
		};
		break;
		
		case "scripters":
		case "developers":
		{
			local plr;
			local dev = null;

			for( local i = 0; i < GetMaxPlayers(); i ++ )
			{
				plr = FindPlayer( i );
				if ( plr )
				{
					switch( playa[ plr.ID ].Level )
					{	
						case 6:
						if( dev ) dev = dev + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].DevDuty == true)
						{
						dev = plr.Name + " [#42f5b6]- Dev Duty \n";
						}
						else dev = plr.Name;
						break;
					}
				}	
			}

			if( dev ) MsgPlr( 3, player, Lang.OnlineDev, dev );
			if( !dev ) MsgPlr( 2, player, Lang.NoDevOnline );
		};
		break;
		
		case "testers":
		case "mappers":
		{
			local plr;
			local mapper = null, tester = null, ucadmin = null;

			for( local i = 0; i < GetMaxPlayers(); i ++ )
			{
				plr = FindPlayer( i );
				if ( plr )
				{
					switch( playa[ plr.ID ].Staff )
					{	
						case 3:
						if( mapper ) mapper = mapper + "[#ffffff], " + plr.Name;
						else if( playa[ plr.ID ].mDuty == true)
						{
						mapper = plr.Name + " [#42f5b6]- Mapper Duty \n";
						}
						else mapper = plr.Name;
						break;
						
						case 2:
						if( tester ) tester = tester + "[#ffffff], " + plr.Name;
						else tester = plr.Name;
						break;
					}
				}	
			}

			if( mapper ) MsgPlr( 3, player, Lang.OnlineMapper, mapper );
			if( tester ) MsgPlr( 3, player, Lang.OnlineTester, tester );
			if( !mapper ) MsgPlr( 2, player, Lang.NoMapperOnline );
			if( !mapper && ucadmin ) MsgPlr( 2, player, Lang.NoMapperOnline );
			if( !tester ) MsgPlr( 2, player, Lang.NoTesterOnline );
			if( !tester && ucadmin ) MsgPlr( 2, player, Lang.NoTesterOnline );
		};
		break;

		case "breakcuff":
		if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
		else if( GetItem( player, 4, 1 ) == false ) MsgPlr( 2, player, Lang.NoBob );
		else if( playa[ player.ID ].CuffPlayer == null ) MsgPlr( 2, player, Lang.NoCuff );
		else
		{
			local kiki = FindPlayer( playa[ player.ID ].CuffPlayer.ID );

			DecQuatity( player, 4, "1" );

			MsgPlr( 6, player, Lang.Uncuff );
			playa[ player.ID ].CuffTimer.Stop();
			playa[ player.ID ].CuffPlayer = null;
			playa[ player.ID ].CuffColldown = time();
			player.IsFrozen = false;

			playa[ playa[ kiki.ID ].Cuff.ID ].CuffTimer.Stop();
			playa[ kiki.ID ].Cuff = null;

			MsgPlr( 2, kiki, Lang.BreakCuff1, GetIngameTag( kiki ) );
		}
		break;

		case "forsale":
		{
			if( !player.IsSpawned ) MsgPlr( 2, player, Lang.NotSpawn );
			else
			{
				local a = 0, b = 0;
				foreach( kiki in pickup )
				{
					if( kiki.Type.find( "Haiti Hut" ) >= 0 && kiki.Owner == 100000 ) a++;
					if( kiki.Type.find( "Mansion" ) >= 0 && kiki.Owner == 100000 ) a++;
					if( kiki.Type.find( "Apartment" ) >= 0 && kiki.Owner == 100000 ) a++;
				}

				foreach( kiki in area ) if( kiki.Owner == 100000 && kiki.Name != "Bank Vault" ) b++;

				MsgPlr( 3, player, Lang.ForSale, a, b );
			}
		}
		break;

		case "changepass":
		if( playa[ player.ID ].Logged )
		{
			if( text )
			{
				local old = GetTok( text, " ", 1 ), new = GetTok( text, " ", 2 );

				if( new )
				{
					if( skydb.GetPass( playa[ player.ID ].ID ) == SHA256( old ).tolower() )
					{
						if( new.len() > 4 )
						{
							local enNewpass = SHA256( new );

							MsgPlr( 3, player, Lang.CHangepassSucs );

							skydb.UpdatePassword( enNewpass, playa[ player.ID ].ID );
						}
						else MsgPlr( 2, player, Lang.CHangepassNotLonger );
					}
					else MsgPlr( 2, player, Lang.CHangepassWrongPass );
				}
				else MsgPlr( 2, player, Lang.CHangepassSyntax );
			}
			else MsgPlr( 2, player, Lang.CHangepassSyntax );
		}
		else MsgPlr( 2, player, Lang.AccNotLogged );
		break;

		case "news":
		if( playa[ player.ID ].Logged )
		{
			sendNewsToPlayer( player );
		}
		else MsgPlr( 2, player, Lang.AccNotLogged );
		break;
	
		case "use":
		if( player.IsSpawned )
		{
			if( !playa[ player.ID ].Knocked.IsKnocked )
            {
				if( text )
				{
					switch( text.tolower() )
					{
						case "kit kat":
						if( GetItem( player, 5, 1 ) )
						{
							if( player.Health < 99 )
							{
								if( !_Timer.Exists( playa[ player.ID ].Healing ) )
								{
									local count = 0;

									MsgPlr( 3, player, Lang.HealDontMove5 );

									SendDataToClient( 6300, "Healing in process:5", player );

									playa[ player.ID ].Healing = _Timer.Create( this, function( x, y,z )
									{
										count ++;
										if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
										{
											if( count == 5 )
											{
												player.Health += 5;

												if( player.Health > 99 ) player.Health = 100;
												DecQuatity( player, 5, 1 );

												MsgPlr( 3, player, Lang.ScsHeal );

												playa[ player.ID ].Healing = null;
											}
										}

										else 
										{
											MsgPlr( 2, player, Lang.FailHealMove );

											_Timer.Destroy( playa[ player.ID ].Healing ) ;
											playa[ player.ID ].Healing = null;

											SendDataToClient( 6310, null, player );
										}
									}, 1000, 5, player.Pos.x, player.Pos.y, player.Pos.z );
								}
								else MsgPlr( 2, player, Lang.HealingInProcesslol );
							}
							else MsgPlr( 2, player, Lang.NoNeedToUseHeal );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Kit Kat" );
						break;
						
						case "firstaid kit":
						if( GetItem( player, 6, 1 ) )
						{
							if( player.Health < 99 )
							{
								if( !_Timer.Exists( playa[ player.ID ].Healing ) )
								{
									local count = 0;

									MsgPlr( 3, player, Lang.HealDontMove15 );

									SendDataToClient( 6300, "Healing in process:15", player );

									playa[ player.ID ].Healing = _Timer.Create( this, function( x, y,z )
									{
										count ++;
										if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
										{
											if( count == 15 )
											{
												player.Health += 100;

												if( player.Health > 99 ) player.Health = 100;
												DecQuatity( player, 6, 1 );

												MsgPlr( 3, player, Lang.ScsHeal );

												playa[ player.ID ].Healing = null;
											}
										}

										else 
										{
											MsgPlr( 2, player, Lang.FailHealMove );

											_Timer.Destroy( playa[ player.ID ].Healing ) ;
											playa[ player.ID ].Healing = null;

											SendDataToClient( 6310, null, player );
										}
									}, 1000, 15, player.Pos.x, player.Pos.y, player.Pos.z );
								}
								else MsgPlr( 2, player, Lang.HealingInProcesslol );
							}
							else MsgPlr( 2, player, Lang.NoNeedToUseHeal );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Firstaid Kit" );
						break;

					/*	case "lockpick":
						if( playa[ player.ID ].JobID.find("cop") == null )
						{ 
							if( GetItem( player, 10, 1 ) )
							{
								local found = false;
								foreach ( id, kiki in vehicle ) 
								{ 
									if( player.Pos.Distance( kiki.vehicle.Pos ) < 2 )
									{
										if( kiki.Locked == false ) return MsgPlr( 2, player, Lang.CantPickUnlock );
										if( kiki.Owner == playa[ player.ID ].ID ) return MsgPlr( 2, player, Lang.CantPickOwnCar );

										kiki.Locked = false;

										playa[ player.ID ].AddWanted( player, 1 );

										MsgPlr( 3, player, Lang.ScsPicked );

										DecQuatity( player, 10, 1 );

										return;
									}
								}
								if( !found ) MsgPlr( 2, player, Lang.NotNearAnyCar );
							}
							else MsgPlr( 2, player, Lang.NoItem2, "Lock Pick" );
						}
						else MsgPlr( 2, player, Lang.CopCantUse );
						break;

						case "bomb":
						if( playa[ player.ID ].JobID.find("cop") == null )
						{
							if( GetItem( player, 3, 1 ) )
							{
								if( InArea( player.Pos.x, player.Pos.y ) == "bankvault" )
								{
									if( Server.BankRobbery != 0 ) MsgPlr( 2, player, Lang.BankRobInProcess );
									else if( ( time() - Server.BankRobTimer ) < 1800 ) MsgPlr( 2, player, Lang.BankRobWait, GetTiming( (1800 - ( time() - Server.BankRobTimer ) ) ) );
									else
									{
										DecQuatity( player, 3, "1" );
										MsgPlr( 3, player, Lang.Plantbomb );
										Server.BankRobbery = 1;
										Server.BankRobber = player.ID;

										player.SetAnim( 24, 214 );
										player.PlaySound( 50002 );

										NewTimer("ExplodeVault", 5000, 1, player.Pos.x, player.Pos.y,player.Pos.z, player.ID );
									}
								}

								else 
								{
									local getPos = player.Pos, world = player.World;

									player.SetAnim( 24, 214 );
									player.PlaySound( 50002 );

									DecQuatity( player, 3, "1" );

									MsgPlr( 3, player, Lang.Plantbomb2 );

									_Timer.Create( this, function()
									{
										CreateExplosion( world, 6, getPos, -1, true );
									}, 15000, 1);
								}
							}
							else MsgPlr( 2, player, Lang.NoBomb );
						}
						else MsgPlr( 2, player, Lang.CopCantUse );
						break;
					*/

						case "m4 case":
						if( GetItem( player, 16, 1 ) )
						{
							player.SetWeapon( 26, ( player.GetAmmoAtSlot( GetSlotAtWeapon( 26 ) ) + 300 ) );

							DecQuatity( player, 16, 1 );

							MsgPlr( 3, player, Lang.CaseUnbox, "M4 Case" );

							LocalMessage(  player.Pos, "UnboxLocal", player.Name, "M4 Case" );
							LocalMessage3D(  player.ID, "UnboxLocal", player.Name, "M4 Case" );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "M4 Case" );
						break;

						case "ruger case":
						if( GetItem( player, 17, 1 ) )
						{
							player.SetWeapon( 27, ( player.GetAmmoAtSlot( GetSlotAtWeapon( 27 ) ) + 300 ) );

							DecQuatity( player, 17, 1 );

							MsgPlr( 3, player, Lang.CaseUnbox, "Ruger Case" );

							LocalMessage(  player.Pos, "UnboxLocal", player.Name, "Ruger Case" );
							LocalMessage3D(  player.ID, "UnboxLocal", player.Name, "Ruger Case" );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Ruger Case" );
						break;

						case "armour case":
						if( GetItem( player, 18, 1 ) )
						{
							if( player.Armour < 99 )
							{
								player.Armour = 100;

								DecQuatity( player, 18, 1 );

								MsgPlr( 3, player, Lang.CaseUnbox, "Armour Case" );

								LocalMessage(  player.Pos, "UnboxLocal", player.Name, "Armour Case" );
								LocalMessage3D(  player.ID, "UnboxLocal", player.Name, "Armour Case" );
							}
							else MsgPlr( 2, player, Lang.NoNeedArmour );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Armour Case" );
						break;

						case "m60 case":
						if( GetItem( player, 19, 1 ) )
						{
							player.SetWeapon( 32, ( player.GetAmmoAtSlot( GetSlotAtWeapon( 32 ) ) + 300 ) );

							DecQuatity( player, 19, 1 );

							MsgPlr( 3, player, Lang.CaseUnbox, "M60 Case" );

							LocalMessage(  player.Pos, "UnboxLocal", player.Name, "M60 Case" );
							LocalMessage3D( player.ID, "UnboxLocal", player.Name, "M60 Case" );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "M60 Case" );
						break;

						case "sniper case":
						if( GetItem( player, 20, 1 ) )
						{
							player.SetWeapon( 28, ( player.GetAmmoAtSlot( GetSlotAtWeapon( 28 ) ) + 100 ) );

							DecQuatity( player, 20, 1 );

							MsgPlr( 3, player, Lang.CaseUnbox, "Sniper Case" );

							LocalMessage(  player.Pos, "UnboxLocal", player.Name, "Sniper Case" );
							LocalMessage3D(  player.ID, "UnboxLocal", player.Name, "Sniper Case" );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Sniper Case" );
						break;

						case "rpg case":
						if( GetItem( player, 21, 1 ) )
						{
							player.SetWeapon( 30, ( player.GetAmmoAtSlot( GetSlotAtWeapon( 28 ) ) + 1 ) );

							DecQuatity( player, 21, 1 );

							MsgPlr( 3, player, Lang.CaseUnbox, "RPG Case" );

							LocalMessage(  player.Pos, "UnboxLocal", player.Name, "RPG Case" );
							LocalMessage3D(  player.ID, "UnboxLocal", player.Name, "RPG Case" );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "RPG Case" );
						break;

						case "toolkit":
						case "tool kit":
						if( GetItem( player, 25, 1 ) )
						{
							if( !player.Vehicle )
							{
								local findveh = null;
								foreach( index, value in vehicle )
								{
									if( DistanceFromPoint( value.vehicle.Pos.x, value.vehicle.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
									{
										findveh = index;
									}
								}

								if( findveh )
								{
									if( vehicle[ findveh ].vehicle.Health < 999 )
									{
										if( !_Timer.Exists( playa[ player.ID ].RepairVehicle ) )
										{
											local count = 0;

											MsgPlr( 3, player, Lang.RepairDontMove10 );

											SendDataToClient( 6300, "Repair in process:10", player );

											playa[ player.ID ].RepairVehicle = _Timer.Create( this, function( x, y,z, findveh )
											{
												if( vehicle.rawin( findveh ) )
												{
													if( DistanceFromPoint( vehicle[ findveh ].vehicle.Pos.x, vehicle[ findveh ].vehicle.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
													{
														count ++;
														if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
														{
															if( count == 10 )
															{
																vehicle[ findveh ].vehicle.Health = 500;
																vehicle[ findveh ].IsDamage = false;

																vehicle[ findveh ].vehicle.ResetHandlingData( 13 );
																vehicle[ findveh ].vehicle.ResetHandlingData( 14 );

																DecQuatity( player, 25, 1 );

																MsgPlr( 3, player, Lang.SucesfullyHalfRepair );

																playa[ player.ID ].RepairVehicle = null;
															}
														}

														else 
														{
															MsgPlr( 2, player, Lang.FailRepairMove );

															_Timer.Destroy( playa[ player.ID ].RepairVehicle );
															playa[ player.ID ].RepairVehicle = null;

															SendDataToClient( 6310, null, player );
														}
													}

													else 
													{
														MsgPlr( 2, player, Lang.FailRepairTargetVehicleNotNear );

														_Timer.Destroy( playa[ player.ID ].RepairVehicle );
														playa[ player.ID ].RepairVehicle = null;

														SendDataToClient( 6310, null, player );
													}
												}

												else 
												{
													MsgPlr( 2, player, Lang.FailRepairTargetVehicleNotNear );

													_Timer.Destroy( playa[ player.ID ].RepairVehicle );
													playa[ player.ID ].RepairVehicle = null;

													SendDataToClient( 6310, null, player );
												}
											}, 1000, 10, player.Pos.x, player.Pos.y, player.Pos.z, findveh );

										}
										else MsgPlr( 2, player, Lang.NoNeedRepair2 );
									}
									else MsgPlr( 2, player, Lang.FixAlready100 );
								}
								else MsgPlr( 2, player, Lang.NotNearvehicle2 );
							}
							else MsgPlr( 2, player, Lang.NotInsideVeh );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Tool Kit" );
						break;














						default:
						MsgPlr( 2, player, Lang.InvalidItem );
						break;
					}
				}
				else MsgPlr( 2, player, Lang.UseSyntax );
			}
			else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;
	
		case "ignore":
		if( playa[ player.ID ].Logged )
		{
			if( text )
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) );
				if( plr )
				{
					if( plr.ID != player.ID )
					{
						if( !Server.Ignore.rawget( player.ID ).rawin( playa[ plr.ID ].ID ) )
						{
							Server.Ignore.rawget( player.ID ).rawset( playa[ plr.ID ].ID, true );

							MsgAll( 9, Lang.IgnoreAll, GetIngameTag( player ), plr.Name );

							MsgPlr( 3, player, Lang.IgnoreSelf, plr.Name );
						}
						else MsgPlr( 2, player, Lang.AlreadyIgnore, plr.Name );
					}
					else MsgPlr( 2, player, Lang.CantIgnoreLSelf );					
				}
				else MsgPlr( 2, player, Lang.UnknownPlr );
			}
			else MsgPlr( 2, player, Lang.IgnoreSyntax );
		}
		else  MsgPlr( 2, player, Lang.AccNotLogged );
		break;

		case "unignore":
		if( playa[ player.ID ].Logged )
		{
			if( text )
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) );
				if( plr )
				{
					if( plr.ID != player.ID )
					{
						if( Server.Ignore.rawget( player.ID ).rawin( playa[ plr.ID ].ID ) )
						{
							Server.Ignore.rawget( player.ID ).rawdelete( playa[ plr.ID ].ID );

							MsgAll( 9, Lang.UnIgnoreAll, GetIngameTag( player ), plr.Name );

							MsgPlr( 3, player, Lang.UnIgnoreSelf, plr.Name );
						}
						else MsgPlr( 2, player, Lang.NotIgnore, plr.Name );
					}
					else MsgPlr( 2, player, Lang.UnCantIgnoreLSelf );					
				}
				else MsgPlr( 2, player, Lang.UnknownPlr );
			}
			else MsgPlr( 2, player, Lang.UnIgnoreSyntax );
		}
		else  MsgPlr( 2, player, Lang.AccNotLogged );
		break;

		case "fps":
		if( player.IsSpawned )
		{
			if( text )
			{
				local plr = FindPlayer( GetTok( text, " ", 1 ) );
				if( plr )
				{
					if( plr.ID != player.ID )
					{
						if( plr.IsSpawned )
						{
							MsgPlr( 3, player, Lang.FPSPlr, plr.Name, plr.FPS );
						}
						else MsgPlr( 2, player, Lang.PlrNotSpawned );
					}
					else MsgPlr( 3, player, Lang.FPSelf, player.FPS );
				}
				else MsgPlr( 2, player, Lang.UnknownPlr );  
			}
			else MsgPlr( 2, player, Lang.FPSSyntax );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;

		case "pick":
		if( player.IsSpawned )
		{
			if( text )
			{
				if( IsNum( text ) )
				{
					local found = null;
					foreach( index, kiki in pickup )
					{
						if( DistanceFromPoint( kiki.Pickup.Pos.x, kiki.Pickup.Pos.y, player.Pos.x, player.Pos.y ) <= 2 && kiki.Type == "deaddrop" )
						{
							if( !found ) found = index;
						}
					}

					if( found )
					{
						if( pickup[ found ].Quatity.rawin( text.tointeger() ) )
						{
							switch( pickup[ found ].Quatity[ text.tointeger() ].Type )
							{
								case "Cash":
								playa[ player.ID ].AddCash( player, pickup[ found ].Quatity[ text.tointeger() ].Quatity );

								MsgPlr( 3, player , Lang.CashPickup2, pickup[ found ].Quatity[ text.tointeger() ].Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found ].Owner ) ) );
								
								pickup[ found ].Quatity.rawdelete( text.tointeger() );

								if( pickup[ found ].Quatity.len() == 0 )
								{
									pickup[ found ].Pickup.Remove();
									pickup.rawdelete( found );
								}
								break;

								case "Item":
								AddQuatity( player, pickup[ found ].Quatity[ text.tointeger() ].ID, 1 );
								
								MsgPlr( 3, player , Lang.ItemPickup2, GetItemNameByID( pickup[ found ].Quatity[ text.tointeger() ].ID ), pickup[ found ].Quatity[ text.tointeger() ].Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found ].Owner ) ) );
								
								pickup[ found ].Quatity.rawdelete( text.tointeger() );

								if( pickup[ found ].Quatity.len() == 0 )
								{
									pickup[ found ].Pickup.Remove();
									pickup.rawdelete( found );
								}
								break;

								case "Weapon":
								if( player.GetWeaponAtSlot( GetSlotFromWeapon( pickup[ found ].Quatity[ text.tointeger() ].ID ) ) != 0 )
								{
									player.SetWeapon( player.GetWeaponAtSlot( GetSlotFromWeapon( pickup[ found ].Quatity[ text.tointeger() ].ID ) ), ( player.GetAmmoAtSlot( GetSlotFromWeapon( pickup[ found ].Quatity[ text.tointeger() ].ID ) ) + pickup[ found ].Quatity[ text.tointeger() ].Quatity ) )
								
									MsgPlr( 3, player , Lang.WeaponPickup3, pickup[ found ].Quatity[ text.tointeger() ].Quatity, GetCustomWeaponName( pickup[ found ].Quatity[ text.tointeger() ].ID ), GetIngameTag( skydb.GetNameFromID( pickup[ found ].Owner ) ) );
								
									pickup[ found ].Quatity.rawdelete( text.tointeger() );

									if( pickup[ found ].Quatity.len() == 0 )
									{
										pickup[ found ].Pickup.Remove();
										pickup.rawdelete( found );
									}
								}

								else 
								{
									player.SetWeapon( pickup[ found ].Quatity[ text.tointeger() ].ID.tointeger(), pickup[ found ].Quatity[ text.tointeger() ].Quatity.tointeger() );
								
									MsgPlr( 3, player , Lang.WeaponPickup2, GetCustomWeaponName( pickup[ found ].Quatity[ text.tointeger() ].ID ), pickup[ found ].Quatity[ text.tointeger() ].Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found ].Owner ) ) );
								
									pickup[ found ].Quatity.rawdelete( text.tointeger() );

									if( pickup[ found ].Quatity.len() == 0 )
									{
										pickup[ found ].Pickup.Remove();
										pickup.rawdelete( found );
									}
								}
								break;								
							}
						}
						else MsgPlr( 2, player, Lang.DeaddopInvalidID );
					}
					else MsgPlr( 2, player, Lang.DeaddopNotFound );
				}

				else 
				{
					if( text == "all" )
					{
						local found1 = null;
						foreach( index, kiki in pickup )
						{
							if( DistanceFromPoint( kiki.Pickup.Pos.x, kiki.Pickup.Pos.y, player.Pos.x, player.Pos.y ) <= 2 && kiki.Type == "deaddrop" )
							{
								if( !found1 ) found1 = index;
							}
						}

						if( found1 )
						{	
						//	foreach( found, value in pickup[ found1 ].Quatity )

							for( local i = 0; i < 50; i++ )
							{
								if( !pickup[ found1 ].Quatity.rawin( i ) ) continue;

								local value = pickup[ found1 ].Quatity[i];
								local found = i;
								switch( value.Type )
								{
									case "Cash":
									playa[ player.ID ].AddCash( player, value.Quatity );

									MsgPlr( 3, player , Lang.CashPickup2, value.Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found1 ].Owner ) ) );
										
									pickup[ found1 ].Quatity.rawdelete( found );
									break;

									case "Item":
									AddQuatity( player, value.ID, 1 );
										
									MsgPlr( 3, player , Lang.ItemPickup2, GetItemNameByID( value.ID ), value.Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found1 ].Owner ) ) );
										
									pickup[ found1 ].Quatity.rawdelete( found );
									break;

									case "Weapon":
									if( player.GetWeaponAtSlot( GetSlotFromWeapon( value.ID ) ) != 0 )
									{
										player.SetWeapon( player.GetWeaponAtSlot( GetSlotFromWeapon( value.ID ) ), ( player.GetAmmoAtSlot( GetSlotFromWeapon( value.ID ) ) + value.Quatity ) )
										
										MsgPlr( 3, player , Lang.WeaponPickup3, value.Quatity, GetCustomWeaponName( value.ID ), GetIngameTag( skydb.GetNameFromID( pickup[ found1 ].Owner ) ) );
										
										pickup[ found1 ].Quatity.rawdelete( found );
									}

									else 
									{
										player.SetWeapon( value.ID.tointeger(), value.Quatity.tointeger() );
										
										MsgPlr( 3, player , Lang.WeaponPickup2, GetCustomWeaponName( value.ID ), value.Quatity, GetIngameTag( skydb.GetNameFromID( pickup[ found1 ].Owner ) ) );
										
										pickup[ found1 ].Quatity.rawdelete( found );
									}
									break;
								}
							}

							pickup[ found1 ].Pickup.Remove();
							pickup.rawdelete( found1 );
						}	
						else MsgPlr( 2, player, Lang.DeaddopNotFound );
					}
					else MsgPlr( 2, player, Lang.PickIDNotNum );				
				}
			}
			else MsgPlr( 2, player, Lang.PickSyntax );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;

		case "p":
		if( !playa[ player.ID ].Mute )
		{
			if( text )
			{
				local getIgnorePlayer = Server.Ignore.rawget( player.ID );
				local plr;
				for( local i = 0; i < GetMaxPlayers(); i ++ )
				{
					plr = FindPlayer( i );
					if ( plr )
					{
						local getIgnorePlr = Server.Ignore.rawget( plr.ID );

						if( getIgnorePlr.rawin( playa[ player.ID ].ID ) ) continue;

						if( playa[ plr.ID ].Logged )
						{
							MessagePlayer( RGBToHex( player.Colour ) + player.Name + "[#ffffff]: " + text, plr );
						}
							
						else
						{
							if( playa[ plr.ID ].Logged )
							{
								MessagePlayer( RGBToHex( player.Colour ) + player.Name + "[#ffffff]: " + text, plr );
							}
						}
					}
				}
			}
			else MsgPlr( 2, player, Lang.PublicchatSyntax );
		}
		else MsgPlr( 2, player, Lang.MutedCantChat );
		break;

		case "ask":
		if( !playa[ player.ID ].Mute )
		{
			if( text )
			{
				if( playa[ player.ID ].Level > 1 ) MsgAll( 3, Lang.AskChat, PInfoColor_Level( playa[ player.ID ].Level ), player.Name, text );
				else MsgAll( 3, Lang.AskChat, "", player.Name, text );
			}
			else MsgPlr( 2, player, Lang.AskChatSyntax );
		}
		else MsgPlr( 2, player, Lang.MutedCantChat );
		break;

		case "cmds":
		case "commands":

		MsgPlr( 2, player, Lang.Breakline );
		
		MsgPlr( 2, player, Lang.AccountCmd );
		MsgPlr( 2, player, Lang.OtherCmd );
		MsgPlr( 2, player, Lang.ChatCmd );
		MsgPlr( 2, player, Lang.RadioCmd );
		MsgPlr( 2, player, Lang.ShopCmd );
		MsgPlr( 2, player, Lang.HouseCmd );
		MsgPlr( 2, player, Lang.GroupCmd );
		MsgPlr( 2, player, Lang.VehicleCmd );
		MsgPlr( 2, player, Lang.JobCmd );

		MsgPlr( 2, player, Lang.Breakline );
		break;

		case "stats":
		MsgPlr( 2, player, Lang.StatsOwn );
		MsgPlr( 2, player, Lang.StatsOwn1, playa[ player.ID ].XP, getExperienceAtLevel( getLevelAtExperience( ( playa[ player.ID ].XP ) + 1 ) ), getLevelAtExperience( playa[ player.ID ].XP ) );
		MsgPlr( 2, player, Lang.StatsOwn2, GetTiming( ( ::time() - playa[ player.ID ].Playtime1.tointeger() ) ), GetTiming( playa[ player.ID ].Playtime.tointeger() ) );
		if( playa[ player.ID ].Phone ) MsgPlr( 2, player, Lang.StatsOwn3, playa[ player.ID ].Phone );
		break;
		
		case "jobcmd":
		switch( playa[ player.ID ].Job.JobID )
		{
			case 1:
			MsgPlr( 2, player, Lang.JobDontHaveCmd );
			break;

			case 2:
			MsgPlr( 2, player, Lang.MedicCmds );
			break;

			case 3:
			case 4:
			if( playa[ player.ID ].Job.PDLevel > 2 ) MsgPlr( 2, player, Lang.HighRankCopCmd );
			else MsgPlr( 2, player, Lang.FreeCopCmd );
			break;

			case 5:
			MsgPlr( 2, player, Lang.FBICmd );
			break;

			default:
			MsgPlr( 2, player, Lang.JobNotInJobToCmd );
			break;
		}
		break;

		case "faq":
		SendDataToClient( 14000, null, player );
		break;
	}
};
