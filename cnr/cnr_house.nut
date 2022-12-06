
function BuyHouse( player )
{
	if( playa[ player.ID ].House == null ) return;
	//if( playa[ player.ID ].XPLevel <= 2 ) MsgPlr( 2, player, Lang.NeedXP, 15 );
	if( pickup[ playa[ player.ID ].House ].Quatity >= playa[ player.ID ].Cash )
	{
		local oldPickData = pickup[ playa[ player.ID ].House ].Pickup.ID, oldObj = null, pickupinstance = CreatePickup( 406, pickup[ playa[ player.ID ].House ].World, 0, pickup[ playa[ player.ID ].House ].Pos, 255, true );
				
		pickup[ playa[ player.ID ].House ].Owner  = playa[ player.ID ].ID;
		pickup[ playa[ player.ID ].House ].Model = 406;
		pickup[ playa[ player.ID ].House ].Pickup.Remove();
		pickup[ playa[ player.ID ].House ].Pickup = pickupinstance;
				
		oldObj = pickup[ playa[ player.ID ].House ];
				
		pickup.rawset( pickupinstance.ID, oldObj );

		playa[ player.ID ].House = pickupinstance.ID;

		pickup.rawdelete( oldPickData );
				
		ChangePlayerInterior( oldPickData, pickupinstance.ID );

		playa[ player.ID ].DecCash( player, pickup[ playa[ player.ID ].House ].Quatity );
			
		MsgPlr( 3, player, Lang.BuyHouse, pickup[ playa[ player.ID ].House ].Type );		
	//	MsgPlr( 3, player, Lang.BuyHouse1 );
			
		print( "\r[Purchase] " + player.Name + "(ID " + playa[ player.ID ].ID + ") has purchased house " + pickup[ playa[ player.ID ].House ].Type + " using cash balance $" + pickup[ playa[ player.ID ].House ].Quatity  );
		
		SavePickup( pickup[ playa[ player.ID ].House ] );
	}
}

function SetHousePassword( player, string )
{
	if( playa[ player.ID ].House == null ) return;
	pickup[ playa[ player.ID ].House ].Password = string;
	MsgPlr( 3, player, Lang.ChangeHPass, string );
	//SendDataToClient( 240, null, player );
	
	SavePickup( pickup[ playa[ player.ID ].House ] );
}

function Housespawn( player )
{
	if( playa[ player.ID ].Spawnhouse == null ) return;
	if( playa[ player.ID ].Spawnhouse.find(",") == null ) return;
	if( playa[ player.ID ].JobID.find("cop") >= 0 || playa[ player.ID ].JobID == "3" ) return;
	if( playa[ player.ID ].Jailtime ) return;

	local findmacker = split( playa[ player.ID ].Spawnhouse, "," );
	
	if( VerifyOwnerAndSharer( GetPickupIndexFromType( findmacker[0] ), playa[ player.ID ].ID ) )
	{
		player.Pos = Vector( findmacker[1].tofloat(), findmacker[2].tofloat(), findmacker[3].tofloat() );
		player.World = findmacker[4].tointeger();
		playa[ player.ID ].LastPos = Vector( findmacker[5].tofloat(), findmacker[6].tofloat(), findmacker[7].tofloat() );
		playa[ player.ID ].House = GetPickupIndexFromType( findmacker[0] );

		onPlayerEnterWorld( findmacker[4].tointeger() );
	}
	else return;
}

function CheckHousePass( player, string )
{
	if( string == "" ) return;
	
	local found = false;
	foreach( kiki in pickup )
	{
		if( DistanceFromPoint( kiki.Pickup.Pos.x, kiki.Pickup.Pos.y, player.Pos.x, player.Pos.y ) <= 2 && kiki.Type.find("#") >= 0 )
		{
			found = true;
			if( string != kiki.Password ) MsgPlr( 2, player, Lang.WrongHousePass );
			else
			{
				playa[ player.ID ].LastPos = player.Pos;
				player.World = (split( pickup[ kiki.Pickup.ID ].Type, "#" )[1].tointeger()+10);
				EnterInt( pickup[ kiki.Pickup.ID ].Interior, player );
				playa[ player.ID ].House = kiki.Pickup.ID;

				if( pickup[ kiki.Pickup.ID ].Owner == 100000 ) MsgPlr( 7, player , Lang.HouseForSale, pickup[ kiki.pickup.ID ].Quatity );
				else MsgPlr( 7, player, Lang.HouseWelcomeMessage, pickup[ kiki.Pickup.ID ].Welcome );
			}
		}
	}
	if( !found ) SendDataToClient( 310, null ,player );
}
	
