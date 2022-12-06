/*

    SkylarksDB
	.ConnectSkylarks();
	.AddPlayer( pPlayer, szPassword );
	.IsRegistered( pPlayer );
	.GetUID( pPlayer );
	.GetPass( pPlayer );
*/

IsDB <- null;

class SkylarksDB
{
	
	function ConnectSkylarks()
	{
	    ::IsDB = ::mysql_connect("stevie.heliohost.org", "kiki1337_skylark", "kikiko", "kiki1337_skylarks");
		if( IsDB ) ::print( "\r[Skylarks] Connected to Skylarks databse!" );
		else ::print( "\r[Skylarks] Could not connect to Skylarks databse. Please try again later." );
        ::NewTimer( "CheckDBConnection",500,0 );
    }
	
	function AddPlayer( pPlayer, szPassword )
	{
	    local q = ::mysql_query( IsDB, "SELECT * FROM playerinfo WHERE namelower='" + pPlayer.Name.tolower() + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
            return true;
		}
		else
		{
	        ::mysql_query( IsDB, "insert into playerinfo values ( '" + pPlayer.Name + "', '" + ::SHA256( szPassword ) + "', '" + pPlayer.IP + "', '" + time() + "', '" + time() + "', '0', '" + pPlayer.Name.tolower() + "', 'N/A' )" );
            ::print( "\r[Skylarks] Player " + pPlayer + " added into databse." );
		}
		::mysql_free_result( q );
	}
		
	function GetPass( pPlayer )
	{
	    local q = ::mysql_query( IsDB, "SELECT * FROM playerinfo WHERE namelower='" + pPlayer.Name.tolower() + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
			local x = ::mysql_fetch_assoc( q );
			return x[ "password" ];
		}
		else
		{
		    return false;
		}
		::mysql_free_result( q );
    }
	
    function IsRegistered( pPlayer )
	{
	    local q = ::mysql_query( IsDB, "SELECT * FROM playerinfo WHERE namelower='" + pPlayer.Name.tolower() + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
			return true;
		}
		else
		{
		    return false;
		}
		::mysql_free_result( q );
    }
	
}

	
function CheckDBConnection()
{
	if( ::mysql_ping( IsDB ) ) return; 
		
	if( !::mysql_ping( IsDB ) ) ::print( "\r[Skylarks] Lost connect to Skylarks, trying to reconnect..." );
	{
		IsDB = ::mysql_connect("stevie.heliohost.org", "kiki1337_skylark", "kikiko", "kiki1337_skylarks");
		if( ::mysql_ping( IsDB ) ) ::print( "\r[Skylarks] Connected to Skylarks databse!" );
    }
}
