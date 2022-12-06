-918.984,-1267.6,-893.826,-1278.48,-882.478,-1252.81,-908.494,-1241.38
-868.44,-126.431,-854.733,-102.638,-883.999,-86.4201,-898.085,-111.748
329.128,423.419,338.486,449.776,310.841,459.092,301.945,431.773


function Arc( player, id )
{
	switch( id )
	{
		case 1:
		local a = CheckArchivement( player, 1 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Logged", 4 );
			MsgAll( 11, Lang.PassArchiceAll, "Logged" );
			playa[ player.ID ].XP += 4;
			UpdateArchivement( player, 1, true );
		}
		break;
		
		case 2:
		local a = CheckArchivement( player, 2 );
		if( a == "0" )
		{
			UpdateArchivement( player, 2, ( a.float()+1 ) );
			UpdateArchivement( player, 3, ( a.float()+1 ) );
			if( a == "100" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Robbed 100 stores", 4 );
				MsgAll( 11, Lang.PassArchiceAll, "Robbed 100 stores" );
				playa[ player.ID ].XP += 4;
				UpdateArchivement( player, 2, 100 );
			}
			Arc( player, 3 );
		}
		break;
		
		case 3:
		local a = CheckArchivement( player, 3 );
		if( a == "0" )
		{
			if( a == "1000" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Robbed 1000 stores", 10 );
				MsgAll( 11, Lang.PassArchiceAll, "Robbed 1000 stores" );
				playa[ player.ID ].XP += 10;
				UpdateArchivement( player, 3, 1000 );
			}
		}
		break;

		case 4:
		local a = CheckArchivement( player, 4 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Buy a house", 15 );
			MsgAll( 11, Lang.PassArchiceAll, "Buy a house" );
			playa[ player.ID ].XP += 15;
			UpdateArchivement( player, 4, true );
		}
		break;
			
		case 5:
		local a = CheckArchivement( player, 5 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Buy a property", 15 );
			MsgAll( 11, Lang.PassArchiceAll, "Buy a property" );
			playa[ player.ID ].XP += 15;
			UpdateArchivement( player, 5, true );
		}
		break;

		case 6:
		local a = CheckArchivement( player, 6 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Buy a vehicle", 5 );
			MsgAll( 11, Lang.PassArchiceAll, "Buy a vehicle" );
			playa[ player.ID ].XP += 5;
			UpdateArchivement( player, 6, true );
		}
		break;

		case 7:
		local a = CheckArchivement( player, 7 );
		if( !a )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Killing a civilian", 2 );
			MsgAll( 11, Lang.PassArchiceAll, "Killing a civilian" );
			playa[ player.ID ].XP += 2;
			UpdateArchivement( player, 7, true );
		}
		break;

		case 8:
		local a = CheckArchivement( player, 8 );
		if( !a )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Visit hospital 100 times", 4 );
			MsgAll( 11, Lang.PassArchiceAll, "Visit hospital 100 times" );
			playa[ player.ID ].XP += 4;
			UpdateArchivement( player, 8, true );
		}
		break;

		case 9:
		local a = CheckArchivement( player, 9 );
		if( a == 0 )
		{
			UpdateArchivement( player, 9, ( a.float()+1 ) );
			UpdateArchivement( player, 10, ( a.float()+1 ) );
			if( a == "100" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Killing a cop with wanted 100 times", 5 );
				MsgAll( 11, Lang.PassArchiceAll, "Killing a cop with wanted 100 times" );
				playa[ player.ID ].XP += 5;
				UpdateArchivement( player, 9, 100 );
			}
			Arc( player , 10 );
		}
		break;

		case 10:
		local a = CheckArchivement( player, 10 );
		if( a == "0" )
		{
			UpdateArchivement( player, 10, ( a.float()+1 ) );
			UpdateArchivement( player, 10, ( a.float()+1 ) );
			if( a == "1000" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Killing a cop with wanted 1000 times", 10 );
				MsgAll( 11, Lang.PassArchiceAll, "Killing a cop with wanted 1000 times" );
				playa[ player.ID ].XP += 10;
				UpdateArchivement( player, 10, 100 );
			}
		}
		break;

		case 11:
		local a = CheckArchivement( player, 11 );
		if( a == "0" )
		{
			UpdateArchivement( player, 11, ( a.tofloat()+1 ) );
			UpdateArchivement( player, 11, ( a.float()+1 ) );
			if( a == "10" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Break the cuff with bobby pin 10 times", 5 );
				MsgAll( 11, Lang.PassArchiceAll, "Killing a cop with wanted 10 times" );
				playa[ player.ID ].XP += 5;
				UpdateArchivement( player, 11, 100 );
			}
		}
		break;
		
		case 12:
		local a = CheckArchivement( player, 12 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Arrest a above 100 wantedlevel robber", 5 );
			MsgAll( 11, Lang.PassArchiceAll,  "Arrest a above 100 wantedlevel robber" );
			playa[ player.ID ].XP += 5;
			UpdateArchivement( player, 12, true );
		}
		break;

		case 13:
		local a = CheckArchivement( player, 13 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Complete 1 minimission/event", 5 );
			MsgAll( 11, Lang.PassArchiceAll,  "Complete 1 minimission/event" );
			playa[ player.ID ].XP += 5;
			UpdateArchivement( player, 13, true );
		}
		break;

		case 14:
		local a = CheckArchivement( player, 14 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Join the DM arena", 5 );
			MsgAll( 11, Lang.PassArchiceAll,  "Join the DM arena" );
			playa[ player.ID ].XP += 5;
			UpdateArchivement( player, 14, true );
		}
		break;

		case 15:
		local a = CheckArchivement( player, 15 );
		if( a == "false" )
		{
			MsgPlr( 11, player, Lang.PassArchice, "Spray your vehicle", 2 );
			MsgAll( 11, Lang.PassArchiceAll,  "Spray your vehicle" );
			playa[ player.ID ].XP += 2;
			UpdateArchivement( player, 15, true );
		}
		break;

		
		case 16:
		local a = CheckArchivement( player, 15 );
		if( a == "0" )
		{
			UpdateArchivement( player, 16, ( a.tofloat()+1 ) );
			if( a == "10" )
			{
				MsgPlr( 11, player, Lang.PassArchice, "Robbing bank 10 times", 5 );
				MsgAll( 11, Lang.PassArchiceAll,  "Robbing bank 10 times" );
				playa[ player.ID ].XP += 5;
				UpdateArchivement( player, 15, true );
			}
		}
		break;

	}
}

function CheckArchivement( player, id )
{
	local a = mysql_query( mysql , "SELECT * FROM Archivement WHERE Name = '" + player.Name + "'" );
	