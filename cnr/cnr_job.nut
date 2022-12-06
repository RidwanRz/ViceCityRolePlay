
function IsJobAllowRadio( player )
{
    switch( playa[ player.ID ].Job.JobID )
    {
     //   case 1:
        case 2:
        case 3:
        case 4:
        case 5:

        return true;
    }
}

function PDOrMedicHighrankCmd( player, cop, fbi, medic )
{
	if( playa[ player.ID ].Job.JobID == 3 && playa[ player.ID ].Job.PDLevel >= cop ) return true;
	if( playa[ player.ID ].Job.JobID == 4 ) return true;
	if( playa[ player.ID ].Job.JobID == 5 && playa[ player.ID ].Job.FBILevel >= fbi ) return true;
	if( playa[ player.ID ].Job.JobID == 2 && playa[ player.ID ].Job.MedicLevel >= medic ) return true;
}

function QuitJob( player )
{
    switch( playa[ player.ID ].Job.JobID )
    {
        case 1:
        QuitTruckerDuty( player );
        break;
        
        case 3:
        case 4:
        case 5: 
        QuitLawDuty( player );
        break;

        case 2:
        QuitEMSDuty( player );
        break;
    }
}

function GiveJobBasepaycheck( player )
{
    local paycheck = 0;
    switch( playa[ player.ID ].Job.JobID )
    {
        case 1:
        paycheck = 500;
        break;

        case 2:
        paycheck = 1000;
        break;

        case 3:
        case 4:
        if( playa[ player.ID ].Job.PDLevel > 2 ) paycheck = 1500;
        else paycheck = 1000;
        break;

        case 5:
        paycheck = 2000;
        break;
    }

    playa[ player.ID ].Paycheck += paycheck;
}

function IsAllowToMegaphone( player )
{
    if( player.Vehicle )
    {
        local verify = vehicle.rawin( player.Vehicle.ID );
	
	    if( !verify ) return 1;

		if( vehicle[ player.Vehicle.ID ].Owner.find( "Group:" ) >= 0 )
		{
			local getname = split( vehicle[ player.Vehicle.ID ].Owner, ":" );

			switch( getname[1] )
			{
				case "EMS":
                if( playa[ player.ID ].Job.JobID == 2 ) return true;
				break;

				case "VCPD":
				case "SWAT":
				case "FBI":
                if( IsLawE( player ) ) return true;
				break;
			}
        }

    }
}