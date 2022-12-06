gangv2 <- {}

function GangLoad()
{
	
    local q = SafeSelect( mysql, "SELECT * FROM `group`" ) ,ID = 0;
	local row;
	while( row = mysql_fetch_assoc( q ) )
	{						
        gangv2.rawset( row["Tag"],
        {
            Name = row["Name"],
            Tag = row["Tag"],
            Rank = GangLoadTable( row["Rank"] ),
            Permission = GangLoadTable( row["Permission"] ),
            Members = GangLoadTable( row["Members"] ),
            XP = row["XP"].tointeger(),
            CreatedDate = row["CreatedDate"].tointeger(),
            Locked = ( row["Locked"] == "true" ) ? true : false,
            Founder = row["Founder"].tointeger(),
            Type = row["Type"],
            Status = row["Status"],
            Description = ( row["Description"] == null ) ? null : row["Description"],
			Bank = row["Bank"].tointeger(),
        });
	}
		
	mysql_free_result( q );
	print( "\r[Group] " + gangv2.len() + " group loaded.");
}

function GangInsertDefaultPermission( name )
{
	local kiki = gangv2[ name ];
	
	kiki.Permission.rawset( "gangkick", 100 );
	kiki.Permission.rawset( "ganglock", 100 ); // vehicle entering
	kiki.Permission.rawset( "gangsetplayerrank", 100 );
	kiki.Permission.rawset( "gangsetrank", 100 );
	kiki.Permission.rawset( "gangsetaddrank", 100 );
	kiki.Permission.rawset( "gangdeleterank", 100 );
	kiki.Permission.rawset( "gangsetcmdlevel", 100 );
	kiki.Permission.rawset( "ganghousemanage", 100 ); // house storage perm
	kiki.Permission.rawset( "gangchangecolor", 100 ); // vehicle manage
	kiki.Permission.rawset( "ganginvite", 100 );	
	kiki.Permission.rawset( "gangchat", 100 );	// group bank
	kiki.Permission.rawset( "gangdescription", 100 );	
	
}

function GangCreate( name, tag, founder, type )
{

	//QuerySQL( gDB, "INSERT INTO mcf_gangv2 ( 'Name', 'Rank', 'Permission', 'Members', 'CreatedDate', 'Founder', 'Type' ) VALUES ( '" + name + "', 'none', 'none', 'none', '" + time() + "', '" + founder + "', '" + type + "' )" );
    ::mysql_query( mysql, "INSERT INTO `group` ( Name, Tag, XP, CreatedDate, Locked, Founder, Type, Status ) VALUES ( '" + name + "', '" + tag + "', 0, '" + time() + "', 'true', '" + founder + "', '" + type + "', 'Normal' )" );
    local ID = tag;
	
    gangv2.rawset( ID,
    {
        Name = name,
        Tag = tag,
        Rank = {},
        Permission = {},
        Members = {},
        XP = 0,
        CreatedDate = time(),
        Locked = true,
        Founder = founder,
        Type = type,
        Status = "Normal",
        Description = null,
		Bank = 0,
    });

	GangInsertDefaultPermission( tag );
	GangInsertMember( tag, founder, "Founder" );
	GangCreateNewRank( tag, "Founder", 100 );
	gangv2[ tag ].Members[ ::GangFindMember( tag, founder ) ].Rank = "Founder";
	
    SaveGroupData( tag );

	gangv2[ tag ].Members = json_decode( json_encode( gangv2[ tag ].Members ) );
	gangv2[ tag ].Rank = json_decode( json_encode( gangv2[ tag ].Rank ) );
	gangv2[ tag ].Permission = json_decode( json_encode( gangv2[ tag ].Permission ) );

	
}

function GangLoadTable( type )
{
	if( type == "none" ) return {};
	return json_decode( type );
}

function GangSaveTable( type )
{
	if( type.len() == 0 ) return "none";
	return json_encode( type );
}

function SaveGroupData( name )
{
	local kiki = gangv2[ name ];
//	::mysql_query( mysql, "BEGIN" ); 
	::mysql_query( mysql, "UPDATE `group` SET Name = '" + kiki.Name + "', Rank = '" + GangSaveTable( kiki.Rank ) + "', Permission = '" + GangSaveTable( kiki.Permission ) + "', Members = '" + GangSaveTable( kiki.Members ) + "', XP = '" + kiki.XP + "', Type = '" + kiki.Type + "', Status = '" + kiki.Status + "', Description = '" + kiki.Description + "', Bank = '" + kiki.Bank + "' WHERE Lower(Tag) = '" + name.tolower() + "'" );
//::mysql_query( mysql, "END" );
}

