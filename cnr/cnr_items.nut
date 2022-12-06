/* 
	Product ID

	24/7
	1 - revive kit - max 4000
	2 - phone - max 2000
	3 - radio - 4000
	4 - gps  - 4000
	5 - kit kat - 500
	6 - medic kit - 5000
	
	weapon section
	7 - colt
	8 - python
	9 - shotgun
	10 - stubby shotgun
	11 - ingram
	12 - tec 9
	13 - mp5
	14 - smg
	15 - armour

	black market (unlimited supplies)
	16 - m4 case 
	17 - ruger case
	18 - armour case
	19 - rpg case
	20 - m60 case
	21 - weed seed
	22 - c4 
*/
function GetItemNameByID( id, skin = 0 )
{
	switch( id.tointeger() )
	{
		case 1: return "Revive Kit";
		case 2: return "Phone";
		case 3: return "Radio";
		case 4: return "GPS";
		case 5: return "Kit Kat";		
		case 6: return "Firstaid Kit";

		case 7: return "Colt .45 (50 Rounds)";
		case 8: return "Python (50 Rounds)";
		case 9: return "Shotgun (50 Rounds)";
		case 10: return "Stubby Shotgun (50 Rounds)";
		case 11: return "Tec 9 (50 Rounds)";
		case 12: return "Uzi (50 Rounds)";
		case 13: return "Ingram (50 Rounds)";
		case 14: return "MP5 (50 Rounds)";
		case 15: return "Armour";

		case 16: return "M4 Case";
		case 17: return "Ruger Case";
		case 18: return "Armour Case";
		case 19: return "M60 Case";
		case 20: return "Sniper Case";
		case 21: return "RPG Case";
		case 22: return "Weed Seed";
		case 23: return "Weed";

		case 24: return "Vehicle Part";

		case 25: return "Tool Kit";

		default:
		if( id >= 101 && id <= 152 ) return GetSkinName( skin );
	}
}

function GetItemNameByID2( id )
{
	switch( id.tointeger() )
	{
		case 1: return "Revive Kit";
		case 2: return "Phone";
		case 3: return "Radio";
		case 4: return "GPS";
		case 5: return "Kit Kat";		
		case 6: return "Firstaid Kit";

		case 7: return "Colt .45";
		case 8: return "Python";
		case 9: return "Shotgun";
		case 10: return "Stubby Shotgun";
		case 11: return "Tec 9";
		case 12: return "Uzi";
		case 13: return "Ingram";
		case 14: return "MP5";

		case 16: return "M4 Case";
		case 17: return "Ruger Case";
		case 18: return "Armour Case";
		case 19: return "M60 Case";
		case 20: return "Sniper Case";
		case 21: return "RPG Case";
		case 22: return "Weed Seed";
		case 23: return "Weed";

		case 24: return "Vehicle Part";
		case 25: return "Tool Kit";
	}
}

function GetItemIDByName( string )
{
	switch( string.tolower() )
	{
		case "revive kit": return 1;
		case "phone": return 2;
		case "radio": return 3;
		case "gps": return 4;
		case "kit kat": return 5;
		case "firstaid kit": return 6;

		case "colt .45 (50 rounds)":
		case "coth .45":
		return 7;

		case "python (50 rounds)":
		case "python":
		return 8;

		case "shotgun (50 rounds)":
		case "shotgun":
		return 9;

		case "stubby shotgun (50 rounds)":
		case "stubby shotgun":
		return 10;

		case "tec 9 (50 rounds)": 
		case "tec 9":
		return 11;

		case "uzi (50 rounds)":
		case "uzi":
		return 12;

		case "ingram (50 rounds)":
		case "ingram":
		return 13;

		case "mp5 (50 rounds)":
		case "mp5":
		return 14;

		case "armour": return 15;

		case "m4 case": return 16;
		case "ruger case": return 17;
		case "armour case": return 18;
		case "m60 case": return 19;
		case "sniper case": return 20;
		case "rpg case": return 21;
		case "weed seed": return 22;
		case "weed": return 23;

		case "vehicle part": return 24;

		case "tool kit": return 25;

		case "haiti #1": return 101;
		case "granny #1": return 102;
		case "church lady": return 103;
		case "pimp": return 104;
		case "bum buy #2": return 105;
		case "haitian #2": return 106;
		case "cuban #1": return 107;
		case "cuban #2": return 108;
		case "haitian #3": return 109;
		case "haitian #4": return 110;

		case "lawyer": return 111;
		case "spanish lady #1": return 112;
		case "spanish lady #2": return 113;
		case "arabic guy": return 114;
		case "spanish lady #3": return 115;
		case "businessman #5": return 116;
		case "businessman #6": return 117;
		case "pizza man": return 118;
		case "prostitute #3": return 119;
		case "diaz gangster #2": return 120;
		case "hood lady": return 121;

		case "golf guy #1": return 122;
		case "punk #1": return 123;
		case "prostitute #1": return 124;
		case "granny #1": return 125;
		case "prostitute #3": return 126;
		case "cool guy #2": return 127;
		case "construction worker #2": return 128;
		case "golf guy #2": return 129;
		case "golf lady": return 130;
		case "golf guy #3": return 131;
		case "spanish guy": return 132;
		case "taxi driver #2": return 133;
		case "vercetti guy #1": return 134;
		case "vercetti guy #2": return 135;
		case "cool guy #1": return 136;

		case "beach lady #1": return 137;
		case "waitress #1": return 138;
		case "beach lady #3": return 139;
		case "prostitute #2": return 140;
		case "beach lady #5": return 141;
		case "beach guy #5": return 142;
		case "beach lady #6": return 143;
		case "beach guy #6": return 144;
		case "beach lady #7": return 145;
		case "beach guy #7": return 146;
		case "skate lady": return 147;
		case "prostitute #3": return 148;
		case "hilary": return 149;
		case "love fist #3": return 150;
		case "love fist #4": return 151;
		case "cam": return 152;

		default: return false; break;
	}
}