function GetHouseAmmoLimit( id )
{
	if( id == null ) return;
	if( pickup.rawin( id ) == false ) return;
	
	if( pickup[ id ].Type.find( "Mansion" ) >= 0 ) return 5000;
	if( pickup[ id ].Type.find( "Hut" ) >= 0 ) return 300;
	if( pickup[ id ].Type.find( "Apartment" ) >= 0 ) return 2500;
}

function GetHouseItemLimit( id )
{
	if( id == null ) return;
	if( pickup.rawin( id ) == false ) return;
	
	if( pickup[ id ].Type.find( "Mansion" ) >= 0 ) return 4500;
	if( pickup[ id ].Type.find( "Hut" ) >= 0 ) return 25;
	if( pickup[ id ].Type.find( "Apartment" ) >= 0 ) return 150;
}

function VerifyOwnerAndSharer( houseid, playerid )
{	
	local player = FindPlayerByAccID( playerid );

	if( pickup[ houseid ].Owner == "100000" ) return false;
	
	if( pickup[ houseid ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( pickup[ houseid ].Owner, ":" );
		
		if( playa[ player.ID ].Group.find( getname[1] ) >= 0 ) return true;
		else return false;
	}

	if( pickup[ houseid ].Owner == playa[ player.ID ].ID.tostring() ) return true;
	if( pickup[ houseid ].Share.rawin( playa[ player.ID ].ID.tostring() ) ) return true;
	// VerifyMember( player )
}

function VerifyOwnerAndSharer2( houseid, playerid )
{	
	local player = FindPlayerByAccID( playerid );

	if( pickup[ houseid ].Owner == "100000" ) return false;
	
	if( pickup[ houseid ].Owner.find( "Group:" ) >= 0 )
	{
		local getname = split( pickup[ houseid ].Owner, ":" );
		
		if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
		{
			if( ::GangGetLevelFromRank( getname[1] ,gangv2[ getname[1] ].Members[ ::GangFindMember( getname[1], playa[ player.ID ].ID ) ].Rank ) >= gangv2[ getname[1] ].Permission.ganghousemanage.tointeger() ) return true;
		}
		else return false;
	}

	if( pickup[ houseid ].Owner == playa[ player.ID ].ID.tostring() ) return true;
	if( pickup[ houseid ].Share.rawin( playa[ player.ID ].ID.tostring() ) ) return true;
	// VerifyMember( player )
}

function GetHouseSharerName( obj )
{
	local getResult = null;
	
	foreach( index, value in obj )
	{
		if( getResult ) getResult = getResult + ", " + mysqldb.GetNameFromID( index.tointeger() );
		else getResult = mysqldb.GetNameFromID( index.tointeger() );
	}
	
	if( getResult ) return getResult;
	else return "None";
}

function ChangePlayerInterior( old, new )
{
	for( local i = 0; i < 100; ++i )
	{
		local player = FindPlayer( i );
		
		if( player )
		{
			if( playa[ i ].House == old ) playa[ i ].House = new;
		}
	}
}

function EnterHouseKey( player )
{
	local allowenter = false;
	foreach( index, value in pickup )
	{
	/*	if( ( DistanceFromPoint( kiki.Pickup.Pos.x, kiki.Pickup.Pos.y, player.Pos.x, player.Pos.y ) <= 2 ) && ( kiki.Type.find( "Haiti Hut" ) >= 0 || kiki.Type.find( "Mansion" ) >= 0 || kiki.Type.find( "Apartment" ) >= 0 ) )
		{
			found = true;
			if( kiki.Owner == 100000 )
			{
				playa[ player.ID ].LastPos = player.Pos;
				player.World = (split( kiki.Type, "#" )[1].tointeger()+10);
				EnterInt( kiki.Interior, player );
				playa[ player.ID ].House = kiki.Pickup.ID;
				MsgPlr( 7, player , Lang.HouseForSale, kiki.Quatity );

				SendDataToClient( 7010, null, player );

				onPlayerEnterWorld( player.World );
			}
			
			else
			{
				if( !VerifyOwnerAndSharer( kiki.Pickup.ID, playa[ player.ID ].ID ) && kiki.Password != false ) SendDataToClient( 2060, null, player ), SendDataToClient( 7010, null, player );
				else
				{
					playa[ player.ID ].LastPos = player.Pos;
					player.World = (split( kiki.Type, "#" )[1].tointeger()+10);
					EnterInt( kiki.Interior, player );
					playa[ player.ID ].House = kiki.Pickup.ID;

					SendDataToClient( 7010, null, player );

					if( kiki.Welcome != "null" ) MsgPlr( 7, player, Lang.HouseWelcomeMessage, kiki.Welcome );

					onPlayerEnterWorld( player.World );
				}

				if( kiki.Owner == 100000 ) MsgPlr( 7, player , Lang.HouseForSale, kiki.Quatity );
			}
		}
	}*/

		if( ( DistanceFromPoint( value.Pickup.Pos.x, value.Pickup.Pos.y, player.Pos.x, player.Pos.y ) <= 2 ) )
		{
			if( value.Owner.find( "Group:" ) >= 0 )
			{
				allowenter = index;
			}

			if( value.Model == 407 || value.Model == 406 )
			{
				allowenter = index;
			}
		}
	}

	if( allowenter )
	{
		local picky = pickup[ allowenter ];

		if( !picky.Locked )
		{
			playa[ player.ID ].LastPos = player.Pos;
			player.World = picky.ID;

			EnterInt( picky.Interior, player );
			playa[ player.ID ].House = allowenter;

			SendDataToClient( 7010, null, player );

			if( picky.Welcome ) MsgPlr( 7, player, Lang.HouseWelcomeMessage, picky.Welcome );

			onPlayerEnterWorld( player.World );
		}

		else 
		{
			if( picky.Owner.find( "Group:" ) >= 0 )
			{
				local getname = split( picky.Owner, ":" );

				if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
				{
					playa[ player.ID ].LastPos = player.Pos;
					player.World = picky.ID;

					EnterInt( picky.Interior, player );
					playa[ player.ID ].House = allowenter;

					SendDataToClient( 7010, null, player );

					if( picky.Welcome ) MsgPlr( 7, player, Lang.HouseWelcomeMessage, picky.Welcome );

					onPlayerEnterWorld( player.World );
				}
				else MsgPlr( 2, player, Lang.GroupHQCantEntere );
			}
			else MsgPlr( 2, player, Lang.GroupHQCantEntere );
		}
	}
}

function ListOwnedHouse( player )
{
	foreach( index, value in pickup ) 
	{ 
		if( ( value.Type.find( "Haiti Hut" ) >= 0 || value.Type.find( "Mansion" ) >= 0 || value.Type.find( "Apartment" ) >= 0 ) && VerifyOwnerAndSharer( index, playa[ player.ID ].ID ) )
		{
			SendDataToClient( 6830, index + " " + value.Type, player );
		}
	}
}

function CountOwnedHouse( player )
{
	local count = 0;
	foreach( index, value in pickup ) 
	{ 
		if( VerifyOwnerAndSharer( index, playa[ player.ID ].ID ) ) count ++;
	}

	return count;
}

function CheckHouseSpawn( player )
{
	if( CountOwnedHouse( player ) > 0 )
	{
		ListOwnedHouse( player );
	}
	else SendDataToClient( 6810, "You dont own any house.", player );
}

function SpawnHouse2( player, index )
{
	local id = pickup.rawin( index.tointeger() );
	if( id )
	{
		local kiki = pickup[ index.tointeger() ];

		player.Spawn();

		player.World = (split( kiki.Type, "#" )[1].tointeger()+10);
		playa[ player.ID ].House = kiki.Pickup.ID;
		playa[ player.ID ].OnSpawnMenu = false;
			
		onPlayerEnterWorld( player.World );

		SendDataToClient( 6820, null, player );

		player.Spawn();

		_Timer.Create( this, function() 
		{
			EnterInt( kiki.Interior, player );
		}, 500, 1 );
	}
	else SendDataToClient( 6810, "An error has occured.", player );
}

function GetOwnedHouseCount( player )
{
	local count = 0;
	foreach( index, value in pickup ) 
	{ 
		if( VerifyOwnerAndSharer( index, playa[ player.ID ].ID ) )
		{
			count ++;
		}
	}

	return count;
}
