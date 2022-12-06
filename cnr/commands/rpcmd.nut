function onRPCmd( player, cmd, text )
{
    switch( cmd )
    {
        case "l":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                            {
                                MessagePlayer( format( Lang.LocalChat[ playa[ plr.ID ].Lang ], player.Name, text ), plr );

                                SendDataToClientToAll( 15000, player.ID + ";" + text );
                            }
                        }
                    }
                }
                else MsgPlr( 2, player, Lang.LocalChatSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "s":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 20 )
                            {
                                MessagePlayer( format( Lang.ShoutChat[ playa[ plr.ID ].Lang ], player.Name, text ), plr );

                                SendDataToClientToAll( 15000, player.ID + ";" + text );
                            }
                        }
                    }
                }
                else MsgPlr( 2, player, Lang.ShoutChatSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "w":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    local plr = FindPlayer( GetTok( text, " ", 1 ) ), text2 = GetTok( text, " ", 2, NumTok( text, " " ) );

                    if( plr )
                    {
                        if( plr.ID != player.ID )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                            {
                                if( text2 )
                                {
                                    MsgPlr( 3, player, Lang.WhisperSelf, plr.Name, text2 );
                                    MsgPlr( 3, plr, Lang.WhisperTarget, player.Name, text2 );

                                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                                    {
                                        local plr2 = FindPlayer( i );
                                        if( plr2 )
                                        {
                                            if( DistanceFromPoint( plr2.Pos.x, plr2.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                                            {
                                                if( !plr.ID || !player.ID ) MessagePlayer( format( Lang.WhisperPublic[ playa[ plr.ID ].Lang ], player.Name, plr.Name ), plr2 );
                                            }
                                        }
                                    }
                                }
                                else MsgPlr( 2, player, Lang.NotNearTarget );
                            }
                            else MsgPlr( 2, player, Lang.NotClosePlr );
                        }
                        else MsgPlr( 2, player, Lang.CantWisperSelf );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.WhisperSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "lw":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                            {
                                MessagePlayer( format( Lang.LocalWhisper[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                            }
                        }
                    }
                }
                else MsgPlr( 2, player, Lang.LocalWhisperSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "me":
        if( player.IsSpawned )
        {
            if( text )
            {
                for( local i = 0; i < GetMaxPlayers(); i ++ )
                {
                    local plr = FindPlayer( i );
                    if( plr )
                    {
                        if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                        {
                            MessagePlayer( format( Lang.MeChat[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                        }
                    }
                }
            }
            else MsgPlr( 2, player, Lang.MeSyntax );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "b":
        if( player.IsSpawned )
        {
            if( text )
            {
                for( local i = 0; i < GetMaxPlayers(); i ++ )
                {
                    local plr = FindPlayer( i );
                    if( plr )
                    {
                        if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                        {
                            MessagePlayer( format( Lang.OOCLocalChat[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                        }
                    }
                }
            }
            else MsgPlr( 2, player, Lang.OOCLocalSyntax );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "ad":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    if( playa[ player.ID ].Phone != 0 )
                    {
                        if( ( time() - Server.AdCooldown ) > 60 )
                        {
                            if( playa[ player.ID ].Cash >= 1000 )
                            {
                                Server.AdCooldown = time();

                                playa[ player.ID ].DecCash( player, 1000 );

                                MsgAll( 2, Lang.PostAD, text, playa[ player.ID ].Phone );
                                MsgAll( 2, Lang.PostAD2, playa[ player.ID ].Phone );
                            }
                            else MsgPlr( 2, player, Lang.AdNeedCash, ( 1000 - playa[ player.ID ].Cash ) );
                        }
                        else MsgPlr( 2, player, Lang.AdNeedWait );
                    }
                    else MsgPlr( 2, player, Lang.AdNeedPhone );
                }
                else MsgPlr( 2, player, Lang.AdSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "chatmode":
        if( text )
        {
            local textmode = [ "local", "public" ];

            if( textmode.find( text.tolower() ) >= 0 )
            {
                playa[ player.ID ].Chatmode = text.tolower();

                MsgPlr( 3, player, Lang.Chatmode, text ); 
            }
            else MsgPlr( 2, player, Lang.ChatmodeSyntax ); 
        }
        else MsgPlr( 2, player, Lang.ChatmodeSyntax ); 
        break;

        case "call":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Phone != 0 )
                {
                    if( text )
                    {
                        if( playa[ player.ID ].PhoneS.Caller == -1 && playa[ player.ID ].PhoneS.Called == -1 )
                        {
                            if( IsNum( text ) )
                            {
                                if( FindPlayerPhone( text.tointeger() ) )
                                {
                                    local plr = FindPlayerPhone( text.tointeger() );
                                    if( plr.ID != player.ID )
                                    {
                                        if( playa[ plr.ID ].PhoneS.Caller == -1 && playa[ plr.ID ].PhoneS.Called == -1 )
                                        {
                                            local count = 0;

                                            playa[ plr.ID ].PhoneS.Caller = player.ID;
                                            playa[ player.ID ].PhoneS.Called = plr.ID;

                                            MsgPlr( 3, player, Lang.CallingTarget, text.tointeger() );

                                            MsgPlr( 3, plr, Lang.CallingTarget2, playa[ player.ID ].Phone );
                                            MsgPlr( 3, plr, Lang.CallingTarget3 );

                                            LocalMessage( plr.Pos, "CallingLocal", plr.Name );
                                            LocalMessage( player.Pos, "CallingLocal2", player.Name );

                                            LocalMessage3D( plr.ID, "CallingLocal", plr.Name );
                                            LocalMessage3D( player.ID, "CallingLocal2", player.Name );

                                            player.SetAnim( 0, 165 );

                                            playa[ plr.ID ].PhoneS.CallerWaiting = _Timer.Create( this, function()
                                            {
                                                count ++;

                                                if( count >= 10 )
                                                {
                                                    playa[ plr.ID ].PhoneS.Caller = -1;
                                                    playa[ player.ID ].PhoneS.Called = -1;

                                                    MsgPlr( 2, player, Lang.CalledFailedToPickup );
                                                    MsgPlr( 2, plr, Lang.CalledFailedToPickup2 );

                                                    _Timer.Destroy( playa[ plr.ID ].PhoneS.CallerWaiting );
                                                }

                                                PlaySoundForNearest( plr.Pos, 267 );

                                            }, 1500, 0 );

                                        }
                                        else MsgPlr( 2, player, Lang.TargetOnCall );
                                    }
                                    else MsgPlr( 2, player, Lang.CantCallSelf );
                                }
                                else MsgPlr( 2, player, Lang.PhoneNotExist );
                            }
                            else MsgPlr( 2, player, Lang.PhoneNotNum );
                        }
                        else MsgPlr( 2, player, Lang.CallAlreadyOnCall );
                    }
                    else MsgPlr( 2, player, Lang.CallSyntax );
                }
                else MsgPlr( 2, player, Lang.AdNeedPhone );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "pickup":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].PhoneS.Caller != -1 )
                {
                    if( _Timer.Exists( playa[ player.ID ].PhoneS.CallerWaiting ) )
                    {
                        local plr = FindPlayer( playa[ player.ID ].PhoneS.Caller );

                        playa[ player.ID ].OldChatmode = playa[ player.ID ].Chatmode;
                        playa[ plr.ID ].OldChatmode = playa[ plr.ID ].Chatmode;

                        playa[ player.ID ].Chatmode = "phone";
                        playa[ plr.ID ].Chatmode = "phone";

                        player.SetAnim( 0, 165 );

                        _Timer.Destroy( playa[ player.ID ].PhoneS.CallerWaiting );

                        MsgPlr( 3, player, Lang.CallPickup );
                        MsgPlr( 3, plr, Lang.CallPickup2, playa[ player.ID ].Phone );

                        LocalMessage( player.Pos, "CallingPickup", plr.Name );
                        LocalMessage3D( player.ID, "CallingPickup", plr.Name );
                    }
                    else MsgPlr( 2, player, Lang.AlreadyOnCall );
                }
                else MsgPlr( 2, player, Lang.NoOneCalling );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "hangup":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].PhoneS.Caller != -1 || playa[ player.ID ].PhoneS.Called != -1 )
                {
                    local plr = FindPlayer( playa[ player.ID ].PhoneS.Caller );

                    if( playa[ player.ID ].PhoneS.Caller != -1 ) plr = FindPlayer( playa[ player.ID ].PhoneS.Caller );
                    if( playa[ player.ID ].PhoneS.Called != -1 ) plr = FindPlayer( playa[ player.ID ].PhoneS.Called );

                    if( _Timer.Exists( playa[ player.ID ].PhoneS.CallerWaiting ) )
                    {
                        _Timer.Destroy( playa[ player.ID ].PhoneS.CallerWaiting );

                        playa[ player.ID ].PhoneS.Caller = -1;
                        playa[ player.ID ].PhoneS.Called = -1;

                        playa[ plr.ID ].PhoneS.Caller = -1;
                        playa[ plr.ID ].PhoneS.Called = -1;

                        if( plr.ID == player.ID ) MsgPlr( 3, player, Lang.CallerHangup ), MsgPlr( 3, plr, Lang.CallerHangup2 );
                        else MsgPlr( 3, player, Lang.RejectCall ), MsgPlr( 3, plr, Lang.RejectCall2 );
                        
                    }

                    else 
                    {
                        MsgPlr( 3, player, Lang.CallerHangup ), MsgPlr( 3, plr, Lang.CallerHangup2 );
                        //MsgPlr( 3, player, Lang.CallerHangup2 ), MsgPlr( 3, plr, Lang.CallerHangup )

                        playa[ player.ID ].Chatmode = playa[ player.ID ].OldChatmode;
                        playa[ plr.ID ].Chatmode = playa[ plr.ID ].OldChatmode;

                        playa[ player.ID ].PhoneS.Caller = -1;
                        playa[ player.ID ].PhoneS.Called = -1;
                        playa[ plr.ID ].PhoneS.Caller = -1;
                        playa[ plr.ID ].PhoneS.Called = -1;

                        player.SetAnim( 0, 164 );
                        plr.SetAnim( 0, 164 );
                    }
                }
                else MsgPlr( 2, player, Lang.NotInCall );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "sms":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Phone != 0 )
                {
                    if( text )
                    {
                        local plr = GetTok( text, " ", 1 ), text2 = GetTok( text, " ", 2, NumTok( text, " " ) );
                        
                        if( plr && text2 )
                        {
                            if( IsNum( plr ) )
                            {
                                if( FindPlayerPhone( plr.tointeger() ) )
                                {
                                    plr = FindPlayerPhone( plr.tointeger() );
                                    if( plr.ID != player.ID )
                                    {
                                        MsgPlr( 3, plr, Lang.SMSFrom, playa[ player.ID ].Phone, text2 );

                                        MsgPlr( 3, player, Lang.SMSTo, playa[ plr.ID ].Phone, text2 );

                                        LocalMessage( plr.Pos, "SMSLocal", plr.Name );
                                        LocalMessage( player.Pos, "SMSLocal2", player.Name );

                                        LocalMessage3D( plr.ID, "SMSLocal", plr.Name );
                                        LocalMessage3D( player.ID, "SMSLocal2", player.Name );
                                    }
                                    else MsgPlr( 2, player, Lang.CantSMSSelf );
                                }
                                else MsgPlr( 2, player, Lang.PhoneNotExist );
                            }
                            else MsgPlr( 2, player, Lang.PhoneNotNum );
                        }
                        else MsgPlr( 2, player, Lang.SMSSyntax );
                    }
                    else MsgPlr( 2, player, Lang.SMSSyntax );
                }
                else MsgPlr( 2, player, Lang.AdNeedPhone );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "m":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( player.Vehicle )
                {
                    if( IsJobAllowRadio( player ) )
                    {
                        if( IsAllowToMegaphone( player ) )
                        {
                            if( text )
                            {
                                for( local i = 0; i < GetMaxPlayers(); i ++ )
                                {
                                    local plr = FindPlayer( i );
                                    if( plr )
                                    {
                                        if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 30 )
                                        {
                                            MessagePlayer( format( Lang.MegaphoneLoud[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                                        }
                                    }
                                }
                            }
                            else MsgPlr( 2, player, Lang.MegaphoneSyntax );
                        }
                        else MsgPlr( 2, player, Lang.VehicleNotSupportMegaphone );
                    }
                    else MsgPlr( 2, player, Lang.MegaphoneNotInJob );
                }
                else MsgPlr( 2, player, Lang.NotInVehicle );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "rob":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    local plr = FindPlayer( GetTok( text, " ", 1 ) ), item = GetTok( text, " ", 2, NumTok( text, " " ) );

                    if( plr )
                    {
                        if( item )
                        {
                            if( plr.ID != player.ID )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
                                {
                                    if( !player.Vehicle )
                                    {
                                        if( playa[ plr.ID ].Knocked.IsKnocked )
                                        {
                                            if( GetRobItem( item ) )
                                            {
                                                if( GetRobItem( item ) == "Weapon" )
                                                {
                                                    local getwep = null;
                                                    for( local i = 0, weapon; i < 8; i++ )
                                                    {
                                                        weapon = plr.GetWeaponAtSlot( i );

                                                        if( weapon > 0 && weapon != 16 )
                                                        {
                                                            if( weapon == GetWeaponID( item ) ) getwep = i;
                                                        }
                                                    }

                                                    if( getwep )
                                                    {
                                                        local getammo1 = ( ( plr.GetAmmoAtSlot( getwep )/100 ) * 30 ), getammo = ( plr.GetAmmoAtSlot( getwep ) - getammo1 );

                                                        player.SetWeapon( plr.GetWeaponAtSlot( getwep ), ( player.GetAmmoAtSlot( getwep ) + getammo ) );
                                                        plr.SetWeapon( plr.GetWeaponAtSlot( getwep ), ( plr.GetAmmoAtSlot( getwep ) - getammo ) );

                                                        LocalMessage( player.Pos, "RobItemLocal", player.Name, GetWeaponName( plr.GetWeaponAtSlot( getwep ) ), plr.Name );
                                                        LocalMessage3D( player.ID, "RobItemLocal", player.Name, GetWeaponName( plr.GetWeaponAtSlot( getwep ) ), plr.Name );

                                                        MsgPlr( 3, player, Lang.RobItem, GetWeaponName( plr.GetWeaponAtSlot( getwep ) ), getammo, plr.Name );
                                                        MsgPlr( 3, plr, Lang.RobItem2, player.Name, GetWeaponName( plr.GetWeaponAtSlot( getwep ) ), getammo );
                                                    }
                                                    else MsgPlr( 2, player, Lang.TargetDontHaveItem );
                                                }

                                                else 
                                                {
                                                    if( GetItemQuatity( plr, GetItemIDByName( item ) ) > 0 )
                                                    {
                                                        local getammo1 = ( ( GetItemQuatity( plr, GetItemIDByName( item ) )/100 ) * 15 ), getammo = ( GetItemQuatity( plr, GetItemIDByName( item ) ) - getammo1 );

                                                        AddQuatity( player, GetItemIDByName( item ), getammo );
                                                        DecQuatity( plr, GetItemIDByName( item ), getammo );

                                                        LocalMessage( player.Pos, "RobItemLocal", player.Name, item, plr.Name );
                                                        LocalMessage3D( player.ID, "RobItemLocal", player.Name, item, plr.Name );

                                                        MsgPlr( 3, player, Lang.RobItem, item, getammo, plr.Name );
                                                        MsgPlr( 3, plr, Lang.RobItem2, player.Name, item, getammo );
                                                    }
                                                    else MsgPlr( 2, player, Lang.TargetDontHaveItem );
                                                }
                                            }
                                            else MsgPlr( 2, player, Lang.InvalidItemx2 );
                                        }
                                        else MsgPlr( 2, player, Lang.ReviveNotClosePlr );
                                    }
                                    else MsgPlr( 2, player, Lang.CantRobInCar );
                                }
                                else MsgPlr( 2, player, Lang.ReviveNotClosePlr );
                            }
                            else MsgPlr( 2, player, Lang.CantRobSelf );
                        }
                        else MsgPlr( 2, player, Lang.RobSyntax );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.RobSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "frisk":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    local plr = FindPlayer( GetTok( text, " ", 1 ) );

                    if( plr )
                    {
                        if( plr.ID != player.ID )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                            {
                                SendDataToClient( 10000, plr.Name + "'s' Inventory", player );

                                foreach( index, value in playa[ plr.ID ].Items )
                                {
                                    if( value.Quatity.tointeger() > 0 ) SendDataToClient( 10030, GetItemNameByID2( index.tointeger() ) + " (" + value.Quatity + ")", player );
                                }

                                for( local i = 0, weapon; i < 8; i++ )
                                {
                                    weapon = plr.GetWeaponAtSlot( i );
                                    if( weapon > 0 && weapon != 16 )
                                    {
                                        SendDataToClient( 10030, GetWeaponName( plr.GetWeaponAtSlot( i ) ) + " (" + plr.GetAmmoAtSlot( i ) + ")", player );
                                    }
                                }
                            }
                            else MsgPlr( 2, player, Lang.NotNearPlr );
                        }
                        else MsgPlr( 2, player, Lang.CantFriskSelf );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.FriskSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "accept":
        if( player.IsSpawned )
        {
            if( text )
            {
                switch( text )
                {
                    case "death":
                    if( playa[ player.ID ].Knocked.IsKnocked )
                    {
                        if( ( time() - playa[ player.ID ].Knocked.Time ) > 120 )
                        {
                            player.Health = 0;
                            player.IsFrozen = 0;
                        }
                        else MsgPlr( 2, player, Lang.CantAcceptDeath );
                    }
                    else MsgPlr( 2, player, Lang.NotKnocked );
                    break;

                    default:
                    MsgPlr( 2, player, Lang.AcceptSyntax );
                    break;
                }
            }
            else MsgPlr( 2, player, Lang.AcceptSyntax );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "do":
        case "em":
        if( player.IsSpawned )
        {
            if( text )
            {
                for( local i = 0; i < GetMaxPlayers(); i ++ )
                {
                    local plr = FindPlayer( i );
                    if( plr )
                    {
                        if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                        {
                            MessagePlayer( format( Lang.DoChat[ playa[ plr.ID ].Lang ], text, player.Name ), plr );
                        }
                    }
                }
            }
            else MsgPlr( 2, player, Lang.doMESyntax, cmd );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "send":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    local plr = FindPlayer( GetTok( text, " ", 1 ) ), cash = GetTok( text, " ", 2 );

                    if( cash )
                    {
                        if( plr )
                        {
                            if( plr.ID != player.ID )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 5 )
                                {
                                    if( IsNum( cash ) )
                                    {
                                        if( cash.tointeger() > 0 )
                                        {
                                            if( playa[ player.ID ].Cash >= cash.tointeger() )
                                            {
                                                playa[ player.ID ].DecCash( player, cash.tointeger() );
                                                playa[ plr.ID ].AddCash( plr, cash.tointeger() );

                                                MsgPlr( 3, player, Lang.GiveCash1, cash.tointeger(), plr.Name  );
                                                MsgPlr( 3, plr, Lang.GiveCash2, player.Name, cash.tointeger() );

                                                LocalMessage( player.Pos, "GiveCashLocal", player.Name, plr.Name );
                                                LocalMessage3D( player.ID, "GiveCashLocal", player.Name, plr.Name );
                                            }
                                            else MsgPlr( 2, player, Lang.GiveCashNotEnoughCash );
                                        }
                                        else MsgPlr( 2, player, Lang.GiveCashInvalidAmount );
                                    }
                                    else MsgPlr( 2, player, Lang.CashNotInNum );
                                }
                                else MsgPlr( 2, player, Lang.NotNearPlr );
                            }
                            else MsgPlr( 2, player, Lang.CantGiveCashSelf );
                        }
                        else MsgPlr( 2, player, Lang.UnknownPlr );
                    }
                    else MsgPlr( 2, player, Lang.GiveCashSyntax );
                }
                else MsgPlr( 2, player, Lang.GiveCashSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;
        
        case "give":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( text )
                {
                    local plr = FindPlayer( GetTok( text, " ", 1 ) ), quatity = GetTok( text, " ", 2 ), item = GetTok( text, " ", 3, NumTok( text, " " ) );

                    if( plr )
                    {
                        if( item )
                        {
                            if( plr.ID != player.ID )
                            {
                                if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
                                {
                                    if( quatity )
                                    {
                                        if( IsNum( quatity ) )
                                        {
                                            if( quatity.tointeger() > 0 )
                                            {
                                                if( GetRobItem( item ) )
                                                {
                                                    if( GetRobItem( item ) == "Weapon" )
                                                    {
                                                        local getwep = null;
                                                        for( local i = 0, weapon; i < 8; i++ )
                                                        {
                                                            weapon = player.GetWeaponAtSlot( i );

                                                            if( weapon > 0 && weapon != 16 )
                                                            {
                                                                if( weapon == GetWeaponID( item ) ) getwep = i;
                                                            }
                                                        }

                                                        if( getwep )
                                                        {
                                                            if( player.GetAmmoAtSlot( getwep ) >= quatity.tointeger() )
                                                            {
                                                                if( player.Weapon == player.GetWeaponAtSlot( getwep ) )
                                                                {
                                                                    local getammo = quatity.tointeger();

                                                                    player.SetWeapon( player.GetWeaponAtSlot( getwep ), ( player.GetAmmoAtSlot( getwep ) - getammo ) );
                                                                    plr.SetWeapon( plr.GetWeaponAtSlot( getwep ), ( plr.GetAmmoAtSlot( getwep ) + getammo ) );

                                                                    LocalMessage( player.Pos, "GiveItemTo", player.Name, GetWeaponName( player.Weapon ), plr.Name );
                                                                    LocalMessage3D( player.ID, "GiveItemTo", player.Name, GetWeaponName( player.Weapon ), plr.Name );

                                                                    MsgPlr( 3, player, Lang.GiveItem, GetWeaponName( player.Weapon ), getammo, plr.Name );
                                                                    MsgPlr( 3, plr, Lang.GiveItem2, player.Name, GetWeaponName( player.Weapon ), getammo );
                                                                }
                                                                else MsgPlr( 2, player, Lang.MustHoldWeapon );
                                                            }
                                                            else MsgPlr( 2, player, Lang.DontHaveEnoughItem );
                                                        }
                                                        else MsgPlr( 2, player, Lang.DontHaveSuchItem );
                                                    }

                                                    else 
                                                    {
                                                        if( GetItemQuatity( player, GetItemIDByName( item ) ) >= quatity.tointeger() )
                                                        {
                                                            AddQuatity( plr, GetItemIDByName( item ), quatity.tointeger() );
                                                            DecQuatity( player, GetItemIDByName( item ), quatity.tointeger() );

                                                            LocalMessage( player.Pos, "GiveItemTo", player.Name, item, plr.Name );
                                                            LocalMessage3D( player.ID, "GiveItemTo", player.Name, item, plr.Name );

                                                            MsgPlr( 3, player, Lang.GiveItem, item, quatity.tointeger(), plr.Name );
                                                            MsgPlr( 3, plr, Lang.GiveItem2, player.Name, item, quatity.tointeger() );
                                                        }
                                                        else MsgPlr( 2, player, Lang.DontHaveEnoughItem );
                                                    }
                                                }
                                                else MsgPlr( 2, player, Lang.InvalidItemx2 );
                                            }
                                            else MsgPlr( 2, player, Lang.GiveCashInvalidAmount );
                                        }
                                        else MsgPlr( 2, player, Lang.QuatityNotNum );
                                    }
                                    else MsgPlr( 2, player, Lang.GiveItemSyntax );
                                }
                                else MsgPlr( 2, player, Lang.NotNearPlr );
                            }
                            else MsgPlr( 2, player, Lang.GiveItemSelf );
                        }
                        else MsgPlr( 2, player, Lang.GiveItemSyntax );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.GiveItemSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;


        case "setfreq":
        if( GetItem( player, 3, 1 ) )
        {
            if( text )
            {
                local slot = GetTok( text, " ", 1 ), channel = GetTok( text, " ", 2 );

                if( slot && channel )
                {
                    if( IsNum( slot ) && IsNum( channel ) )
                    {
                        if( slot.tointeger() >= 1 && slot.tointeger() <= 5 )
                        {
                            if( !GetPlayerJoinedChannel( channel.tointeger(), player ) )
                            {
                                if( channel.tointeger() >= 0 && channel.tointeger() <= 9999 )
                                {
                                    RegisterChannel( channel.tointeger() )

                                    if( !IsRadioLocked( channel.tointeger(), player ) )
                                    {
                                        if( !GetRadioMemberBannedState( channel.tointeger(), playa[ player.ID ].ID ) )
                                        {
                                            if( playa[ player.ID ].Radio[ slot.tostring() ].Channel != "0" ) MsgRadio( playa[ player.ID ].Radio[ slot.tostring() ].Channel.tointeger(), Lang.RadioFregLeft, player.Name );

                                            playa[ player.ID ].Radio[ slot.tostring() ].Channel = channel.tostring();

                                            MsgRadio( channel.tointeger(), Lang.RadioFregJoin, player.Name );
                                    
                                            if( cradio[ channel.tointeger() ].Owner == 100000 ) MsgPlr( 3, player, Lang.RadioFregJoined1, channel.tointeger() );
                                            else MsgPlr( 3, player, Lang.RadioFregJoined, channel.tointeger(), mysqldb.GetNameFromID( cradio[ channel.tointeger() ].Owner ) );

                                            if( cradio[ channel.tointeger() ].Description != "x" ) MsgPlr( 3, player, Lang.RadioFregJoined2, cradio[ channel.tointeger() ].Description );                                        
                                        }
                                        else MsgPlr( 2, player, Lang.RadioFregBanned );
                                    }
                                    else MsgPlr( 2, player, Lang.RadioFregLocked );
                                }
                                else MsgPlr( 2, player, Lang.RadioFregNotCorrect );
                            }
                            else MsgPlr( 2, player, Lang.RadioSlotAlreadyJoined );
                        }
                        else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
                    }
                    else MsgPlr( 2, player, Lang.SetFregSlotOrChannelNotNum );
                }
                else MsgPlr( 2, player, Lang.SetFregSyntax );
            }
            else MsgPlr( 2, player, Lang.SetFregSyntax );
        }
        else MsgPlr( 2, player, Lang.NeedRadio );
        break;

        case "crregister":
        if( text )
        {
            if( IsNum( text ) )
            {
                if( text.tointeger() != 0 )
                {
                    if( GetPlayerJoinedChannel( text.tointeger(), player ) == text.tointeger() )
                    {
                        if( cradio[ text.tointeger() ].Owner == 100000 )
                        {
                            cradio[ text.tointeger() ].Owner = playa[ player.ID ].ID;

                            InitRadioMember( text.tointeger(), playa[ player.ID ].ID, 4 );

                            MsgRadio( text.tointeger(), Lang.CRRegisterAll, player.Name );

                            MsgPlr( 3, player, Lang.CRRegister, text.tointeger() );

                            SaveRadioData( text.tointeger() );
                        }
                        else MsgPlr( 2, player, Lang.CRAlreadyOwned );
                    }
                    else MsgPlr( 2, player, Lang.CRNotInChannel );
                }
                else MsgPlr( 2, player, Lang.CRCantRegister );
            }
            else MsgPlr( 2, player, Lang.CRChannelNotNum );
        }
        else MsgPlr( 2, player, Lang.CRRegisterSyntax );
        break;

        case "cr":
        if( text )
        {
            local slot = GetTok( text, " ", 1 ), txt = GetTok( text, " ", 2, NumTok( text, " " ) );

            if( slot && txt )
            {
                if( IsNum( slot ) )
                {
                    if( slot.tointeger() >= 1 && slot.tointeger() <= 5 )
                    {
                        if( GetPlayerJoinedSlot( slot.tointeger(), player ) != 0 )
                        {
                            local getchannel = GetPlayerJoinedSlot( slot.tointeger(), player );

                            MsgRadio( getchannel, Lang.CRSendMsg, player.Name, StripCol( txt ), player.Name );

                            MsgRadioLocal( getchannel, player.Pos, Lang.PoliceROutside, player.Name, txt );
                        }
                        else MsgPlr( 2, player, Lang.CRCantTalk );
                    }
                    else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
                }
                else MsgPlr( 2, player, Lang.CRSlotNotNum );
            }
            else MsgPlr( 2, player, Lang.CRTalkSyntax );
        }
        else MsgPlr( 2, player, Lang.CRTalkSyntax );
        break;
     
        case "crlock":
        if( text )
        {
            if( IsNum( text ) )
            {
                if( text.tointeger() >= 1 && text.tointeger() <= 5 )
                {
                    if( GetRadioMemberLevel( GetPlayerJoinedSlot( text.tointeger(), player ), playa[ player.ID ].ID ) >= 3 )
                    {
                        local getchannel = GetPlayerJoinedSlot( text.tointeger(), player );

                        switch( cradio[ getchannel ].Locked )
                        {
                            case false:
                            cradio[ getchannel ].Locked = true;

                            MsgRadio( getchannel, Lang.CRLock, player.Name );
                            break;

                            case true:
                            cradio[ getchannel ].Locked = false;

                            MsgRadio( getchannel, Lang.CRUnLock, player.Name );
                            break;

                            SaveRadioData( getchannel );
                        }
                    }
                    else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                }
                else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
            }
            else MsgPlr( 2, player, Lang.CRSlotNotNum );
        }
        else MsgPlr( 2, player, Lang.CRLockSyntax );
        break;

        case "crpanic":
        if( text )
        {
            if( IsNum( text ) )
            {
                if( text.tointeger() >= 1 && text.tointeger() <= 5 )
                {
                    if( GetPlayerJoinedSlot( text.tointeger(), player ) != 0 )
                    {
                        local getchannel = GetPlayerJoinedSlot( text.tointeger(), player );

                        MsgRadio( getchannel, Lang.CRPanic, player.Name, IsPlayerInArea( player.Pos.x, player.Pos.y ) );

                        MsgRadioLocal( getchannel, player.Pos, Lang.PolicePanicOutside, player.Name );
                    }
                    else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                }
                else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
            }
            else MsgPlr( 2, player, Lang.CRSlotNotNum );
        }
        else MsgPlr( 2, player, Lang.CRPanicSyntax );
        break;

        case "cralert":
        if( text )
        {
            local slot = GetTok( text, " ", 1 ), txt = GetTok( text, " ", 2, NumTok( text, " " ) );

            if( slot && txt )
            {
                if( IsNum( slot ) )
                {
                    if( slot.tointeger() >= 1 && slot.tointeger() <= 5 )
                    {
                        if( GetPlayerJoinedSlot( slot.tointeger(), player ) != 0 )
                        {
                            if( GetRadioMemberLevel( GetPlayerJoinedSlot( text.tointeger(), player ), playa[ player.ID ].ID ) >= 2 )
                            {
                                local getchannel = GetPlayerJoinedSlot( slot.tointeger(), player );

                                MsgRadio( getchannel, Lang.CRSendMsgR, player.Name, StripCol( txt ) );

                                MsgRadioLocal( getchannel, player.Pos, Lang.PoliceROutside, player.Name, txt );
                            }
                            else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                        }
                        else MsgPlr( 2, player, Lang.CRCantTalk );
                    }
                    else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
                }
                else MsgPlr( 2, player, Lang.CRSlotNotNum );
            }
            else MsgPlr( 2, player, Lang.CRAlertSyntax );
        }
        else MsgPlr( 2, player, Lang.CRAlertSyntax );
        break;

        case "crdescription":
        if( text )
        {
            local slot = GetTok( text, " ", 1 ), txt = GetTok( text, " ", 2, NumTok( text, " " ) );

            if( slot && txt )
            {
                if( IsNum( slot ) )
                {
                    if( slot.tointeger() >= 1 && slot.tointeger() <= 5 )
                    {
                        if( GetPlayerJoinedSlot( slot.tointeger(), player ) != 0 )
                        {
                            if( GetRadioMemberLevel( GetPlayerJoinedSlot( slot.tointeger(), player ), playa[ player.ID ].ID ) >= 3 )
                            {
                                local getchannel = GetPlayerJoinedSlot( slot.tointeger(), player );

                                cradio[ getchannel ].Description = txt;

                                MsgRadio( getchannel, Lang.CRUpdateDescription, player.Name, txt );

                                SaveRadioData( getchannel );
                            }
                            else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                        }
                        else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                    }
                    else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
                }
                else MsgPlr( 2, player, Lang.CRSlotNotNum );
            }
            else MsgPlr( 2, player, Lang.CRAlertSyntax );
        }
        else MsgPlr( 2, player, Lang.CRAlertSyntax );
        break;

        case "crsetlevel":
        if( text )
        {
            local slot = GetTok( text, " ", 1 ), plr = FindPlayer( GetTok( text, " ", 2 ) ), lvl = GetTok( text, " ", 3 );

            if( slot && plr && lvl )
            {
                if( IsNum( slot ) )
                {
                    if( slot.tointeger() >= 1 && slot.tointeger() <= 5 )
                    {
                        if( GetPlayerJoinedSlot( slot.tointeger(), player ) != 0 )
                        {
                            if( GetRadioMemberLevel( GetPlayerJoinedSlot( slot.tointeger(), player ), playa[ player.ID ].ID) >= 3 )
                            {
                                if( plr )
                                {
                                    if( plr.ID != player.ID )
                                    {
                                        if( GetPlayerJoinedChannel( slot.tointeger(), plr ) == GetPlayerJoinedChannel( slot.tointeger(), player ) )
                                        {
                                            if( IsNum( lvl ) )
                                            {
                                                if( lvl.tointeger() >= 0 && lvl.tointeger() <= 3 )
                                                {
                                                    local getchannel = GetPlayerJoinedSlot( slot.tointeger(), player );

                                                    InitRadioMember( getchannel, plr.Name, lvl.tointeger() );

                                                    MsgRadio( getchannel, Lang.CRSetLevel, player.Name, plr.Name, lvl.tointeger() );

                                                    SaveRadioData( getchannel );
                                                }
                                                else MsgPlr( 2, player, Lang.CRLevelInvalid );
                                            }
                                            else MsgPlr( 2, player, Lang.CRLevelNotNum );
                                        }
                                        else MsgPlr( 2, player, Lang.TargetNotInChannel );
                                    }
                                    else MsgPlr( 2, player, Lang.CRCantSetSelfLevel );
                                }
                                else MsgPlr( 2, player, Lang.UnknownPlr );
                            }
                            else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                        }
                        else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                    }
                    else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
                }
                else MsgPlr( 2, player, Lang.CRSlotNotNum );
            }
            else MsgPlr( 2, player, Lang.CRSetlevelSyntax );
        }
        else MsgPlr( 2, player, Lang.CRSetlevelSyntax );
        break;

        case "crmembers":
        if( text )
        {
            if( IsNum( text ) )
            {
                if( text.tointeger() >= 1 && text.tointeger() <= 5 )
                {
                    if( GetPlayerJoinedSlot( text.tointeger(), player ) != 0 )
                    {
                        local getchannel = GetPlayerJoinedSlot( text.tointeger(), player ), nm = null, nm2 = 0;

                        for( local i = 0; i < GetMaxPlayers(); i ++ )
                        {
                            local plr = FindPlayer( i );
                            if( plr )
                            {
                                if( playa[ plr.ID ].Logged )
                                {
                                    if( GetPlayerJoinedChannel( getchannel, plr ) == getchannel ) 
                                    {
                                        if( nm ) nm = nm + ", " + plr.Name;
                                        else nm = plr.Name;

                                        nm2 ++;
                                    }
                                }
                            }
                        }
                        
                        if( nm ) 
                        {
                            MsgPlr( 3, player, Lang.CRMembers, text.tointeger(), getchannel );
                            MsgPlr( 3, player, Lang.CRMembers1, nm );
                            MsgPlr( 3, player, Lang.CRMembers2, nm2 );
                        }
                    }
                    else MsgPlr( 2, player, Lang.RadioCantUseCmd );
                }
                else MsgPlr( 2, player, Lang.RadioSlotNotCorrect );
            }
            else MsgPlr( 2, player, Lang.CRSlotNotNum );
        }
        else MsgPlr( 2, player, Lang.CRMemberSyntax );
        break;































    }
}