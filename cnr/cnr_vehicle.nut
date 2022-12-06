vehicle <- {}

function LoadVehicle()
{
    local q = SafeSelect(mysql, "SELECT * FROM `vehicles`"),ID = 1;
	local result;
	while( result = mysql_fetch_assoc( q ) )
	{
		local getID = CreateVehicle( result["Model"].tointeger(), 1, ConvertStringToPos( result["Pos"].tostring() ), result["Angle"].tofloat(), result["Col1"].tointeger(), result["Col2"].tointeger() );
		ID = getID.ID;

		vehicle.rawset( ID,
		{
			Model = result["Model"].tointeger(),
			Owner = result["Owner"],
			Share = json_decode( result["Share"] ),
			Pos = ConvertStringToPos( result["Pos"].tostring() ),
			PosString = result["Pos"],
			Angle = result["Angle"].tofloat(),
			Locked = ( result["Locked"] == "true" ) ? true : false,
			Col1 = result["Col1"].tointeger(),
			Col2 = result["Col2"].tointeger(),
			UID = result["UID"],
			UID2 = result["UID2"],
			Price = result["Price"],
			Body = 0,
			TruckerInvent = {},
			IsDamage = false,
			vehicle = getID,
		})
	}	
	mysql_free_result( q );
	print( "\r[Vehicle] " + vehicle.len() + " Vehicles loaded.");
	
}

function GetRadiansAngle(Rotation)
{
	local angle;
	angle = ::asin( Rotation.z ) * -2;
	return Rotation.w < 0 ? 3.14159 - angle : 6.28319 - angle;
}
   
function VSaveData( kiki )
{
	mysql_query( mysql, "UPDATE vehicles SET Owner = '" + kiki.Owner + "', Share = '" + json_encode( kiki.Share ) + "', Pos = '" + kiki.PosString + "', Locked = '" + kiki.Locked + "', Col1 = '" + kiki.Col1 + "', Col2 = '" + kiki.Col2 + "', Angle = '" + kiki.Angle + "' WHERE UID = '" + kiki.UID + "' " );
}

/*function VSaveData()
{
	foreach( kiki in vehicle )
	{
		QuerySQL( db, "UPDATE Vehicle SET Owner = '" +  kiki.Owner + "', Share = '" + kiki.Share + "', Pos = '" + kiki.PosString + "', Locked = '" + kiki.Locked + "', Col1 = '" + kiki.Col1 + "', Col2 = '" + kiki.Col2 + "', Angle = '" + kiki.Angle + "' WHERE UID = '" + kiki.UID + "' " );
	}
}*/

function GetVehicleType( model )
{
	// Returns: Car / Bike / Heli / Plane / Boat / RC
	switch ( model ) {
		case 136:
		case 160:
		case 176:
		case 182:
		case 183:
		case 184:
		case 190:
		case 202:
		case 203:
		case 214:
		case 223:
			return "Boat";
		case 155:
		case 165:
		case 217:
		case 218:
		case 227:
			return "Heli";
		case 166:
		case 178:
		case 191:
		case 192:
		case 193:
		case 198:
			return "Bike";
		case 171:
		case 194:
		case 195:
		case 231:
			return "RC";
		case 180:
		case 181:
			return "Plane";
		default:
			return "Car";
	}
}
		

function DefaultVehicleSpawn( model )
{
	switch( model )
	{
		case "Car":
		return { Pos = Vector(-975.54, -831.049, 6.80091 ), Angle = 1.50965 };
		case "Bike":
		return { Pos = Vector( -590.174, 620.104, 11.4557 ), Angle = 3.84221};
		case "Heli":
		return { Pos = Vector( -1125.4, 1445.94, 8.73682 ), Angle = -1.89766};
		case "Boat":
		return { Pos = Vector( -573.737, -1494.89, 7.39096 ), Angle = -1.80754};		
	}
}

function GetShowroomPos( type )
{
	switch( type )
	{
		case 1:
		case 2:
		case 3:
		case 4:
		return { Pos = Vector( -1018.92, -866.614, 17.4898 ), Camera = Vector( -1019.84, -856.062, 18.3374 ), Camera1 = Vector( -1018.92, -866.614, 17.4898 ), Angle = 0 };

		case 5:
		return { Pos = Vector( -588.869, 652.399, 11.4398 ), Camera = Vector( -589.267, 659.946, 10.9053 ), Camera1 = Vector( -588.869, 652.399, 11.4398 ), Angle = 0 };
	}
}

