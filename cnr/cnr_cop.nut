function RightCuff( player, key )
{
 /*   if ( key == right_click )
	{

		if ( IsLawE( player ) == null ) return;
		if( playa[ player.ID ].Cuff ) return MsgPlr( 6, player, Lang.CuffTakeFirst, GetIngameTag( FindPlayer( playa[ player.ID ].Cuff ) ) );
	
	    local found = false;
		local kiki = null;
		for( local i = 0; i < GetMaxPlayers(); i ++ )
		{
			kiki = FindPlayer( i );
			if ( kiki )
			{
				if ( kiki != player && kiki && !kiki.Vehicle && DistanceFromPoint( kiki.Pos.x, kiki.Pos.y, player.Pos.x, player.Pos.y ) <= 5 && playa[ kiki.ID ].Suspect.len() > 0 && playa[ kiki.ID ].Jailtime == 0 && playa[ player.ID ].Cuff == null && !_Timer.Exists( playa[ kiki.ID ].CuffTimer ) )
				{
					if( playa[ player.ID ].AdminDuty ) found = true, MsgPlr( 2, player, Lang.AdutyCantDuty );
					else if( ( time() - playa[ player.ID ].CuffColldown ) < 60 ) found = true, MsgPlr( 2, player, Lang.CuffCooldown );
					else if( !playa[ kiki.ID ].Surrender ) found = true, MsgPlr( 2, player, Lang.CuffCantCuffAbove40 );
					else if( playa[ kiki.ID ].Suspect.len() == 0 ) found = true, MsgPlr( 2, player, Lang.CuffNoNear );
					else
					{
						playa[ kiki.ID ].CuffTimer = _Timer.Create( this, function( player, kiki ) 
						{
							if( player.Vehicle )
							{
								if( !kiki.Vehicle ) kiki.PutInVehicleSlot( player.Vehicle, 1 );
							}

							else 
							{
								kiki.Pos.x = player.Pos.x
								kiki.Pos.y = player.Pos.y+2
								kiki.Pos.z = player.Pos.z
								kiki.World = player.World;
							}
						}, 500, 0, player, kiki );

						playa[ kiki.ID ].CuffPlayer = player.ID;
						playa[ player.ID ].Cuff = kiki.ID;
						kiki.IsFrozen = true;
						MsgPlr( 3, player, Lang.CuffSucess, GetIngameTag( kiki ) );
						MsgPlr( 6, kiki, Lang.CuffSucessCrime );

					//	ArrestPlayer( player, kiki );

						found = true;
					}
				}
			}
		}
		if ( !found ) MsgPlr( 2, player, Lang.CuffNoNear );
	}*/
}

function FindCuffedPlayer( player, sus )
{
	if( sus == null ) sus = -1;
	
	local kiki = FindPlayer( sus );
	if( !kiki ) return;
	
	MsgPlr( 6, kiki, Lang.Uncuff );

	_Timer.Destroy( playa[ kiki.ID ].CuffTimer );
	playa[ kiki.ID ].CuffPlayer = -1;
	kiki.IsFrozen = false;

	playa[ player.ID ].Cuff = null;
}

function FindCuffPlayer( player )
{
	if( _Timer.Exists( playa[ player.ID ].CuffTimer ) )
	{
		local plr = FindPlayer( playa[ player.ID ].CuffPlayer );
		if( plr )
		{
			//ArrestSphere( plr );

			playa[ plr.ID ].Cuff = null;
		}

		_Timer.Destroy( playa[ player.ID ].CuffTimer );
	}
}

function FindCuffPlayer1( player )
{
	if( _Timer.Exists( playa[ player.ID ].CuffTimer ) )
	{
		local plr = FindPlayer( playa[ player.ID ].CuffPlayer );
		if( plr )
		{
			ArrestSphere( plr );

			playa[ plr.ID ].Cuff = null;
		}

		_Timer.Destroy( playa[ player.ID ].CuffTimer );
	}
}

