/*function FollowK( id, id1 )
{
	local player = FindPlayer( id1 ), plr = FindPlayer( id );
	
	if( player && plr )
	{
		if( ( time() - playa[ plr.ID ].KidnapVictimTimer ) > 60 ) 
		{
			playa[ plr.ID ].KidnapVictimTimer = 0;
			playa[ plr.ID ].KidnapTime.Stop();
			playa[ plr.ID ].KidnapTime = null;
			playa[ plr.ID ].Kidnapper = null;
			playa[ player.ID ].Kidnap = null;
			plr.IsFrozen = false;
			MessagePlayer( "You has been auto unfroze." , plr );
			MessagePlayer( plr.Name + " has escaped.", player );
			
		}
		
		else
		{
			plr.Pos.x = player.Pos.x
			plr.Pos.y = player.Pos.y+2
			plr.Pos.z = player.Pos.z
		}
	}
}

function FindVictim( player, reason )
{
	local kiki = FindPlayer( player );
	if( !kiki ) return;
	
	if( reason == 1 ) MessagePlayer("You have been unfroze.", kiki );
	playa[ kiki.ID ].KidnapTime.Stop();
	playa[ kiki.ID ].Kidnapper = null;
	kiki.IsFrozen = false;
}

function FindKinapper( player )
{
	local kiki = FindPlayer( player );
	if( !kiki ) return;
	
	MessagePlayer( player.Name + " has left the server.",kiki );
	playa[ playa[ kiki.ID ].Kidnapper.ID ].KidnapTime.Stop();
	playa[ kiki.ID ].Kidnap = null;

}

function RightKidnap( player, key )
{
    if ( key == r )
	{

		//if ( playa[ player.ID ].JobID != 3 ) return;
		//if( !GetItemQuatity( player ) ) return MessagePlayer( "You dont have any rope.", player );
		if( playa[ player.ID ].Kidnap ) return MessagePlayer( "You aready kidnapped " + playa[ player.ID ].Kidnap.Name + ".", player );
	
	    local found = false;
 		//foreach( kiki in Server.players )
        //{
			if ( playa != player && DistanceFromPoint( playa.Pos.x, playa.Pos.y, player.Pos.x, player.Pos.y ) <= 5 && playa[ player.ID ].Jailtime == 0 && playa[ player.ID ].Cuff == null && playa[ player.ID ].CuffTimer == null )
			{
				playa[ player.ID ].CuffTimer = NewTimer( "FollowK", 500,0, kiki.ID, player.ID );
				playa[ player.ID ].CuffPlayer = player;
				playa[ player.ID ].Cuff = playa;
				playa.IsFrozen = true;
				MessagePlayer("You have kidnapped " + playa.Name + ".", player );
				MessagePlayer("You have been kidnapped.", playa );
				found = true;
				//ModifyQuatity( player, 1, "-1" );
			}
		//}
		if ( !found ) MessagePlayer( "You need to be near a civilian.", player );
	}
}

function Rob( id, id1, x, y, z, x1, x2, x3 )
{
	local player = FindPlayer( id ), plr = FindPlayer( id1 );
	if( player && plr )
	{
		if( plr.Pos.x == x1 && plr.Pos.y == x2 && plr.Pos.z == x3 )
		{
			if( player.Pos.x == x && player.Pos.y == y && player.Pos.z == z )
			{
				if( playa[ plr.ID ].Cash > 0 )
				{
					local casy = ( playa[ plr.ID ].Cash/1.5 ).tointeger();
					MessagePlayer( player.Name + " has picked $" + casy + " from you.", player );
					MessagePlayer( "You picked $" + casy + " from " + plr.Name, player );
					playa[ plr.ID ].DecCash( player, casy );
					playa[ player.ID ].AddCash( player, casy );
				}
				else MessagePlayer( plr.Name + " has no cash.", player );
			}
			else MessagePlayer( "Pickpocket failed because you move.", player );
		}
		else MessagePlayer( "Pickpocket failed because target player move.", player );
	}
	
	if( !plr ) MessagePlayer("Pickpocket failed because target does not exist.", player );
}*/