sphere <- {}

function LoadSphere()
{
	local q = SafeSelect( mysql, "SELECT * FROM `sphere`" ),ID = 0;
	local result;
	while ( result = mysql_fetch_assoc( q ) )
	{		
		::sphere[ ID ]          <- {}
		::sphere[ ID ].Place    <- result["Name"];
		::sphere[ ID ].Pos      <- ConvertStringToPos( result["Pos"] );
		::sphere[ ID ].MaxCash  <- ( result["MaxCash"] == null ) ? 0 : result["MaxCash"].tointeger();
		::sphere[ ID ].Type     <- result["Type"];
		::sphere[ ID ].timer    <- 1453631537;
		::sphere[ ID ].World  <- ( result["World"] == null ) ? 0 : result["World"].tointeger();
		::sphere[ ID ].Rob      <- CreateCheckpoint( null, sphere[ ID ].World, true, sphere[ ID ].Pos, GetRGBColorFromString( result["Color"] ) , GetSphereSize( sphere[ ID ].Type ) );
		::sphere[ ID ].Count    <- 0;

		ID ++;
	}
		
	mysql_free_result( q );
	print( "\r[Sphere] " + sphere.len() + " spheres loaded.");
}


function GetRGBColorFromString( string )
{
	switch( string )
	{
		case "red": return ARGB( 255, 255, 0, 0 );
		case "blue": return ARGB( 255,0, 102, 255 );
		case "green": return ARGB( 255,0, 255, 64 );
		case "white": return ARGB( 255, 255, 255, 255 );
		default: return ARGB( 255, 0, 0, 255 );
	 }
}

function GetSphereSize( type )
{
	switch( type )
	{ 
		case "PnS":
		case "E1_Cop":
		case "E1_Civ":
		return 5;
		case "trucker": return 3;
		default: return 1.5;
	}
}

function onCheckpointEntered( player, spheres )
{
	local kaki = sphere.rawin( spheres.ID );
	if ( !kaki ) return ;
	
	switch( sphere[ spheres.ID ].Type )
	{
		case "robbery": return PlayerRob( player, spheres ); break;
		case "ammu": return SendDataToClient( 120, null, player ), player.IsFrozen = true; break;
		case "bank": return ShowBankInfo( player ); player.IsFrozen = true; break;
		case "carsell": return SendDataToClient( 96, null, player ), player.IsFrozen = true; break;
		case "Store": return SendDataToClient( 214, null, player ), player.IsFrozen = true; break;
		case "Arrest": return ArrestSphere( player ); break;
		case "Bike": return SendDataToClient( 95, null, player ), player.IsFrozen = true; break;
		case "PnS": if( player.Vehicle ) return SendDataToClient( 161, null, player ), player.IsFrozen = true; break;
		case "Sur": return playa [ player.ID ].SurSphere = true; break;
		case "Heal": return EnterToHeal( player ); break;
		case "CopFill": return ReFillVCPD( player ); break;
		case "Tool":  return SendDataToClient( 121, null, player ), player.IsFrozen = true; break;
		case "Heli Shop": return SendDataToClient( 212, null, player ), player.IsFrozen = true; break;
	//	case "EnterDM": return EnterDM( player ); break;
	//	case "ExitDM": return ExitDM( player ); break;
		case "BuyBed": return SendDataToClient( 6000, null, player ), player.IsFrozen = true; break;
		case "BuyFun": return SendDataToClient( 6000, null, player ), player.IsFrozen = true; break;
		case "BuyBM": return SendDataToClient( 6200, null, player ), player.IsFrozen = true; break;

		case "E1_Cop": return E1_EnterMilitaryAsCop( player ); break;
		case "E1_Civ": return E1_EnterMilitaryAsCiv( player ); break;
		case "EnterMusic": return SendDataToClient( 6400, null, player ); break;
		case "Boat": return SendDataToClient( 7500, null, player ), player.IsFrozen = true; break;
		case "trucker": return DeliverSphere( player, sphere[ spheres.ID ].Place ); break;
		default: return TelePickup( player, spheres ); break;
	}
  
}

