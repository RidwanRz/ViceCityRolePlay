/* ported from mfi mapping script */

objects <- {}

function LoadObject()
{ 
    local q = SafeSelect( mysql, "SELECT * FROM `object`" ), ID = 0;
	local row;
	while( row = mysql_fetch_assoc( q ) )
	{						
		objects.rawset( ID,
		{
			ID = ID,
			Model = row["Name"].tointeger(),
			World = row["World"].tointeger(),
			x = row["X"].tofloat(),
			y = row["Y"].tofloat(),
			z = row["Z"].tofloat(),
			rotx = row["RotX"].tofloat(),
			roty = row["RotY"].tofloat(),
			rotz = row["RotZ"].tofloat(),
			UID = row["UID"],
			object = null,
			Owner = "100000",
			Timeout = 0,
		});
    }
		
	mysql_free_result( q );
	print( "\r[Object] " + objects.len() + " objects loaded in cache." );
}

function SaveData( id )
{
	local ob = objects[ id ];

	mysql_query( mysql, "UPDATE Object SET Name = '" + ob.Model + "', World = '" + ob.World + "', X = '" + ob.x.tofloat() + "', Y = '" + ob.y.tofloat() + "', Z = '" + ob.z.tofloat() + "', RotX = '" + ob.rotx.tofloat() + "', RotY = '" + ob.roty.tofloat() + "', RotZ = '" + ob.rotz.tofloat() + "' WHERE UID = '" + ob.UID + "'" );
}

function AddObject( model, world, pos, owner )
{
	local obj = CreateObject( model, world, pos , 255 );
	local ID = ( objects.len() + 1 );

	objects.rawset( ID,
	{
		ID = ID,
		Model = model,
		World = world,
		x = pos.x,
		y = pos.y,
		z = pos.z,
		rotx = 0,
		roty = 0,
		rotz = 0,
		UID = MD5( "" + time() ),
		object = obj,
		Owner = owner,
		Timeout = 0,
	});

	return obj
}

class Obj
{
   
    Model = null;
	ID = null;
	World = 0;
	x = 0;
	y = 0;
	z = 0;
	rotx = 0;
	roty = 0;
	rotz = 0;
	object = null;
	UID = null;
	Timeout = 0;

	function SaveData()
	{
    	::QuerySQL( db, "BEGIN TRANSACTION" );
		::QuerySQL( db, "UPDATE Object SET Name = '" + this.Model + "', World = '" + this.World + "', X = '" + this.x.tofloat() + "', Y = '" + this.y.tofloat() + "', Z = '" + this.z.tofloat() + "', RotX = '" + this.rotx.tofloat() + "', RotY = '" + this.roty.tofloat() + "', RotZ = '" + this.rotz.tofloat() + "' WHERE UID = '" + this.UID + "'" );
	   	::QuerySQL( db, "END TRANSACTION" );	
	}
	
}

function onPlayerEnterWorld( worldid )
{
	foreach( index, value in objects )
	{
		if( value.World == worldid && value.object == null )
		{

			value.object = CreateObject( value.Model, value.World, value.x, value.y, value.z , 255 );
//		objects[ ID ].object.TrackingShots = true;
			value.object.RotationEuler.x = value.rotx;
			value.object.RotationEuler.y = value.roty;
			value.object.RotationEuler.z = value.rotz;
		}
	}
}

function onPlayerExitWorld( worldid )
{
	local count = 0;
	foreach( index, value in Server.Players )
	{
		local player = FindPlayer( value );

		if( player )
		{
			if( player.World == worldid ) count ++;
		}
	}

	if( count == 0 )
	{
		foreach( index, value in objects )
		{
			if( value.World == worldid && value.object == null )
			{
				value.Timeout = time();
			}
		}
	}
}

function RemoveObject()
{
	local count = [];
	foreach( index, value in Server.Players )
	{
		local player = FindPlayer( value );

		if( player )
		{
			if( player.World > 2 ) 
			{
				if( count.find( player.World ) == null ) count.push( player.World );
			}
		}
	}

	foreach( index, value in objects )
	{
		if( value.World > 2 )
		{
			if( ( time() - value.Timeout ) > 60 && count.find( value.World ) == null )
			{
				if( value.object != null )
				{
					value.object.Delete();
					value.object = null;
				}
			}
		}
	}
}

function SaveObject()
{
	foreach( kiki in objects )
	{
		kiki.SaveData();
	}
}

