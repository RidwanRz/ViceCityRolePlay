function onVehicleCommand( player, cmd, text )
{
	local p = playa[ player.ID ];
	switch( cmd.tolower() )
	{
		case "myveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				local clanz = null, sharer = null;

			    foreach ( id, kiki in vehicle ) 
                { 
                   if( kiki.Owner.tolower() == playa[ player.ID ].ID.tostring() ) 
                   {
						local v = split( kiki.UID2, "-" );
						if ( clanz ) clanz = format( Lang.MyVehicle[ playa[ player.ID ].Lang ], clanz, GetVehicleNameFromModel2( kiki.Model ), v[1] );
						else clanz = format( Lang.MyVehicle1[ playa[ player.ID ].Lang ], GetVehicleNameFromModel2( kiki.Model ), v[1] );
				   }

                   if( kiki.Share.rawin( playa[ player.ID ].ID.tostring() ) )
                   {
						local v = split( kiki.UID2, "-" );
						if ( sharer ) clanz = format( Lang.OurVehicle[ playa[ player.ID ].Lang ], sharer, GetVehicleNameFromModel2( kiki.Model ), GetIngameTag( mysqldb.GetNameFromID( kiki.Owner ) ), v[1] );
						else sharer = format( Lang.OurVehicle1[ playa[ player.ID ].Lang ], GetVehicleNameFromModel2( kiki.Model ), GetIngameTag( mysqldb.GetNameFromID( kiki.Owner ) ), v[1] );
				   }
				}
				if( clanz ) MsgPlr( 3, player, Lang.MyVehicle3, clanz );
				if( sharer ) MsgPlr( 3, player, Lang.MyVehicle4, sharer );
				if( !clanz && !sharer ) MsgPlr( 2, player, Lang.MyVehicleNoVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;	
			
		case "parkveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						if( GetOwnerOrGroupOwner( player.Vehicle.ID, player ) )
						{
							local kurwa = player.Vehicle.Pos.x + ", " + player.Vehicle.Pos.y + ", " + player.Vehicle.Pos.z;
							vehicle[ player.Vehicle.ID ].PosString = kurwa;
							vehicle[ player.Vehicle.ID ].Angle = GetRadiansAngle( player.Vehicle.Angle );
							vehicle[ player.Vehicle.ID ].vehicle.SpawnPos = player.Vehicle.Pos;
							vehicle[ player.Vehicle.ID ].vehicle.EulerSpawnAngle = player.Vehicle.EulerAngle;
							MsgPlr( 3, player, Lang.SucessPark );
								
							VSaveData( vehicle[ player.Vehicle.ID ] );
						}
						else MsgPlr( 2, player, Lang.NotOwner );
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
				
		case "veh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						local v = split( vehicle[ player.Vehicle.ID ].UID2, "-" );

						MsgPlr( 3, player, Lang.VehicleInfo1, GetVehicleNameFromModel2( vehicle[ player.Vehicle.ID ].Model ), v[1], player.Vehicle.Health );
						if( vehicle[ player.Vehicle.ID ].Owner == playa[ player.ID ].ID.tostring() ) MsgPlr( 3, player, Lang.VehicleInfo, mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ), GetHouseSharerName( vehicle[ player.Vehicle.ID ].Share ) );
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "aparkcar":
		if( p.Level >= 4 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						local kurwa = player.Vehicle.Pos.x + ", " + player.Vehicle.Pos.y + ", " + player.Vehicle.Pos.z;
						vehicle[ player.Vehicle.ID ].PosString = kurwa;
						vehicle[ player.Vehicle.ID ].Angle = GetRadiansAngle( player.Vehicle.Angle );
						vehicle[ player.Vehicle.ID ].vehicle.SpawnPos = player.Vehicle.Pos;
						vehicle[ player.Vehicle.ID ].vehicle.EulerSpawnAngle = player.Vehicle.EulerAngle;
						MsgPlr( 3, player, Lang.SucessParkA, ( vehicle[ player.Vehicle.ID ].Owner == 100000 ? "the State." : mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ) ), vehicle[ player.Vehicle.ID ].UID2 );
						
						VSaveData( vehicle[ player.Vehicle.ID ] );
						MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has admin parked vehicle[#33cc33] " + GetVehicleNameFromModel2( player.Vehicle.Model ) + " [#ffffff]owned by " + ( vehicle[ player.Vehicle.ID ].Owner == 100000 ? "the State" : GetIngameTag( mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ) ) ) );
					/*	local UID = MD5( ""+time() );
						local UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9;
						local PosString = player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z
						mysql_query( mysql, "insert into vehicles VALUES ( '157', '100000', 'N/A', '" + PosString + "', '" + player.Angle + "', 'false', '0', '0', '" + UID + "', '" + UID2 + "', '0', '0' )" );
						legacyMessage("done");*/
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		/*case "impound":
		if( p.Level >= 3 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle[ ID ].Impounded == true )
					{
						MessagePlayer("[#ff3355]This vehicle is already impounded!");
					}
					else
					{
						if( vehicle.rawin( player.Vehicle.ID ) )
						{
							local kurwa = player.Vehicle.Pos.x + ", " + player.Vehicle.Pos.y + ", " + player.Vehicle.Pos.z;
							vehicle[ player.Vehicle.ID ].PosString = kurwa;
							vehicle[ player.Vehicle.ID ].Angle = GetRadiansAngle( player.Vehicle.Angle );
							vehicle[ player.Vehicle.ID ].vehicle.SpawnPos = player.Vehicle.Pos;
							vehicle[ player.Vehicle.ID ].vehicle.EulerSpawnAngle = player.Vehicle.EulerAngle;
							MessagePlayer( "[#ff3355]You have successfully impounded this vehicle!", player );
							vehicle[ ID ].Impounded = true;
							VSaveData( vehicle[ player.Vehicle.ID ] );
							MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has impounded vehicle[#33cc33] " + GetVehicleNameFromModel2( player.Vehicle.Model ) + " [#ffffff]owned by " + ( vehicle[ player.Vehicle.ID ].Owner == 100000 ? "the State" : GetIngameTag( mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ) ) ) );
						/*	local UID = MD5( ""+time() );
							local UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9;
							local PosString = player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z
							QuerySQL( db, "insert into Vehicle VALUES ( '157', '100000', 'N/A', '" + PosString + "', '" + player.Angle + "', 'false', '0', '0', '" + UID + "', '" + UID2 + "', '0', '0' )" );
							legacyMessage("done");*//*
						}
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;*/
		
		/*case "unimpound":
		if( p.Level >= 3 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle[ ID ].Impounded == false )
					{
						MessagePlayer("[#ff3355]This vehicle is not impounded!");
					}
					else
					{
						if( vehicle.rawin( player.Vehicle.ID ) )
						{
							local kurwa = player.Vehicle.Pos.x + ", " + player.Vehicle.Pos.y + ", " + player.Vehicle.Pos.z;
							vehicle[ player.Vehicle.ID ].PosString = kurwa;
							vehicle[ player.Vehicle.ID ].Angle = GetRadiansAngle( player.Vehicle.Angle );
							vehicle[ player.Vehicle.ID ].vehicle.SpawnPos = player.Vehicle.Pos;
							vehicle[ player.Vehicle.ID ].vehicle.EulerSpawnAngle = player.Vehicle.EulerAngle;
							MessagePlayer( "[#ff3355]You have successfully impounded this vehicle!", player );
							vehicle[ ID ].Impounded = false;
							VSaveData( vehicle[ player.Vehicle.ID ] );
							MsgStaff("[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has unimpounded vehicle[#33cc33] " + GetVehicleNameFromModel2( player.Vehicle.Model ) + " [#ffffff]owned by " + ( vehicle[ player.Vehicle.ID ].Owner == 100000 ? "the State" : GetIngameTag( mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ) ) ) );
						/*	local UID = MD5( ""+time() );
							local UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9;
							local PosString = player.Pos.x + ", " + player.Pos.y + ", " + player.Pos.z
							QuerySQL( db, "insert into Vehicle VALUES ( '157', '100000', 'N/A', '" + PosString + "', '" + player.Angle + "', 'false', '0', '0', '" + UID + "', '" + UID2 + "', '0', '0' )" );
							legacyMessage("done");*//*
						}
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;*/

		case "sellveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( IsVehDealership( player ) )
					{
						if( vehicle.rawin( player.Vehicle.ID ) )
						{
							if( GetOwnerOrGroupOwner( player.Vehicle.ID, player ) )
							{
								local getCash = ( vehicle[ player.Vehicle.ID ].Price / 2 );

								playa[ player.ID ].AddCash( player, getCash );

								MsgPlr( 3, player, Lang.Sellcar, getCash );
								
								mysql_query( mysql, "DELETE FROM vehicles WHERE UID = '" + vehicle[ player.Vehicle.ID ].UID + "'" );

								vehicle.rawdelete( player.Vehicle.ID );

								player.Vehicle.Delete();
							}
							else MsgPlr( 2, player, Lang.NotOwner );
						}
						else MsgPlr( 2, player, Lang.NotOwner );
					}
					else MsgPlr( 2, player, Lang.NotAtVehShowroom );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
		
		case "asellcar":
		if( p.Level >= 4 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has admin sold vehicle [#33cc33]" + GetVehicleNameFromModel2(player.Vehicle.Model) + " [#ffffff]owned by " + GetIngameTag( mysqldb.GetNameFromID( vehicle[ player.Vehicle.ID ].Owner ) ) );
						
						mysql_query( mysql, "DELETE FROM vehicles WHERE UID = '" + vehicle[ player.Vehicle.ID ].UID + "'" );
						vehicle.rawdelete( player.Vehicle.ID );
						player.Vehicle.Delete();
					}
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		/*case "addcar":
		if( p.Level >= 4 )
		{
			if( p.Logged == true )
			{
				if( !text ) MessagePlayer("[#32a891]Syntax, /addcar [name] [color1] [color2]", player);
				{
					local carname = GetTok(text," ",1), color1 = GetTok(text," ",2), color2 = GetTok(text," ",3);
					if ( !carname || !color1 || !color2 ) MessagePlayer( ">> Use /" + cmd + " <name> <Col1> <Col2>", player );
				
					local instance = CreateVehicle( GetVehicleModelFromName( carname ), 1, player.Pos, player.Angle, color1, color2 ),
				
					AddID = instance.ID,
					GenerateUID = playa[ player.ID ].Password +""+ time() , st = split( string, ":" );
					vehicle[ AddID ] <- {};
					vehicle[ AddID ].Model <- GetVehicleModelFromName( cash[0] );
					vehicle[ AddID ].Owner <- "State";
					vehicle[ AddID ].Share <- {};
					vehicle[ AddID ].PosString <- player.Pos;
					vehicle[ AddID ].Angle <- player.Angle;
					vehicle[ AddID ].Locked <- false;
					vehicle[ AddID ].Col1 <- color1;
					vehicle[ AddID ].Col2 <- color2;
					vehicle[ AddID ].UID <- MD5( GenerateUID );
					vehicle[ AddID ].UID2 <- "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9;
					vehicle[ AddID ].Price <- "0";
					vehicle[ AddID ].vehicle <- instance;
					player.Vehicle = vehicle[ AddID ].vehicle;
					QuerySQL( db, "insert into Vehicle VALUES ( '" + vehicle[ AddID ].Model + "', '" + "State" + "', 'N/A', '" + vehicle[ AddID ].PosString + "', '" + vehicle[ AddID ].Angle + "', 'false', 'color1', 'color2', '" + vehicle[ AddID ].UID + "', '" + vehicle[ AddID ].UID2 + "', '0', '" + "0" + "' )" );
					//MsgPlr( 3, player, Lang.VehicleBuyed, GetVehicleNameFromModel2( vehicle[ AddID ].Model ) );
					
					MsgStaff( "[#737373][[#ff3399]Admin[#737373]] " + GetIngameTag( player ) + " [#ffffff]has added a permanent vehicle " + GetVehicleNameFromModel2(player.Vehicle.Model) + " owned by the state.");
					MessagePlayer("[#32a891]You have added this vehicle!", player);
				}
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;*/

		case "lockveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						if( VehicleVerifyOwnerAndSharer( player.Vehicle.ID, playa[ player.ID ].ID ) )
						{
							switch( vehicle[ player.Vehicle.ID ].Locked )
							{
								case true:
								vehicle[ player.Vehicle.ID ].Locked = false;
								MsgPlr( 3, player, Lang.Unlockcar );

								LocalMessage( player.Pos, "UnLockVehLocal", player.Name, GetVehicleNameFromModel2( vehicle[ player.Vehicle.ID ].Model ) );
								break;

								case false:
								vehicle[ player.Vehicle.ID ].Locked = true;
								MsgPlr( 3, player, Lang.lockcar );

								LocalMessage( player.Pos, "LockVehLocal", player.Name, GetVehicleNameFromModel2( vehicle[ player.Vehicle.ID ].Model ) );
								break;
							}
							VSaveData( vehicle[ player.Vehicle.ID ] );
						}
						else MsgPlr( 2, player, Lang.NotOwner1 );
					}
					else MsgPlr( 2, player, Lang.NotOwner1 );
				}

				else 
				{
					local findveh = null;
					foreach( index, value in vehicle )
					{
						if( DistanceFromPoint( value.vehicle.Pos.x, value.vehicle.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
						{
							if( VehicleVerifyOwnerAndSharer( index, playa[ player.ID ].ID ) )
							{
								findveh = index;
							}
						}
					}

					if( findveh )
					{
						switch( vehicle[ findveh ].Locked )
						{
							case true:
							vehicle[ findveh ].Locked = false;
							MsgPlr( 3, player, Lang.Unlockcar );

							LocalMessage( player.Pos, "UnLockVehLocal", player.Name, GetVehicleNameFromModel2( vehicle[ findveh ].Model ) );
							break;

							case false:
							vehicle[ findveh ].Locked = true;
							MsgPlr( 3, player, Lang.lockcar );

							LocalMessage( player.Pos, "LockVehLocal", player.Name, GetVehicleNameFromModel2( vehicle[ findveh ].Model ) );
							break;
						}
						VSaveData( vehicle[ findveh ] );
					}
					else MsgPlr( 2, player, Lang.NotNearOwnVeh );
				}
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;
	

		case "sharevehkey":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( text )
					{
						local plr = FindPlayer( text );

						if( plr )
						{
							if( plr.IsSpawned )
							{
								if( vehicle.rawin( player.Vehicle.ID ) )
								{
									if( player.ID != plr.ID )
									{
										if( vehicle[ player.Vehicle.ID ].Owner == playa[ player.ID ].ID )
										{		
											if( !vehicle[ player.Vehicle.ID ].Share.rawin( playa[ plr.ID ].ID.tostring() ) )
											{
												local v = split( vehicle[ player.Vehicle.ID ].UID2, "-" );

												vehicle[ player.Vehicle.ID ].Share.rawset( playa[ plr.ID ].ID.tostring(),
												{
													Time = time().tostring(),
												});
											
												MsgPlr( 3, player, Lang.VehicleShare, GetVehicleNameFromModel2( player.Vehicle.Model ), v[1], GetIngameTag( plr ) );
												MsgPlr( 7, plr, Lang.VehicleShare1, GetIngameTag( player ), GetVehicleNameFromModel2( player.Vehicle.Model ), v[1] );
												
												VSaveData( vehicle[ player.Vehicle.ID ] );
											}
											else MsgPlr( 2, player, Lang.AlreadyShareVehicle );
										}
										else MsgPlr( 2, player, Lang.VehicleAlreadyShare );
									}
									else MsgPlr( 2, player, Lang.VehicleCantShareSelf );
								}
								else MsgPlr( 2, player, Lang.NotOwner );
							}
							else MsgPlr( 2, player, Lang.PlrNotSpawned );
						}
						else MsgPlr( 2, player, Lang.UnknownPlr );
					}
					else MsgPlr( 2, player, Lang.SharecarSyntax );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "removevehkey":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( text )
					{
						local plr = FindPlayer( text );

						if( plr )
						{
							if( plr.IsSpawned )
							{
								if( vehicle.rawin( player.Vehicle.ID ) )
								{
									if( player.ID != plr.ID )
									{
										if( vehicle[ player.Vehicle.ID ].Owner == playa[ player.ID ].ID )
										{		
											if( vehicle[ player.Vehicle.ID ].Share.rawin( playa[ plr.ID ].ID.tostring() ) )
											{
												local v = split( vehicle[ player.Vehicle.ID ].UID2, "-" );

												vehicle[ player.Vehicle.ID ].Share.rawdelete( playa[ plr.ID ].ID.tostring() );

												MsgPlr( 3, player, Lang.VehicleUnShare, GetVehicleNameFromModel2( player.Vehicle.Model ), v[1], GetIngameTag( plr ) );
												MsgPlr( 7, plr, Lang.VehicleUnShare1, GetIngameTag( player ), GetVehicleNameFromModel2( player.Vehicle.Model ), v[1] );
												
												VSaveData( vehicle[ player.Vehicle.ID ] );
											}
											else MsgPlr( 2, player, Lang.AlreadyShareUnVehicle );
										}
										else MsgPlr( 2, player, Lang.NotOwner );
									}
									else MsgPlr( 2, player, Lang.UnShareSelf );
								}
								else MsgPlr( 2, player, Lang.NotOwner );
							}
							else MsgPlr( 2, player, Lang.PlrNotSpawned );
						}
						else MsgPlr( 2, player, Lang.UnknownPlr );
					}
					else MsgPlr( 2, player, Lang.SharecarSyntax );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "giveveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( text )
					{
						local plr = FindPlayer( text );

						if( plr )
						{
							if( plr.IsSpawned )
							{
								if( vehicle.rawin( player.Vehicle.ID ) )
								{
									if( player.ID != plr.ID )
									{
										if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
										{
											if( GetOwnerOrGroupOwner( player.Vehicle.ID, player ) )
											{		
												local v = split( vehicle[ player.Vehicle.ID ].UID2, "-" );
												
												vehicle[ player.Vehicle.ID ].Owner = playa[ plr.ID ].ID.tostring();
												
												if( vehicle[ player.Vehicle.ID ].Share.rawin( playa[ plr.ID ].ID.tostring() ) ) vehicle[ player.Vehicle.ID ].Share.rawdelete( playa[ plr.ID ].ID.tostring() );
												
												MsgPlr( 3, player, Lang.VehicleGive, GetVehicleNameFromModel2( player.Vehicle.Model ), v[1], plr.Name );
												MsgPlr( 7, plr, Lang.VehicleGive1, player.Name, GetVehicleNameFromModel2( player.Vehicle.Model ), v[1] );

												VSaveData( vehicle[ player.Vehicle.ID ] );
											}
											else MsgPlr( 2, player, Lang.NotOwner );
										}
										else MsgPlr( 2, player, Lang.NotNearPlr );
									}
									else MsgPlr( 2, player, Lang.UnShareSelf );
								}
								else MsgPlr( 2, player, Lang.NotOwner );
							}
							else MsgPlr( 2, player, Lang.PlrNotSpawned );
						}
						else MsgPlr( 2, player, Lang.UnknownPlr );
					}
					else MsgPlr( 2, player, Lang.GivecarSyntax );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;		

		case "repair":
		if( player.Vehicle )
		{
			if( IsPNS( player ) )
			{
				if( player.Vehicle.Health < 999 )
				{
					local getitem = area[ playa[ player.ID ].Area ].Items[ "24" ];
					local value = area[ playa[ player.ID ].Area ];

					if( !_Timer.Exists( playa[ player.ID ].RepairVehicle ) )
					{
						if( playa[ player.ID ].Cash >= getitem.Price.tointeger() )
						{
							if( getitem.Stock.tointeger() > 0 )
							{
								player.IsFrozen = true;

								MsgPlr( 3, player, Lang.RepairingVehicle );

								playa[ player.ID ].RepairVehicle = _Timer.Create( this, function()
								{
									player.Vehicle.ResetHandlingData( 13 );
									player.Vehicle.ResetHandlingData( 14 );
									player.Vehicle.Health = 1000;
									player.Vehicle.Fix();
									player.IsFrozen = false;

									playa[ player.ID ].DecCash( player, getitem.Price.tointeger() );

									vehicle[ player.Vehicle.ID ].IsDamage = false;

									area[ playa[ player.ID ].Area ].Items[ "24" ].Stock = ( area[ playa[ player.ID ].Area ].Items[ "24" ].Stock.tointeger() - 1 );
									area[ playa[ player.ID ].Area ].Income += getitem.Price.tointeger();

									MsgPlr( 3, player, Lang.RepairVehicle, getitem.Price.tointeger() );

									if( value.Owner == "100000" ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]This property is for sale for [#ffffff]$" + value.Price + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );
									else SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );
								}, 10000, 1 );
							}
							else MsgPlr( 2, player, Lang.PnSOutOfStock );
						}
						else MsgPlr( 2, player, Lang.NeedCashRepair, ( getitem.Price.tointeger() - playa[ player.ID ].Cash ) );
					}
					else MsgPlr( 2, player, Lang.RepairInProgress );
				}
				else MsgPlr( 2, player, Lang.NoNeedRepair );
			}
			else MsgPlr( 2, player, Lang.NotInPns );
		}
		else MsgPlr( 2, player, Lang.NotInVehicle );
		break;

		case "browse":
        if( player.IsSpawned )
        {
			if( !player.Vehicle )
			{
				if( !playa[ player.ID ].Knocked.IsKnocked )
				{
					if( player.World != player.UniqueWorld )
					{
						switch( playa[ player.ID ].Area )
						{
							case "sunshine-1":
							SendDataToClient( 13000, "sunshine", player );
							playa[ player.ID ].Showroom.Shop = "sunshine";
							break;

							case "biker-1":
							SendDataToClient( 13000, "bike", player );
							playa[ player.ID ].Showroom.Shop = "bike";
							break;

							default:
							MsgPlr( 2, player, Lang.NotAtVehShowroom );
							break;
						}
					}
					else MsgPlr( 2, player, Lang.AlreadyInVehBrowse );
				}
				else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
			}
			else MsgPlr( 2, player, Lang.NotOnFoot );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "changevehcolor":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( vehicle.rawin( player.Vehicle.ID ) )
					{
						if( IsVehDealership( player ) )
						{
							if( GetOwnerOrGroupOwner( player.Vehicle.ID, player ) )
							{
								if( text )
								{
									local col1 = GetTok( text, " ", 1 ), col2 = GetTok( text, " ", 2 );

									if( col1 && col2 )
									{
										if( IsNum( col1 ) && IsNum( col2 ) )
										{
											if( playa[ player.ID ].Cash >= 500 )
											{
												vehicle[ player.Vehicle.ID ].Col1 = col1.tointeger();
												vehicle[ player.Vehicle.ID ].Col2 = col1.tointeger();
												vehicle[ player.Vehicle.ID ].vehicle.Colour1  = col1.tointeger();
												vehicle[ player.Vehicle.ID ].vehicle.Colour2  = col2.tointeger();
												MsgPlr( 3, player, Lang.ChangevehColor );

												playa[ player.ID ].DecCash( player, 500 );
											
												VSaveData( vehicle[ player.Vehicle.ID ] );
											}
											else MsgPlr( 2, player, Lang.ChangevehColorNotEnough, ( 500 - playa[ player.ID ].Cash ) );
										}
										else MsgPlr( 2, player, Lang.ChangevehColorNotNum );
									}
									else MsgPlr( 2, player, Lang.ChangevehColorSyntax );
								}
								else MsgPlr( 2, player, Lang.ChangevehColorSyntax );
							}
							else MsgPlr( 2, player, Lang.NotOwner );
						}
						else MsgPlr( 2, player, Lang.NotAtVehShowroom );
					}
					else MsgPlr( 2, player, Lang.NotOwner );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "givevehtogroup":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( player.Vehicle )
				{
					if( text )
					{
						if( ::FindGang( text ) )
						{
							if( vehicle[ player.Vehicle.ID ].Owner.tostring() == playa[ player.ID ].ID.tostring() ) 
							{	
								if( playa[ player.ID ].Group.find( text ) >= 0 )
								{	
									if( ::GangGetLevelFromRank( text, gangv2[ text ].Members[ ::GangFindMember( text, playa[ player.ID ].ID ) ].Rank ) >= gangv2[ text ].Permission.gangchangecolor.tointeger() )
									{
										local v = split( vehicle[ player.Vehicle.ID ].UID2, "-" );
															
										vehicle[ player.Vehicle.ID ].Owner = "Group:" + text;
																												
										MsgPlr( 3, player, Lang.VehicleGive, GetVehicleNameFromModel2( player.Vehicle.Model ), v[1], gangv2[ text ].Name );

										VSaveData( vehicle[ player.Vehicle.ID ] );
									}
									else MsgPlr( 2, player, Lang.gNotAllowedCmd );
								}
								else MsgPlr( 2, player, Lang.gNotIn );
							}
							else MsgPlr( 2, player, Lang.NotOwner );
						}
						else MsgPlr( 2, player, Lang.gNotExist );
					}
					else MsgPlr( 2, player, Lang.GivecarToGroupSyntax );
				}
				else MsgPlr( 2, player, Lang.NotInVehicle );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;		


		case "listgroupveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					if( ::FindGang( text ) )
					{
						if( playa[ player.ID ].Group.find( text ) >= 0 )
						{
							if( ::GangGetLevelFromRank( text, gangv2[ text ].Members[ ::GangFindMember( text, playa[ player.ID ].ID ) ].Rank ) >= gangv2[ text ].Permission.gangchangecolor.tointeger() )
							{
								local clanz = null, sharer = null;

								foreach( id, kiki in vehicle ) 
								{ 
									if( kiki.Owner.find( "Group:" ) >= 0 )
									{
										local getname = split( kiki.Owner, ":" );
										if( getname[1] == text )
										{
											local v = split( kiki.UID2, "-" );
											if ( clanz ) clanz = format( Lang.MyVehicle[ playa[ player.ID ].Lang ], clanz, GetVehicleNameFromModel2( kiki.Model ), v[1] );
											else clanz = format( Lang.MyVehicle1[ playa[ player.ID ].Lang ], GetVehicleNameFromModel2( kiki.Model ), v[1] );
										}
									}
								}

								if( clanz ) MsgPlr( 3, player, Lang.Listgroupveh, gangv2[ text].Name, clanz );
								if( !clanz ) MsgPlr( 2, player, Lang.MyVehicleNoVehicle2 );
							}
							else MsgPlr( 2, player, Lang.gNotAllowedCmd );
						}
						else MsgPlr( 2, player, Lang.gNotIn );
					}
					else MsgPlr( 2, player, Lang.gNotExist );
				}
				else MsgPlr( 2, player, Lang.ListgroupvehSyntax );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;

		case "towgroupveh":
		if( p.Level >= 0 )
		{
			if( p.Logged == true )
			{
				if( text )
				{
					local gang = GetTok( text, " ", 1 ), id = GetTok( text, " ", 2 );

					if( gang && id )
					{
						if( ::FindGang( gang ) )
						{
							if( playa[ player.ID ].Group.find( gang ) >= 0 )
							{
								if( ::GangGetLevelFromRank( gang, gangv2[ gang ].Members[ ::GangFindMember( gang, playa[ player.ID ].ID ) ].Rank ) >= gangv2[ gang ].Permission.gangchangecolor.tointeger() )
								{
									if( IsNum( id ) )
									{
										if( GetGroupVehID( gang, id ) )
										{
											local veh = GetGroupVehID( gang, id );

											if( !vehicle[ veh ].vehicle.Driver )
											{
												if( playa[ player.ID ].Cash >= 5000 )
												{
													local v = split( vehicle[ veh ].UID2, "-" );

													playa[ player.ID ].DecCash( player, 5000 );

													vehicle[ veh ].vehicle.Pos = vehicle[ veh ].Pos;
													vehicle[ veh ].vehicle.EulerAngle = vehicle[ veh ].vehicle.EulerSpawnAngle;

													MsgPlr( 3, player, Lang.GroupTow, GetVehicleNameFromModel2( vehicle[ veh ].vehicle.Model ), v[1] );
												}
												else MsgPlr( 2, player, Lang.NeedCashFortow );
											}
											else MsgPlr( 2, player, Lang.VehicleHasDriver );
										}
										else MsgPlr( 2, player, Lang.GroupVehIDNotFound );
									}
									else MsgPlr( 2, player, Lang.GroupVehIDNotNum );
								}
								else MsgPlr( 2, player, Lang.gNotAllowedCmd );
							}
							else MsgPlr( 2, player, Lang.gNotIn );
						}
						else MsgPlr( 2, player, Lang.gNotExist );
					}
					else MsgPlr( 2, player, Lang.TowGroupVehSyntax );
				}
				else MsgPlr( 2, player, Lang.TowGroupVehSyntax );
			}
			else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		}
		else MsgPlr( 2, player, Lang.InvalidCmd ); break;
		break;






















	}
}