function GetVehicleType( model ) {
	// Returns: Car / Bike / Heli / Plane / Boat / RC
	switch ( model ) {
		case 136:
		case 160:
		case 176:
		case 182:
		case 183:
		case 184:
		case 190:
		case 202:
		case 203:
		case 214:
		case 223:
			return "Boat";
		case 155:
		case 165:
		case 217:
		case 218:
		case 227:
		case 199:
			return "Heli";
		case 166:
		case 178:
		case 191:
		case 192:
		case 198:
			return "Bike";
		case 171:
		case 194:
		case 195:
		case 231:
			return "RC";
		case 180:
		case 181:
			return "Plane";
		default:
			return "Car";
	}
}

function GetVehSpawnPos( model )
{
	switch( GetVehicleType( model ) )
	{
		case "Bike": return "-590.174, 620.104, 11.4557";
	}
}

function TrackCar( id )
{
	local player = FindPlayer( id );
	
	if( player )
	{
		if( playa[ player.ID ].vehicleicon.len() > 0 )
		{
			foreach( id, kiki in playa[ player.ID ].vehicleicon )
			{
				DestroyMarker( kiki );
				playa[ player.ID ].vehicleicon.remove( playa[ player.ID ].vehicleicon.find( kiki ) ) ;
			}
			
			if( playa[ player.ID ].vehicleicon.len() == 0 )
			{
				foreach ( id, kiki in vehicle ) 
				{ 
					if ( kiki.Owner == "100000" ) 
					{
						playa[ player.ID ].vehicleicon.push( CreateMarker( player.UniqueWorld, kiki.vehicle.Pos, 2, RGB(55, 153, 0), 0 ) );
					}
				}
			}
		}
	}
}

function DelMarker( player )
{	
	if( playa[ player.ID ].vehicleicon.len() > 0 )
	{
		playa[ player.ID ].vehicleTimer.Stop();
		playa[ player.ID ].vehicleTimer = null;
		foreach( id, kiki in playa[ player.ID ].vehicleicon )
		{
			DestroyMarker( kiki );
			playa[ player.ID ].vehicleicon.remove( playa[ player.ID ].vehicleicon.find( kiki ) ) ;
		}
	}
}

function onPlayerEnteringVehicle( player, vehicles, door )
{
	local verify = vehicle.rawin( vehicles.ID );
	
	if( !verify ) return 1;

	if( vehicle[ vehicles.ID ].Locked == true ) return;

/*	if( vehicle[ vehicles.ID ].Locked && !VehicleVerifyOwnerAndSharer( vehicles.ID, playa[ player.ID ].ID ) )
	{
		return MsgPlr( 2, player, Lang.CantEnterCarLocked );
	}
	
	if( vehicles.Model == 156 || vehicles.Model == 157 || vehicles.Model == 236 || vehicles.Model == 177 )
	{
		if( door == 0 )
		{
			if( playa[ player.ID ].JobID.find("cop") >= 0 )
			{
				return 1;
			}
			else return MsgPlr( 2, player, Lang.CantEnterCopCar );
		}
		else return 1;
	}

	if( vehicles.Model == 155 )
	{
		if( door == 0 )
		{
			if( playa[ player.ID ].Copskill >= 200 && playa[ player.ID ].JobID.find("cop") >= 0  )
			{
				return 1;
			}
			else return MsgPlr( 2, player, Lang.CantEnterCopCar2 );
		}
		else return 1;
	}
	else return 1;*/

	if( door == 0 )
	{
		if( vehicle[ vehicles.ID ].Owner.find( "Group:" ) >= 0 )
		{
			local getname = split( vehicle[ vehicles.ID ].Owner, ":" );

			switch( getname[1] )
			{
				case "EMS":
				if( playa[ player.ID ].Job.JobID == 2 ) return 1;
				else return MsgPlr( 2, player, Lang.VehicleOwnedByJob );
				break;

				case "VCPD":
				if( IsLawE( player ) ) return 1;
				else return MsgPlr( 2, player, Lang.VehicleOwnedByJob );
				break;

				case "SWAT":
				if( playa[ player.ID ].Job.JobID == 4 ) return 1;
				else return MsgPlr( 2, player, Lang.VehicleOwnedByJob );
				break;

				case "FBI":
				if( playa[ player.ID ].Job.JobID == 5 ) return 1;
				else return MsgPlr( 2, player, Lang.VehicleOwnedByJob );
				break;

				default:
				if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
				{
					if( ::GangGetLevelFromRank( getname[1], gangv2[ getname[1] ].Members[ ::GangFindMember( getname[1], playa[ player.ID ].ID ) ].Rank ) < gangv2[ getname[1] ].Permission.ganglock.tointeger() ) return MsgPlr( 2, player, Lang.GroupVehicleNotPerm  );
					else return 1;
				}
				else return MsgPlr( 2, player, Lang.GroupVehicleCantEnterNotPart, gangv2[ getname[1] ].Name );
				break;
			}
		}

		if( vehicle[ vehicles.ID ].Owner.find( "Job:" ) >= 0 )
		{
			local getname = split( vehicle[ vehicles.ID ].Owner, ":" );

			switch( getname[1] )
			{
				case "Trucker":
				if( playa[ player.ID ].Job.JobID == 1 ) return 1;
				else return MsgPlr( 2, player, Lang.VehicleOwnedByJob );
				break;
			}
		}
	}

	return 1;
}