function onPlayerEditObject( player,key )
{
	local pPlr = playa[ player.ID ]
	if ( pPlr.MapEdit != null )
	{
		local kaki = objects.rawin( pPlr.MapEdit );
		if ( !kaki ) MsgPlr( 2, player, Lang.ObjectNotExist );
		else
		{
	
			local
			id = pPlr.MapEdit,
			x = objects[ id ].x,
			y = objects[ id ].y,
			z = objects[ id ].z;
		
			switch( key )
			{
				case Key_Up:
				case Key_Down:
				case Key_Left:
				case Key_Right:
				case Key_PageUp:
				case Key_PageDown:
				
				playa[ player.ID ].MappingTimer = _Timer.Create( this, function() 
				{
					switch( key )
					{
						case Key_Up: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.y += pPlr.Editsens;
							objects[ id ].y = objects[ id ].object.Pos.y; 
							break;

							case "angle":
							objects[ id ].object.RotationEuler.z += pPlr.Editsens;
							objects[ id ].rotz = objects[ id ].object.RotationEuler.z; 
							break;						
						}
						break;

						case Key_Down: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.y -= pPlr.Editsens;
							objects[ id ].y = objects[ id ].object.Pos.y; 
							break;

							case "angle":
							objects[ id ].object.RotationEuler.z -= pPlr.Editsens;
							objects[ id ].rotz = objects[ id ].object.RotationEuler.z; 
							break;
						}
						break;

						case Key_Left: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.x += pPlr.Editsens;
							objects[ id ].x = objects[ id ].object.Pos.x;
							break;

							case "angle":
							objects[ id ].object.RotationEuler.y += pPlr.Editsens;
							objects[ id ].roty = objects[ id ].object.RotationEuler.y; 
							break;
						}
						break;

						case Key_Right: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.x -= pPlr.Editsens;
							objects[ id ].x = objects[ id ].object.Pos.x; 
							break;

							case "angle":
							objects[ id ].object.RotationEuler.y -= pPlr.Editsens;
							objects[ id ].roty = objects[ id ].object.RotationEuler.y; 
							break;
						}
						break;

						case Key_PageUp: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.z += pPlr.Editsens;
							objects[ id ].z = objects[ id ].object.Pos.z;
							break;

							case "angle":
							objects[ id ].object.RotationEuler.x += pPlr.Editsens;
							objects[ id ].rotx = objects[ id ].object.RotationEuler.x; 
							break;
						}
						break;

						case Key_PageDown: 
						switch( playa[ player.ID ].EditType )
						{
							case "xyz":
							objects[ id ].object.Pos.z -= pPlr.Editsens;
							objects[ id ].z = objects[ id ].object.Pos.z; 
							break;

							case "angle":
							objects[ id ].object.RotationEuler.x -= pPlr.Editsens; 
							objects[ id ].rotx = objects[ id ].object.RotationEuler.x; 
							break;
						}
						break;
					}
				}, 100, 0 );
				break;

				case Key_F2:
				switch( playa[ player.ID ].EditType )
				{
					case "xyz":
					playa[ player.ID ].EditType = "angle";
					MsgPlr( 3, player, Lang.ChangeEditMode, "Angle" );
					break;

					case "angle":
					playa[ player.ID ].EditType = "xyz";
					MsgPlr( 3, player, Lang.ChangeEditMode, "Position" );
					break;
				}
				break;

				case Key_Shift: objects[ id ].object.SetAlpha(255,0); MsgPlr( 3, player, Lang.ObjSave ), _Timer.Destroy( playa[ player.ID ].MappingTimer ), pPlr.MapEdit = null; objects[ id ].SaveData(); break;
				case Key_Del: objects[ id ].object.Delete(); QuerySQL( db, "delete from Object WHERE UID = '" + objects[ id ].UID + "'" ), _Timer.Destroy( playa[ player.ID ].MappingTimer ), AddQuatity( player, FromModelToItem( objects[ id ].Model ) , "1"), objects.rawdelete( id ), MsgPlr( 3, player, Lang.ObjDel ), pPlr.MapEdit = null; break;
			}		
	    }
	}
}

function onPlayerEditObjectUp( player,key )
{
	_Timer.Destroy( playa[ player.ID ].MappingTimer );
}

function SaveObj( player )
{
	if( playa[ player.ID ].MapEdit != null )
	{
		local id = playa[ player.ID ].MapEdit;
		
		objects[ id ].object.SetAlpha(255,0); 
		objects[ id ].SaveData();

		MsgPlr( 3, player, Lang.ObjSave );
		playa[ player.ID ].MapEdit = null;

		_Timer.Destroy( playa[ player.ID ].MappingTimer );
	}
}

function FromItemToModel( id )
{
	switch( id.tointeger() )
	{
		case 100: return 573;
		case 101: return 2272;
		case 102: return 4595;
		case 103: return 591;
		case 104: return 2486;
		case 105: return 4594;
		case 106: return 2465;
		case 107: return 4763;
		case 108: return 2462;
	}
}

function FromModelToItem( id )
{
	switch( id.tointeger() )
	{
		case 573: return 100;
		case 2272: return 101;
		case 4595: return 102;
		case 591: return 103;
		case 2486: return 104;
		case 4594: return 105;
		case 2465: return 106;
		case 4763: return 107;
		case 2462: return 108;
	}
}

