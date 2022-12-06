function onCriminalCmd( player, cmd , text )
{
	if( playa[ player.ID ].Logged == false ) return MsgPlr( 2, player, Lang.InvalidCmd );
	else switch( cmd.tolower( ) )
	{
        case "plantseed":
		if( player.IsSpawned )
		{
			if( !playa[ player.ID ].Knocked.IsKnocked )
            {
				if( !player.Vehicle )
				{
					if( IsWeedField( player ) )
					{
						if( GetItem( player, 22, 1 ) )
						{
							if( !GetNearestWeed2( player.Pos ) )
							{
								MsgPlr( 3, player, Lang.PlantSeed );

								AddWeedPlant( player.Pos );

								DecQuatity( player, 22, 1 );
								
								player.SetAnim( 12, 206 );

								LocalMessage(  player.Pos, "PlantweedLocal", player.Name );
								LocalMessage3D(  player.ID, "PlantweedLocal", player.Name );
							}
							else MsgPlr( 2, player, Lang.PlantseedCantNearPlant );
						}
						else MsgPlr( 2, player, Lang.NoItem2, "Weed Seed" );
					}
					else MsgPlr( 2, player, Lang.NeedAtWeeField );
				}
				else MsgPlr( 2, player, Lang.NotOnFoot );
			}
			else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;

		case "harvestweed":
		if( player.IsSpawned )
		{
			if( !playa[ player.ID ].Knocked.IsKnocked )
            {
				if( !player.Vehicle )
				{
					if( GetNearestWeed( player.Pos ) >= 0 )
					{
						local getplant = GetNearestWeed( player.Pos );

						if( weedfield[ getplant ].Status == 3 )
						{
							local genreward = ( rand() % 7 );

							if( genreward == 0 ) genreward = 2;

							weedfield[ getplant ].Object.Delete();
							weedfield.remove( getplant );

							player.SetAnim( 12, 205 );

							AddQuatity( player, 23, genreward.tostring() );

							MsgPlr( 3, player, Lang.HarvestWeed, genreward );
						}
						else MsgPlr( 2, player, Lang.WeedNotReady );
					}
					else MsgPlr( 2, player, Lang.NotNearWeedPlant );
				}
				else MsgPlr( 2, player, Lang.NotOnFoot );
			}
			else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;

		case "sell":
		if( player.IsSpawned )
		{
			if( !playa[ player.ID ].Knocked.IsKnocked )
            {
				if( playa[ player.ID ].Area == "black-market" )
				{
					if( text )
					{
						local item = GetTok( text, " ", 1 ), quatity = GetTok( text, " ", 2 );

						if( IsNum( quatity ) )
						{
							switch( item.tolower() )
							{
								case "weed":
								if( GetItem( player, 23, quatity.tointeger() ) )
								{
									local math = ( quatity.tointeger() * 85 );

									DecQuatity( player, 23, quatity.tointeger() );

									playa[ player.ID ].AddCash( player, math );

									MsgPlr( 3, player, Lang.SoldWeed, quatity.tointeger(), math );

								/*	local i = GetCriminalGroup( player );

									gangv2[ i ].XP += 2;

									SaveGroupData( i );*/
								}
								else MsgPlr( 2, player, Lang.NotEnoughWeed );
								break;

								default:
								MsgPlr( 2, player, Lang.SellSyntax );
								break;
							}
						}
						else MsgPlr( 2, player, Lang.QuatityNotNum );
					}
					else MsgPlr( 2, player, Lang.SellSyntax );
				}
				else MsgPlr( 2, player, Lang.NotInBlackMarket );
			}
			else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
		}
		else MsgPlr( 2, player, Lang.NotSpawn );
		break;





















    }
}