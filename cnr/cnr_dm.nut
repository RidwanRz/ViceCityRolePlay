DMArenaSpawn <- [ Vector(-829.59, -1500.14, 12.1196), Vector(-851.361, -1507.15, 12.1238), Vector(-834.305, -1509.83, 12.1295), Vector(-846.106, -1495.86, 12.1123), Vector(-838.653, -1494.03, 12.1115)  ];

function EnterDM( player )
{
	if( playa[ player.ID ].DM == true ) return;
	if( playa[ player.ID ].JobID.find("cop") >= 0 ) return MsgPlr( 2, player, Lang.EnterDMCop );
	if( playa[ player.ID ].Cash < 500 ) return MsgPlr( 2, player, Lang.EnterDMNoCash );
	
	player.Pos = Vector(-842.105, -1483.69, 12.0773);
	playa[ player.ID ].DecCash( player, 500 );
	MsgPlr( 3, player, Lang.EnterDM );
	playa[ player.ID ].DM = true;
	AddIncome( "dm-1", 500 );
}

function RespawnDM( player )
{
	if( playa[ player.ID ].DM == false ) return;
	
	player.Pos = DMArenaSpawn[ rand()%DMArenaSpawn.len() ];
	player.World = 0;
	playa[ player.ID ].House = null;
}

function AddScoreDM( killer, player, weapon, bodypart )
{
	if( playa[ player.ID ].DM == false ) return;

	MsgPlr( 3, killer, Lang.KillDM, GetIngameTag( player ), GetWeaponName( weapon ), GetBodyPart( bodypart ), killer.Pos.Distance( player.Pos ) );
	MsgPlr( 3, player, Lang.KillDM1, GetWeaponName( weapon ), GetBodyPart( bodypart ), player.Pos.Distance( killer.Pos ) );
	playa[ killer.ID ].Kills ++;
	playa[ player.ID ].Deaths ++;
}

function ExitDM( player )
{
	playa[ player.ID ].DM = false;
	MsgPlr( 3, player, Lang.ExitDM );
	player.Pos = Vector( -822.275, -1489.62, 11.9836 );
}

function GetBodyPart( id )
{
	switch( id )
	{
		case 0: return "Body";
		case 1: return "Torse";
		case 2: return "Left Arm";
		case 3: return "Right Arm";
		case 4: return "Left Leg";
		case 5: return "Right Leg";
		case 6: return "Head";
	}
}

function AddDMData( id )
{
	local q = QuerySQL( db, "SELECT Kills, Deaths FROM DM WHERE ID = '" + id + "' " );
	if( GetSQLColumnData( q, 0 ) != null )
	{
		playa[ player.ID ].Kills = GetSQLColumnData( q, 1 ).tointeger();
		playa[ player.ID ].Deaths = GetSQLColumnData( q, 2 ).tointeger();
	}
	else
	{
		QuerySQL( db, "INSERT INTO DM VALUES ( '" + id + "', '0', '0' )" );
	}
	FreeSQLQuery( q );
}

function SaveDMData( player )
{
	::QuerySQL( db, "UPDATE DM SET Kills = '" + playa[ player.ID ].Kills + "', Deaths = '" + playa[ player.ID ].Deaths + "' WHERE Name '" + playa[ player.ID ].ID + "'" );
}