

    //SkylarksDB
	//.ConnectSkylarks();
	//.AddPlayer( instance Player, string Password );
	//.IsRegistered( instance Player );
	//.GetUID( integer AccountID );
	//.GetPass( integer AccountID );
	//.GetNameFromID( integer AccountID );


mysql <- null;

class MySQLDB
{
	
	function ConnectMySQL()
	{
		::mysql = ::mysql_connect("host", "name", "password", "dbname");
		if( mysql ) ::print( "\r Connected to MySQL databse!" );
		else ::print( "\r Could not connect to MySQL databse. Please try again later." );
        ::NewTimer( "CheckDBConnection",500,0 );
    }
	
	function AddPlayer( pPlayer, szPassword )
	{
	    local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE Lower(Name) = '" + pPlayer.Name.tolower() + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
            return true;
		}
		else
		{
	        //::mysql_query( mysql, "INSERT INTO accounts ( 'Name', 'Password', 'IP', 'Playtime', 'LogTime', 'RegDate' ) VALUES ( '" + pPlayer.Name.tolower() + "', '" + ::SHA256( szPassword ) + "', '" + pPlayer.IP + "', '" + "" + "', '" + time() + "', '" + time() + "' )" );
            ::mysql_query( mysql, "INSERT INTO accounts ( Name, Password, IP, Playtime, LogTime, RegDate ) VALUES ( '" + pPlayer.Name + "', '" + ::SHA256( szPassword ) + "', '" + pPlayer.IP + "', '" + "N/A" + "', '" + time() + "', '" + time() + "' )" );
			::print( "\r[MySQL] Player " + pPlayer + " added into databse." );
		}
		::mysql_free_result( q );
	}
		
	function GetPass( iID )
	{
	    local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE ID = '" + iID + "' " );
		if( ::mysql_num_rows( q ) != 0 )
        {
			::print( "\r[DB/GetPass] Password found " );
			local x = ::mysql_fetch_assoc( q );
			return x[ "Password" ];
		}
		else
		{
			::print( "\r[DB/GetPass] Password NOT found " );
		    return false;
		}
		::mysql_free_result( q );
    }
	
    function IsRegistered( pPlayer )
	{
	    local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE Lower(Name) = '" + pPlayer.Name.tolower() + "' " );
		if( ::mysql_num_rows( q ) != 0 )
        {
			::print( "\r[DB/IsRegistered] WE FOUND THE PLAYER IN THE DATABASE " );
			local x = ::mysql_fetch_assoc( q );
			return x[ "ID" ];
		}
		else
		{
			::print( "\r[DB/IsRegistered] WE DID NOT FIND THE PLAYER IN THE DATABASE " );
		    return false;
		}
		::mysql_free_result( q );
    }
	
	function UpdateDatabase( pPlayer, iID )
	{
		local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE ID = '" + iID + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
			::mysql_query( mysql, "UPDATE accounts SET IP = '" + pPlayer.IP + "', LogTime = '" + ::time() + "', Name = '"+ pPlayer.Name + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::mysql_free_result( q );
	}

	function UpdatePassword( sText, iID )
	{
		local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE ID = '" + iID + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
			::mysql_query( mysql, "UPDATE accounts SET Password = '" + sText + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::mysql_free_result( q );
	}
	
	function GetReqDate( iID )
	{
		local q = ::mysql_query( mysql, "SELECT RegDate FROM accounts WHERE Lower(Name) = '" + iID + "' " );
		if( ::mysql_num_rows( q ) == 0 )
        {
			local bl = ::mysql_fetch_assoc( q );
			return bl["RegDate"];
		}
		::mysql_free_result;
	}
	
	function GetNameFromID( iID )
	{
	    local q = ::mysql_query( mysql, "SELECT Name FROM accounts WHERE ID = '" + iID.tointeger() + "' " );
	    if( !q ) return "Unknown";
		local row = ::mysql_fetch_assoc( q );

		if( ::mysql_num_rows( q ) == 1 )
        {
			return row["Name"];
		}
		
		else
		{
		    return "Unknown";
		}
		::mysql_free_result( q );
    }
	
	function GetSimilarNameToID( szText )
	{
	    local q = ::mysql_query( mysql, "SELECT ID FROM accounts LIKE WHERE Lower(Name)= '" + szText.tolower() + "'% " );
		local row = ::mysql_fetch_assoc( q );
		if( ::mysql_num_rows( q ) == 1 )
        {
			return row["Name"];
		}
		
		else
		{
		    return 100000;
		}
		::mysql_free_result( q );
    }

    function isExist( szText )
	{
	    local q = ::mysql_query( mysql, "SELECT ID FROM accounts WHERE WHERE Lower(Name) = '" + szText.tolower() + "' " );
	    if( !q ) return false;
		local row = ::mysql_fetch_assoc( q );

		if( ::mysql_num_rows( q ) != null )
        {
			return row["Name"];
		}
		
		else
		{
		    return false;
		}
		::mysql_free_result( q );
    }

	function UpdateName( sText, iID )
	{
		local q = ::mysql_query( mysql, "SELECT * FROM accounts WHERE ID = '" + iID + "' " );
		if( ::mysql_num_rows( q ) == 1 )
        {
			::mysql_query( mysql, "UPDATE accounts SET Name = '" + sText + "' WHERE ID = '" + iID + "'" );
		}
		
		else
		{
		    return false;
		}
		::mysql_free_result( q );
	}

	function GetAccountInfo( iID )
	{
		local q = ::mysql_query( mysql, "SELECT IP, RegIP, RegDate, LogTime FROM accounts WHERE ID = '" + iID + "' " );
		local row = ::mysql_fetch_assoc( q );
		if( ::mysql_num_rows( q ) == 0 )
        {
			return { "IP": row["IP"], "RegIP": row["RegIP"],  "RegDate": row["RegDate"], "LogTime": row["LogTime"] }
		}
		::mysql_free_result( q );
	}
}

function SafeSelect(db, str) {
    local result = mysql_query(db, str);
    // If the result is null, nothing was selected
    if (result == null) 
        return null;
    // If the result is false, there was an error
    else if (result == false)
        throw format("MySQL Error (%d): %s", mysql_errno(db), mysql_error(db));
    // At this point something was selected and we have it
    else
        return result;
}
	
function CheckDBConnection()
{
	if( ::mysql_ping( mysql ) ) return; 
		
	if( !::mysql_ping( mysql ) ) ::print( "\r[DB] Lost connection to MySQL DB, trying to reconnect..." );
	{
		mysql = ::mysql_connect("138.68.81.159", "rp", "QE_^BBKZa5%nS9Eu", "rp");
		if( ::mysql_ping( mysql ) ) ::print( "\r[DB] Connected to MySQL database!" );
    }
}