function onCheckpointExited( player, spheres )
{
    local kaki = sphere.rawin( spheres.ID );
    if ( !kaki ) return;

	if( playa[ player.ID ].IsRobbing )
	{
		Announce("", player, 1 ); 
		sphere[ spheres.ID ].Count = 0; 
	//	sphere[ spheres.ID ].timer = time(); 
		MsgPlr( 2, player, Lang.RobFailMove );
		playa[ player.ID ].IsRobbing = false;
	//	playa[ player.ID ].AddWanted( player, 1 );
		SendDataToClient( 36, "stop" , player );
		player.SetAnim( 0, 44 );
		player.SetAnim( 0, 44 );			


		_Timer.Destroy( playa[ player.ID ].RobTimer );
	}
  
	switch( sphere[ spheres.ID ].Type )
	{
		//case "bank": return SendDataToClient( 82, null , player ); break;
		case "Sur": return playa [ player.ID ].SurSphere = false; break;
		case "Heal": 
		_Timer.Destroy( playa[ player.ID ].Healing );
		break;
		case "trucker":
		SendDataToClient( 9602, "" , player );
		break;
	}
  
	SendDataToClient( 7010, null, player );
}

function TelePickup( player, spe )
{
	local kaki = sphere.rawin( spe.ID );
	if ( !kaki || player.Vehicle ) return;

	switch( sphere[ spe.ID ].Type )
	{
		 case "To bank locker":
		 player.Pos = Vector( -933.277, -351.746, 7.22692 );  
		 break;
		 case "From bank locker":
		 player.Pos = Vector( -933.531, -351.39, 17.8038 );  
		 break;
		 case "To Office Buliding Lift(UP)":
		 player.Pos = Vector( -555.477, 788.2, 97.5104 );  
		 break;
		 case "To Office Buliding Lift(DOWN)":
		 player.Pos = Vector( -562.089, 782.275, 22.8768 );  
		 break;
		 case "To Lawyers Office":
		 player.Pos = Vector( 140.503, -1366.83, 13.1827 );  
		 break;
		 case "From Lawyers Office":
		 player.Pos = Vector( 145.115, -1373.62, 10.432 );  
		 break;
		 case "To Roof access near malibu #1":
		 player.Pos = Vector( 531.82, -127.311, 31.8522 );  
		 break;
		 case "From Roof access near malibu #1":
		 player.Pos = Vector( 531.851, -111.883, 10.7477 );  
		 break;
		 case "To Roof access near malibu #2":
		 player.Pos = Vector( 456.443, 30.3307, 34.8713 );  
		 break;
		 case "From Roof access near malibu #2":
		 player.Pos = Vector( 481.619, 30.4486, 11.0712 );  
		 break;
		 case "To Lovefist":
		 player.Pos = Vector( -943.87, 1077.19, 11.0946 );  
		 break;
		 case "From Lovefistcase":
		 player.Pos = Vector( -888.268, 1054.37, 14.689 );  
		 break;
		 case "To Roof Access in Downtown #1":
		 player.Pos = Vector( -820.836, 1355.72, 66.4525 );  
		 break;
		 case "From Roof Access in Downtown #1":
		 player.Pos = Vector( -828.593, 1304.96, 11.5887 );  
		 break;
		 case "To Bloodring":
		 player.Pos = Vector( -1423.86, 941.064, 260.276 );  
		 break;
		 case "From Bloodring":
		 player.Pos = Vector( -1088.61, 1312.74, 9.50517 );  
		 break;
		 case "To Racetrack(Stadium)":
		 player.Pos = Vector( -1412.4, 1159.08, 266.689 );  
		 break;
		 case "From Racetrack(Stadium)":
		 player.Pos = Vector( -1086.57, 1352.84, 9.50517 );  
		 break;
		 case "To VCN Building":
		 player.Pos = Vector(  -445.71, 1127.11, 56.6909 );  
		 break;
		 case "From VCN Building":
		 player.Pos = Vector( -408.424, 1114.92, 11.0709 );  
		 break;
		 case "To Roof Access in Downtown #2":
		 player.Pos = Vector( -444.803, 1253.35, 77.4241 );  
		 break;
		 case "From Roof Access in Downtown #2":
		 player.Pos = Vector( -449.452, 1252.74, 11.767 );  
		 break;
		 case "To V Rock(Near Lovefist)":
		 player.Pos = Vector( -880.359, 1159.52, 17.8184 );  
		 break;
		 case "From V Rock(Near Lovefist)":
		 player.Pos = Vector( -872.045, 1161.86, 11.16 );  
		 break;
		 case "To Dirtring":
		 player.Pos = Vector( -1332.08, 1453.91, 299.146 );  
		 break;
		 case "From Dirtring":
		 player.Pos = Vector( -1105.68, 1333.03, 20.07 );  
		 break;
		 case "To Lovefist roof":
		 player.Pos = Vector( -890.945, 1066.15, 75.8666 );  
		 break;
		 case "From Lovefist roof":
		 player.Pos = Vector( -887.988, 1046.99, 14.4515 );  
		 break;

		case "To Outside":
		if( playa[ player.ID ].House )
		{
			local oldworld = player.World;
			
			SaveObj( player );
			onPlayerExitWorld( oldworld );
			SendDataToClient( 6043, null, player );

			player.Pos = pickup[ playa[ player.ID ].House ].Pickup.Pos;

		//	Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );

			playa[ player.ID ].House = null;
			playa[ player.ID ].Area = null;

			player.World = 0;
			return;
		}

		else 
		{
			if( player.World > 1 )
			{
				local oldworld = player.World;
				playa[ player.ID ].House = null;
				playa[ player.ID ].Area = null;
				SaveObj( player );
				onPlayerExitWorld( oldworld );
				SendDataToClient( 6043, null, player );

				_Timer.Create( this, function( player ) 
				{
					player.World = 0;
					player.Pos = Vector( playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y, playa[ player.ID ].LastPos.z );

				}, 1000, 1, player );
				
				switch( playa[ player.ID ].Area )
				{
				/*	case "store-1":
					player.Pos = Vector(38.05, -1067.78, 10.4633);
					break;

					case "store-2":
					player.Pos = Vector(-872.894, -537.601, 11.1036);
					break;

					case "store-3":
					player.Pos = Vector(-880.283, 764.486, 11.0846);
					break;

					case "store-4":
					player.Pos = Vector(439.866, 789.153, 12.1234);
					break;

					case "store-5":
					player.Pos = Vector(-842.387, -640.586, 11.1331);
					break;*/

					default:
					player.Pos = Vector( playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y, playa[ player.ID ].LastPos.z );
					break;
				}
			}
		}

		//Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );
		break;

		 case "To VCPD INT":
		 Announce( "VCPD", player, 2 );
		 playa[ player.ID ].LastPos = player.Pos;
		 player.Pos = Vector( -1151.41, 904.346, 998.922 );
		 player.World = 2;
		 break;
		 
		 case "To Outside PD":
		 player.Pos = GetPosByDis( player );
		 Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );

		_Timer.Create( this, function( player ) 
		{
			player.World = 0;
			player.CanAttack = true;

		}, 1000, 1, player );		 
		 break;
		 case "To Biker Int":
		 player.Pos = Vector( 1072.11, -934.383, 1980.54 );
		 Announce("Biker", player, 2 );
		 player.World = 2;
		 break;
		 case "Exit Biker":
		 player.Pos = Vector( -599.376, 671.296, 11.0835 );
		 Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );
		_Timer.Create( this, function( player ) 
		{
			player.World = 0;

		}, 1000, 1, player );	
				 break;
		 case "EnterBed":
		 player.Pos = Vector( -2009.92, -177.285, 2033.67 );
		 Announce("Bed Shop", player, 2 );
		 player.World = 3;
		 break;
		 case "To Outside Bed":
		 player.Pos = Vector( -870.975, -177.993, 11.0845 );
		 Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );
		_Timer.Create( this, function( player ) 
		{
			player.World = 0;

		}, 1000, 1, player );	
		break;

		case "To Store Interior-1":
		case "To Store Interior-2":
		case "To Store Interior-3":
		case "To Store Interior-4":
		case "To Store Interior-5":
		case "To BM":

		if( !player.Vehicle ) SendDataToClient( 7000, "Press [H] to enter.", player );
		break;

	/*	case "To BM":
		if( playa[ player.ID ].JobID.find("cop") == null )
		{
			if( playa[ player.ID ].XPLevel >= 2 )
			{
				player.Pos = Vector( -546.124, -281.466, 301.177 );
				player.World = 5;
				player.CanAttack = false;

				Announce("Black Market", player, 2 );
			}
			else MsgPlr( 2, player, Lang.Need2ToEnterBM );
		}
		else MsgPlr( 2, player, Lang.CopCantEnterBM );
		break;
	*/

		case "To Outside BM":
		player.Pos = Vector( -1095.64, 122.189, 11.263 );
		player.CanAttack = true;

		playa[ player.ID ].Area = null;
		Announce( GetDistrictName( player.Pos.x, player.Pos.y ), player, 2 );
		_Timer.Create( this, function( player ) 
		{
			player.World = 0;

		}, 1000, 1, player );
		break;
		
		case "To Lounge":
		if( playa[ player.ID ].Level >= 2 )
		{
			player.Pos = Vector(-1359.52, -6.73112, 424.419);
			player.World = 1;
			Announce("Admin Lounge", player, 2 );
		}
		else MessagePlayer("[#bc0000]Only admins can enter the Admin Lounge.", player);
		break;

		case "To Outside Lounge":
		player.Pos = Vector(-1356.1, -31.8889, 424.419);
		break;
		
		case "To Jail Area":
		player.Pos = Vector(-1345.55, -33.6787, 424.142);
		player.World = 1;
		Announce("Admin Jail", player, 2 );
		break;

		case "To Outside Jail Area":
		player.Pos = Vector(-1356.1, -31.8889, 424.419);
		break;

	}
}

