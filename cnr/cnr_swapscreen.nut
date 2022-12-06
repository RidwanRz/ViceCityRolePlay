
	SetUseClasses( true );
	SetFriendlyFire( false );
	SetSpawnPlayerPos( -378.633, -652.871, 11.1389 );
	SetSpawnCameraPos( -378.449, -648.024, 12.4131 );
	SetSpawnCameraLook( -378.633, -652.871, 11.1389 );

	/* Civilian - male */

	AddClass( 255, RGB( 255, 255, 255 ), 7, Vector( -1077.34, 62.2939, 11.2575 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 11, Vector( -1077.34, 62.2939, 11.2575 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 15, Vector( 3.8113, 1146.35, 19.3949 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 29, Vector( 3.8113, 1146.35, 19.3949 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 30, Vector( -378.196, -590.591, 25.3263 ), 0, 0, 0 ,0, 0, 0, 0 );

	/* Civilian - female */
	AddClass( 255, RGB( 255, 255, 255 ), 13, Vector( -378.196, -590.591, 25.3263 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 14, Vector( -591.205, 651.381, 11.4564 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 22, Vector( -591.205, 651.381, 11.4564 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 24, Vector( 218.967, -1274.93, 12.0867 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 255, RGB( 255, 255, 255 ), 35, Vector( 218.967, -1274.93, 12.0867 ), 0, 0, 0 ,0, 0, 0, 0 );

	/* cop */
	AddClass( 2, RGB( 0, 0, 255 ), 1, Vector( 218.967, -1274.93, 12.0867 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 2, RGB( 0, 0, 255 ), 120, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 2, RGB( 0, 0, 255 ), 97, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 2, RGB( 0, 0, 255 ), 98, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 2, RGB( 0, 0, 255 ), 2, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );
	AddClass( 2, RGB( 0, 0, 255 ), 3, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );

	/* medic */
	AddClass( 255, RGB( 0, 204, 255 ), 5, Vector( -1193.68, -588.745, 11.4595 ), 0, 0, 0 ,0, 0, 0, 0 );


function HandleSpawn( player )
{	
	player.World = 1;
	if( playa[ player.ID ].Autospawn == false ) playa[ player.ID ].Autospawn = true;
	Announce("",player, 1 );
	switch( player.Skin )
	{
		case 7:
		case 11:
		case 15:
		case 29:
		case 30:
		case 13:
		case 14:
		case 22:
		case 24:
		case 35:
		player.Pos = DM_Spawn[ rand()%DM_Spawn.len() ];
		playa[ player.ID ].JobID = "0";
		MsgPlr( 1, player, Lang.F4 );
		break;

		case 1:
		case 120:
		case 97:
		case 98:
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		playa[ player.ID ].JobID = "cop:1";
		player.SetWeapon( 17, 200 );
		player.SetWeapon( 19, 400 );
		player.SetWeapon( 4, 50 );
		player.Armour = 50;
		MsgPlr( 1, player, Lang.F4 );
		break;

		case 5:
		player.Pos = MedicPos[ rand()% MedicPos.len() ];
		playa[ player.ID ].JobID = "3";
		MsgPlr( 1, player, Lang.F4 );
		break;

		case 2:
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		playa[ player.ID ].JobID = "cop:2";
		player.SetWeapon( 17, 200 );
		player.SetWeapon( 21, 200 );
		player.SetWeapon( 24, 350 );
		player.SetWeapon( 14, 50 );
		player.Armour = 100;
		MsgPlr( 1, player, Lang.F4 );
		break;

		case 3:
		player.Pos = PolicePos[ rand()% PolicePos.len() ];
		playa[ player.ID ].JobID = "cop:3";
		player.SetWeapon( 17, 500 );
		player.SetWeapon( 20, 50 );
		player.SetWeapon( 26, 200 );
		player.Armour = 100;
		MsgPlr( 1, player, Lang.F4 );
		break;

	}
	NewTimer( "CorrectSpawn", 1000, 1, player.ID );
}

function RandomSpawnForCivil( player )
{
	player.Spawn();
	playa[ player.ID ].JobID = "0";
	SendDataToClient( 6820, null, player );

	playa[ player.ID ].OnSpawnMenu = false;

	player.Spawn();

	_Timer.Create( this, function() 
	{
		player.Pos = DM_Spawn[ rand()%DM_Spawn.len() ];
	}, 500, 1 );
}