function GetRobItem( string )
{
	switch( string.tolower() )
	{
		case "revive kit": return 1;
		case "kit kat": return 5;
		case "firstaid kit": return 6;

		case "m4 case": return 16;
		case "ruger case": return 17;
		case "armour case": return 18;
		case "m60 case": return 19;
		case "sniper case": return 20;
		case "rpg case": return 21;
		case "weed seed": return 22;
		case "weed": return 23;
		case "tool kit": return 25;

		default: 
		if( GetWeaponID( string ) == 255 ) return null;
		else return "Weapon";
	}
}

function GetSkinNameByItemID( id )
{
	switch( id.tointeger() )
	{
		case 101: return 29;
		case 102: return 32;
		case 103: return 36;
		case 104: return 37;
		case 105: return 45;
		case 106: return 46;
		case 107: return 83;
		case 108: return 84;
		case 109: return 85;
		case 110: return 86;

		case 111: return 12;
		case 112: return 13;
		case 113: return 14;
		case 114: return 16;
		case 115: return 53;
		case 116: return 68;
		case 117: return 69;
		case 118: return 131;
		case 119: return 175;
		case 120: return 181;
		case 121: return 182;

		case 122: return 7;
		case 123: return 11;
		case 124: return 24;
		case 125: return 32;
		case 126: return 49;
		case 127: return 55;
		case 128: return 61;
		case 129: return 62;
		case 130: return 63;
		case 131: return 64;
		case 132: return 73;
		case 133: return 74;
		case 134: return 95;
		case 135: return 96;
		case 136: return 15;

		case 137: return 17;
		case 138: return 22;
		case 139: return 38;
		case 140: return 43;
		case 141: return 57;
		case 142: return 58;
		case 143: return 59;
		case 144: return 60;
		case 145: return 65;
		case 146: return 66;
		case 147: return 77;
		case 148: return 105;
		case 149: return 110;
		case 150: return 117;
		case 151: return 122;
		case 152: return 126;

	}
}

function GetWeaponIDByItem( id )
{
	switch( id.tointeger() )
	{
		case 7: return 17;
		case 8: return 18;
		case 9: return 19;
		case 10: return 21;
		case 11: return 22;
		case 12: return 23;
		case 13: return 24;
		case 14: return 25;
	}
}

function GetStockLimit( id )
{
	switch( id.tointeger() )
	{
		case 1: return 200;
		case 2: return 1000;
		case 3: return 1000;
		case 4: return 1000;
		case 5: return 500;		
		case 6: return 200;		

		case 7: return 5000;
		case 8: return 5000;
		case 9: return 5000;
		case 11: return 5000;
		case 12: return 5000;
		case 13: return 5000;
		case 14: return 5000;
		case 15: return 5000;

		case 24: return 3000;
		case 25: return 1000;
	}
}

function GetStockPrice( id )
{
	switch( id.tointeger() )
	{
		case 1: return 1500;
		case 2: return 1000;
		case 3: return 2000;
		case 4: return 2000;
		case 5: return 150;		
		case 6: return 1500;		

		case 7: return 300;
		case 8: return 2200;
		case 9: return 300;
		case 11: return 500;
		case 12: return 1500;
		case 13: return 1200;
		case 14: return 2800;
		case 15: return 6000;

		case 24: return 500;
		case 25: return 1000;
	}
}

function GetStockMaxPrice( id )
{
	switch( id.tointeger() )
	{
		case 1: return 4000;
		case 2: return 2000;
		case 3: return 4000;
		case 4: return 4000;
		case 5: return 500;		
		case 6: return 5000;

		case 7: return 900;
		case 8: return 1500;
		case 9: return 900;
		case 11: return 2100;
		case 12: return 1400;
		case 13: return 1900;
		case 14: return 4000;
		case 15: return 8000;

		case 24: return 5000;
		case 25: return 6000;
	}
}


function GetItemIDByNameForObj( string )
{
	switch( string )
	{
		case "100":
		case "101":
		case "102":
		case "103":
		case "104":
		case "105":
		case "106":
		case "107":
		case "108":
		return string.tointeger(); break;

		default: return false; break;
	}
}