function GetPosByDis( p )
{

   switch( GetDistrictName( playa[ p.ID ].LastPos.x , playa[ p.ID ].LastPos.y ) )
   {
       case "Viceport":
	   case "Little Havana":
	   case "Little Haiti":
	   return Vector( -871.866+2, -685.598+2, 11.3002 );
	   case "Downtown Vice City":
	   return Vector( -655.381, 758.32, 11.1969 );
	   case "Prawn Island":
	   case "Vice Point":
	   return Vector( -1151.41, 905.55, 998.922 );
	   case "Ocean Beach":
	   case "Starfish Island":
	   case "Washington Beach":
	   return Vector( 397.348+2, -471.704+2, 12.0581 );
	   default: return Vector( 397.348+2, -471.704+2, 12.0581 );
	}
}

function EnterStore( type, player )
{
	playa[ player.ID ].LastPos = player.Pos;

	switch( type )
	{
		case "To Store Interior-1":
		playa[ player.ID ].Area = "store-1";
		player.World = 5;
		player.Pos = Vector( -1472.81, 641.648, 1002 );
		break;

		case "To Store Interior-2":
		playa[ player.ID ].Area = "store-2";
		player.World = 6;
		player.Pos = Vector( -1472.81, 641.648, 1002 );
		break;

		case "To Store Interior-3":
		playa[ player.ID ].Area = "store-3";
		player.World = 7;
		player.Pos = Vector( -1472.81, 641.648, 1002 );
		break;

		case "To Store Interior-4":
		playa[ player.ID ].Area = "store-4";
		player.World = 8;
		player.Pos = Vector( -1472.81, 641.648, 1002 );
		break;

		case "To Store Interior-5":
		playa[ player.ID ].Area = "store-5";
		player.World = 9;
		player.Pos = Vector( -1472.81, 641.648, 1002 );
		break;

		case "To BM":
		if( IsLawE( player ) ) return MsgPlr( 2, player, Lang.BMCops );
		playa[ player.ID ].Area = "black-market";
		player.World = 10;
		player.Pos = Vector( -546.124, -281.466, 301.177 );
		break;

	}
	//Announce("24-7 Store", player, 2 );

	if( area[ playa[ player.ID ].Area ].Welcome != "null" ) MsgPlr( 7, player, Lang.PropWel, area[ playa[ player.ID ].Area ].Welcome );

}

function IsBiz( type )
{
	switch( type )
	{
		case "To Store Interior-1":
		case "To Store Interior-2":
		case "To Store Interior-3":
		case "To Store Interior-4":
		case "To Store Interior-5":
		case "To BM":
		return true;
		break;
	}

}

function EnterBiz( player )
{
	foreach( index, value in sphere )
	{
		if( ( DistanceFromPoint( value.Rob.Pos.x, value.Rob.Pos.y, player.Pos.x, player.Pos.y ) <= 2 ) && IsBiz( value.Type ) )
		{
			SendDataToClient( 7010, null, player );

			EnterStore( value.Type, player );
		}
	}
}
