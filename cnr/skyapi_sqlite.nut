

    //SkylarksDB
	//.ConnectSkylarks();
	//.AddPlayer( instance Player, string Password );
	//.IsRegistered( instance Player );
	//.GetUID( integer AccountID );
	//.GetPass( integer AccountID );
	//.GetNameFromID( integer AccountID );


IsDB <- null;

class SkylarksDB
{
	
	function ConnectSkylarks()
	{
		IsDB = ::ConnectSQL( "skydb.db" );
    }
	
	/*function AddPlayer( pPlayer, szPassword )
	{
	    local q = ::QuerySQL( IsDB, "SELECT * FROM playerinfo WHERE Lower(Name) ='" + pPlayer.Name.tolower() + "' " );
		if( ::GetSQLColumnData( q, 1 ) )
        {
            return true;
		}
		
		else
		{
	        ::QuerySQL( IsDB, "INSERT INTO playerinfo ( 'Name', 'Password', 'IP', 'RegDate', 'LogTime', 'RegIP' ) VALUES ( '" + pPlayer.Name + "', '" + ::SHA256( szPassword ) + "', '" + pPlayer.IP + "', '" + time() + "', '" + time() + "', '" + pPlayer.IP + "' )" );
            ::print( "\r[Skylarks] Player " + pPlayer.Name + " added into databse. ID " + this.IsRegistered( pPlayer )  );
		}
		::FreeSQLQuery( q );
	}
		
	function GetPass( iID )
	{
	    local q = ::QuerySQL( IsDB, "SELECT Password FROM playerinfo WHERE ID= '" + iID + "' " );
		if( ::GetSQLColumnData( q, 0 ) )
        {
			return ::GetSQLColumnData( q, 0 ).tolower();
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
    }
	
    function IsRegistered( pPlayer )
	{
	    local q = ::QuerySQL( IsDB, "SELECT ID FROM playerinfo WHERE Lower(Name) = '" + pPlayer.Name.tolower() + "' " );
		if( ::GetSQLColumnData( q, 0 ) != null )
        {
			return ::GetSQLColumnData( q, 0 ).tointeger();
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
    }*/
	
	/*function UpdateDatabase( pPlayer, iID )
	{
		local q = ::QuerySQL( IsDB, "SELECT * FROM playerinfo WHERE ID='" + iID + "' " );
		if( ::GetSQLColumnData( q, 1 ) )
        {
			::QuerySQL( IsDB, "UPDATE playerinfo SET IP = '" + pPlayer.IP + "', LogTime = '" + ::time() + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
	}*/

	/*function UpdatePassword( sText, iID )
	{
		local q = ::QuerySQL( IsDB, "SELECT * FROM playerinfo WHERE ID='" + iID + "' " );
		if( ::GetSQLColumnData( q, 1 ) )
        {
			::QuerySQL( IsDB, "UPDATE playerinfo SET Password = '" + sText + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
	}*/
	
	/*function GetReqDate( iID )
	{
		local q = ::QuerySQL( IsDB, "SELECT RegDate FROM playerinfo WHERE ID= '" + iID + "' " );
		if( ::GetSQLColumnData( q, 0 ) )
        {
			return ::GetSQLColumnData( q, 0 ).tointeger();
		}
		::FreeSQLQuery( q );
	}
	
	function GetNameFromID( iID )
	{
	    local q = ::QuerySQL( IsDB, "SELECT Name FROM playerinfo WHERE ID= '" + iID + "' " );
	    if( !q ) return "Unknown";

		if( ::GetSQLColumnData( q, 0 ) )
        {
			return ::GetSQLColumnData( q, 0 );
		}
		
		else
		{
		    return "Unknown";
		}
		::FreeSQLQuery( q );
    }
	
	function GetSimilarNameToID( szText )
	{
	    local q = ::QuerySQL( IsDB, "SELECT ID FROM playerinfo LIKE Lower(Name)= '" + szText.tolower() + "'% " );
		if( ::GetSQLColumnData( q, 0 ) )
        {
			return ::GetSQLColumnData( q, 0 ).tointeger();
		}
		
		else
		{
		    return 100000;
		}
		::FreeSQLQuery( q );
    }

    function isExist( szText )
	{
	    local q = ::QuerySQL( IsDB, "SELECT ID FROM playerinfo WHERE Lower(Name) = '" + szText.tolower() + "' " );
	    if( !q ) return false;

		if( ::GetSQLColumnData( q, 0 ) != null )
        {
			return ::GetSQLColumnData( q, 0 ).tointeger();
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
    }*/

	/*function UpdateName( sText, iID )
	{
		local q = ::QuerySQL( IsDB, "SELECT * FROM playerinfo WHERE ID='" + iID + "' " );
		if( ::GetSQLColumnData( q, 1 ) )
        {
			::QuerySQL( IsDB, "UPDATE playerinfo SET Name = '" + sText + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::FreeSQLQuery( q );
	}*/

	/*function GetAccountInfo( iID )
	{
		local q = ::QuerySQL( IsDB, "SELECT IP, RegIP, RegDate, LogTime FROM playerinfo WHERE ID= '" + iID + "' " );
		if( ::GetSQLColumnData( q, 0 ) )
        {
			return { "IP": ::GetSQLColumnData( q, 0 ), "RegIP": ::GetSQLColumnData( q, 1 ),  "RegDate": ::GetSQLColumnData( q, 2 ).tointeger(), "LogTime": ::GetSQLColumnData( q, 3 ).tointeger() }
		}
		::FreeSQLQuery( q );
	}*/	
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
