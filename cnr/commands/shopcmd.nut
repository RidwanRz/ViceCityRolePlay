function onBizCmd( player, cmd, text )
{
    switch( cmd )
    {
        case "buy":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                   	local getitem = area[ playa[ player.ID ].Area ].Items;
                    
                    if( getitem.len() > 0 )
                    {
                        if( IsClothShop( player ) ) GetClothShopCatalogue( player );
                        else GetShopCatalogue( player );
                    }
                    else MsgPlr( 2, player, Lang.NothingForSale );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "restock":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            local quatity = GetTok( text, " ", 1 ), item = GetTok( text, " ", 2, NumTok( text, " " ) );

                            if( IsNum( quatity ) )
                            {
                                if( quatity.tointeger() > 0 )
                                {
                                    if( GetItemIDByName( item ) )
                                    {
                                        local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item.tolower() ).tostring() ];

                                        if( ( getitem.Stock.tointeger() + quatity.tointeger() ) < GetStockLimit( GetItemIDByName( item.tolower() ) ) )
                                        {
                                            local calc = ( GetStockPrice( GetItemIDByName( item.tolower() ) ) * quatity.tointeger() )

                                            if( playa[ player.ID ].Cash >= calc )
                                            {
							                    playa[ player.ID ].DecCash( player, calc );

                                                area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock = ( area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Stock.tointeger() + quatity.tointeger() );

                                                MsgPlr( 3, player, Lang.ReStockItem, item, calc );

                                                SaveArea( area[ playa[ player.ID ].Area ] );
                                            }
                                            else MsgPlr( 2, player, Lang.NotEnoughCashRestock, ( calc - playa[ player.ID ].Cash ) );
                                        }
                                        else MsgPlr( 2, player, Lang.ReStockCantExceed, GetStockLimit( GetItemIDByName( item.tolower() ) ) );
                                    }
                                    else MsgPlr( 2, player, Lang.ReStockInvalidItem );
                                }
                                else MsgPlr( 2, player, Lang.ReStockInvalidQuatity );
                            }
                            else MsgPlr( 2, player, Lang.ReStockQuatityNotNum );
                        }
                        else MsgPlr( 2, player, Lang.RestockSyntax );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

       case "setstockprice":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            local quatity = GetTok( text, " ", 1 ), item = GetTok( text, " ", 2, NumTok( text, " " ) );

                            if( IsNum( quatity ) )
                            {
                                if( quatity.tointeger() > 0 )
                                {
                                    if( GetItemIDByName( item ) )
                                    {
                                        local getitem = area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item.tolower() ).tostring() ];

                                        if( quatity.tointeger() <= GetStockMaxPrice( GetItemIDByName( item.tolower() ) ) )
                                        {
                                            area[ playa[ player.ID ].Area ].Items[ GetItemIDByName( item ).tostring() ].Price = quatity;

                                            MsgPlr( 3, player, Lang.SetStockPrice, item, quatity.tointeger() );

                                            SaveArea( area[ playa[ player.ID ].Area ] );
                                        }
                                        else MsgPlr( 2, player, Lang.SetPriceCantExceed, GetStockMaxPrice( GetItemIDByName( item.tolower() ) ) );
                                    }
                                    else MsgPlr( 2, player, Lang.ReStockInvalidItem );
                                }
                                else MsgPlr( 2, player, Lang.SetPriceInvalidQuatity );
                            }
                            else MsgPlr( 2, player, Lang.SetStockPriceNotNum );
                        }
                        else MsgPlr( 2, player, Lang.SetStockPriceSyntax );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "buybiz":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == "100000" )
                    {
                        if( playa[ player.ID ].Cash >= area[ playa[ player.ID ].Area ].Price )
                        {
                            local value = area[ playa[ player.ID ].Area ];

                            area[ playa[ player.ID ].Area ].Owner = playa[ player.ID ].ID.tostring();

                            playa[ player.ID ].DecCash( player, area[ playa[ player.ID ].Area ].Price );
                            MsgPlr( 3, player, Lang.BuyProp, area[ playa[ player.ID ].Area ].Name, area[ playa[ player.ID ].Area ].Price );
                        //    MsgPlr( 3, player, Lang.BuyProp1 );

                            if( IsPNS2( value.ID ) ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );
                            else SendDataToClientToAll( 6020, value.ID + ";[#ffffff]" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner )  + ";[#e6e600]Value [#ffffff]$" + value.Price + "; ; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );
                    
                            print( "\r[Purchase] " + player.Name + " has purchased property " + area[ playa[ player.ID ].Area ].Name + "(ID " + playa[ player.ID ].Area + ") for $" + area[ playa[ player.ID ].Area ].Price );
                        
                            SaveArea( area[ playa[ player.ID ].Area ] );
                        }
                        else MsgPlr( 2, player, Lang.PropNotEnoughCash, ( area[ playa[ player.ID ].Area ].Price - playa[ player.ID ].Cash ) );
                    }
                    else MsgPlr( 2, player, Lang.PropNotForSale );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "sellbiz":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        local value = area[ playa[ player.ID ].Area ];

                        area[ playa[ player.ID ].Area ].Owner = "100000";

                        playa[ player.ID ].AddCash( player, area[ playa[ player.ID ].Area ].Price );
                        MsgPlr( 3, player, Lang.SellProp, area[ playa[ player.ID ].Area ].Name, area[ playa[ player.ID ].Area ].Price );
                    //    MsgPlr( 3, player, Lang.BuyProp1 );

                        if( IsPNS2( value.ID ) ) SendDataToClient( 6020, value.ID + ";" + value.Name + ";[#e6e600]This property is for sale for [#ffffff]$" + value.Price + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
                        else SendDataToClient( 6020, value.ID + ";" + value.Name + ";[#e6e600]This property is for sale for [#ffffff]$" + value.Price + "; ;" + GetText3Type( value.ID ) + "; ; ;" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z, player );
                        
                        SaveArea( area[ playa[ player.ID ].Area ] );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "income":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        MsgPlr( 3, player, Lang.PropIncome, area[ playa[ player.ID ].Area ].Name, area[ playa[ player.ID ].Area ].Income );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "collectincome":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( area[ playa[ player.ID ].Area ].Income > 0 )
                        {
                            local value = area[ playa[ player.ID ].Area ];

                            MsgPlr( 3, player, Lang.CollectPropIncome, area[ playa[ player.ID ].Area ].Income, area[ playa[ player.ID ].Area ].Name );

                            playa[ player.ID ].AddCash( player, area[ playa[ player.ID ].Area ].Income );

                            if( IsPNS2( value.ID ) ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );

                            area[ playa[ player.ID ].Area ].Income = 0;

                            SaveArea( area[ playa[ player.ID ].Area ] );
                        }
                        else MsgPlr( 2, player, Lang.NotIncome );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "bizname":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            local value = area[ playa[ player.ID ].Area ];

                            MsgPlr( 3, player, Lang.ChangeBizName );

                            area[ playa[ player.ID ].Area ].Name = text;

                            if( IsPNS2( value.ID ) ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );
                            else SendDataToClientToAll( 6020, value.ID + ";[#ffffff]" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner )  + ";[#e6e600]Value [#ffffff]$" + value.Price + "; ; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );

                            SaveArea( area[ playa[ player.ID ].Area ] );
                        }
                        else MsgPlr( 2, player, Lang.SetBizName );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

		case "bizwelcomemessage":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( playa[ player.ID ].Area )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            MsgPlr( 3, player, Lang.SetBizWelcomeMessage, text );

                            area[ playa[ player.ID ].Area ].Welcome = text;

                            SaveArea( area[ playa[ player.ID ].Area ] );
                        }
                        else MsgPlr( 2, player, Lang.SetBizWelcomeMessageSyntax );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInsideShop );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

       case "setpnsfee":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( IsPNS( player ) )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            local quatity = GetTok( text, " ", 1 );

                            if( IsNum( quatity ) )
                            {
                                if( quatity.tointeger() > 0 )
                                {
                                    local getitem = area[ playa[ player.ID ].Area ].Items[ "24" ];
                                    local value = area[ playa[ player.ID ].Area ];

                                    if( quatity.tointeger() <= GetStockMaxPrice( 24 ) )
                                    {
                                        area[ playa[ player.ID ].Area ].Items[ "24" ].Price = quatity;

                                        MsgPlr( 3, player, Lang.SetPnsPrice, quatity.tointeger() );

                                        if( IsPNS2( value.ID ) ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );

                                        SaveArea( area[ playa[ player.ID ].Area ] );
                                    }
                                    else MsgPlr( 2, player, Lang.SetPriceCantExceed, GetStockMaxPrice( 24 ) );
                                }
                                else MsgPlr( 2, player, Lang.SetPriceInvalidQuatity );
                            }
                            else MsgPlr( 2, player, Lang.SetStockPriceNotNum );
                        }
                        else MsgPlr( 2, player, Lang.SetPnsStockPriceSyntax );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInPns );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

        case "restockpns":
        if( player.IsSpawned )
        {
            if( !playa[ player.ID ].Knocked.IsKnocked )
            {
                if( IsPNS( player ) )
                {
                    if( area[ playa[ player.ID ].Area ].Owner == playa[ player.ID ].ID.tostring() )
                    {
                        if( text )
                        {
                            local quatity = GetTok( text, " ", 1 );

                            if( IsNum( quatity ) )
                            {
                                if( quatity.tointeger() > 0 )
                                {
                                    local getitem = area[ playa[ player.ID ].Area ].Items[ "24" ];
                                    local value = area[ playa[ player.ID ].Area ];
                                    
                                    if( ( getitem.Stock.tointeger() + quatity.tointeger() ) < GetStockLimit( 24 ) )
                                    {
                                        local calc = ( GetStockPrice( 24 ) * quatity.tointeger() )

                                        if( playa[ player.ID ].Cash >= calc )
                                        {
							                playa[ player.ID ].DecCash( player, calc );

                                            area[ playa[ player.ID ].Area ].Items[ "24" ].Stock = ( area[ playa[ player.ID ].Area ].Items[ "24" ].Stock.tointeger() + quatity.tointeger() );

                                            MsgPlr( 3, player, Lang.ReStockItem, "Vehicle Parts", calc );

                                            if( IsPNS2( value.ID ) ) SendDataToClientToAll( 6020, value.ID + ";" + value.Name + ";[#e6e600]Owner [#ffffff]" + mysqldb.GetNameFromID( value.Owner ) + ";[#e6e600]Repair fee [#ffffff]$" + value.Items[ "24" ].Price + ";[#e6e600]Stock [#ffffff]" + value.Items[ "24" ].Stock +"; ;" + GetText3Type( value.ID ) + ";" + value.InfoPos.x + ";" + value.InfoPos.y + ";" + value.InfoPos.z );

                                            SaveArea( area[ playa[ player.ID ].Area ] );
                                        }
                                        else MsgPlr( 2, player, Lang.NotEnoughCashRestock, ( calc - playa[ player.ID ].Cash ) );
                                    }
                                    else MsgPlr( 2, player, Lang.ReStockCantExceed, GetStockLimit( 24 ) );
                                }
                                else MsgPlr( 2, player, Lang.ReStockInvalidQuatity );
                            }
                            else MsgPlr( 2, player, Lang.ReStockQuatityNotNum );
                        }
                        else MsgPlr( 2, player, Lang.RestockPnsSyntax );
                    }
                    else MsgPlr( 2, player, Lang.NotBizOwner );
                }
                else MsgPlr( 2, player, Lang.NotInPns );
            }
            else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
        }
        else MsgPlr( 2, player, Lang.NotSpawned );
        break;

    }
}