function IsItemExist( player, id )
{
	if( playa[ player.ID ].Items.find( "null" ) >= 0 || playa[ player.ID ].Items.find( "N/A" ) >= 0 ) return false;
	foreach( kiki in playa[ player.ID ].Items )
	{
		local item = split( kiki , "-" );
		if( item[0].tointeger() == id ) return true;
	}
	return false;
}

function GetItemQuatity( player, item )
{
	item = item.tostring();

	if( !playa[ player.ID ].Items.rawin( item ) )
	{
		playa[ player.ID ].Items.rawset( item,
		{
			Quatity 		= "0",
		});

		return 0;
	}
	
	else 
	{
		if( playa[ player.ID ].Items[ item ].Quatity.tointeger() > 0 ) return playa[ player.ID ].Items[ item ].Quatity.tointeger();
	}

	return 0
}

function ModifyQuatity( player, id, quatity )
{
	id = id.tostring();

	if( !playa[ player.ID ].Items.rawin( item ) )
	{
		playa[ player.ID ].Items.rawset( item,
		{
			Quatity 		= quatity.tostring(),
		});
	}
	
	else 
	{
		playa[ player.ID ].Items[ item ].Quatity = quatity;
	}
}

function DecQuatity( player, item, quatity )
{
	item = item.tostring();

	if( playa[ player.ID ].Items.rawin( item ) ) playa[ player.ID ].Items[ item ].Quatity = ( ( playa[ player.ID ].Items[ item ].Quatity.tointeger() - quatity.tointeger() ) );
}

function AddQuatity( player, item, quatity )
{
	item = item.tostring();

	if( !playa[ player.ID ].Items.rawin( item ) )
	{
		playa[ player.ID ].Items.rawset( item,
		{
			Quatity 		= quatity.tostring(),
		});
	}
	
	else 
	{
		playa[ player.ID ].Items[ item ].Quatity = ( ( playa[ player.ID ].Items[ item ].Quatity.tointeger() + quatity.tointeger() ) );
	}
}

function GetItem( player, xx, qua )
{
	if( GetItemQuatity( player, xx ).tointeger() >= qua.tointeger() ) return true;		
	else return GetItemQuatity( player, xx );			
}

function StripItemFromString( player, string )
{
	if( string.find( "null" ) >= 0 || string.find( "N/A" ) >= 0 ) return;
	print( string );
	local stripdance = split( string, ", " );
	foreach( kiki in stripdance )
	{
		playa[ player.ID ].Items.push( kiki );
	}
}

function ConvertArrayToString( player )
{
	if( playa[ player.ID ].Items.find( "null" ) >= 0 || playa[ player.ID ].Items.find( "N/A" ) >= 0 ) return "N/A";
	
	local data = null;
	foreach( ID, kiki in playa[ player.ID ].Items )
	{
		if ( data ) data = data + ", " + kiki
		else data = kiki;
	}
	
	return data;
}

function GetItemByList( player )
{
	local thing = split( playa[ player.ID ].Items, "," ),lol = [], lol1 = [], l;
					
	foreach( kiki in thing )
	{
		lol.push( kiki );
	}
				
	foreach( kiki in lol )
	{
		if( kiki.len() > 0 )
		{
			local s = split( kiki, "-" );
			if( s[1].tointeger() == 0 ) continue;
			if( l ) l = format( Lang.Item1[ playa[ player.ID ].Lang ], l ,GetItemNameByID( s[0].tointeger() ), s[1] );
			else l = format( Lang.Item[ playa[ player.ID ].Lang ], GetItemNameByID( s[0].tointeger() ), s[1] );
		}
	}
	
	if( l ) return l;
	else return Lang.NoItem[ playa[ player.ID ].Lang ];
}

function GetCustomWeaponName( id )
{
	switch( id )
	{
		case 102:
		return "Ak-47";

		case 103:
		return "Bulldog Shotgun";

		case 104:
		return "M14";

		case 107:
		return "MP5K";

		default: return GetWeaponName( id );
	}
}

function GetSoundIDFromMusicKit( id )
{
	switch( id )
	{
		case "11":
		return 50004;

		case "12":
		return 50005;

		case "13":
		return 50006;

		case "14":
		return 50003;

		case "15":
		return 50007;

		default: return 0;
	}
}

function GetCustomWeaponID( name )
{
	switch( name.tolower() )
	{
		case "ak-47":
		return 102;

		case "bulldog shotgun":
		return 103;

		case "m14":
		return 104;

		case "mp5k":
		return 105;

		default: return GetWeaponID( name );
	}
}

function GetSlotFromWeapon( id )
{
	switch( id )
	{
		case 102: return 6;
		case 103: return 4;
		case 104: return 7;
		case 105: return 5;

		default: return GetWeaponDataValue( id , 25 );
	}
}

function GetAllowedItemDrop( id )
{
	switch( id.tointeger() )
	{
		case 1:
		case 2:
		case 3:
		case 4:
		case 8:
		case 9:
		case 10:
		return true;

		default: return false;
	}
}