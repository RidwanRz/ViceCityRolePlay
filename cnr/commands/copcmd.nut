function onCopCommand( player, cmd, text )
{
	local p = playa[ player.ID ];
	switch( cmd )
	{
		case "wanted":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !IsLawE( player ) ) MsgPlr( 2, player, Lang.NotACop );
		else
		{	
			local kiki = null, wanted = null;
			for( local i = 0; i < GetMaxPlayers(); i ++ )
			{
				kiki = FindPlayer( i );
				if ( kiki )
				{
					if( playa[ kiki.ID ].Suspect.len() > 0 && playa[ kiki.ID ].Jailtimer == null )
					{
						if( wanted ) wanted = wanted + ", " + kiki.Name;
						else wanted = kiki.Name;
					}
				}
			}
			if ( wanted ) MsgPlr( 3, player, Lang.WantedList2, wanted ), MsgPlr( 3, player, Lang.WantedList3 );
			else MsgPlr( 2, player, Lang.WantedNoWanted );
		}
		break;
		
		
		case "sus":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !IsLawE( player ) ) MsgPlr( 2, player, Lang.NotACop );
		else if( !text ) MsgPlr( 2, player, Lang.SusSyntax );
		else
		{	
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
			else if( playa[ player.ID ].Jailtimer != null ) MsgPlr( 2, player, Lang.CantSusJailedPlr );
		//	else if( playa[ player.ID ].Wanted >= 1 ) MsgPlr( 2, player, Lang.CantSusPlr );
			else if( !reason ) MsgPlr( 2, player, Lang.SusSyntax );
			else
			{
			//	MsgAll( 6, Lang.SusSucess, GetIngameTag( player ), GetIngameTag( plr ), reason );

	            MessageToAllLaw( "Radio", "PoliceSuspect", player.Name, plr.Name, reason ); 
                MsgPlr( 3, plr, Lang.SuspectTarget, player.Name, reason ); 

			//	EchoMessage( "**" + player.Name + "** has suspect **" + plr.Name + "** for **" + reason + "**" );

				playa[ plr.ID ].Suspect.rawset( ( playa[ plr.ID ].Suspect.len() + 1 ), { "Reason": reason, "Author": player.Name, "Date": time().tostring() } );
			//	playa[ plr.ID ].AddWanted( plr, 1 );
                plr.SetWantedLevel( ( playa[ plr.ID ].Suspect.len() + 1 ) );
            
                if ( plr.WantedLevel > 5 ) plr.SetWantedLevel( 6 );
			}
		}
		break;
		
	/*	case "asus":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( playa[ player.ID ].Level < 3 ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !text ) MsgPlr( 2, player, Lang.SusSyntax );
		else
		{	
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
			else if( playa[ player.ID ].Jailtimer != null ) MsgPlr( 2, player, Lang.CantSusJailedPlr );
			else if( playa[ player.ID ].Wanted >= 1 ) MsgPlr( 2, player, Lang.CantSusPlr );
			else if( !reason ) MsgPlr( 2, player, Lang.SusSyntax );
			else
			{
				MsgAll( 6, Lang.SusSucess, GetIngameTag( player ), GetIngameTag( plr ), reason );
				EchoMessage( "**" + player.Name + "** has suspect **" + plr.Name + "** for **" + reason + "**" );

				playa[ plr.ID ].Suspect = reason;
				playa[ plr.ID ].AddWanted( plr, 1 );
			}
		}
		break;*/
					
		case "unsus":
		if( playa[ player.ID ].Logged == false ) MsgPlr( 2, player, Lang.InvalidCmd );
		else if( !IsLawE( player ) ) MsgPlr( 2, player, Lang.NotACop );
		else if( !PDHighrankCmd( player, 3, 1 ) ) MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
		else if( !text ) MsgPlr( 2, player, Lang.UnSusSyntax );
		else
		{	
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( !plr.IsSpawned ) MsgPlr( 2, player, Lang.PlrNotSpawned );
		//	else if( playa[ player.ID ].JobID.find("cop") >= 0 ) MsgPlr( 2, player, Lang.PlrCopCantSus );
			else if( playa[ player.ID ].Jailtimer != null ) MsgPlr( 2, player, Lang.CantUnsusPlr );
		//	else if( playa[ player.ID ].Suspect != null ) MsgPlr( 2, player, Lang.CantUnsusPlr );
		//	else if( playa[ player.ID ].Wanted >= 2 ) MsgPlr( 2, player, Lang.CantUnsusPlr );
			else if( !reason ) MsgPlr( 2, player, Lang.UnSusSyntax );
			else
			{
			//	MsgAll( 6, Lang.UnSusSucess, GetIngameTag( player ), GetIngameTag( plr ), reason );
			//	EchoMessage( "**" + player.Name + "** has unsuspect **" + plr.Name + "** for **" + reason + "**" );

                MessageToAllLaw( "Radio", "PoliceUnSuspect", player.Name, plr.Name, reason ); 
                MsgPlr( 3, plr, Lang.UnSuspectTarget, player.Name ); 

			//	playa[ plr.ID ].Wanted = 0;
				plr.SetWantedLevel( 0 );
				playa[ plr.ID ].Suspect = {};
			}
		}
		break;

	/*	case "paycaution":
		if( p.Logged && p.Level > 0 )
		{
			if( p.Jailtimer )
			{
				local ss = playa[ player.ID ].Jailtime*1.5;
				if( p.Cash > ss.tointeger()  )
				{
					 MsgAll( 6, Lang.PayCauRel, GetIngameTag( player ) );
					EchoMessage( "**" + player.Name + "** has been release from jail after using /paycaution" );
					 p.Jailtimer.Stop();
					 p.Jailtimer = null;
					 p.Jailtimerr = 0;
					 p.Jailtime = 0;
					 player.CanAttack = true;
					 playa[ player.ID ].ClearWanted( player ); 
					 player.Pos = Vector(-1137.49, 882.349, 996.047);
					 SendDataToClient( 70, null, player );
					 playa[ player.ID ].DecCash( player, ss.tointeger() );
				}
				else MsgPlr( 2, player, Lang.PayCauNeedCash, ss.tointeger() );
			}
			else MsgPlr( 2, player, Lang.PayCauNotJailed );
		}
		else MsgPlr( 2, player, Lang.InvalidCmd );
		break;*/
	
		case "m":
		case "megaphone":
		if( player.IsSpawned )
		{
			if( playa[ player.ID ].JobID.find("cop") >= 0 )
			{
				if( text )
				{
					local plr;

					for( local i = 0; i < GetMaxPlayers(); i ++ )
					{
						plr = FindPlayer( i );
						if ( plr )
						{
							if( plr.World == player.World )
							{
								if( player.Pos.Distance( plr.Pos ) < 25 )
								{
									MsgPlr( 11, plr, Lang.MegaChat, GetIngameTag( player ), text );
								}
							}
						}
					}
				}
				else MsgPlr( 2, player, Lang.MegaChatSyntax, cmd );
			}
			else MsgPlr( 2, player, Lang.NotACop );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;

        case "equip":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( PDHighrankCmd( player, 3, 1 ) )
                {
                    if( IsInPDOrRancher( player ) )
                    {
                        if( text )
                        {
                            local weapon = GetTok( text, " ", 1 ), ammo = GetTok( text, " ", 2 ), plr = GetTok( text, " ", 3 );
                            if( weapon.tolower() == "armour" )
                            {
                                if( ammo )
                                {
                                    ammo = FindPlayer( ammo );
                                    if( ammo )
                                    {
                                        if( IsLawE( ammo ) )
                                        {
                                            if( DistanceFromPoint( ammo.Pos.x, ammo.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                                            {
                                                ammo.Armour = 100;

                                                MsgPlr( 3, player, Lang.EquipArmPlr, ammo.Name );
                                                                
                                                LocalMessage( player.Pos, "EquipArmPlrLocal2", player.Name, ammo.Name );
                                                LocalMessage3D( player.ID, "EquipArmPlrLocal2", player.Name, ammo.Name );
                                            }
                                            else MsgPlr( 2, player, Lang.NotClosePlr );
                                        }
                                        else MsgPlr( 2, player, Lang.NotPartOfLaw );
                                    }
                                    else MsgPlr( 2, player, Lang.UnknownPlr );
                                }

                                else 
                                {
                                    player.Armour = 100;

                                    MsgPlr( 3, player, Lang.EquipArmSelf );

                                    LocalMessage( player.Pos, "EquipArmPlrLocal", player.Name );
                                    LocalMessage3D( player.ID, "EquipArmPlrLocal", player.Name );
                                }
                            }

                            else 
                            {
                                if( weapon && ammo )
                                {
                                    //local wepdata = { "Weapon": 0, "Ammo": 9999 };
                                    weapon = ( IsNum( weapon ) ) ? weapon.tointeger() : GetWeaponID( weapon );
                                    if( LawEnformentWeapon( weapon ) )
                                    {
                                        if( IsNum( ammo ) )
                                        {
                                            if( ammo.tointeger() <= 500 && ammo.tointeger() > 0 )
                                            {
                                                if( plr )
                                                {
                                                    plr = FindPlayer( plr );
                                                    if( plr )
                                                    {
                                                        if( IsLawE( plr ) )
                                                        {
                                                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                                                            {
                                                                plr.SetWeapon( weapon, ammo.tointeger() );

                                                                MsgPlr( 3, player, Lang.EquipPlr, plr.Name, GetWeaponName( weapon ), ammo.tointeger() );
                                                                
                                                                LocalMessage( player.Pos, "EquipPlrLocal", player.Name, plr.Name, GetWeaponName( weapon ), ammo.tointeger() );
                                                                LocalMessage3D( player.ID, "EquipPlrLocal", player.Name, plr.Name, GetWeaponName( weapon ), ammo.tointeger() );
                                                            }
                                                            else MsgPlr( 2, player, Lang.NotClosePlr );
                                                        }
                                                        else MsgPlr( 2, player, Lang.NotPartOfLaw );
                                                    }
                                                    else MsgPlr( 2, player, Lang.UnknownPlr );
                                                }

                                                else 
                                                {
                                                    player.SetWeapon( weapon, ammo.tointeger() );

                                                    MsgPlr( 3, player, Lang.EquipSelf, GetWeaponName( weapon ), ammo.tointeger() );

                                                    LocalMessage( player.Pos, "EquipPlrLocal", player.Name, player.Name, GetWeaponName( weapon ), ammo.tointeger() );
                                                    LocalMessage3D( player.ID, "EquipPlrLocal", player.Name, player.Name, GetWeaponName( weapon ), ammo.tointeger() );
                                                }
                                            }
                                            else MsgPlr( 2, player, Lang.EquipInvalidAmmo );
                                        }
                                        else MsgPlr( 2, player, Lang.EquipInvalidAmmo );
                                    }
                                    else MsgPlr( 2, player, Lang.EquipInvalidWep );
                                }
                                else MsgPlr( 2, player, Lang.EquipSyntax );
                            }
                        }
                        else MsgPlr( 2, player, Lang.EquipSyntax );
                    }
                    else MsgPlr( 2, player, Lang.CmdNotInPDOrRancher );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "unequip":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( player.Weapon != 0 )
                {
                    player.SetWeapon( player.Weapon, 0 );

                    MsgPlr( 3, player, Lang.UnEquip, GetWeaponName( player.Weapon ) );
                                                            
                    LocalMessage( player.Pos, "UnEquipLocal", player.Name, GetWeaponName( player.Weapon ) );
                    LocalMessage3D( player.ID, "UnEquipLocal", player.Name, GetWeaponName( player.Weapon ) );
                }
                else MsgPlr( 2, player, Lang.UneqNoWep );
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "panic":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                MessageToAllLaw( "Dispatch", "PolicePanic", player.Name, IsPlayerInArea( player.Pos.x, player.Pos.y ) ); 
                                                            
                foreach( kiki in Server.Players )
                {
                    local plr = FindPlayer( kiki );
                    if( plr )
                    {
                        if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                        {
                            if( !IsLawE( plr ) ) MessagePlayer( format( Lang.PolicePanicOutside[ playa[ plr.ID ].Lang ], player.Name ), plr );
                        }
                    }
                }
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "tg":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( IsPD( player ) )
                {
                    player.Armour = 100;
                    player.SetWeapon( 17, 200 );
                    player.SetWeapon( 19, 100 );
                    player.SetWeapon( 4, 1 );

                    MsgPlr( 3, player, Lang.PoliceRefillDutyEq );

                    LocalMessage( player.Pos, "PoliceRefillDutyEqOutside", player.Name );
                    LocalMessage3D( player.ID, "PoliceRefillDutyEqOutside", player.Name );
                }
                else MsgPlr( 2, player, Lang.CmdNotInPD );
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "jail":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( !player.Vehicle )  
                {
                    if( text )
                    {
                        local plr = FindPlayer( GetTok( text, " ", 1 ) ), cash = GetTok( text, " ", 2 );
                        if( plr )
                        {   
                            if( plr.ID != player.ID )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                                {
                                    if( playa[ plr.ID ].Suspect.len() > 0 )
                                    {
                                        if( playa[ player.ID ].Area == "WashPD" )
                                        {
                                            if( cash )
                                            {
                                                if( IsNum( cash ) )
                                                {
                                                    if( cash.tointeger() <= 300 && cash.tointeger() >= 20 )
                                                    {
                                                        ArrestPlayer( player, plr, cash.tointeger() );
                                                    }
                                                    else MsgPlr( 2, player, Lang.ArrestInvalidNum );
                                                }
                                                else MsgPlr( 2, player, Lang.ArrestNotNum );
                                            }
                                            else MsgPlr( 2, player, Lang.ArrestSyntax );
                                        }
                                        else MsgPlr( 2, player, Lang.NotInJail );
                                    }
                                    else MsgPlr( 2, player, Lang.NotSu );
                                }
                                else MsgPlr( 2, player, Lang.NotNearPlr );
                            }
                            else MsgPlr( 2, player, Lang.CantGiveCashSelf );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.ArrestSyntax );
                }
                else MsgPlr( 2, player, Lang.NeedOutVehToArrest );
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "su":
        case "crime":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( text )
                {
                    local plr = FindPlayer( text );
                    if( plr )
                    {
                        if( playa[ plr.ID ].Suspect.len() > 0 )
                        {
                            MsgPlr( 3, player, Lang.SurListHeader2, plr.Name );

                            foreach( index, value in playa[ plr.ID ].Suspect )
                            {
                                MsgPlr( 3, player, Lang.SurList, index.tointeger(), value.Reason, value.Author );
                            }
                        }
                        else MsgPlr( 2, player, Lang.NotSu );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.NotSu );
            }
            else 
            {
                if( playa[ player.ID ].Suspect.len() > 0 )
                {
                    MsgPlr( 3, player, Lang.SurListHeader );

                    foreach( index, value in playa[ player.ID ].Suspect )
                    {
                        MsgPlr( 3, player, Lang.SurList, index.tointeger(), value.Reason, value.Author );
                    }
                }
                else MsgPlr( 2, player, Lang.NotSu );
            }
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "sb":
        if( playa[ player.ID ].Logged ) 
        {
            if( IsLawE( player ) )
            {
                if( IsUC( player ) )
                {
                    switch( playa[ player.ID ].Undercover )
                    {
                        case true:
                        playa[ player.ID ].Undercover = false;

                        player.Colour = RGB( 0, 68, 204 );

                        MsgPlr( 3, player, Lang.NotOnUndercover );

                        for( local i = 0; i < GetMaxPlayers(); i ++ )
                        {
                            local plr = FindPlayer( i );
                            if( plr )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                                {
                                    if( playa[ player.ID ].Job.JobID == 5 ) MessagePlayer( format( Lang.FBIShowBadge[ playa[ plr.ID ].Lang ], player.Name, playa[ player.ID ].Job.FBIRank, player.Name ), plr );
                                    if( playa[ player.ID ].Job.JobID == 3 ) MessagePlayer( format( Lang.PDShowBadge[ playa[ plr.ID ].Lang ], player.Name, playa[ player.ID ].Job.PDRank, player.Name ), plr );
                                }
                            }
                        }
                        break;

                        case false:
                        playa[ player.ID ].Undercover = true;

                        player.Colour = RGB( 255, 255, 255 );

                        MsgPlr( 3, player, Lang.OnUndercover );

                        for( local i = 0; i < GetMaxPlayers(); i ++ )
                        {
                            local plr = FindPlayer( i );
                            if( plr )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                                {
                                    MessagePlayer( format( Lang.FBIHideBadge[ playa[ plr.ID ].Lang ], player.Name ), plr );
                                }
                            }
                        }
                        break;
                    }
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotACop );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "pdsetlevel":
        if( playa[ player.ID ].Logged ) 
        {
            if( playa[ player.ID ].Job.JobID == 3 )
            {
                if( PDHighrankCmd( player, 3, 10 ) )
                {
                    if( text )
                    {
                        local plr = FindPlayer( GetTok( text, " ", 1 ) ), level = GetTok( text, " ", 2 );
                        if( plr )
                        {   
                            if( plr.ID != player.ID )
                            {
                                if( playa[ plr.ID ].Job.JobID == 3 )
                                {
                                    if( level )
                                    {
                                        if( IsNum( level ) )
                                        {
                                            if( level.tointeger() <= 300 && level.tointeger() >= 0 )
                                            {
                                                playa[ plr.ID ].Job.PDLevel = level.tointeger();

                                        //    MsgPlr( 3, plr, Lang.PDSetLevel, plr.Name, level.tointeger() );
                                                MsgPlr( 3, player, Lang.PDSetLevel1, plr.Name, level.tointeger() );
                                            }
                                            else MsgPlr( 2, player, Lang.PDLevelInvalid );
                                        }
                                        else MsgPlr( 2, player, Lang.PDLevelNotNum );
                                    }
                                    else MsgPlr( 2, player, Lang.PDSetLevelSyntax );
                                }
                                else MsgPlr( 2, player, Lang.TargetNotPDDuty );
                            }
                            else MsgPlr( 2, player, Lang.PDSetlevelCantSetSelf );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.PDSetLevelSyntax );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotPDDuty2 );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "swatsetlevel":
        if( playa[ player.ID ].Logged ) 
        {
            if( playa[ player.ID ].Job.JobID == 3 || playa[ player.ID ].Job.JobID == 4 )
            {
                if( PDHighrankCmd( player, 3, 10 ) )
                {
                    if( text )
                    {
                        local plr = FindPlayer( GetTok( text, " ", 1 ) ), level = GetTok( text, " ", 2 );
                        if( plr )
                        {   
                            if( plr.ID != player.ID )
                            {
                                if( playa[ plr.ID ].Job.JobID == 3 )
                                {
                                    if( level )
                                    {
                                        if( IsNum( level ) )
                                        {
                                            if( level.tointeger() <= 300 && level.tointeger() >= 0 )
                                            {
                                                playa[ plr.ID ].Job.SWATLevel = level.tointeger();

                                        //    MsgPlr( 3, plr, Lang.PDSetLevel, plr.Name, level.tointeger() );
                                                MsgPlr( 3, player, Lang.SWATSetLevel1, plr.Name, level.tointeger() );
                                            }
                                            else MsgPlr( 2, player, Lang.PDLevelInvalid );
                                        }
                                        else MsgPlr( 2, player, Lang.PDLevelNotNum );
                                    }
                                    else MsgPlr( 2, player, Lang.SWATSetLevelSyntax );
                                }
                                else MsgPlr( 2, player, Lang.TargetNotPDDuty );
                            }
                            else MsgPlr( 2, player, Lang.PDSetlevelCantSetSelf );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.SWATSetLevelSyntax );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotPDDuty2 );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "pdsetrank":
        if( playa[ player.ID ].Logged ) 
        {
            if( playa[ player.ID ].Job.JobID == 3 )
            {
                if( PDHighrankCmd( player, 3, 10 ) )
                {
                    if( text )
                    {
                        local plr = FindPlayer( GetTok( text, " ", 1 ) ), level = GetTok( text, " ", 2, NumTok( text, " " ) );
                        if( plr )
                        {   
                            if( playa[ plr.ID ].Job.JobID == 3 )
                            {
                                if( level )
                                {
                                    playa[ plr.ID ].Job.PDRank = level;

                                    MsgPlr( 3, plr, Lang.PDSetRank, player.Name, level );
                                    MsgPlr( 3, player, Lang.PDSetRank1, plr.Name, level );
                                }
                                else MsgPlr( 2, player, Lang.PDSetRankSyntax );
                            }
                            else MsgPlr( 2, player, Lang.TargetNotPDDuty );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.PDSetRankSyntax );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotPDDuty2 );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "swatsetrank":
        if( playa[ player.ID ].Logged ) 
        {
            if( playa[ player.ID ].Job.JobID == 3 || playa[ player.ID ].Job.JobID == 4 )
            {
                if( PDHighrankCmd( player, 3, 10 ) )
                {
                    if( text )
                    {
                        local plr = FindPlayer( GetTok( text, " ", 1 ) ), level = GetTok( text, " ", 2, NumTok( text, " " ) );
                        if( plr )
                        {   
                            if( playa[ plr.ID ].Job.JobID == 3 )
                            {
                                if( level )
                                {
                                    playa[ plr.ID ].Job.SWATRank = level;

                                    MsgPlr( 3, plr, Lang.SWATSetRank, player.Name, level );
                                    MsgPlr( 3, player, Lang.SWATSetRank1, plr.Name, level );
                                }
                                else MsgPlr( 2, player, Lang.SWATSetRankSyntax );
                            }
                            else MsgPlr( 2, player, Lang.TargetNotPDDuty );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.SWATSetRankSyntax );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );            
            }
            else MsgPlr( 2, player, Lang.NotPDDuty2 );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;

        case "ucright":
        if( playa[ player.ID ].Logged ) 
        {
            if( playa[ player.ID ].Job.JobID == 3 )
            {
                if( PDHighrankCmd( player, 3, 10 ) )
                {
                    if( text )
                    {
                        local plr = FindPlayer( text );
                        if( plr )
                        {   
                            if( playa[ plr.ID ].Job.JobID == 3 )
                            {
                                switch( playa[ plr.ID ].Job.PDUC )
                                {
                                    case true:
                                    playa[ plr.ID ].Job.PDUC = false;

                                    MsgPlr( 3, plr, Lang.RevokeUCRight, player.Name );
                                    MsgPlr( 3, player, Lang.RevokeUCRight1, plr.Name );
                                    break;

                                    case false:
                                    playa[ plr.ID ].Job.PDUC = true;

                                    MsgPlr( 3, plr, Lang.GainUCRight, player.Name );
                                    MsgPlr( 3, player, Lang.GainUCRight1, plr.Name );
                                    break;
                                }
                            }
                            else MsgPlr( 2, player, Lang.TargetNotPDDuty );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.UCRightSyntax );
                }
                else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
            }
            else MsgPlr( 2, player, Lang.NotPDDuty2 );
        }
        else MsgPlr( 2, player, Lang.InvalidCmd );
        break;






    }
}