function Follow( id, id1 )
{
	local player = FindPlayer( id1 ), plr = FindPlayer( id );
	
	if( player && plr )
	{
		if( player.Vehicle )
		{
			if( !plr.Vehicle ) plr.PutInVehicleSlot( player.Vehicle, 1 );
		}

		else 
		{
			plr.Pos.x = player.Pos.x
			plr.Pos.y = player.Pos.y+2
			plr.Pos.z = player.Pos.z
			plr.World = player.World;
		}
	}
}

function Jail( id )
{
	local player = FindPlayer( id );
	if ( player )
	{
        local plr = playa[ player.ID ];
	    if ( plr.Jailtime != "0" )
	    {
			//local timertest = time() - plr.Jailtimerr;
	        if ( ( time() - plr.Jailtimerr ) > plr.Jailtime )
			{
				//MsgAll( 6, Lang.UnjailAll, GetIngameTag( player ) );
				//EchoMessage( "**" + player.Name + "** has been released from jail."  );

				plr.Jailtimer.Stop();
				plr.Jailtimer = null;
				plr.Jailtimerr = 0;
				plr.Jailtime = 0;
				player.CanAttack = true;
				playa[ player.ID ].Suspect = {};
				player.SetWantedLevel( 0 );
				player.Pos = Vector(392.385, -477.519, 12.3432);
				SendDataToClient( 70, null, player );
				playa[ player.ID ].ToiToiToi		=	false;

				ClearJailSlot( player );
			}
		   
			else
			{
			//	local timeleft = ( ( plr.Jailtimerr ) - ( time() - plr.Jailtime ) );
			//	SendDataToClient( 60, GetTiming( timeleft ) , player );
			}
		   
	    }
	}
}

function ArrestSphere( player )
{
    //if( playa[ player.ID ].Cuff == null ) return MsgPlr( 2, player, Lang.NoCuffAlert );

    if( player.Vehicle ) return MsgPlr( 2, player, Lang.NeedOutVehToArrest );
   
    local pTarget1 = FindPlayer( playa[ player.ID ].Cuff );
	if( !pTarget1 ) return;
	
	_Timer.Destroy( playa[ pTarget1.ID ].RobTimer );
	//if( playa[ pTarget1.ID ].Wanted > 100 ) Arc( player, 12 );
	playa[ pTarget1.ID ].Jailtime = GetJailTime( playa[ pTarget1.ID ].Wanted );
	MsgAll( 6, Lang.JailPlr, GetIngameTag( pTarget1 ), GetTiming( playa[ pTarget1.ID ].Jailtime ), GetIngameTag( player ) );
	EchoMessage( "**" + pTarget1.Name + "** has been jailed for **" + GetTiming( playa[ pTarget1.ID ].Jailtime ) + "**, after being arrested by **" + player.Name + "**" );

	local generatereward = ( rand() % 9 ) + "" + ( rand() % 9 ) + ( rand() % 9 ) + ( rand() % 9 ), reward = generatereward.tointeger();

	MsgPlr( 3, player, Lang.JailReward, plr.Name, reward );

	_Timer.Destroy( playa[ pTarget1.ID ].CuffTimer );
	playa[ pTarget1.ID ].CuffPlayer = null;
	playa[ player.ID ].Cuff = null;
    playa[ player.ID ].AddXP( player, playa[ pTarget1.ID ].Wanted );
    playa[ pTarget1.ID ].Jailtimer = NewTimer( "Jail", 500, 0, pTarget1.ID );
    playa[ pTarget1.ID ].Jailtimerr = time();
    pTarget1.World = 2;
    pTarget1.Health = 100;
	pTarget1.CanAttack = false;
	playa[ pTarget1.ID ].LastPos = player.Pos;
    pTarget1.Pos = Vector(-1133.94, 875.15, 996.047);
	pTarget1.IsFrozen = false;
	SendDataToClient( 60, playa[ pTarget1.ID ].Jailtime, pTarget1 );

	ConfiscateDMStuff( pTarget1 );

//	if( playa[ player.ID ].ActiveMusickit != "none" ) PlaySoundToAll( GetSoundIDFromMusicKit( playa[ player.ID ].ActiveMusickit ) );
}

