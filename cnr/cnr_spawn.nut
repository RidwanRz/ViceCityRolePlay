function HospitalRespawn2( player )
{
	player.Spawn();
	player.World = 0;
	Announce("",player,1);
	//SendDataToClient( 6820, null, player );

	playa[ player.ID ].OnSpawnMenu = false;

	local hospital = [ Vector( -883.101, -471.864, 13.1099 ), Vector( -822.674, 1140.28, 12.4111 ), Vector( 493.654, 702.559, 12.1033 ), Vector( -137.186, -981.112, 10.4653 ) ]
	local nearest = 1000000;
	local result = 0;

	foreach( index, value in hospital )
	{
		if( DistanceFromPoint( value.x, value.y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) <= playa[ player.ID ].LastPos.Distance( value ) && ( DistanceFromPoint( value.x, value.y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) < DistanceFromPoint( hospital[ result ].x, hospital[ result ].y, playa[ player.ID ].LastPos.x, playa[ player.ID ].LastPos.y ) ) ) result = index;
	}

	player.Spawn();

	_Timer.Create( this, function() 
	{
		player.Pos = hospital[ result ];
        player.Skin = playa[ player.ID ].LastUsedSkin;
        RespawnRestoreColor( player );
        player.IsFrozen = false;
	}, 500, 1 );

    SendDataToClient( 9402, player, "" );
    MsgPlr( 3, player, Lang.RespawnHospital );
}

function SpawnAtJob( player )
{
    switch( playa[ player.ID ].Job.JobID )
    {
        case 1:
        SendDataToClient( 9403, "Vice Port Trucking Depot;Little Havana Depot", player );
        break;

        case 2:
        SendDataToClient( 9403, "Ocean View Hospital;Schuman Health Care Center;Little Havana Police Department", player );
        break;

        case 3:
        SendDataToClient( 9403, "Washington Police Department Headquaters;Vice Point Police Department;Little Havana Police Department", player );
        break;

        case 4:
        SendDataToClient( 9403, "Washington Police Department Headquaters;Vice Point Police Department;Little Havana Police Department;Special Weapon and Tactic Downtown HQ", player );
        break;

        case 5:
        SendDataToClient( 9403, "Federal Bureau of Investigation Headquaters", player );
        break;
    }
}

function SpawnAtJobSel( player, text )
{
    local pos = Vector( 0,0,0 );

    player.Spawn();

    switch( text )
    {
        case "Vice Point Police Department":
        pos = Vector( 501.397, 512.665, 11.4859 );
        break;

        case "Little Havana Police Department":
        pos = Vector(-877.96, -678.159, 11.2101 );
        break;

        case "Washington Police Department Headquaters":
        pos = Vector( 405.916, -477.516, 10.0662);
        break;

        case "Special Weapon and Tactic Downtown HQ":
        pos = Vector( -661.222, 767.597, 11.1652 );
        break;

        case "Ocean View Hospital":
        pos = Vector( -137.774, -985.083, 10.4672 );
        break;

        case "Schuman Health Care Center":
        pos = Vector( -818.763, 1144.4, 12.4111 );
        break;

        case "Vice Port Trucking Depot":
        pos = Vector( -734.695, -1470.46, 11.9592 );
        break;

        case "Little Havana Depot":
        pos = Vector( -1056.89, -484.728, 11.1385 );
        break;

        case "Federal Bureau of Investigation Headquaters":
        pos = Vector( -558.17, 1169.43, 11.339 );
        break;
    }

    _Timer.Create( this, function() 
	{
		player.Pos = pos;
        player.Skin = playa[ player.ID ].LastUsedSkin;
        RespawnRestoreColor( player );

	}, 500, 1 );

    SendDataToClient( 9402, player, "" );
    MsgPlr( 3, player, Lang.RespawnJob );
}

function GetNearestHospital( pos )
{
    local hospital = [ Vector( -883.101, -471.864, 13.1099 ), Vector( -822.674, 1140.28, 12.4111 ), Vector( 493.654, 702.559, 12.1033 ), Vector( -137.186, -981.112, 10.4653 ) ]
	local nearest = 1000000;
	local result = 0;

	foreach( index, value in hospital )
	{
		if( DistanceFromPoint( value.x, value.y, pos.x, pos.y ) <= pos.Distance( value ) && ( DistanceFromPoint( value.x, value.y, pos.x, pos.y ) < DistanceFromPoint( hospital[ result ].x, hospital[ result ].y, pos.x, pos.y ) ) ) result = index;
	}

    return hospital[ result ];
}

function RespawnRestoreColor( player )
{
	switch( playa[ player.ID ].Job.JobID )
	{
		case 2:
		player.Colour = RGB( 255, 153, 255 );
		break;
		
		case 3:
		if( playa[ player.ID ].Job.PDLevel > 1 ) player.Colour = RGB( 0, 68, 204 );
		else player.Colour = RGB( 102, 153, 255 );
		break;

		case 4:
		player.Colour = RGB( 0, 68, 204 );
		break;

		case 5:
		player.Colour = RGB( 0, 68, 204 );
		break;

        default:
        player.Colour = RGB( 255, 255, 255 );
        break;
    }
}

function GetHouseList( player )
{
    local str = null;
    foreach( index, value in pickup )
    {
        if( value.Owner == playa[ player.ID ].ID.tostring() )
        {
            if( str ) str = str + ";" + value.Type;
            else str = value.Type;
        }
    }

    if( str ) SendDataToClient( 9404, str, player );
}

function GetHQList( player )
{
    local str = null;
    foreach( index, value in pickup )
    {
        if( value.Owner.find( "Group:" ) >= 0 )
        {
            local getname = split( value.Owner, ":" );

            if( playa[ player.ID ].Group.find( getname[1] ) >= 0 )
            {
                if( str ) str = str + ";" + value.Type;
                else str = value.Type;
            }
        }
    }

    if( str ) SendDataToClient( 9405, str, player );

}

function SpawnAtHouse( str, player )
{
    local pos = null;

    player.Spawn();

    foreach( index, value in pickup )
    {
        if( value.Owner == playa[ player.ID ].ID.tostring() )
        {
            if( str == value.Type ) pos = value.Pos;
        }
    }

    if( pos )
    {
        _Timer.Create( this, function() 
        {
            player.Pos = pos;
            player.Skin = playa[ player.ID ].LastUsedSkin;
            RespawnRestoreColor( player );

        }, 500, 1 );

        SendDataToClient( 9402, player, "" );
        MsgPlr( 3, player, Lang.RespawnHouse );
    }
}

function SpawnAtHQ( str, player )
{
    local pos = null;
    
    player.Spawn();

    foreach( index, value in pickup )
    {
        if( value.Owner.find( "Group:" ) >= 0 )
        {
            if( str == value.Type ) pos = value.Pos;
        }
    }

    if( pos )
    {
        _Timer.Create( this, function() 
        {
            player.Pos = pos;
            player.Skin = playa[ player.ID ].LastUsedSkin;
            RespawnRestoreColor( player );

        }, 500, 1 );

        SendDataToClient( 9402, player, "" );
        MsgPlr( 3, player, Lang.RespawnHQ );
    }
}
