/*
-				Map Editor Script
-				Created By:
-				Doom_Killer
-
-				Version:
-				1.2.5
-
-				Credits:
-				SLC - For providing a better SQLite plugin.
-				Juppi - Free Camera Movement Script.
-
-				Enjoy your mapping, if you find any bugs, report them on VCMP forum on the script's topic.
-*/
/*-				Changelogs	
-*/
/*
-				Changelog - v1.1
-				► Changed data-type for rotations x, y, z to FLOAT.
-
-				Changelog - v1.2	
-				► Improved queries to reduce memory leakage.
-				► Added Page UP | DOWN key in keys list.
-				
-				Changelog - v1.2.1
-				► Fixed error on location returning.
-				
-				Changelog - v1.2.2
-				► Fixed error on newmap, unable to release sqlite data.
-				► Fixed error when not sending any text argument in addobject.
-
-				Changelog - v1.2.3
-				► Fixed errors.
-				► Fixed crash on loading map.
-				► Fixed some other things regarding errors and crashes.
-
-				Changelog - v1.2.4
-				► Now with free camera view! /cam to toggle!
-
-				Changelog - v1.2.5
-				► Added text for Currently Holding Object Name and Model.
-				► Added Auto Saving for maps, default auto save every minute.
-				► Added autosave command! /autosave to toggle.
-				
-				Changelog - v1.2.6
-				► Map menu is now available! use /addobject without any id to enter map menu and select map while previewing!
-				► Press CTRL to select & create the object.
-
-				Changelog - v1.2.7
-				► Exports are now exported in a text file without any [SCRIPT] Tags, easy to add objects in script now!
-
-				Changelog - v1.2.8
-				► Fixed locations as the database was bugged
-				► Added /settime [hour] [minute] and /setweather [id] to set weather & time.
-				► Added object control in object selection menu, use page up/down to move object higher/lower and arrow up/down to bring it near or far.
-				► Added commands to get a list of all maps & locations. /getmaps & /getlocs
-				► Changed the location of object selection menu
-				► Added /view command to switch immediately to any object ID supplied when in object selection menu
-				► Added commands /deletemap [name] and /deleteloc [name] to delete any map or location from database
-				
-   			Changelog - v1.2.9
-    			► Now supports XML outputs!
-    			► Fixed /desall, not removing all objects.
-   			
-   			Changelog - v1.3
-    			► Updated to latest server version
-    			► Fixed a few very minor bugs
-    			► Added client-sided gui labels
-   			
-   			Changelog - v1.3.2
-    			► Fixed /desall @ Thanks to Omar for pointint it out!
-    			► Fixed /closemap working as savemap; Note that if you map but didn't save and did closemap, changes will be lost!
-    			► Added /selectobject || /editobject to edito the object ID specified; Useful for objects which can't be shot/collided @ Idea by [Serious]Sam.
-				► Added /objects || /allobjects to get a list of every object created with its ID and model @ Idea by [Serious]Sam.
*/

// =========================================== CONSTANTS ==============================================

const Motion_Speed = 100; // You should not touch this unless you know what you're doing.
const cAutoSaveTime = 60000; // Auto save every minute, you can change the time here.

// =========================================== CLASES =================================================

class PlayerData
{
	MapDelete = false;
	PositionMode = false;
	Speed = "normal";
	Editing = false;
	Holding = false;
	Motion = null;
	LastKey = null;
	CTRL = false;
	car = null;
	txdObject = null;
	// Object selection.
	lastPos = null;
	viewObject = null;
	viewModel = 500;
	motionTimer = null;
}

// =========================================== LOCALS ==================================================

local txdCurrentMap;
local txdTotalObjects;
local autoSave = true;
local mapSave = { Saved = false, unsavedObjects = [] };

local C_PLOC = Vector( -1789.84, -62.7762, 35.4862 ); /*Vector( -1351.37, 1275.35, 91.1706 ); //Old */
local C_VIEWLOC = Vector( -1903.7, -17.8781, 34.7495 ); /*Vector( -1372.88, 1282.51, 83.8704 ); // Old */