function ArrestPlayer( player, pTarget1, timer )
{
    //if( playa[ player.ID ].Cuff == null ) return MsgPlr( 2, player, Lang.NoCuffAlert );

    if( player.Vehicle ) return MsgPlr( 2, player, Lang.NeedOutVehToArrest );
   	
	_Timer.Destroy( playa[ pTarget1.ID ].RobTimer );
	//if( playa[ pTarget1.ID ].Wanted > 100 ) Arc( player, 12 );
	playa[ pTarget1.ID ].Jailtime = timer;
	MsgAll( 6, Lang.JailPlr, pTarget1.Name, GetTiming( playa[ pTarget1.ID ].Jailtime ) );
	//EchoMessage( "**" + pTarget1.Name + "** has been jailed for **" + GetTiming( playa[ pTarget1.ID ].Jailtime ) + "**, after being arrested by **" + player.Name + "**" );

	local generatereward = ( rand() % 9 ) + "" + ( rand() % 9 ) + ( rand() % 9 ) + ( rand() % 9 ), reward = generatereward.tointeger();

	MsgPlr( 3, player, Lang.JailReward, pTarget1.Name, reward );

	//HandleCopReward( player, pTarget1 );
	_Timer.Destroy( playa[ pTarget1.ID ].CuffTimer );
	playa[ pTarget1.ID ].CuffPlayer = null;
	playa[ player.ID ].Cuff = null;
 //   playa[ player.ID ].AddXP( player, playa[ pTarget1.ID ].Wanted );
    playa[ pTarget1.ID ].Jailtimer = NewTimer( "Jail", 500, 0, pTarget1.ID );
    playa[ pTarget1.ID ].Jailtimerr = time();
	playa[ pTarget1.ID ].Suspect = {};

	playa[ player.ID ].Paycheck += reward;

  //  pTarget1.World = 2;
    pTarget1.Health = 100;
	pTarget1.CanAttack = false;
//	playa[ pTarget1.ID ].LastPos = player.Pos;
    //pTarget1.Pos = Vector(-1133.94, 875.15, 996.047);
	pTarget1.IsFrozen = false;

	AssignJailSlot( pTarget1 );

	SendDataToClient( 60, playa[ pTarget1.ID ].Jailtime, pTarget1 );

//	ConfiscateDMStuff( pTarget1 );

	MessageToAllLaw( "Radio", "PoliceJail", player.Name, pTarget1.Name, GetTiming( playa[ pTarget1.ID ].Jailtime ) ); 

	//if( playa[ player.ID ].ActiveMusickit != "none" ) PlaySoundToAll( GetSoundIDFromMusicKit( playa[ player.ID ].ActiveMusickit ) );
}

function HandleCopReward( player, plr )
{
	if( playa[ player.ID ].JobID.find("cop") == null ) return;
	local evil = split( playa[ player.ID ].JobID, ":");
	local getDiscount = ( ( playa[ plr.ID ].Cash/100 ) * 20 ), deccash = ( playa[ plr.ID ].Cash - getDiscount );
	local isState = false;

	if( deccash < 10 ) deccash = ( playa[ plr.ID ].Wanted * 1000 ), isState = true;

	switch( evil[1] )
	{
		case "1":
		if( !isState ) MsgPlr( 3, player, Lang.JailReward, GetIngameTag( plr ), deccash, 2 );
		else MsgPlr( 3, player, Lang.JailReward3, GetIngameTag( plr ), deccash, 2 );

		playa[ player.ID ].Copskill += 2;
		playa[ player.ID ].AddCash( player, deccash );
		break;
		
		case "2":
		if( !isState ) MsgPlr( 3, player, Lang.JailReward, GetIngameTag( plr ), deccash, 2 );
		else MsgPlr( 3, player, Lang.JailReward3, GetIngameTag( plr ), deccash, 2 );

		playa[ player.ID ].Copskill += 5;
		playa[ player.ID ].AddCash( player, deccash );
		break;

		case "3":
		if( !isState ) MsgPlr( 3, player, Lang.JailReward, GetIngameTag( plr ), deccash, 2 );
		else MsgPlr( 3, player, Lang.JailReward3, GetIngameTag( plr ), deccash, 2 );

		playa[ player.ID ].Copskill += 10;
		playa[ player.ID ].AddCash( player, deccash );
		break;
	}

	if( !isState )
	{
		playa[ plr.ID ].DecCash( plr, deccash );
		MsgPlr( 2, plr, Lang.JailPlr2, deccash );	
	}
}

