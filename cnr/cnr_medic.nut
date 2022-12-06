function RightHeal( player, key )
{
	if( key == right_click ) 
	{
		if ( playa[ player.ID ].JobID != "3" ) return;
	
		local found = false, plr;
		foreach( kiki in Server.Players )
		{
			plr = FindPlayer( kiki );
			if( plr && plr.ID!= player.ID && DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 && plr.Health < 100 )
			{
				local rand_reward = rand()%4;
				if( rand_reward == 3 ) MsgPlr( 3, player, Lang.HealWithCash, GetIngameTag( plr ) ), playa[ player.ID ].AddCash( player, 10 );
				else  MsgPlr( 3, player, Lang.Heal, GetIngameTag( plr ) );
				MsgPlr( 5, plr, Lang.HealPlr, GetIngameTag( player ) );
				plr.Health = 100;
				found = true;
				//PlaySoundForWorld( 0, soundID );
			}
		}
		if ( !found ) MsgPlr( 2, player, Lang.HealNotAround );
	}

}

function Medicspawn( player )
{
	if ( playa[ player.ID ].JobID != "3" ) return;
	player.Pos = MedicPos[ rand()% MedicPos.len() ];
}

function EnterToHeal( player )
{
	if( player.Health == 100 ) return MsgPlr( 2, player, Lang.FullHeal );

	MsgPlr( 3, player, Lang.HealWait );

	playa[ player.ID ].Healing = _Timer.Create( this, function( player )
	{
		if( playa[ player.ID ].Cash < 50 && player.Health < 99 ) 
		{
			MsgPlr( 2, player, Lang.NoMoney, ( 100 - player.Health ) );

			_Timer.Destroy( playa[ player.ID ].Healing );
		}
		
		if( playa[ player.ID ].Cash < 10 && player.Health < 99 ) 
		{
			if( playa[ player.ID ].Bank == false ) 
			{
				MsgPlr( 2, player, Lang.NoMoney, ( 100 - player.Health ) );

				_Timer.Destroy( playa[ player.ID ].Healing );
			}
			else
			{
				player.Health += 10;
				playa[ player.ID ].DecBank( player, 100 );
			}
		}
			
		else
		{
			player.Health += 10;
			playa[ player.ID ].DecCash( player, 100 );
		}
		
		if( player.Health == 100 ) 
		{
			MsgPlr( 3, player, Lang.FullyHealed );

			_Timer.Destroy( playa[ player.ID ].Healing );
		}
	}, 10000, 1, player );
}

function Heal( p )
{

}

Corps <-
{
	Count = 0,

	CorpsData = {},
}

function AddCorps( pos, owner, text = null )
{
	if( ( Corps.CorpsData.len() + 1 ) > 200 ) Corps.CorpsData = {};

	local ID = ( Corps.CorpsData.len() + 1 );

	Corps.CorpsData.rawset( ID,
	{
		Pos = pos,
		Status = -1,
		Time = time(),
		Owner = owner,
	});

	// SendDataToClientToAll( 9300, ID + ";Corps #" + ID + ";((/bagbody to bag the corps));"+ pos.x + ";" + pos.y + ";" + pos.z );
	SendDataToClientToAll( 9300, ID + ";((This player is knocked));((/rob to rob player  /revive to revive player));"+ pos.x + ";" + pos.y + ";" + pos.z );

	Corps.Count ++;

	return ID;
}

function UpdateCorps( id )
{
	SendDataToClientToAll( 9301, id + ";Corps #" + id + ";((/pickbody to pick up the bodybag))" );
}

function RemoveCorps2( id )
{
	Corps.CorpsData.rawdelete( id );

	SendDataToClientToAll( 9301, id + ";     ;   " );
}

function RemoveCorps()
{
	foreach( index, value in Corps.CorpsData )
	{
		if( ( value.Time - time() ) > 600 ) 
		{
			SendDataToClientToAll( 9302, index );

			Corps.CorpsData.remove( index );
		}
	}
}

function OnEMSDuty( player )
{
	playa[ player.ID ].LastSkin = player.Skin;
	playa[ player.ID ].Job.JobID = 2;
	player.Skin = 5;

	SendDataToClient( 9502, "", player );

	MsgPlr( 3, player, Lang.OnEMSDuty );	

	player.Colour = RGB( 255, 153, 255 );
}

function QuitEMSDuty( player )
{
	player.Skin = playa[ player.ID ].LastSkin;
	player.Colour = RGB( 255, 255, 255 );

	playa[ player.ID ].Job.JobID = 0;

	MsgPlr( 3, player, Lang.QuitJob );

	SendDataToClient( 9202, "", player );
}

function UpdateCorps2( id )
{
	Corps.CorpsData[ id ].Status = 1;

	SendDataToClientToAll( 9301, id + ";Corps #" + id + ";((/bagbody to bag the corps))" );
}

function CreateCorpsTextdraw( player )
{
	foreach( index, value in Corps.CorpsData )
	{
		switch( value.Status )
		{
			case -1:
			SendDataToClient( 9300, index + ";((This player is knocked));((/rob to rob player  /revive to revive player));"+ value.Pos.x + ";" + value.Pos.y + ";" + value.Pos.z, player );
			break;

			case 1:
			SendDataToClient( 9300, index + ";Corps #" + index + ";((/bagbody to bag the corps));"+ value.Pos.x + ";" + value.Pos.y + ";" + value.Pos.z, player );
			break;

			case 2:
			SendDataToClient( 9300, index + ";Corps #" + index + ";((/pickbody to pick up the bodybag;"+ value.Pos.x + ";" + value.Pos.y + ";" + value.Pos.z, player );
			break;
		}
	}
}

function CancelReviveVictim( player )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
    {
        local plr = FindPlayer( i );
        if( plr )
        {
			if( playa[ player.ID ].Knocked.BeingRevive == plr.ID )
			{
				_Timer.Destroy( playa[ plr.ID ].ReviveTimer );
				
				plr.SetAnim( 0, 44 );
                                                                    
                playa[ player.ID ].Knocked.BeingRevive = null;
			}
		}
	}
}

function CancelRevive( player )
{
	if( _Timer.Exists( playa[ player.ID ].ReviveTimer ) )
	{
		_Timer.Destroy( playa[ player.ID ].ReviveTimer );

		for( local i = 0; i < GetMaxPlayers(); i ++ )
		{
			local plr = FindPlayer( i );
			if( plr )
			{
				if( playa[ plr.ID ].Knocked.BeingRevive == player.ID )
				{																		
					playa[ plr.ID ].Knocked.BeingRevive = null;
				}
			}
		}
	}
}

function GetRevivingPlayer( player )
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
    {
        local plr = FindPlayer( i );
        if( plr )
        {
			if( playa[ player.ID ].Knocked.BeingRevive ) return true;
		}
	}
}
