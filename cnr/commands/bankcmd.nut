function onBankCmd( player, cmd , text )
{
	if( playa[ player.ID ].Logged == false ) return MsgPlr( 2, player, Lang.InvalidCmd );
	else switch( cmd.tolower() )
	{
		case "deposit":
		if( playa[ player.ID ].Area != "bank" ) MsgPlr( 2, player, Lang.NotInBank );
		else 
		{
			if( !text ) MsgPlr( 2, player, Lang.DepositSyntax );
			else 
			{
				switch( text )
				{
					case "all":
					if( playa[ player.ID ].Cash < 0 ) MsgPlr( 2, player, Lang.CashNotEnough );
					else 
					{
						local allcash = playa[ player.ID ].Cash;

						playa[ player.ID ].AddBank( player, allcash );
						playa[ player.ID ].DecCash( player, allcash );

						MsgPlr( 3, player, Lang.CashDeposit, allcash, playa[ player.ID ].Bank );
					}
					break;

					default:
					if( !IsNum( text ) ) MsgPlr( 2, player, Lang.CashNotInNum );
					else if( text.tointeger() < 0  || text.tointeger() > playa[ player.ID ].Cash ) MsgPlr( 2, player, Lang.CashNotEnough );
					else
					{
						playa[ player.ID ].AddBank( player, text.tointeger() );
						playa[ player.ID ].DecCash( player, text.tointeger() );

						MsgPlr( 3, player, Lang.CashDeposit, text.tointeger(), playa[ player.ID ].Bank );
					}
					break;
				}
			}
		}
		break;

		case "withdraw":
		if( playa[ player.ID ].Area != "bank" ) MsgPlr( 2, player, Lang.NotInBank );
		else
		{
			if( !text ) MsgPlr( 2, player, Lang.WithdrawSyntax );
			else 
			{
				switch( text )
				{
					case "all":
					if( playa[ player.ID ].Bank < 0 ) MsgPlr( 2, player, Lang.BankNotEnough );
					else 
					{
						local bankcash = playa[ player.ID ].Bank;

						playa[ player.ID ].DecBank( player, bankcash );
						playa[ player.ID ].AddCash( player, bankcash );

						MsgPlr( 3, player, Lang.BankWithdraw, bankcash, playa[ player.ID ].Bank );
					}
					break;

					default:				
					if( !IsNum( text ) ) MsgPlr( 2, player, Lang.CashNotInNum );
					else if(  text.tointeger() < 0  || text.tointeger() > playa[ player.ID ].Bank ) MsgPlr( 2, player, Lang.BankNotEnough );
					else
					{
						playa[ player.ID ].DecBank( player, text.tointeger().tointeger() );
						playa[ player.ID ].AddCash( player, text.tointeger().tointeger() );

						MsgPlr( 3, player, Lang.BankWithdraw, text.tointeger(), playa[ player.ID ].Bank );
					}
					break;
				}
			}
		}
		break;

		case "cash":
		MsgPlr( 3, player, Lang.CashInHad, playa[ player.ID ].Cash );
		break;

		case "bank":
		if( playa[ player.ID ].Area == "bank" )
		{
			MsgPlr( 3, player, Lang.BankInHad, playa[ player.ID ].Bank );
		}
		else MsgPlr( 2, player, Lang.NotInBank ); break;
		break;

		case "paycheck":
		if( playa[ player.ID ].Area == "bank" )
		{
			if( playa[ player.ID ].Paycheck > 0 )
            {
                local getcash = playa[ player.ID ].Paycheck;

                MsgPlr( 3, player, Lang.WithdrawPaycheck, getcash );

                playa[ player.ID ].Paycheck = 0;
                playa[ player.ID ].AddCash( player, getcash );
            }
            else MsgPlr( 2, player, Lang.NoPaycheck );
		}
		else MsgPlr( 2, player, Lang.NotInBank ); break;
		break;

		case "groupbank":
		if( playa[ player.ID ].Area == "bank" )
		{
			if( text )
			{
				local group = GetTok( text, " ", 1 ), type = GetTok( text, " ", 2 ), value = GetTok( text, " ", 3 );
				
				if( group && type )
				{
					if( ::FindGang( group ) )
					{
						if( playa[ player.ID ].Group.find( group ) >= 0 )
						{
							if( gangv2[ group ].Permission.gangchat.tointeger() >= ::GangGetLevelFromRank( group, gangv2[ group ].Members[ ::GangFindMember( group, player.Name ) ].Rank ) )
							{
								switch( type )
								{
									case "balance":
									MsgPlr( 3, player, Lang.gBankCheckBal, gangv2[ group ].Name, gangv2[ group ].Bank );
									break;

									case "deposit":
									if( value )
									{
										if( IsNum( value ) )
										{
											if( value.tointeger() > 0 )
											{
												if( playa[ player.ID ].Cash >= value.tointeger() )
												{
													playa[ player.ID ].DecCash( player, value.tointeger() );

													gangv2[ group ].Bank += value.tointeger();

													MsgPlr( 3, player, Lang.gBankDeposit, gangv2[ group ].Bank, gangv2[ group ].Name );
												}
												else MsgPlr( 2, player, Lang.CashNotEnough );
											}
											else MsgPlr( 2, player, Lang.CashNotEnough );
										}
										else MsgPlr( 2, player, Lang.CashNotInNum );
									}
									else MsgPlr( 2, player, Lang.gBankDepositSyntax, group, type );
									break;

									case "withdraw":
									if( value )
									{
										if( IsNum( value ) )
										{
											if( value.tointeger() > 0 )
											{
												if( gangv2[ group ].Bank >= value.tointeger() )
												{
													playa[ player.ID ].AddCash( player, value.tointeger() );

													gangv2[ group ].Bank -= value.tointeger();

													MsgPlr( 3, player, Lang.gBankWithdraw, value.tointeger(), gangv2[ group ].Name );
												}
												else MsgPlr( 2, player, Lang.gBankNotEnough );
											}
											else MsgPlr( 2, player, Lang.CashNotEnough );
										}
										else MsgPlr( 2, player, Lang.CashNotInNum );
									}
									else MsgPlr( 2, player, Lang.gBankDepositSyntax, group, type );
									break;

									default:
									MsgPlr( 2, player, Lang.GroupBankSyntax );
									break;
								}
							}
							else MsgPlr( 2, player, Lang.gNotAllowedCmd );
						}
						else MsgPlr( 2, player, Lang.gNotIn );
					}
					else MsgPlr( 2, player, Lang.gNotExist );
				}
				else MsgPlr( 2, player, Lang.GroupBankSyntax );
			}
			else MsgPlr( 2, player, Lang.GroupBankSyntax );
		}
		else MsgPlr( 2, player, Lang.NotInBank ); break;
		break;

    }
}