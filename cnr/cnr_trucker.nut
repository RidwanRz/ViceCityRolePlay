function AddTruckerItem( player, items )
{
	local splititem = split( items, "-" ),
	getpreweight = SearchAndReplace( splititem[1], "Weight:", "" ),
	getweight = split( getpreweight, "Reward" )[0],
	getprereward = SearchAndReplace( splititem[1], "Reward: $", "" ),
	getreward = split( getprereward, " " )[3],
	getpreloc = SearchAndReplace( splititem[1], "Location: ", "" ),
	getlocation = GetTok( getpreloc, " ", 6, NumTok( getpreloc, " " ) );

    if( player.Vehicle )
    {
        if( ( CalcTruckWeight( player ) + getweight.tointeger() ) < 200 )
        {
            local getID = ( vehicle[ player.Vehicle.ID ].TruckerInvent.len() + 1 );

            vehicle[ player.Vehicle.ID ].TruckerInvent.rawset( getID,
            {
                ItemName = splititem[0],
                Price = getreward.tointeger(),
                Location = getlocation,
                Weight = getweight.tointeger(),
            });
            SendDataToClient( 9604, items, player );

            if( CalcTruckWeight( player ) > 150 ) MsgPlr( 2, player, Lang.TruckAboveLegalWeight );
        }
        else SendDataToClient( 9601, "You cannot pick this cargo", player );
    }
}

function CalcTruckWeight( player )
{
    local result = 0;

    if( player.Vehicle )
    {
        foreach( index, value in vehicle[ player.Vehicle.ID ].TruckerInvent )
        {
            result += value.Weight;
        }
    }

    return result;
}

function TruckerDeliver( player, sphere )
{
    if( player.Vehicle )
    {
        foreach( index, value in vehicle[ player.Vehicle.ID ].TruckerInvent )
        {
            if( sphere == value.Location )
            {
                MsgPlr( 3, player, Lang.TruckerDeliver, value.ItemName, value.Price );

                playa[ player.ID ].Paycheck += value.Price;

                vehicle[ player.Vehicle.ID ].TruckerInvent.rawdelete( index );   
            }
        }
    }
}


function GenerateTruckItem( currentstation )
{
    local getitem = [];

    for( local i = 0; i < 6; ++i )
    {
        local item = [ "Dildo", "Gun Part", "Electornic Part", "Waifu Pillow", "Pet Food", "Meat", "Paint", "Furniture", "Motherboard", "Eggs", "iPhone 7", "Catgirl Custome", "RTX 3090", "Ryzen Threadripper", "Used Computer" ],
        genitem = item[ rand() % item.len() ],
        genwei = ( rand() % 9 ) + "" + ( rand() % 9 ),
        weight = genwei.tointeger(),
        genred = ( rand() % 9 ) + "" + ( rand() % 9 ) + "" + ( rand() % 9 ),
        reward = genred.tointeger(),
        getstation = "";

        switch( currentstation )
        {
            case "TruckerVicePoint":
            local station = [ "TruckerDowntown", "TruckerVicePort", "TruckerHavana" ];

            getstation = station[ rand() % station.len() ];
            break;

            case "TruckerDowntown":
            local station = [ "TruckerVicePoint", "TruckerVicePort", "TruckerHavana" ];

            getstation = station[ rand() % station.len() ];
            break;

            case "TruckerHavana":
            local station = [ "TruckerDowntown", "TruckerVicePoint", "TruckerVicePort" ];

            getstation = station[ rand() % station.len() ];
            break;

            case "TruckerVicePort":
            local station = [ "TruckerVicePoint", "TruckerHavana", "TruckerDowntown" ];

            getstation = station[ rand() % station.len() ];
            break;
        }

        getitem.push( 
        {
            Item = genitem,
            Weight = weight,
            Reward = reward,
            Station = getstation,
        });
    }

    return getitem;
}

function DeliverSphere( player, sphere )
{
    if( playa[ player.ID ].Job.JobID == 1 )
    {
        if( player.Vehicle )
        {
            local getopp = ( player.Vehicle.GetOccupant( 0 ) == null ) ? -1 : player.Vehicle.GetOccupant( 0 ).ID;
            local getplr = ( FindPlayer( getopp ) == null ) ? null : FindPlayer( getopp ).ID;

            if( getplr == player.ID )
            {
                if( vehicle[ player.Vehicle.ID ].Owner.find( "Job:" ) >= 0 )
                {
                    local getname = split( vehicle[ player.Vehicle.ID ].Owner, ":" );

                    if( getname[1] == "Trucker" )
                    {
                        TruckerDeliver( player, sphere );

                        local generateItem = GenerateTruckItem( sphere );

                        SendDataToClient( 9600, "", player );

                        foreach( index, value in generateItem )
                        {
                            SendDataToClient( 9603, value.Item + " - Weight: " + value.Weight + " Reward: $" + value.Reward + " Location: " + value.Station, player );
                        }
                    }
                    else MsgPlr( 2, player, Lang.TruckerNotInRightVehicle );
                }
                else MsgPlr( 2, player, Lang.TruckerNotInRightVehicle );
            }
            else MsgPlr( 2, player, Lang.TruckerNotInRightVehicle );
        }
        else MsgPlr( 2, player, Lang.TruckerNotInRightVehicle );
    }
    else MsgPlr( 2, player, Lang.NotTrucker );
}

function OnTruckerDuty( player )
{
	playa[ player.ID ].Job.JobID = 1;

	SendDataToClient( 9702, "", player );

	MsgPlr( 3, player, Lang.OnTruckerDuty );	
}

function QuitTruckerDuty( player )
{
	playa[ player.ID ].Job.JobID = 0;

	MsgPlr( 3, player, Lang.QuitJob );

	SendDataToClient( 9202, "", player );
}
