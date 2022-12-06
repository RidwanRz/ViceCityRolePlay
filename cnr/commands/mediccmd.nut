function onMedicCmd( player, cmd, text )
{
    switch( cmd )
    {
        case "carrybody":
        if( playa[ player.ID ].Job.JobID == 2 )
        {
            if( playa[ player.ID ].CarryBody.Status == 0 )
            {
                if( text )
                {
                    if( IsNum )
                    {
                        if( Corps.CorpsData.rawin( text.tointeger() ) )
                        {
                            local body = Corps.CorpsData[ text.tointeger() ];

                            if( DistanceFromPoint( body.Pos.x, body.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
                            {
                                if( body.Status == 2 )
                                {
                                    playa[ player.ID ].CarryBody.Status = 1;
                                    playa[ player.ID ].CarryBody.CarryID = text.tointeger();

                                    SendDataToClientToAll( 9302, text.tointeger() );
                                    Corps.CorpsData.rawdelete( text.tointeger() );
                                    
                                    MsgPlr( 3, player, Lang.CarryBody );
                                }
                                else MsgPlr( 2, player, Lang.BodyNotBody );
                            }
                            else MsgPlr( 2, player, Lang.NotNearCorps );
                        }
                        else MsgPlr( 2, player, Lang.InvalidCorpsID );
                    }
                    else MsgPlr( 2, player, Lang.CarryBodyNotNum );
                }
                else MsgPlr( 2, player, Lang.CarryBodySyntax );
            }
            else MsgPlr( 2, player, Lang.AlreadyCarryBody );
        }
        else MsgPlr( 2, player, Lang.NotMedic );
        break;

        case "bagbody":
        if( playa[ player.ID ].Job.JobID == 2 )
        {
            if( playa[ player.ID ].CarryBody.Status == 0 )
            {
                if( text )
                {
                    if( IsNum )
                    {
                        if( Corps.CorpsData.rawin( text.tointeger() ) )
                        {
                            local body = Corps.CorpsData[ text.tointeger() ];

                            if( DistanceFromPoint( body.Pos.x, body.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
                            {
                                if( body.Status == 1 )
                                {
                                    SendDataToClientToAll( 9301, text.tointeger() + ";Corps #" + text.tointeger() + ";((/carrybody to pick up the bodybag))" );

                                    Corps.CorpsData[ text.tointeger() ].Status = 2;

                                //    MsgPlr( 3, player, Lang.BagBody );
                                }
                                else MsgPlr( 2, player, Lang.BodyAlreadyBag );
                            }
                            else MsgPlr( 2, player, Lang.NotNearCorps );
                        }
                        else MsgPlr( 2, player, Lang.InvalidCorpsID );
                    }
                    else MsgPlr( 2, player, Lang.CarryBodyNotNum );
                }
                else MsgPlr( 2, player, Lang.BagBodySyntax );
            }
            else MsgPlr( 2, player, Lang.AlreadyCarryBody );
        }
        else MsgPlr( 2, player, Lang.NotMedic );
        break;


        case "storebody":
        if( playa[ player.ID ].Job.JobID == 2 )
        {
            if( playa[ player.ID ].CarryBody.Status == 1 )
            {
                local findam = null;
                foreach( index, value in vehicle )
                {
                    if( value.Model == 146 )
                    {
                        if( DistanceFromPoint( value.Pos.x, value.Pos.y, player.Pos.x, player.Pos.y ) <= 5 ) findam = index;
                    }
                }

                if( findam )
                {
                    vehicle[ findam ].Body ++;

                    MsgPlr( 3, player, Lang.StoreBody, GetVehicleNameFromModel( vehicle[ findam ].Model ) );

                    LocalMessage( player.Pos, "StorebodyLocal", player.Name, GetVehicleNameFromModel( vehicle[ findam ].Model ) );
                     LocalMessage3D( player.ID, "StorebodyLocal", player.Name, GetVehicleNameFromModel( vehicle[ findam ].Model ) );

                    playa[ player.ID ].CarryBody.Status = 0;
                    playa[ player.ID ].CarryBody.CarryID = null;
                }
                else MsgPlr( 2, player, Lang.NoAmbulanceNearby );
            }
            else MsgPlr( 2, player, Lang.NotCarryBody );
        }
        else MsgPlr( 2, player, Lang.NotMedic );
        break;

        case "unloadbody":
        if( playa[ player.ID ].Job.JobID == 2 )
        {
            if( playa[ player.ID ].CarryBody.Status == 0 )
            {
                local findam = null;
                foreach( index, value in vehicle )
                {
                    if( value.Model == 146 )
                    {
                        if( DistanceFromPoint( value.Pos.x, value.Pos.y, player.Pos.x, player.Pos.y ) <= 5 ) findam = index;
                    }
                }

                if( findam )
                {
                    if( vehicle[ findam ].Body > 0 )
                    {
                        vehicle[ findam ].Body --;

                        MsgPlr( 3, player, Lang.UnloadBody, GetVehicleNameFromModel( vehicle[ findam ].Model ) );

                        LocalMessage( player.Pos, "UnloadbodyLocal", player.Name, GetVehicleNameFromModel( vehicle[ findam ].Model ) );
                        LocalMessage3D( player.ID, "UnloadbodyLocal", player.Name, GetVehicleNameFromModel( vehicle[ findam ].Model ) );

                        playa[ player.ID ].CarryBody.Status = 1;
                        playa[ player.ID ].CarryBody.CarryID = null;
                    }
                    else MsgPlr( 2, player, Lang.NoBodyStoreInAm, GetVehicleNameFromModel( vehicle[ findam ].Model ) );
                }
                else MsgPlr( 2, player, Lang.EMSNoVehicleNearby );
            }
            else MsgPlr( 2, player, Lang.AlreadyCarryBody );
        }
        else MsgPlr( 2, player, Lang.NotMedic );
        break;

        case "cremate":
        if( playa[ player.ID ].Job.JobID == 2 )
        {
            if( playa[ player.ID ].CarryBody.Status == 1 )
            {
            if( IsHospital( player ) )  //  if( playa[ player.ID ].Area.find( "Hospital-1" ) || playa[ player.ID ].Area.find( "Hospital-2" ) || playa[ player.ID ].Area.find( "Hospital-3" ) || playa[ player.ID ].Area.find( "Hospital-4" ) )
                {
                    local generater = ( rand() % 100) + "00";
                    local randomr = generater.tointeger();

                    MsgPlr( 3, player, Lang.CremateBody, randomr );

                    playa[ player.ID ].CarryBody.Status = 0;
                    playa[ player.ID ].CarryBody.CarryID = null;

                    playa[ player.ID ].Paycheck += generater;
                }
                else MsgPlr( 2, player, Lang.NotInHospital );
            }
            else MsgPlr( 2, player, Lang.NotCarryBody );
        }
        else MsgPlr( 2, player, Lang.NotMedic );
        break;

        case "revive":
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
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 2 )
                            {
                                if( !player.Vehicle )
                                {
                                    if( playa[ plr.ID ].Knocked.IsKnocked )
                                    {
                                        if( !GetRevivingPlayer( plr ) )
                                        {
                                            if( playa[ player.ID ].Job.JobID == 2 )
                                            {
                                                if( GetNearestAmbulance( player ) )
                                                {
                                                    local count = 0;

                                                    player.SetAnim( 24, 214 );

                                                    MsgPlr( 3, player, Lang.RevivePlayer, plr.Name );

                                                    playa[ plr.ID ].Knocked.BeingRevive = player.ID;

                                                    playa[ player.ID ].ReviveTimer = _Timer.Create( this, function( x, y, z )
                                                    {
                                                        count ++;
                                                        if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
                                                        {
                                                            if( count > 10 )
                                                            {
                                                                local reward = 0;

                                                                if( playa[ plr.ID ].Cash >= 4000 ) reward = 4000;

                                                                playa[ plr.ID ].DecCash( plr, reward );
                                                                playa[ player.ID ].Paycheck += reward;

                                                                player.SetAnim( 0, 44 );
                                                                plr.SetAnim( 0, 44 );
                                                                RespawnRestoreColor( plr );
                                                                plr.Health = 5;
                                                                plr.IsFrozen = false;

                                                                MsgPlr( 3, player, Lang.ReviveScsMedic, plr.Name, reward );
                                                                MsgPlr( 3, plr, Lang.ReviveScsMedic2, player.Name, reward );
                                                                
                                                                RemoveCorps2( playa[ plr.ID ].Knocked.Corps );

                                                                playa[ plr.ID ].Knocked.IsKnocked = false;
                                                                playa[ plr.ID ].Knocked.BeingRevive = null;
                                                                playa[ plr.ID ].Knocked.Corps = null;

                                                                Announce( "", plr, 3 );
                                                                Announce( "", plr, 1 );

                                                                _Timer.Destroy( playa[ plr.ID ].Knocked.Timer );
                                                                _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                            }
                                                            
                                                            player.SetAnim( 24, 214 );
                                                        }

                                                        else 
                                                        {
                                                            MsgPlr( 2, player, Lang.ReviveFailMove );
                                                            
                                                            playa[ plr.ID ].Knocked.BeingRevive = null;

                                                            _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                        }
                                                    }, 1000, 0, player.Pos.x, player.Pos.y, player.Pos.z );
                                                }

                                                else 
                                                {
                                                    if( GetItem( player, 1, 1 ) )
                                                    {
                                                        local count = 0;

                                                        player.SetAnim( 24, 214 );

                                                        MsgPlr( 3, player, Lang.RevivePlayer, plr.Name );

                                                        playa[ plr.ID ].Knocked.BeingRevive = player.ID;

                                                        playa[ player.ID ].ReviveTimer = _Timer.Create( this, function( x, y, z )
                                                        {
                                                            count ++;
                                                            if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
                                                            {
                                                                if( count > 10 )
                                                                {
                                                                    DecQuatity( player, 1, 1 );

                                                                    player.SetAnim( 0, 44 );
                                                                    plr.SetAnim( 0, 44 );
                                                                    RespawnRestoreColor( plr );
                                                                    plr.Health = 5;
                                                                    plr.IsFrozen = false;
                        
                                                                    MsgPlr( 3, player, Lang.ReviveScs, plr.Name );
                                                                    MsgPlr( 3, plr, Lang.ReviveScs2, player.Name );
                                                                        
                                                                    RemoveCorps2( playa[ plr.ID ].Knocked.Corps );

                                                                    playa[ plr.ID ].Knocked.IsKnocked = false;
                                                                    playa[ plr.ID ].Knocked.BeingRevive = null;
                                                                    playa[ plr.ID ].Knocked.Corps = null;

                                                                    Announce( "", plr, 3 );
                                                                    Announce( "", plr, 1 );

                                                                    _Timer.Destroy( playa[ plr.ID ].Knocked.Timer );
                                                                    _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                                }
                                                                    
                                                                player.SetAnim( 24, 214 );
                                                            }

                                                            else 
                                                            {
                                                                MsgPlr( 2, player, Lang.ReviveFailMove );
                                                                    
                                                                playa[ plr.ID ].Knocked.BeingRevive = null;

                                                                _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                            }
                                                        }, 1000, 0, player.Pos.x, player.Pos.y, player.Pos.z );


                                                    }
                                                    else MsgPlr( 2, player, Lang.ReviveNotHaveKitOrNearAmbulance );
                                                }
                                            }

                                            else 
                                            {
                                                if( GetItem( player, 1, 1 ) )
                                                {
                                                    local count = 0;

                                                    player.SetAnim( 24, 214 );

                                                    MsgPlr( 3, player, Lang.RevivePlayer, plr.Name );

                                                    playa[ plr.ID ].Knocked.BeingRevive = player.ID;

                                                    playa[ player.ID ].ReviveTimer = _Timer.Create( this, function( x, y, z )
                                                    {
                                                        count ++;
                                                        if( x == player.Pos.x && y == player.Pos.y && z == player.Pos.z )
                                                        {
                                                            if( count > 10 )
                                                            {
                                                                DecQuatity( player, 1, 1 );

                                                                player.SetAnim( 0, 44 );
                                                                plr.SetAnim( 0, 44 );
                                                                RespawnRestoreColor( plr );
                                                                plr.Health = 5;
                                                                plr.IsFrozen = false;

                                                                MsgPlr( 3, player, Lang.ReviveScs, plr.Name );
                                                                MsgPlr( 3, plr, Lang.ReviveScs2, player.Name );
                                                                    
                                                                RemoveCorps2( playa[ plr.ID ].Knocked.Corps );

                                                                playa[ plr.ID ].Knocked.IsKnocked = false;
                                                                playa[ plr.ID ].Knocked.BeingRevive = null;
                                                                playa[ player.ID ].Knocked.Corps = null;

                                                                Announce( "", plr, 3 );
                                                                Announce( "", plr, 1 );

                                                                _Timer.Destroy( playa[ plr.ID ].Knocked.Timer );
                                                                _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                            }
                                                                
                                                            player.SetAnim( 24, 214 );
                                                        }

                                                        else 
                                                        {
                                                            MsgPlr( 2, player, Lang.ReviveFailMove );
                                                                
                                                            playa[ plr.ID ].Knocked.BeingRevive = null;

                                                            _Timer.Destroy( playa[ player.ID ].ReviveTimer );
                                                        }
                                                    }, 1000, 0, player.Pos.x, player.Pos.y, player.Pos.z );
                                                }
                                                else MsgPlr( 2, player, Lang.ReviveNotHaveKit );
                                            }
                                        }
                                        else MsgPlr( 2, player, Lang.TargetBeingRevive );
                                    }
                                    else MsgPlr( 2, player, Lang.ReviveNotClosePlr );
                                }
                                else MsgPlr( 2, player, Lang.ReviveInCar );
                            }
                            else MsgPlr( 2, player, Lang.ReviveNotClosePlr );
                        }
                        else MsgPlr( 2, player, Lang.CantReviveSelf );
                    }
                    else MsgPlr( 2, player, Lang.UnknownPlr );
                }
                else MsgPlr( 2, player, Lang.ReviveSyntax );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
      
    }
}