// =========================================== PLAYER EVENTS ======

function AutoSave()
{
	if( autoSave && CurrentMap != "" && objCreated > 1 )
	{
		QuerySQL( Maps, "DELETE FROM '" + CurrentMap.tolower() + "'" );
		for( local i = 0; i < objCreated; i++ )
		{
			local obj = FindObject(i);
			if( obj )
			{
				QuerySQL( Maps, "INSERT INTO '" + CurrentMap.tolower() + "' VALUES ( '" + obj.Model + "', '" + obj.Pos.x + "', '" + obj.Pos.y + "', '" + obj.Pos.z + "', '" + obj.RotationEuler.x + "', '" + obj.RotationEuler.y + "', '" + obj.RotationEuler.z + "');" );
			}
		}
		MsgStaff( "[#00CC00][AUTO-SAVE]: [#ffffff]Map has been saved!" );
	}
	else return;
}

function ClientRender( idPlayer )
{
	local player = FindPlayer( idPlayer );
	if( player )
	{
		sendClientData( player, "Map" );
		sendClientData( player, "TotalObjects" );
		sendClientData( player, "ControlObject" );
	}	
}

function sendClientData( player, data ) {
	if( data == "Map" ) {
		local mapdata = Stream();
		mapdata.WriteString( "Current Map:" + ( CurrentMap == "" ? "None" : CurrentMap ) );
		mapdata.SendStream( player );
	}
	else if( data == "TotalObjects" ) {
		local mapdata = Stream();
		mapdata.WriteString( "Total Objects:" + objCreated );
		mapdata.SendStream( player );
	}
	else if( data == "ControlObject" ) {
		local object; 
		local mapdata = Stream();
		if( Object[ player.ID ] == null ) {
			mapdata.WriteString( "Object:None" );
		}
		else {
			if( typeof Object[ player.ID ] == "instance" ) object = Object[ player.ID ];
			else object = FindObject( Object[ player.ID ] );
				
			local objectModel = object.Model, objectID = object.ID;
			mapdata.WriteString( "Object:" + objectModel + ":" + objectID );
		}
		mapdata.SendStream( player );
	}
}

function FindLoc( text ) 
{
    local Location = QuerySQL( db, "SELECT Name FROM Gotoloc WHERE Name='" + text + "'" );
    if( Location ) { FreeSQLQuery( Location ); return true }
    else { return false }
}

function onObjectShot( object, player, weapon )
{
	local obj = FindObject( object.ID );
	local plr = FindPlayer( player.ID );
	Object[ plr.ID ] = obj;
	pData[ player.ID ].Editing = true;
	MessagePlayer( "[#00CC00][SELECT]: [#ffffff]Selected object " + object.ID, player );
	return 1;
}

function onObjectBump( object, player )
{
	local obj = FindObject( object.ID );
	local plr = FindPlayer( player.ID );
	obj.Delete();
	pData[ player.ID ].Editing = false;
	objCreated--;
	Object[ player.ID ] = null;
	MessagePlayer( "[#00CC00][SELECT]: [#ffffff]Object deleted!", player );
}

function EnableBumpTracks()
{
	for( local i = 0; i < objCreated; i++ )
	{
		local o = FindObject( i );
		if( o ) o.TrackingBumps = true;
	}
}

function DisableBumpTracks()
{
	for( local i = 0; i < objCreated; i++ )
	{
		local o = FindObject( i );
		if( o ) o.TrackingBumps = false;
	}
}

function RemoveObjects( CurrentMap )
{
	local i = 0;
	do
	{
		local obj = FindObject( i );
		if( obj ) { obj.Delete(); objCreated--; }
		i++;
	}
	while( objCreated > 0 );
	objCreated = 0;
	MsgStaff( "[#ffffff]All objects of the map " + CurrentMap + " were removed!" );
}