function Sur( player )
{
    if( playa[ player.ID ].Wanted <= 0 ) return MsgPlr( 2, player, Lang.NoWanted );
   	
	playa[ player.ID ].Jailtime = GetJailTime( playa[ player.ID ].Wanted );

	MsgAll( 6, Lang.SurJail, GetIngameTag( player ), GetTiming( playa[ player.ID ].Jailtime ) );
	EchoMessage( "**" + player.Name + "** has been jailed for **" + GetTiming( playa[ player.ID ].Jailtime ) + "**, after surrendering." );

    playa[ player.ID ].Jailtimer = NewTimer( "Jail", 500, 0, player.ID );
    playa[ player.ID ].Jailtimerr = time();
    player.World = 2;
    player.Health = 100;
	player.CanAttack = false;
    player.Pos = Vector(-1133.94, 875.15, 996.047);
	player.IsFrozen = false;
	SendDataToClient( 60, playa[ player.ID ].Jailtime, player );
}

function GetJailTime( time )
{
  local kiki = time*20;
  if ( kiki > 599 ) kiki = 300;
  
  return kiki;
}

function JailSpawn( player )
{
	if( playa[ player.ID ].Jailtime.tointeger() != 0 )
	{
		if( !player.Spawn() ) player.Spawn();
		if( playa[ player.ID ].JailSlot == null ) AssignJailSlot( player );

		playa[ player.ID ].Jailtimer = NewTimer( "Jail", 500, 0, player.ID );
		playa[ player.ID ].Jailtimerr = time();
	//	MsgAll( 6, Lang.JailSpawn, GetIngameTag( player ), time() );
	//	EchoMessage( "**" + player.Name + "** has been jailed. Jailtime **" + GetTiming( playa[ player.ID ].Jailtime ) + "**" );

	//	player.World = 2;
		player.CanAttack = false;
	//	playa[ player.ID ].LastPos = player.Pos;
		player.IsFrozen = false;
		SendDataToClient( 60, playa[ player.ID ].Jailtime, player );

		_Timer.Create( this, function() 
		{
			player.Pos = Jail_Room[ playa[ player.ID ].JailSlot ].SpawnPos
				player.CanAttack = false;

		}, 1000, 1 );
	}
}

function ClearJail( player )
{
	if( !playa[ player.ID ].Jailtimer ) return;
	
	SendDataToClient( 70, null, player );
	playa[ player.ID ].Jailtimer.Stop();
	playa[ player.ID ].Jailtimer = null;

}

function ReFillVCPD( player )
{
	if( playa[ player.ID ].JobID.find("cop") == null ) return;
	local evil = split( playa[ player.ID ].JobID, ":");
	
	switch( evil[1] )
	{
		case "1":
		player.SetWeapon( 17, 200 );
		player.SetWeapon( 19, 400 );
		player.SetWeapon( 4, 50 );
		player.Armour = 50;
		MsgPlr( 3, player, Lang.RefillVCPD );
		break;
		
		case "2":
		player.SetWeapon( 17, 200 );
		player.SetWeapon( 21, 200 );
		player.SetWeapon( 24, 350 );
		player.SetWeapon( 14, 50 );
		player.Armour = 100;
		MsgPlr( 3, player, Lang.RefillVCPD );
		break;

		case "3":
		player.SetWeapon( 17, 500 );
		player.SetWeapon( 20, 50 );
		player.SetWeapon( 26, 200 );
		player.Armour = 100;
		MsgPlr( 3, player, Lang.RefillVCPD );
		break;

	}	
	
}


function ConfiscateDMStuff( player )
{
	local found = true;
	for( local i = 0, world, pos, pickup, weapon; i < 8; i++ )
	{
		weapon = player.GetWeaponAtSlot( i );

		if ( weapon > 0 && weapon != 16 )
		{
			switch( weapon )
			{
				case 12:
				case 15:
				case 26:
				case 30:

				player.SetWeapon( weapon, 0 );
				found = true;
				break;
			}
		}
	}

	if( found ) MsgPlr( 2, player, Lang.JailCons );	
}