function GangGetGangIDFromDatabase( name )
{
	local result = 0;

    local q = ::mysql_query( mysql, "SELECT * FROM group WHERE Lower(Name) = '" + name.tolower() + "' " );
	if( ::mysql_num_rows( q ) != 0 )
    {
		local x = ::mysql_fetch_assoc( q );
		return x[ "ID" ];
	}
	::mysql_free_result( q );
}

function GangPlayerLoad( player )
{
	local gangName = [];
	
	foreach( kiki in gangv2 )
	{
		foreach( a in kiki.Members )
		{
			if( typeof( a ) == "table" )
			{
				if( a.Name.tostring() == player.tostring() ) gangName.push( kiki.Tag );
			}
		}
	}
	
	return gangName;
}

function LoadPlayerGang( player )
{
	if( GangPlayerLoad( playa[ player.ID ].ID ).len() == 0 ) return;
	
	foreach( kiki in GangPlayerLoad( playa[ player.ID ].ID ) )
	{
		playa[ player.ID ].Group.push( kiki );
	}
}

function SetTeamFromGroup( string )
{
	if( string == "x" ) return 255;
	if( Misc.IsFloat( string ) ) return 255;
	if( !FindGang( string ) ) return 255;
	else return gangv2[ string ].Team;
}

function GangFindMember( gang, player )
{
	if( gangv2.rawin( gang ) == false ) return;
	
	foreach( v, a in gangv2[ gang ].Members )
	{
		if( typeof( a ) == "table" )
		{
			if( a.Name.tostring() == player.tostring() ) return v;
		}
	}
}

function GangFindRank( gang, player )
{
	if( gangv2.rawin( gang ) == false ) return;
	
	foreach( v, a in gangv2[ gang ].Rank )
	{
		if( typeof( a ) == "table" )
		{
			if( a.Name.tolower() == player.tolower() ) return v;
		}
	}
}

function GangInsertMember( gang, name, rank )
{
	if( gangv2.rawin( gang ) == false ) return;
	
	local Members = gangv2[ gang ].Members, memID = (Members.len()+1);
	
	Members[ memID ]      <- {};
	Members[ memID ].Name <- name.tostring();
	Members[ memID ].Rank <- rank;
}

function GangCreateNewRank( gang, rank, level )
{
	if( gangv2.rawin( gang ) == false ) return;
	
	local Ranks = gangv2[ gang ].Rank, rankID = (Ranks.len()+1);
	
	Ranks[ rankID ]      <- {};
	Ranks[ rankID ].Name <- rank;
	Ranks[ rankID ].Level <- level;
}

function GangRemoveMember( gang, name )
{
	if( GangFindMember( gang, name ) == null ) return;
	
	gangv2[ gang ].Members.rawdelete( GangFindMember( gang, name ) );
}

function GangRemoveRank( gang, name )
{
	if( GangFindRank( gang, name ) == null ) return;
	
	gangv2[ gang ].Rank.rawdelete( GangFindRank( gang, name ) );
	
	foreach( v, a in gangv2[ gang ].Members )
	{
		if( typeof( a ) == "table" )
		{
			if( a.Name.tostring() == name.tostring() ) a.Rank = "default";
		}
	}

}

function FindGang( gang )
{
    if( gangv2.rawin( gang ) ) return true;
	
	return false;
}

function GangGetLevelFromRank( gang, rank )
{
	if( GangFindRank( gang, rank ) == null ) return 0;

	return gangv2[ gang ].Rank[ GangFindRank( gang, rank ) ].Level.tointeger();
}

function IsGangHouse( player, id )
{
	if( pickup[ id ].Owner.find( "(Group)" ) == null ) return false;
	if( playa[ player.ID ].Group.find( Misc.ReplaceChar( pickup[ id ].Owner, " (Group)", "" ) ) >= 0 ) return true;
	else return false;
}

function GangChangeStats( type, player )
{
	switch( type )
	{
		case "inc":
		foreach( kiki in playa[ player.ID ].Group )
		{
			if( FindGang( kiki ) == true ) 
			{
				if( gangv2[ kiki ].Type == "gang" ) gangv2[ kiki ].Kills++;
				SaveGroupData( kiki );
			}
		}
		break;
		
		case "dec":
		foreach( kiki in playa[ player.ID ].Group )
		{
			if( FindGang( kiki ) == true ) 
			{
				if( gangv2[ kiki ].Type == "gang" ) gangv2[ kiki ].Deaths++;
				SaveGroupData( kiki );
			}
		}
		break;
	}
}

function GangSetColor( string )
{
	local getColor = Server.RandomColor[ rand()% Server.RandomColor.len() ];
	if( string == "255 255 255" ) return getColor.r + " " + getColor.g + " " + getColor.b;
	else return RGB( string[0].tointeger(), string[1].tointeger(), string[2].tointeger() );;
}

function GetCriminalGroup( player )
{
	foreach( index, value in playa[ player.ID ].Group )
	{
		if( gangv2[ index ].Type == "Criminal" ) return index;
	}
}