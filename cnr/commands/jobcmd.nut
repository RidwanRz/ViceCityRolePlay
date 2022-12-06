function onJobCommand( player, cmd, text )
{
	local p = playa[ player.ID ];
	switch( cmd )
	{
        case "r":
        case "radio":
        if( IsJobAllowRadio( player ) )
        {
            if( text )
            {
                switch( playa[ player.ID ].Job.JobID )
                {
                    case 2: MessageToAllEMS( "Radio", "MedicR", "" + playa[ player.ID ].Job.MedicRank, player.Name, text ); break;
                    case 3: MessageToAllLaw( "Radio", "PoliceR", "VCPD " + playa[ player.ID ].Job.PDRank, player.Name, text ); break;
                    case 4: MessageToAllLaw( "Radio", "PoliceR", "SWAT " + playa[ player.ID ].Job.SWATRank, player.Name, text ); break;
                    case 5: MessageToAllLaw( "Radio", "PoliceR", "FBI " + playa[ player.ID ].Job.FBIRank, player.Name, text ); break;
                }

                switch( playa[ player.ID ].Job.JobID )
                {
                    case 2:
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                            {
                                if( playa[ plr.ID ].Job.JobID != 2 ) MessagePlayer( format( Lang.PoliceROutside[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                            }
                        }
                    }
                    break;

                    case 3:
                    case 4:
                    case 5:
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                            {
                                if( !IsLawE( plr ) ) MessagePlayer( format( Lang.PoliceROutside[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                            }
                        }
                    }
                    break;
                }
            }
            else MsgPlr( 2, player, Lang.RadioSyntax );
        }
        else MsgPlr( 2, player, Lang.NotInJobWithRadio );
        break;

		case "psa":
		if( IsJobAllowRadio( player ) )
		{
            if( PDOrMedicHighrankCmd( player, 4, 1, 3 ) )
            {
				if( text )
				{
					MsgAll( 2, Lang.PSA, text );

					switch( playa[ player.ID ].Job.JobID )
					{
						case 3: MsgAll( 2, Lang.PSA2, "VCPD " + playa[ player.ID ].Job.PDRank, player.Name ); break;
						case 4: MsgAll( 2, Lang.PSA2, "SWAT " + playa[ player.ID ].Job.SWATRank, player.Name ); break;
						case 5: MsgAll( 2, Lang.PSA2, "FBI " + playa[ player.ID ].Job.FBIRank, player.Name ); break;
						case 2: MsgAll( 2, Lang.PSA2, "EMS " + playa[ player.ID ].Job.MedicRank, player.Name ); break;
					}
				}
				else MsgPlr( 2, player, Lang.PSASyntax );
			}
			else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
			break;
		}
		else MsgPlr( 2, player, Lang.NotAllowedUseCmd2 );
		break;

        case "dep":
        if( IsJobAllowRadio( player ) )
        {
            if( text )
            {
                switch( playa[ player.ID ].Job.JobID )
                {
					case 3: MessageToAllE( Lang.DEPRadio, "VCPD", player.Name, text ); break;
					case 4: MessageToAllE( Lang.DEPRadio, "SWAT", player.Name, text ); break;
					case 5: MessageToAllE( Lang.DEPRadio, "FBI", player.Name, text ); break;
					case 2: MessageToAllE( Lang.DEPRadio, "EMS", player.Name, text ); break;
                }

                switch( playa[ player.ID ].Job.JobID )
                {
                    case 2:
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                            {
                                if( playa[ plr.ID ].Job.JobID != 2 ) MessagePlayer( format( Lang.PoliceROutside[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                            }
                        }
                    }
                    break;

                    case 3:
                    case 4:
                    case 5:
                    for( local i = 0; i < GetMaxPlayers(); i ++ )
                    {
                        local plr = FindPlayer( i );
                        if( plr )
                        {
                            if( DistanceFromPoint( plr.Pos.x, plr.Pos.y, player.Pos.x, player.Pos.y ) <= 12 )
                            {
                                if( !IsJobAllowRadio( plr ) ) MessagePlayer( format( Lang.PoliceROutside[ playa[ plr.ID ].Lang ], player.Name, text ), plr );
                            }
                        }
                    }
                    break;
                }
            }
            else MsgPlr( 2, player, Lang.DepSyntax );
        }
        else MsgPlr( 2, player, Lang.NotInJobWithRadio );
        break;

    }

}