function onPlayerEnterVehicle( player, v, door )
{	
	local verify = vehicle.rawin( v.ID );
	
	if( !verify ) return;
	if( player.World == player.UniqueWorld ) return;

	if( vehicle[ v.ID ].Owner == "100000" ) return MsgPlr( 3, player, Lang.VehicleEnterNoOwner );
	if( vehicle[ v.ID ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( vehicle[ v.ID ].Owner, ":" );

		MsgPlr( 3, player, Lang.VehicleEnterHasOwner, gangv2[ getname[1] ].Name );

		return;
	}

	if( vehicle[ v.ID ].Owner.find( "Job:" ) >= 0 ) MsgPlr( 3, player, Lang.VehicleEnterOwnedByJob );

	else 
	{
		if( vehicle[ v.ID ].Owner == playa[ player.ID ].ID.tostring() ) MsgPlr( 3, player, Lang.VehicleEnterHasOwner2 );
		else MsgPlr( 3, player, Lang.VehicleEnterHasOwner, mysqldb.GetNameFromID( vehicle[ v.ID ].Owner ) );
	}
}
			
function onVehicleExplode( v )	
{
	//onEventVehicleExplode( v );
	local verify = vehicle.rawin( v.ID );
	
	if( !verify ) return;

	vehicle[ v.ID ].TruckerInvent = {};
}

function onPlayerExitVehicle( player, vehicles )
{
	if( playa[ player.ID ].Job.JobID == 1 ) SendDataToClient( 9602, "" , player );

	if( playa[ player.ID ].Showroom.Vehicle ) player.Vehicle = vehicles;
}

function BuyPnS( player, string )
{
	if( !player.Vehicle ) return MsgPlr( 2, player, Lang.NotInVehicle );
	if( vehicle.rawin( player.Vehicle.ID ) == false ) return;
	
	if( string == "fixveh")
	{
		 if( 1000 > playa[ player.ID ].Cash )
		{
			if( player.Vehicle.Health == 1000 ) MsgPlr( 2, player, Lang.FixAlready100 );
			if( playa[ player.ID ].Bank == false ) MsgPlr( 2, player, Lang.FixNotEnoughCash );
			else if( 500 > playa[ player.ID ].Bank ) MsgPlr( 2, player, Lang.FixNotEnoughCash );
			else 
			{
				player.Vehicle.Fix();
				MsgPlr( 3, player, Lang.FixVeh );
				playa[ player.ID ].DecBank( player, 1000 );
				AddIncome( playa[ player.ID ].Area, 1000 );
				
				VSaveData( vehicle[ player.Vehicle.ID ] );
			}
			
		}
		
		else
		{
			if( player.Vehicle.Health == 1000 ) MsgPlr( 2, player, Lang.FixAlready100 );
			else
			{
				player.Vehicle.Fix();
				MsgPlr( 3, player, Lang.FixVeh );
				playa[ player.ID ].DecCash( player, 1000 );
				AddIncome( playa[ player.ID ].Area, 1000 );
				
				VSaveData( vehicle[ player.Vehicle.ID ] );
			}
		}
	}
	
	else
	{
		local s = split( string, ":" )
		
		if( 500 > playa[ player.ID ].Cash )
		{
			if( playa[ player.ID ].Bank == false ) MsgPlr( 2, player, Lang.PaintNotEnoughCash );
			else if( 500 > playa[ player.ID ].Bank ) MsgPlr( 2, player, Lang.PaintNotEnoughCash );
			else if( vehicle[ player.Vehicle.ID ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.NotOwner );
			else
			{
				if( s[1] == "1" ) player.Vehicle.Colour1 = s[0].tointeger(), vehicle[ player.Vehicle.ID ].Col1 = s[0].tointeger();
				else if( s[1] == "2" ) player.Vehicle.Colour2 = s[0].tointeger(), vehicle[ player.Vehicle.ID ].Col2 = s[0].tointeger();
				MsgPlr( 3, player, Lang.PaintCar );
				playa[ player.ID ].DecBank( player, 500 );
				AddIncome( playa[ player.ID ].Area, 500 );
				
				VSaveData( vehicle[ player.Vehicle.ID ] );
			}
			
		}
		
		else
		{
			if( vehicle[ player.Vehicle.ID ].Owner != playa[ player.ID ].ID ) MsgPlr( 2, player, Lang.NotOwner );
			else
			{
				if( s[1] == "1" ) player.Vehicle.Colour1 = s[0].tointeger(), vehicle[ player.Vehicle.ID ].Col1 = s[0].tointeger();
				else if( s[1] == "2" ) player.Vehicle.Colour2 = s[0].tointeger(), vehicle[ player.Vehicle.ID ].Col2 = s[0].tointeger();
				MsgPlr( 3, player, Lang.PaintCar );
				playa[ player.ID ].DecCash( player, 500 );
				AddIncome( playa[ player.ID ].Area, 500 );
				
				VSaveData( vehicle[ player.Vehicle.ID ] );
			}
		}
	}
}

function getPlayerVehicleCount( id )
{
	local count = 0;
	foreach ( id, kiki in vehicle ) 
    { 
        if ( kiki.Owner == id ) 
        {
        	count ++;
		}
	}

	return count;
}


function VehicleVerifyOwnerAndSharer( vehid, playerid )
{	
	local player = FindPlayerByAccID( playerid );

	if( !vehicle.rawin( vehid ) ) return;

	if( vehicle[ vehid ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( vehicle[ vehid ].Owner, ":" );
		
		if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
		{
			if( ::GangGetLevelFromRank( getname[1], gangv2[ getname[1] ].Members[ ::GangFindMember( getname[1], playa[ player.ID ].ID ) ].Rank ) < gangv2[ getname[1] ].Permission.ganglock.tointeger() ) return false;
			else return 1;
		}
		else return false;
	}

	if( vehicle[ vehid ].Owner == "100000" ) return false;
	
	if( vehicle[ vehid ].Owner == playerid.tostring() ) return true;
	if( vehicle[ vehid ].Share.rawin( playerid.tostring() ) ) return true;
	// VerifyMember( player )


}

function GetOwnerOrGroupOwner( vehid, player )
{
	if( vehicle[ vehid ].Owner == playa[ player.ID ].ID.tostring() ) return true;

	if( vehicle[ vehid ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( vehicle[ vehid ].Owner, ":" );
		
		if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
		{
			if( ::GangGetLevelFromRank( getname[1] ,gangv2[ getname[1] ].Members[ ::GangFindMember( getname[1], playa[ player.ID ].ID ) ].Rank ) < gangv2[ getname[1] ].Permission.gangchangecolor.tointeger() ) return false;
			else return 1;
		}
		else return false;
	}
}

function GetNearestAmbulance( player )
{
    local findam = null;
    foreach( index, value in vehicle )
    {
        if( value.Model == 146 )
        {
            if( DistanceFromPoint( value.vehicle.Pos.x, value.vehicle.Pos.y, player.Pos.x, player.Pos.y ) <= 10 ) findam = index;
        }
    }

	return findam;
}

function GetNearestPDEquip( player )
{
    local findam = null;
    foreach( index, value in vehicle )
    {
		if( value.Owner.find( "Group:" ) >= 0 )
		{
			local getname = split( value.Owner, ":" );

			switch( getname[1] )
			{
				case "FBI":
				case "VCPD":
				case "SWAT":

				switch( value.Model )
				{
					case 6410:
					case 157:
					if( DistanceFromPoint( value.vehicle.Pos.x, value.vehicle.Pos.y, player.Pos.x, player.Pos.y ) <= 10 ) findam = index;
					break;
				}
				break;
			}
		}
    }

	return findam;
}

function onVehicleHealthChange( vehicles, oldHP, newHP )
{
	local verify = vehicle.rawin( vehicles.ID );
	
	if( !verify ) return;

	if( newHP < 250 ) 
	{
		if( vehicles.Driver ) MsgPlr( 2, vehicles.Driver, Lang.EngineBroke );

		vehicles.SetHandlingData( 13, 0 );
		vehicles.SetHandlingData( 14, 0 );
		vehicles.Health = 250;
		vehicles.Immunity = 31;
		vehicle[ vehicles.ID ].IsDamage = true;
	}
}

function CheckVehicles()
{
	foreach( index, value in vehicle )
	{
		if( value.vehicle )
		{
			if( !value.vehicle.Driver ) value.vehicle.Immunity = 31;
			else value.vehicle.Immunity = 0;
		}
	}
}

function onVehicleRespawn( vehicles ) 
{
	local verify = vehicle.rawin( vehicles.ID );
	
	if( !verify ) return;

	if( vehicle[ vehicles.ID ].IsDamage == true ) vehicles.Health = 230;
}

function DestroyFixVehicle( player )
{
	if( _Timer.Exists( playa[ player.ID ].RepairVehicle ) )
	{
		player.IsFrozen = false;

		_Timer.Destroy( playa[ player.ID ].RepairVehicle );
	}
}

function CreateShowroom( player, type )
{
	local state, startingvehicle;

	playa[ player.ID ].LastPos = player.Pos;

	switch( type )
	{
		case "4 Doors":
		state = 1;
		startingvehicle = 134;
		break;

		case "Vans":
		state = 2;
		startingvehicle = 179;
		break;

		case "Sports":
		state = 3;
		startingvehicle = 132;
		break;

		case "2 Doors":
		state = 4;
		startingvehicle = 131;
		break;

		case "Bikes":
		state = 5;
		startingvehicle = 192;
		break;

	}

	player.World = player.UniqueWorld;
	player.Vehicle = CreateVehicle( startingvehicle, player.UniqueWorld, GetShowroomPos( state ).Pos,  GetShowroomPos( state ).Angle, 0, 0 );
			
	local GenerateUID = playa[ player.ID ].Password +""+ time();
	local AddID = player.Vehicle.ID;

	player.IsFrozen = true;


	vehicle.rawset( player.Vehicle.ID,
	{
		Model = 6410,
		Owner = "100000",
		Share = {},
		Pos =  Vector( player.Pos.x.tofloat(), player.Pos.y.tofloat(), player.Pos.z.tofloat() ),
		PosString = player.Pos.x.tofloat() + ", " + player.Pos.y.tofloat() + "," + player.Pos.z.tofloat(),
		Angle = player.Angle.tofloat(),
		Locked = false,
		Col1 = 0,
		Col2 = 0,
		UID = GenerateUID,
		UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9,
		Price = 0,
		Body = 0,
		TruckerInvent = {},
		vehicle = player.Vehicle,
		IsDamage = false,
	})

	playa[ player.ID ].Showroom.Vehicle = player.Vehicle;
	playa[ player.ID ].Showroom.Menu = state;
	playa[ player.ID ].Showroom.State = 1;
	//playa[ player.ID ].Showroom.Shop = shop;
	
	NextVehicle( player );

	player.SetCameraPos(  GetShowroomPos( state ).Camera,  GetShowroomPos( state ).Camera1 );
}

function NextVehicle( player )
{
    try 
    {
            if( playa[ player.ID ].Showroom.Vehicle )
            {
                local model = 0;
                local price = 0;
                local state = 0;

                switch( playa[ player.ID ].Showroom.Menu )
                {
                    // 4 door
                    case 1:
                    switch( playa[ player.ID ].Showroom.State )
                    {
                        case 1:
                        model = 134;
                        price = 30000;
                        state = 1;
                        break;

                        case 2:
                        model = 148;
                        price = 35000;
                        state = 2;
                        break;

                        case 3:
                        model = 130;
                        price = 60000;
                        state = 3;
                        break;

                        case 4:
                        model = 196;
                        price = 70000;
                        state = 4;
                        break;

                        case 5:
                        model = 197;
                        price = 75000;
                        state = 5;
                        break;

                        case 6:
                        model = 222;
                        price = 80000;
                        state = 6;
                        break;

                        case 7:
                        model = 135;
                        price = 100000;
                        state = 7;
                        break;

                        case 8:
                        model = 175;
                        price = 200000;
                        state = 8;
                        break;

                        case 9:
                        model = 209;
                        price = 210000;
                        state = 9;
                        break;

                        case 10:
                        model = 200;
                        price = 250000;
                        state = 10;
                        break;

                        case 11:
                        model = 139;
                        price = 300000;
                        state = 11;
                        break;

                        case 12:
                        model = 151;
                        price = 250000;
                        state = 12;
                        break;

                        case 13:
                        model = 201;
                        price = 350000;
                        state = 13;
                        break;

                        case 14:
                        model = 174;
                        price = 420000;
                        state = 14;
                        break;

                        default: 
                        if( playa[ player.ID ].Showroom.State == 15 )
                        {
                            model = 134;
                            price = 30000;
                            state = 1;
                        }

                        else 
                        {
                            model = 174;
                            price = 420000;
                            state = 14;
                        }
                        break;
                    }
                    break;

                    // vans
                    case 2:
                    switch( playa[ player.ID ].Showroom.State )
                    {
                        case 1:
                        model = 179;
                        price = 50000;
                        state = 1;
                        break;

                        case 2:
                        model = 212;
                        price = 45000;
                        state = 2;
                        break;

                        case 3:
                        model = 143;
                        price = 45000;
                        state = 3;
                        break;

                        case 4:
                        model = 170;
                        price = 55000;
                        state = 4;
                        break;

                        case 5:
                        model = 189;
                        price = 55000;
                        state = 5;
                        break;

                        default: 
                        if( playa[ player.ID ].Showroom.State == 6 )
                        {
                            model = 179;
                            price = 50000;
                            state = 1;
                        }

                        else 
                        {
                            model = 189;
                            price = 55000;
                            state = 5;
                        }
                        break;
                    }
                    break;
                    
                    // sports
                    case 3: 
                    switch( playa[ player.ID ].Showroom.State )
                    {
                        case 1:
                        model = 132;
                        price = 250000;
                        state = 1;
                        break;

                        case 2:
                        model = 159;
                        price = 340000;
                        state = 2;
                        break;

                        case 3:
                        model = 207;
                        price = 450000;
                        state = 3;
                        break;

                        case 4:
                        model = 210;
                        price = 450000;
                        state = 4;
                        break;

                        case 5:
                        model = 211;
                        price = 500000;
                        state = 5;
                        break;

                        case 6:
                        model = 226;
                        price = 450000;
                        state = 6;
                        break;

                        case 7:
                        model = 145;
                        price = 550000;
                        state = 7;
                        break;

                        case 8:
                        model = 141;
                        price = 750000;
                        state = 8;
                        break;

                        default: 
                        if( playa[ player.ID ].Showroom.State == 9 )
                        {
                            model = 132;
                            price = 250000;
                            state = 1;
                        }

                        else 
                        {
                            model = 141;
                            price = 750000;
                            state = 8;
                        }
                        break;			
                    }
                    break;

                    // 2 doors
                    case 4: 
                    switch( playa[ player.ID ].Showroom.State )
                    {
                        case 1:
                        model = 131;
                        price = 20000;
                        state = 1;
                        break;

                        case 2:
                        model = 140;
                        price = 30000;
                        state = 2;
                        break;

                        case 3:
                        model = 140;
                        price = 32000;
                        state = 3;
                        break;

                        case 4:
                        model = 142;
                        price = 40000;
                        state = 4;
                        break;

                        case 5:
                        model = 149;
                        price = 42000;
                        state = 5;
                        break;

                        case 6:
                        model = 164;
                        price = 66000;
                        state = 6;
                        break;

                        case 7:
                        model = 169;
                        price = 55000;
                        state = 7;
                        break;

                        case 8:
                        model =204 ;
                        price = 60000;
                        state = 8;
                        break;

                        case 9:
                        model = 205;
                        price = 65000;
                        state = 9;
                        break;

                        case 10:
                        model = 221;
                        price = 45000;
                        state = 10;
                        break;

                        case 11:
                        model = 230;
                        price = 35000;
                        state = 11;
                        break;

                        case 12:
                        model = 219;
                        price = 75000;
                        state = 12;
                        break;

                        default: 
                        if( playa[ player.ID ].Showroom.State == 13 )
                        {
                            model = 131;
                            price = 20000;
                            state = 1;
                        }

                        else 
                        {
                            model = 219;
                            price = 75000;
                            state = 12;
                        }
                        break;			

                    }
                    break;

                    case 5: //bike
                    switch( playa[ player.ID ].Showroom.State )
                    {
                        case 1:
                        model = 192;
                        price = 15000;
                        state = 1;
                        break;

                        case 2:
                        model = 193;
                        price = 45000;
                        state = 2;
                        break;

                        case 3:
                        model = 166;
                        price = 55000;
                        state = 3;
                        break;

                        case 4:
                        model = 198;
                        price = 75000;
                        state = 4;
                        break;

                        case 5:
                        model = 191;
                        price = 200000;
                        state = 5;
                        break;

                        default: 
                        if( playa[ player.ID ].Showroom.State == 6 )
                        {
                            model = 192;
                            price = 15000;
                            state = 1;
                        }

                        else 
                        {
                            model = 191;
                            price = 200000;
                            state = 5;
                        }
                        break;			

                    }
                    break;
                }

                local oldveh = playa[ player.ID ].Showroom.Vehicle.ID;
                local newveh = CreateVehicle( model, player.UniqueWorld, GetShowroomPos( playa[ player.ID ].Showroom.Menu ).Pos, 0, 0, 0 );
                
                playa[ player.ID ].Showroom.Vehicle.Delete();
                
                vehicle.rawdelete( oldveh );

                player.Vehicle = newveh;
                local GenerateUID = playa[ player.ID ].Password +""+ time();

                vehicle.rawset( newveh.ID,
                {
                    Model = newveh.Model,
                    Owner = "100000",
                    Share = {},
                    Pos =  Vector( player.Pos.x.tofloat(), player.Pos.y.tofloat(), player.Pos.z.tofloat() ),
                    PosString = player.Pos.x.tofloat() + ", " + player.Pos.y.tofloat() + "," + player.Pos.z.tofloat(),
                    Angle = player.Angle.tofloat(),
                    Locked = false,
                    Col1 = 0,
                    Col2 = 0,
                    UID = GenerateUID,
                    UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9,
                    Price = 0,
                    Body = 0,
                    TruckerInvent = {},
                    vehicle = newveh,
                    IsDamage = false,
                })

                playa[ player.ID ].Showroom.State = state;
                playa[ player.ID ].Showroom.Vehicle = player.Vehicle;
                playa[ player.ID ].Showroom.Price = price; 
                playa[ player.ID ].Showroom.Model = model;

                SendDataToClient( 12000, GetVehicleNameFromModel2( model ) + ";" + price, player );
            }
    }
    catch( e ) print( e );
}

function DestroyShowroom( player )
{
	if( playa[ player.ID ].Showroom.Vehicle )
	{
		local oldveh = playa[ player.ID ].Showroom.Vehicle.ID;

		playa[ player.ID ].Showroom.Vehicle.Remove();
		playa[ player.ID ].Showroom.Vehicle = null;
		playa[ player.ID ].Showroom.State = 0;
		playa[ player.ID ].Showroom.Menu = 0;
		playa[ player.ID ].Showroom.Price = 0;
		
		vehicle.rawdelete( oldveh );

		player.World = 1;
		player.RestoreCamera();
		player.IsFrozen = false;
		player.Pos = playa[ player.ID ].LastPos;

		SendDataToClient( 12020, "", player );
		SendDataToClient( 13000, playa[ player.ID ].Showroom.Shop, player );
	}
}

function NextShowroomVehicle( player )
{
	if( playa[ player.ID ].Showroom.Vehicle )
	{
		playa[ player.ID ].Showroom.State = ( playa[ player.ID ].Showroom.State + 1 );

		NextVehicle( player );
	}
}

function PreviousShowroomVehicle( player )
{
	if( playa[ player.ID ].Showroom.Vehicle )
	{
		playa[ player.ID ].Showroom.State --;

		NextVehicle( player );
	}
}

function PurchaseVehicle( player )
{
	if( playa[ player.ID ].Showroom.Vehicle )
	{
		if( playa[ player.ID ].Cash >= playa[ player.ID ].Showroom.Price )
		{
			local getpos = DefaultVehicleSpawn( GetVehicleType( playa[ player.ID ].Showroom.Model ) );

			player.World = 1;
			player.Vehicle = CreateVehicle( playa[ player.ID ].Showroom.Model, 1, getpos.Pos, getpos.Angle, 0, 0 );
				
			local GenerateUID = playa[ player.ID ].Password +""+ time();
			local AddID = player.Vehicle.ID;

			vehicle.rawset( player.Vehicle.ID,
			{
				Model = playa[ player.ID ].Showroom.Model,
				Owner = playa[ player.ID ].ID.tostring(),
				Share = {},
				Pos =  getpos.Pos,
				PosString = getpos.Pos.x.tofloat() + ", " + getpos.Pos.y.tofloat() + "," + getpos.Pos.z.tofloat(),
				Angle = getpos.Angle.tofloat(),
				Locked = false,
				Col1 = 0,
				Col2 = 0,
				UID = GenerateUID,
				UID2 = "VC-" + rand()%9 + rand()%9 + rand()%9 + rand()%9,
				Price =  playa[ player.ID ].Showroom.Price,
				Body = 0,
				TruckerInvent = {},
				vehicle = player.Vehicle,
				IsDamage = false,
			})

			playa[ player.ID ].DecCash( player, playa[ player.ID ].Showroom.Price );

			SendDataToClient( 12020, "", player );

			MsgPlr( 3, player, Lang.PurchaseVehicle, GetVehicleNameFromModel2( vehicle[ AddID ].Model ), playa[ player.ID ].Showroom.Price );

			mysql_query( mysql, "insert into vehicles ( Model, Owner, Share, Pos, Angle, Locked, Col1, Col2, UID, UID2, World, Price ) VALUES ( '" + vehicle[ AddID ].Model + "', '" + playa[ player.ID ].ID.tostring() + "', 'N/A', '" + vehicle[ AddID ].PosString + "', '" + vehicle[ AddID ].Angle + "', 'false', '0', '0', '" + vehicle[ AddID ].UID + "', '" + vehicle[ AddID ].UID2 + "', '0', '" + vehicle[ AddID ].Price + "' )" );			
		
			playa[ player.ID ].Showroom.Vehicle.Remove();
			playa[ player.ID ].Showroom.Vehicle = null;
			playa[ player.ID ].Showroom.State = 0;
			playa[ player.ID ].Showroom.Menu = 0;
			playa[ player.ID ].Showroom.Price = 0;

			player.RestoreCamera();
			player.IsFrozen = false;

		}
		else MsgPlr( 2, player, Lang.NotEnoughBuyCar, ( playa[ player.ID ].Showroom.Price - playa[ player.ID ].Cash ) );
	
	
	
	
	}
}

function GetVehicleNameFromModel2( model )
{
	switch( model )
	{
		case 6410:
		return "FBI Rancher";

		case 6411:
		return "SWAT Tank";

		default:
		return GetVehicleNameFromModel( model );
	}
}

function GetGroupVehID( group, id )
{
	foreach( index, kiki in vehicle ) 
	{ 
		if( kiki.Owner.find( "Group:" ) >= 0 )
		{
			local getname = split( kiki.Owner, ":" );
			if( getname[1] == group )
			{
				local v = split( kiki.UID2, "-" );

				if( v[1] == id.tostring() ) return index;
			}
		}
	}
}