function EditObject( player, text )
{
	if( playa[ player.ID ].House == null ) SendDataToClient( 6042, "You need to be inside house.", player );
	else if( !text ) SendDataToClient( 6042, "You need to be inside house.", player );
	else
	{
		if( !VerifyOwnerAndSharer( playa[ player.ID ].House, playa[ player.ID ].ID ) ) SendDataToClient( 6042, "You are not owner or shared.", player );			
		else if( !IsNum( text ) ) SendDataToClient( 6042, "Object id must be in number.", player );
		else
		{
			if( objects.rawin( text.tointeger() ) == false ) SendDataToClient( 6042, "This object does not exist.", player );
			else if( playa[ player.ID ].MapEdit != null ) SendDataToClient( 6042,"You are still editing object.", player );
			else if( objects[ text.tointeger() ].World != player.World ) SendDataToClient( 6042, "This object does not exist.", player );
			else
			{
				local re = false;
				foreach( kiki in Server.Players )
				{
					local pTarget1 = FindPlayer( kiki );
					if( pTarget1 && playa[ pTarget1.ID ].MapEdit == text.tointeger() ) re = true;
				}
						
				if( re ) SendDataToClient( 6042, "Someone is editing this object.", player );
				else
				{
					objects[ text.tointeger() ].object.SetAlpha( 100, 1000 );
					playa[ player.ID ].MapEdit = objects[ text.tointeger() ].ID;

					MsgPlr( 3, player, Lang.EditObject, GetItemNameByID( FromModelToItem( objects[ text.tointeger() ].Model ) ) );

					SendDataToClient( 6043, null, player );
				}
			}
		}
	}
}

function onObjCmd( player, cmd, text )
{
	switch( cmd )
	{
		case "addobject":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else if( playa[ player.ID ].MapEdit != null ) MsgPlr( 2, player, Lang.EditObjStillEdit );
		else if( !text ) MsgPlr( 2, player, Lang.AddObjectSyntax );
		else
		{
			local s = GetItemIDByNameForObj( text );
			if( !VerifyOwnerAndSharer( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared );			
			else if( !IsNum( text ) ) MsgPlr( 2, player, Lang.ObjNotNum );
			else if( s == false ) MsgPlr( 2, player, Lang.InvalidItemx2 ), MsgPlr( 2, player, Lang.InvalidItem32 );
			else if( 1 > GetItemQuatity( player, GetItemIDByName( text ) ) ) MsgPlr( 2, player, Lang.InvalidItem64, GetItemNameByID( GetItemIDByName( text ) ) );
			else if( text.tointeger() > 109 ) MsgPlr( 2, player, Lang.AddObjEx );
			else if( text.tointeger() < 99 ) MsgPlr( 2, player, Lang.AddObjEx );
			else
			{
				local instance = ::CreateObject( FromItemToModel( text.tointeger() ), player.World, ( player.Pos.x + 1 ), ( player.Pos.y + 1 ), player.Pos.z , 255 );
				local addID = instance.ID, ra = time();
						
				objects[ addID ] <- Obj();
				objects[ addID ].Model = FromItemToModel( text.tointeger() );
				objects[ addID ].World = player.World;
				objects[ addID ].x = player.Pos.x + 1;
				objects[ addID ].y = player.Pos.y + 1;
				objects[ addID ].z = player.Pos.z;
				objects[ addID ].rotx = 0
				objects[ addID ].roty = 0
				objects[ addID ].rotz = 0;
				objects[ addID ].UID = ::MD5( ""+ra );
				objects[ addID ].ID = addID;

				::QuerySQL( db, "insert into Object VALUES ( '" + FromItemToModel( text.tointeger() ) + "', '" + player.World + "', '" + player.Pos.x + "', '" + player.Pos.y + "', '" + player.Pos.z + "', '0', '0', '0', '" + ::MD5( ""+ra ) + "' )" );
				objects[ addID ].object = instance;
				objects[ addID ].object.SetAlpha( 155,1000 );
				playa[ player.ID ].MapEdit = addID;
				DecQuatity( player, FromModelToItem( objects[ addID ].Model ), "1" );
				
				MsgPlr( 3, player, Lang.AddObject, GetItemNameByID( text.tointeger() ) );
			}
		}
		break;
		
		case "objectlist":
		if( playa[ player.ID ].House == null ) MsgPlr( 2, player, Lang.NotInHouse );
		else
		{
			if( !VerifyOwnerAndSharer( playa[ player.ID ].House, playa[ player.ID ].ID ) ) MsgPlr( 2, player, Lang.NotOwnerShared );			
			else if( playa[ player.ID ].MapEdit != null ) MsgPlr( 2, player, Lang.EditObjStillEdit );
			else
			{
				local t = 0, tt = [];
				foreach( id, kiki in objects )
				{
					if( kiki.World == player.World )
					{
						tt.append( FromModelToItem( kiki.Model ) + ":" + kiki.ID );
						t ++;
					}
				}
				
				if( t )
				{
					SendDataToClient( 6040, null, player );

					foreach( i in tt )
					{
						SendDataToClient( 6041, i, player );
					}
				}
				else MsgPlr( 2, player, Lang.Objectlistnoobject );
			}
		}
		break;

		case "editsens":
		if( !text ) MsgPlr( 2, player, Lang.EditSensSyntax );
		else if( !IsFloat( text ) ) MsgPlr( 2, player, Lang.EditSensNotIntOrFt );
		else
		{
			playa[ player.ID ].Editsens = text.tofloat();

			MsgPlr( 3, player, Lang.EditSens, text );
		}
		break;
	}
}
