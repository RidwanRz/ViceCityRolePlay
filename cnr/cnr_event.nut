
function E1_StartMilitaryEvent()
{
	MsgAll( 9, Lang.E1_Start );
	Server.Event.Event = 1;
	Server.Event.Timer = time();
	
	foreach( a in vehicle )
	{
		if( a.UID2 == "VC-159")
		{
			a.vehicle.Pos = Vector( -657.34, -1386.04, 10.9206 );
			a.vehicle.EulerAngle = Vector(0.0348953, -0.0359137, 1.27505);
			a.vehicle.Fix();
		}
	}
	
	foreach( a in sphere )
	{
		if( a.Place == "e1" )
		{
			a.Rob.World = 0;
		}
	}

	
}

function onPlayerEnterEventVehicle( player, v )
{
	if( vehicle[ v.ID ].UID2 == "VC-159" && Server.Event.Event == 1 )
	{
		if( playa[ player.ID ].JobID.find("cop") >= 0 )
		{
			MsgPlr( 3, player, Lang.E1_CopEnter );
		}
		
		else
		{
			MsgPlr( 9, player, Lang.E1_CivEnter );
		}
	}
}

function E1_EnterMilitaryAsCop( player )
{
	if( !player.Vehicle ) return;
	
	if( vehicle [ player.Vehicle.ID ].UID2 == "VC-159" )
	{
		MsgAll( 9, Lang.E1_CopSucessAll );
		MsgPlr( 3, player, Lang.E1_CopSucess );
		playa[ player.ID ].AddCash( player, 1000 );
		playa[ player.ID ].AddXP( player, 5 );
		playa[ player.ID ].Copskill += 1;
		E1_ResetEvent();
		player.Eject();
	}
}

function E1_EnterMilitaryAsCiv( player )
{
	if( !player.Vehicle ) return;
	
	if( vehicle [ player.Vehicle.ID ].UID2 == "VC-159" )
	{
		MsgAll( 9, Lang.E1_CivSucessAll );
		MsgPlr( 3, player, Lang.E1_CivSucess );
		playa[ player.ID ].AddCash( player, 500 );
		playa[ player.ID ].AddXP( player, 2 );
		player.SetWeapon( GetWeaponID("mp5"), 450 );
		player.SetWeapon( GetWeaponID( "m60"), 250 );
		playa[ player.ID ].AddWanted( player, 6 );
		E1_ResetEvent();
		player.Eject();
	}
}

function E1_ResetEvent()
{
	foreach( a in vehicle )
	{
		if( a.UID2 == "VC-159" )
		{
			a.vehicle.Pos = Vector( -1704.98, -215.96, 15.265 );
			a.vehicle.EulerAngle = Vector(8.77805e-009, 2.26837e-005, 4.45951e-006);
			a.vehicle.Fix();
		}
	}
	
	foreach( a in sphere )
	{
		if( a.Place == "e1" )
		{
			a.Rob.World = 3;
		}
	}
	
	Server.Event.Event = 0;
	Server.EventCooldown = time();
}

function AutoEndEvent()
{
	if( Server.Event.Event == 1 )
	{
		if( ( Server.Event.Timer - time() ) > 120 )
		{
			E1_ResetEvent();
			MsgAll( 9 , Lang.E1_CopSucessAll );
		}
	}
}

function onEventVehicleExplode( v )
{
	if( vehicle[ v.ID ].UID2 == "VC-159" && Server.Event.Event == 1 )
	{
		E1_ResetEvent();
		MsgAll( 9, Lang.E1_Destroy );
	}
}