function cops( player)
{
		playa[ player.ID ].Job.JobID = 3;
		player.SetWeapon( 17, 200 );
		player.SetWeapon( 19, 400 );
		player.SetWeapon( 4, 50 );
		player.Armour = 50;
		MsgPlr( 1, player, Lang.F4 );

}


function IsLawE( player )
{
	switch( playa[ player.ID ].Job.JobID )
	{
		case 3:
		case 4:
		case 5:
		return true;

		default: return false;
	}
}

/*
 	Job ID 

3 = pd
4 = swat
5 = fbi

*/

Jail_Room <-
[
	{
		"SpawnPos": Vector(381.669, -504.407, 9.39562),
		"IsUsed": false,
	}

	{
		"SpawnPos": Vector(384.265, -501.723, 9.39562),
		"IsUsed": false,
	}

	{
		"SpawnPos": Vector(386.617, -498.227, 9.39561),
		"IsUsed": false,
	}

	{
		"SpawnPos": Vector(391.08, -507.097, 9.39561),
		"IsUsed": false,
	}

]

function ClearJailSlot( player )
{
	if( playa[ player.ID ].JailSlot == null ) return;

	Jail_Room[ playa[ player.ID ].JailSlot ].IsUsed = false;

	playa[ player.ID ].JailSlot = null;
}

function AssignJailSlot( player )
{
	local tp = Vector(391.08, -507.097, 9.39561);
	local slot = 3;

	if( !Jail_Room[ 0 ].IsUsed ) slot = 0, tp = Jail_Room[ 0 ].SpawnPos;
	if( !Jail_Room[ 1 ].IsUsed ) slot = 1, tp = Jail_Room[ 1 ].SpawnPos;
	if( !Jail_Room[ 2 ].IsUsed ) slot = 2, tp = Jail_Room[ 2 ].SpawnPos;
	else slot = 3, tp = Jail_Room[ 3 ].SpawnPos;

	player.Pos = tp;
	playa[ player.ID ].JailSlot = slot;
}

function LawEnformentWeapon( id )
{
	switch( id )
	{
		case 4:
		case 17:
		case 18:
		case 19:
		case 21:
		case 23:
		case 25:
		case 26:
		case 28:
		return true;

		default: return false;
	}
}

function CheckPDutyRequirement( player, type )
{
	switch( type )
	{
		case "pd":
		if( playa[ player.ID ].Job.PDLevel > 1 ) SendDataToClient( 9103, "pdofficial", player );
		else SendDataToClient( 9103, "pd", player );
		break;

		case "swat":
		if( playa[ player.ID ].Job.SWATLevel > 0 )
		{
			SendDataToClient( 9103, "swat", player );
		}
		else SendDataToClient( 9101, "You are not part of SWAT.", player );
		break;

		case "fbi":
		if( playa[ player.ID ].Job.FBILevel > 0 )
		{
			SendDataToClient( 9103, "fbi", player );
		}
		else SendDataToClient( 9101, "You are not part of FBI.", player );
		break;

	}
}