function onKeyUp( player, key )
{
	if( pData[ player.ID ].Motion != null )
	{
		pData[ player.ID ].Motion.Delete();
		pData[ player.ID ].Motion = null;
	}
	
	if( key == ctrl ) { pData[ player.ID ].CTRL = false; }
	onCamKeyUp( player, key );
}

function onKeyDown( plr, key )
{
	local player;
	if( typeof plr != "instance" ) player = FindPlayer( plr );
	else player = plr;
	
	if( !pData[ player.ID ].Editing && pData[ player.ID ].lastPos == null ) return onCamKeyDown( plr, key ); /*MessagePlayer( "[#00CC00][MAP]: [#ffffff]You are not controlling any object!", player );*/
	
	if( key == ArrowRight && pData[ player.ID ].lastPos != null )
	{
		pData[ player.ID ].viewObject.Delete();
		pData[ player.ID ].viewObject = null;
		pData[ player.ID ].viewModel++;
		pData[ player.ID ].viewObject = CreateObject( pData[ player.ID ].viewModel, player.World, C_VIEWLOC.x, C_VIEWLOC.y, C_VIEWLOC.z, 255 );
		//MessagePlayer( "[#00CC00][OBJECT]: [#FFFFFF]Viewing object: " + pData[ player.ID ].viewModel, player );
	}
	else if( key == ArrowLeft && pData[ player.ID ].lastPos != null )
	{
		pData[ player.ID ].viewObject.Delete();
		pData[ player.ID ].viewObject = null;
		pData[ player.ID ].viewModel--;
		pData[ player.ID ].viewObject = CreateObject( pData[ player.ID ].viewModel, player.World, C_VIEWLOC.x, C_VIEWLOC.y, C_VIEWLOC.z, 255 );
		//MessagePlayer( "[#00CC00][OBJECT]: [#FFFFFF]Viewing object: " + pData[ player.ID ].viewModel, player );
	}
	else if( key == ctrl && pData[ player.ID ].lastPos != null )
	{
		pData[ player.ID ].motionTimer.Delete();
		player.Pos = pData[ player.ID ].lastPos;
		pData[ player.ID ].lastPos = null;
		player.RestoreCamera();
		player.World = 0;
		pData[ player.ID ].viewObject.Delete();
		pData[ player.ID ].viewObject = null;
		player.IsFrozen = false;
		Object[ player.ID ] = CreateObject( pData[ player.ID ].viewModel, 0, player.Pos.x, player.Pos.y, player.Pos.z, 255 );
		Object[ player.ID ].TrackingShots = true;
		objCreated++;
		player.Pos = Vector( player.Pos.x, player.Pos.y, player.Pos.z + 3 );
		pData[ player.ID ].Editing = true;
		mapSave.Saved = false;
		mapSave.unsavedObjects.append( Object[ player.ID ] );
		MsgStaff( "[#00CC00][MAP]: [#ffffff]Created object " + pData[ player.ID ].viewModel );
	}
	else if( key == PageDown && pData[ player.ID ].lastPos != null )
	{
		local objPosition = pData[ player.ID ].viewObject.Pos;
		pData[ player.ID ].viewObject.Pos = Vector( objPosition.x, objPosition.y, objPosition.z - 5 );
	}
	else if( key == PageUp && pData[ player.ID ].lastPos != null )
	{
		local objPosition = pData[ player.ID ].viewObject.Pos;
		pData[ player.ID ].viewObject.Pos = Vector( objPosition.x, objPosition.y, objPosition.z + 5 );
	}
	else if( key == ArrowDown && pData[ player.ID ].lastPos != null )
	{
		local objPosition = pData[ player.ID ].viewObject.Pos;
		pData[ player.ID ].viewObject.Pos = Vector( objPosition.x + 13, objPosition.y - 5, objPosition.z );
	}
	else if( key == ArrowUp && pData[ player.ID ].lastPos != null )
	{
		local objPosition = pData[ player.ID ].viewObject.Pos;
		pData[ player.ID ].viewObject.Pos = Vector( objPosition.x - 13, objPosition.y + 5, objPosition.z );
	}
	
	if( pData[ player.ID ].Motion == null && key != one && key != R && key != two && key != backspace && key != del ) pData[ player.ID ].Motion = NewTimer( "onKeyDown", Motion_Speed, 0, player.ID, key );
	
	if( key == ArrowLeft && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, 0.05 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, 0.30 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, 1.30 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, 0.01 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, 0.03 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == ArrowRight && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, -0.05 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, -0.30 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, -1.30 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, -0.01 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0, -0.03 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == PageUp && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( 0.05, 0, 0 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( 0.30, 0, 0 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( 1.30, 0, 0 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( 0.01, 0, 0 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( 0.03, 0, 0 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == PageDown && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( -0.05, 0, 0 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( -0.30, 0, 0 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( -1.30, 0, 0 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( -0.01, 0, 0 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( -0.03, 0, 0 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == ArrowUp && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0.05, 0 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0.30, 0 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, 1.30, 0 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0.01, 0 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, 0.03, 0 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == ArrowDown && !pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].RotateByEuler( Vector( 0, -0.05, 0 ), 100 );
			break;
			
			case "fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, -0.30, 0 ), 100 );
			break;
			
			case "very fast":
			Object[ player.ID ].RotateByEuler( Vector( 0, -1.30, 0 ), 100 );
			break;
			
			case "very slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, -0.01, 0 ), 100 );
			break;
			
			case "slow":
			Object[ player.ID ].RotateByEuler( Vector( 0, -0.03, 0 ), 100 );
			break;
		}
		return;
	}
	
	else if( key == PageUp && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x, y, z + 0.05 );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x, y, z + 0.30 );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x, y, z + 1.30 );
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x, y, z + 0.01 );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x, y, z + 0.03 );
			break;
		}
		return;
	}
	
	
	else if( key == PageDown && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x, y, z - 0.05 );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x, y, z - 0.30 );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x, y, z - 1.30 );
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x, y, z - 0.01 );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x, y, z - 0.03 );
			break;
		}
		return;
	}
	
	else if( key == ArrowLeft && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x - 0.05, y, z );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x - 0.30, y, z );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x - 1.30, y, z);
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x - 0.01, y, z );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x - 0.03, y, z );
			break;
		}
		return;
	}
	
	else if( key == ArrowRight && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x + 0.05, y, z );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x + 0.30, y, z );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x + 1.30, y, z);
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x + 0.01, y, z );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x + 0.03, y, z );
			break;
		}
		return;
	}
	
	else if( key == ArrowUp && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x, y + 0.05, z );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x, y + 0.30, z );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x, y + 1.30, z);
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x, y + 0.01, z );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x, y + 0.03, z );
			break;
		}
		return;
	}
	
	else if( key == ArrowDown && pData[ player.ID ].PositionMode && Object[ player.ID ] != null )
	{
		local x = Object[ player.ID ].Pos.x;
		local y = Object[ player.ID ].Pos.y;
		local z = Object[ player.ID ].Pos.z;
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			Object[ player.ID ].Pos = Vector( x, y - 0.05, z );
			break;
			
			case "fast":
			Object[ player.ID ].Pos = Vector( x, y - 0.30, z );
			break;
			
			case "very fast":
			Object[ player.ID ].Pos = Vector( x, y - 1.30, z);
			break;
			
			case "very slow":
			Object[ player.ID ].Pos = Vector( x, y - 0.01, z );
			break;
			
			case "slow":
			Object[ player.ID ].Pos = Vector( x, y - 0.03, z );
			break;
		}
		return;
	}
	
	else if( key == one && Object[ player.ID ] != null )
	{
		if( !pData[ player.ID ].PositionMode )
		{
			pData[ player.ID ].PositionMode = true;
			MessagePlayer( "[#ffffff]Map positioning mode is [#00ff00]ON[#ffffff]! Rotation mode [#ff0000]OFF[#ffffff]!", player );
		}
		
		else if( pData[ player.ID ].PositionMode )
		{
			pData[ player.ID ].PositionMode = false;
			MessagePlayer( "[#ffffff]Map positioning mode is [#ff0000]OFF[#ffffff]! Rotation mode [#00ff00]ON[#ffffff]!", player );
		}
	}
	
	else if( key == two && Object[ player.ID ] != null )
	{
		switch( pData[ player.ID ].Speed )
		{
			case "normal":
			pData[ player.ID ].Speed = "fast";
			MessagePlayer( "[#ffffff]Speed movement level is now [#00ff00]Fast[#ffffff]!", player );
			break;
			
			case "fast":
			pData[ player.ID ].Speed = "very fast";
			MessagePlayer( "[#ffffff]Speed movement level is now [#00ff00]Very Fast[#ffffff]!", player );
			break;
			
			case "very fast":
			pData[ player.ID ].Speed = "very slow";
			MessagePlayer( "[#ffffff]Speed movement level is now [#00ff00]Very Slow[#ffffff]!", player );
			break;
			
			case "very slow":
			pData[ player.ID ].Speed = "slow";
			MessagePlayer( "[#ffffff]Speed movement level is now [#00ff00]Slow[#ffffff]!", player );
			break;
			
			case "slow":
			pData[ player.ID ].Speed = "normal";
			MessagePlayer( "[#ffffff]Speed movement level is now [#00ff00]Normal[#ffffff]!", player );
			break;
		}
	}
	
	else if( key == ctrl ) { pData[ player.ID ].CTRL = true; }
	
	else if( key == c && pData[ player.ID ].CTRL && Object[ player.ID ] != null )
	{
		local old_obj = Object[ player.ID ].Pos;
		local old_objid = Object[ player.ID ].Model;
		local old_objrot = Object[ player.ID ].RotationEuler;
		
		Object[ player.ID ] = CreateObject( old_objid, 0, old_obj, 255 );
		Object[ player.ID ].RotateToEuler( old_objrot, 0 );
		Object[ player.ID ].TrackingShots = true;
		objCreated++;
		pData[ player.ID ].Editing = true;
		MsgStaff( "[#00CC00][CLONE]: [#ffffff]Cloned object " + old_objid + " at its position" );
	}
	
	else if( key == del && Object[ player.ID ] != null )
	{
		local object;
		if( typeof Object[ player.ID ] != "instance" ) object = FindObject( Object[ player.ID ] );
		else object = Object[ player.ID ];
		if( !object ) return MessagePlayer( "[#00CC00][ERROR]: [#FFFFFF]Could not delete object", player );
		object.Delete();
		Object[ player.ID ] = null;
		pData[ player.ID ].Editing = false;
		objCreated--;
		MessagePlayer( "[#00CC00][SELECT]: [#ffffff]Object deleted!", player );
	}
	
	else if( key == R && Object[ player.ID ] != null )
	{
		Object[ player.ID ].RotateToEuler( Vector( 0, 0, 0 ), 0 );
		MessagePlayer( "[#ffffff]Rotation angles have been Reset!", player );
		return;
	}
	
	else if( key == backspace && pData[ player.ID ].Editing )
	{
		pData[ player.ID ].Editing = false;
		Object[ player.ID ] = null;
		MessagePlayer( "[#00CC00][EDIT]: [#ffffff]You have finished editing the object.", player );
	}
}

function onObjectRender( idPlayer )
{
	local player = FindPlayer( idPlayer );
	if( player && pData[ player.ID ].viewObject != null )
	{
		local object = pData[ player.ID ].viewObject;
		if( object ) 
		{
			if( object.World != player.World )
			{
				MessagePlayer( "Not same world, fixing.", player );
				object.World = player.World;
			}
			object.RotateByEuler( Vector( 0, 0, -0.1 ), 100 );
		}
	}
	else return null;
}
// ================================== END ======================================