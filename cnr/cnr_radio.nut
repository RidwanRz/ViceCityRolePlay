cradio <- {}

function LoadRadio()
{
    local q = SafeSelect( mysql, "SELECT * FROM `radio`" ) ,ID = 0;
	local row;
	while( row = mysql_fetch_assoc( q ) )
	{						
        cradio.rawset( row["Channel"].tointeger(),
        {
            Owner = row["Owner"].tointeger(),
            Description = row["Description"],
            Locked = ( row["Locked"] == "true" ) ? true: false,
            Members = ( row["Members"] == "x" ) ? {} : json_decode( row["Members"] ),
        });
    }
		
	mysql_free_result( q );
	print( "\r[Radio] " + cradio.len() + " radios loaded.");
}

function InitRadioMember( id, player, level )
{
    if( !cradio[ id ].Members.rawin( player.tostring() ) )
    {
        cradio[ id ].Members.rawset( player.tostring(),
        {
            Level = level.tostring(),
            IsBanned = "false",
        })
    }

    else 
    {
        cradio[ id ].Members[ player.tostring() ].Level = level.tostring();
    }
}

function SaveRadioData( id )
{
    local cr = cradio[ id ];

    ::mysql_query( mysql, "UPDATE radio SET Owner = '" + cr.Owner + "', Description = '" + cr.Description + "', Locked = '" + cr.Locked.tostring() + "', Members = '" + json_encode( cr.Members ) + "' WHERE Channel = '" + id + "'" );
}

function RegisterChannel( id )
{
    if( cradio.rawin( id ) ) return;

    ::mysql_query( mysql, format( "INSERT INTO radio ( Channel, Owner, Description, Locked, Members ) VALUES ( '%d', '100000', 'x', 'false', '{}' )", id ) );

    cradio.rawset( id,
    {
        Owner = 100000,
        Description = "x",
        Locked = false,
        Members = {},
    });
}

function GetRadioMemberLevel( id, player )
{
    if( !cradio[ id ].Members.rawin( player.tostring() ) ) return 0;

    return cradio[ id ].Members[ player.tostring() ].Level.tointeger();
}

function GetRadioMemberBannedState( id, player )
{
    if( !cradio[ id ].Members.rawin( player.tostring() ) ) return false;

    if( cradio[ id ].Members[ player.tostring() ].IsBanned == "true" ) return true;
}

function IsRadioLocked( id, player )
{
    if( cradio[ id ].Locked )
    {
        if( GetRadioMemberLevel( id, playa[ player.ID ].ID ) <= 1 ) return true;

    //    if( GetRadioMemberBannedState( id, player ) == "true" ) return true;
    }
    else return false;
}

function GetPlayerJoinedChannel( ch, player )
{
    foreach( slot, value in playa[ player.ID ].Radio )
    {
        if( value.Channel.tointeger() == ch ) return ch;
    }
}

function GetPlayerJoinedChannel2( ch, player )
{
    foreach( slot, value in playa[ player.ID ].Radio )
    {
        if( value.Channel.tointeger() == ch ) return slot;
    }
}

function GetPlayerJoinedSlot( slt, player )
{
    return playa[ player.ID ].Radio[ slt.tostring() ].Channel.tointeger();
}

function JoinChannel( player )
{
    foreach( slot, value in playa[ player.ID ].Radio )
    {
        if( value.Channel.tointeger() != 0 ) MsgRadio( value.Channel.tointeger(), Lang.RadioFregJoin, player.Name );
    }
}