function OnPoliceDuty( player, type, skin )
{
	if( playa[ player.ID ].Suspect.len() == 0 )
	{
		switch( type )
		{
			case "pd":
			if( skin == -1 )
			{
				if( playa[ player.ID ].Job.PDUC )
				{
					playa[ player.ID ].Undercover = true;

					MsgPlr( 3, player, Lang.LawEDuty, "Undercover" );
				}
				else return SendDataToClient( 9104, "You dont have UC right.", player );
			}

			SaveCivilWep( player );
			playa[ player.ID ].Job.JobID = 3;

			player.Disarm();

			SendDataToClient( 9105, "", player );

			player.SetWeapon( 17, 200 );
			player.SetWeapon( 19, 100 );
			player.SetWeapon( 4, 1 );

			if( skin == -1 ) return;

			if( playa[ player.ID ].Job.PDLevel > 1 )
			{
				player.Armour = 100;
				playa[ player.ID ].LastSkin = player.Skin;
				player.Colour = RGB( 0, 68, 204 );
				player.Skin = skin;
				MsgPlr( 3, player, Lang.LawEDuty, "Police" );	
			}

			else 
			{
				player.Colour = RGB( 102, 153, 255 );
				player.Armour = 100;
				playa[ player.ID ].LastSkin = player.Skin;
				player.Skin = skin;
				MsgPlr( 3, player, Lang.LawEDuty, "Police" );	

			}
			break;

			case "swat":
			if( playa[ player.ID ].Job.SWATLevel > 0 )
			{
				if( playa[ player.ID ].Job.JobID >= 3 )
				{
					player.Disarm();
					player.Skin = skin;
				}
				
				else 
				{
					playa[ player.ID ].LastSkin = player.Skin;
					SaveCivilWep( player );
				}

				player.Skin = skin;

				player.SetWeapon( 21, 200 );
				player.SetWeapon( 26, 500 );
				player.Colour = RGB( 0, 68, 204 );
				player.Health = 200;
				player.Armour = 200;

				playa[ player.ID ].Job.JobID = 4;

				SendDataToClient( 9105, "", player );

				MsgPlr( 3, player, Lang.LawEDuty, "SWAT" );	
			}
			else SendDataToClient( 9101, "You are not part of SWAT.", player );
			break;

			case "fbi":
			if( playa[ player.ID ].Job.FBILevel > 0 )
			{
				playa[ player.ID ].LastSkin = player.Skin;

				if( skin != -1 )
				{
					player.Skin = skin;
					player.Colour = RGB( 0, 68, 204 );				

					MsgPlr( 3, player, Lang.LawEDuty, "FBI" );	
				}

				else 
				{
					playa[ player.ID ].Undercover = true;

					MsgPlr( 3, player, Lang.LawEDuty, "Undercover" );
				}

				SaveCivilWep( player );
				player.Armour = 100;

				playa[ player.ID ].Job.JobID = 5;

				SendDataToClient( 9105, "", player );

				player.Disarm();
			}
			else SendDataToClient( 9101, "You are not part of FBI.", player );
			break;
		}
	}
	else MsgPlr( 2, player, Lang.WantedCantGoDuty );	
}

function QuitLawDuty( player )
{
	player.Disarm();
	player.Skin = playa[ player.ID ].LastSkin;
	player.Colour = RGB( 255, 255, 255 );


	SpawnCivilWeapon( player );

	playa[ player.ID ].Job.JobID = 0;
	playa[ player.ID ].Undercover = false;

	MsgPlr( 3, player, Lang.QuitJob );

	SendDataToClient( 9202, "", player );
}

function GetCopColor( player )
{
	switch( playa[ player.ID ].Job.JobID )
	{
		case 3:
		if( playa[ player.ID ].Job.PDLevel > 1 ) player.Colour = RGB( 0, 68, 204 );
		else player.Colour = RGB( 102, 153, 255 );
		break;

		case 4:
		player.Colour = RGB( 0, 68, 204 );
		break;

		case 5:
		player.Colour = RGB( 0, 68, 204 );
		break;
	}
}


function PDHighrankCmd( player, cop, fbi )
{
	if( playa[ player.ID ].Job.JobID == 3 && playa[ player.ID ].Job.PDLevel >= cop ) return true;
	if( playa[ player.ID ].Job.JobID == 4 ) return true;
	if( playa[ player.ID ].Job.JobID == 5 && playa[ player.ID ].Job.FBILevel >= fbi ) return true;
}

function CheckHandsup()
{
	for( local i = 0; i < GetMaxPlayers(); i ++ )
	{
		local player = FindPlayer( i );
		if( player )
		{
			if( playa[ player.ID ].Surrender.Status )
			{
				if( playa[ player.ID ].Surrender.Pos.x != player.Pos.x || playa[ player.ID ].Surrender.Pos.y != player.Pos.y ) playa[ player.ID ].Surrender.Status = false;
			}
		}
	}
}

function IsInPDOrRancher( player )
{
	if( GetNearestPDEquip( player ) ) return true;
	if( IsPD( player ) ) return true;
}

function IsUC( player )
{
	if( playa[ player.ID ].Job.JobID == 3 && playa[ player.ID ].Job.PDUC ) return true;
	if( playa[ player.ID ].Job.JobID == 5 && playa[ player.ID ].Job.FBILevel >= 1 ) return true;
}