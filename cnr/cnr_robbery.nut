function PlayerRob( player, spheres )
{
  //  if ( playa[ player.ID ].JobID.find("cop") >= 0 ) return;
	 if ( player.VehicleStatus == 3 )
	{
		//MessagePlayer("[#ff3399]What are you? Superman? You can't rob while inside a vehicle!", player);
		return;
	}

	else
	{
    	local ID = spheres.ID, kaki = sphere.rawin( spheres.ID );
    	if ( !kaki ) return;
    	else
   		{
			if ( ( time() - sphere[ ID ].timer ) < 300 ) MsgPlr( 2, player, Lang.RobFail );
			else if ( sphere[ ID ].Count > 0 ) sphere[ ID ].Count = 0, MsgPlr( 2, player, Lang.RobFail );
			else
			{
			//   playa[ player.ID ].RobTimer = NewTimer( "RobTheShop", 1000, 10 , player.ID, spheres.ID );

				playa[ player.ID ].RobTimer = _Timer.Create( this, function( player, spheres ) 
				{
					sphere[ spheres.ID ].Count ++;

					switch( sphere[ spheres.ID ].Count )
					{
						case 15:
						local reward_xp = ( rand()%4 );
						local kiki = ( time() - sphere[ spheres.ID ].timer ) + 400;
					//	if ( kiki > sphere[ id2 ].MaxCash ) kiki = sphere[ id2 ].MaxCash;
						local MaxCash = sphere [ ID ].MaxCash;
						if ( kiki > 4000 ) kiki = ( rand()%MaxCash );
					//	playa[ player.ID ].AddXP( player, reward_xp );
						sphere[ spheres.ID ].timer = time(); 
						sphere[ spheres.ID ].Count = 0; 
						playa[ player.ID ].IsRobbing = false;
						playa[ player.ID ].AddCash( player, kiki );
						SendDataToClient( 36, "stop" , player );

						SendDataToClient( 6030, "Alert:You've robbed $" + kiki , player );

						playa[ player.ID ].RobTimer = null;
					//	MsgAll( 4, Lang.RobSucess, GetIngameTag( player ), kiki, sphere[ spheres.ID ].Place );

						player.SetAnim( 0, 44 );
						player.SetAnim( 0, 44 );			
						break;
					}
				}, 1000, 15, player, spheres );

				playa[ player.ID ].IsRobbing = true;
				SendDataToClient( 35, null , player );
				MsgPlr( 3, player, Lang.RobWait );

				player.SetAnim( 0, 11 );

			//	EchoMessage( "**" + player.Name + "** is robbing **" + sphere[ ID ].Place + "** at **" + GetDistrictName( player.Pos.x, player.Pos.y ) + "**." );
				MessageToAllLaw( "Dispatch", "PoliceRobbery", sphere[ ID ].Place, GetDistrictName( player.Pos.x, player.Pos.y ) ); 
			}
    	}
	}
}

function RobTheShop( id, id2 )
{
	local kiki = 0;
	sphere[ id2 ].Count ++;
	  
	local player = FindPlayer( id );
	if ( player )
	{

		switch( sphere[ id2 ].Count )
		{
		/*	case 1: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 2: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 3: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 4: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 5: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 6: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break; 
			case 7: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;
			case 8: SendDataToClient( 35, sphere[ id2 ].Count * 10 , player ); break;*/
			case 10:
			local reward_xp = ( rand()%4 );
			kiki = ( time() - sphere[ id2 ].timer ) - 119;
		//	if ( kiki > sphere[ id2 ].MaxCash ) kiki = sphere[ id2 ].MaxCash;
			if ( kiki > 4000 ) kiki = 4000;
		//	playa[ player.ID ].AddXP( player, reward_xp );
			sphere[ id2 ].timer = time(); 
			sphere[ id2 ].Count = 0; 
			playa[ player.ID ].IsRobbing = false;
			playa[ player.ID ].AddCash( player, kiki );
		//	playa[ player.ID ].AddWanted( player, 1 );
			SendDataToClient( 36, "stop" , player );

			SendDataToClient( 6030, "Alert:You've robbed $" + kiki , player );

			playa[ player.ID ].RobTimer = null;
		//	MsgAll( 4, Lang.RobSucess, GetIngameTag( player ), kiki, sphere[ id2 ].Place );

			player.SetAnim( 0, 44 );
			player.SetAnim( 0, 44 );			
			break;
		//	default: sphere[ id2 ].Count = 0; break;
		}
	}
}

function ExplodeVault( x, y, z, id )
{
	local player = FindPlayer( id )
	if( player )
	{
		if( InArea( player.Pos.x, player.Pos.y ) != "bank" ) Server.BankRobTimer = time(), Server.BankRobbery = 3, Server.BankRobber = null, MsgPlr( 2, player, Lang.BanrobFail );
		else
		{
			CreateExplosion( 0, 6, Vector( x, y, z ), -1, true );
			Server.BankRobTimer = time();
			Server.BankRobbery = 2;
			Server.BankRobber = null;

			playa[ player.ID ].AddWanted( player, 6 );

			Server.BankVault.Delete();
			Server.BankVault = CreateObject(4578, 0, Vector(-945.596, -342.627, 7.58308), 255);
			Server.BankVault.RotateTo( Quaternion(1.81072993282e-06, 1.81072993282e-06, -0.867764804312, -0.496975094336), 0 );

			MsgAll( 4, Lang.Banrob, GetIngameTag( player ) );
			EchoMessage("3** " + player.Name + " has cracked the vault door." );

			CreateCash();
		}
	}
}

banki <- [ Vector(-946.69, -342.016, 7.23199), Vector(-947.879, -341.833, 7.2304), Vector(-949.707, -341.551, 7.22794), Vector(-946.185, -346.945, 7.22695), Vector(-947.807, -346.358, 7.22695), Vector(-948.264, -347.854, 7.22695), Vector(-950.062, -347.203, 7.22695), Vector(-951.098, -346.829, 7.22695), Vector(-950.144, -348.147, 7.22695), Vector(-950.498, -345.382, 7.22694), Vector(-949.008, -346.235, 7.22695), Vector(-949.432, -343.892, 7.22694), Vector(-947.388, -343.723, 7.22761) ]
function CreateCash()
{
	foreach( kiki in banki )
	{
		local model = 337, plrworld = 0, plrname = 100000, plrpos = kiki, uid = MD5( time().tostring() );
		local pickupinstance = CreatePickup( model, plrworld, 0, plrpos, 255, true );

		pickup.rawset( pickupinstance.ID, 
		{
			Model = model, 
			Type = "bank",
			Quatity = 20000,
			World = 0,
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
		});

	}
}
