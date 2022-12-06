/* 

	#		NPC handler.
	#		By Xmair.
	
*/

/*

	-	Things I need to make
	
		-	NPC. 					[Done]
		
			-	Health. 			[Done]
			-	Armour. 			[Done]
			-	Name.       		[Done]
			-	Can walk.   		[Done]
			-	Can follow. 		[Done]
			-	Can be attacked		[Not done]
			-	Can attack. 		[Not done]
			
		-
		
	-

*/

NPCs 					<-	{ /* ... */ }; // An empty table to hold our NPC instances in.
AutoDeleteAfterArrest 	<-	true;

class cNPC
{

	Cuff 				=	null;
	CuffTimer 			=	null;
	CuffPlayer 			=	null;
	FollowPlayer		=	null;
	
	iInstance			=	null;
	
	intType				=	0;
	intHealth			=	0;
	intArmour			=	0;
	intWorld			=	0;
	
	szName				=	"";
	
	vCurrentPosition	=	Vector( 0, 0, 0 );
	
	bStandBy			=	false;
	
	constructor( intObjectID = 6024, intHP = 100, intArm = 100, intSpawnWorld = 1, vPosition = Vector( 0, 0, 0 ), szNick = "NPC #" + NPCs.len( ).tointeger( ) + 1 )
	{
	
		::AdminMessage( "Attempt to create a NPC. Data:" );
		::AdminMessage( "Object ID: " + intObjectID + ". Health: " + intHP + ". Armour: "+ intArm + ". World: " + intSpawnWorld + ". Name: " + szNick + "." );
		this.iInstance					=	::CreateObject( intObjectID, intSpawnWorld, vPosition, 255 );
		this.iInstance.RotateByEuler( Vector( 0, 1.55, 0 ), 0 );
		this.iInstance.TrackingShots	=	true;
		this.iInstance.TrackingBumps	=	true;
		NPCs.rawset( this.iInstance.ID, this );
		this.intHealth					=	intHP;
		this.intArmour					=	intArm;
		this.intWorld					=	intSpawnWorld;
		this.vCurrentPosition			=	vPosition;
		this.szName						=	szNick;
		::AdminMessage( "Created NPC." );
	
	};

	function Move( vPosition, intTime )
	{
	
		this.vCurrentPosition			=	vPosition;
		this.iInstance.MoveTo( vPosition, intTime );
	
	};
	
	function Follow( iPlayer, intSpeed )
	{
	
		this.vCurrentPosition			=	iPlayer.Pos;
		this.iInstance.MoveTo( iPlayer.Pos, intSpeed );
		this.iInstance.RotateByEuler( Vector( 0, 0, iPlayer.Angle ), 300 );
	
	};
	
	function NearPlayer( iPlayer )
	{
	
		if ( this.iInstance.Pos.Distance( iPlayer.Pos ) <= 5 ) return true;
		else return false;
	
	};
	
	function CuffAPlayer( iPlayer )
	{

		if ( !iPlayer.Vehicle && this.NearPlayer( iPlayer ) && playa[ iPlayer.ID ].Wanted > 0 && playa[ iPlayer.ID ].Jailtime == 0 && this.Cuff == null && this.CuffTimer == null )
		{
			
			local
				intTime								=	( this.iInstance.Pos.Distance( ::GetNearestPD( this.iInstance.Pos.x, this.iInstance.Pos.y ) ) * 250 ).tointeger( );
			if ( intTime > 180000 ) intTime			=	180000;
			this.CuffTimer 							=	NewTimer( "FollowNPC", 500, 0, iPlayer.ID, this.iInstance.ID );
			this.CuffPlayer 						=	iPlayer;
			this.Cuff								=	iPlayer;
			::MsgPlr( 6, iPlayer, Lang.CuffSucessCrime );
			iPlayer.Frozen = true;
			this.iInstance.MoveTo( ::GetNearestPD( this.iInstance.Pos.x, this.iInstance.Pos.y ), intTime );
			NewTimer( "ArrestNPCSphere", intTime, 1, this.iInstance.ID )
			::AdminMessage( "NPC " + this.szName + " has cuffed " + iPlayer.Name + ". Time to reach police station: " + intTime / 1000 + " seconds." );
			
		};
	
	};

};

function ArrestNPCSphere( iNPC )
{

	local
		iNPCBackup			=	iNPC;

	if ( NPCs.rawin( iNPC ) )
	{
	
		iNPC			=	NPCs.rawget( iNPC );
		local pTarget1 = FindPlayer( iNPC.Cuff.ID );
		if ( pTarget1 )
		{

			if ( playa[ pTarget1.ID ].RobTimer ) playa[ pTarget1.ID ].RobTimer.Stop();
			playa[ pTarget1.ID ].Jailtime = GetJailTime( playa[ pTarget1.ID ].Wanted );
			MsgAll( 6, Lang.JailPlr, GetIngameTag( pTarget1 ), GetTiming( playa[ pTarget1.ID ].Jailtime ), iNPC.szName );
			EchoMessage( "3** " + pTarget1 + " has been jailed for " + GetTiming( playa[ pTarget1.ID ].Jailtime ) +  " , after being arrested by " + iNPC.szName );
			iNPC.Cuff 							=	null;
			iNPC.CuffPlayer						=	null;
			iNPC.CuffTimer.Delete( );
			iNPC.CuffTimer						=	null;
			playa[ pTarget1.ID ].Jailtimer = NewTimer( "Jail", 500, 0, pTarget1.ID );
			playa[ pTarget1.ID ].Jailtimerr = time( );
			pTarget1.World = 2;
			pTarget1.CanAttack = false;
			playa[ pTarget1.ID ].LastPos = iNPC.iInstance.Pos;
			pTarget1.Pos = Vector( -1133.94, 875.15, 996.047 );
			pTarget1.IsFrozen = false;
			SendDataToClient( 60, null, pTarget1 );
			if ( AutoDeleteAfterArrest == true )
			{
			
				iNPC.iInstance.Delete( )
				NPCs.rawdelete( iNPCBackup );
				
			};
		
		};
		
	};

};

function FollowNPC( iPlayer, iNPC )
{

	iPlayer			=	FindPlayer( iPlayer );
	
	if ( iPlayer && NPCs.rawin( iNPC ) )
	{

		iNPC			=	NPCs.rawget( iNPC ).iInstance;
		
		iPlayer.Pos.x	=	iNPC.Pos.x;
		iPlayer.Pos.y	=	iNPC.Pos.y + 2;
		iPlayer.Pos.z	=	iNPC.Pos.z;
		iPlayer.World	=	iNPC.World;
		iPlayer.Frozen 	=	true;
	
	};

};

function onObjectShot( iObject, iPlayer, intWeapon )
{

	if ( NPCs.rawin( iObject.ID ) )
	{

		local
			iNPC					=	NPCs.rawget( iObject.ID );
			
		if ( iNPC.iInstance.ID == iObject.ID )
		{
		
			local
				intDetuction			=	rand( ) % 10,
				intLeftHP				=	null;
				
			switch( GetWeaponName( intWeapon ) )
			{
			
				case "Colt .45":
				
					intDetuction		+=	5;
				
				break;
				
				case "Python":
				
					intDetuction		+=	27;
				
				break;
				
				case "Pump-Action Shotgun":
				
					intDetuction		+=	16;
				
				break;
				
				case "Stubby Shotgun":
				
					intDetuction		+=	24;
				
				break;
				
				case "SPAS-12 Shotgun":
				
					intDetuction		+=	20;
				
				break;
				
				case "TEC-9":
				case "Silenced Ingram":
				case "Uzi":
				case "MP5":
				
					intDetuction		+=	6;
				
				break;
				
				case "M4":
				
					intDetuction		+=	8;
				
				break;
				
				case "Ruger":
				
					intDetuction		+=	7;
				
				break;
				
				case "Laserscope Sniper Rifle":
				case "Sniper Rifle":
				
					intDetuction		+=	25;
				
				break;
				
				case "M60":
				
					intDetuction		+=	20;
				
				break;
				
				case "Minigun":
				
					intDetuction		=	100;
				
				break;
			
			};
			
			if ( iNPC.intArmour >= 1 ) iNPC.intArmour 	-=	intDetuction;
			else iNPC.intHealth							-=	intDetuction;
			
			if ( intDetuction > 100 ) intDetuction		=	100;
			
			intLeftHP				=	( iNPC.intHealth + iNPC.intArmour );
			if ( intLeftHP < 0 ) intLeftHP = 0
		
			if ( intLeftHP == 0 )
			{
			
				Message( "[#990000][Kill] " + ::GetIngameTag( iPlayer ) + " [#ffffff]killed [#0000FF]NPC " + iNPC.szName + " [#ffffff]with [#33cc33]" + ::GetWeaponName( intWeapon ) );
				EchoMessage( "4 " + iPlayer.Name + " killed NPC " + iNPC.szName + ". (" + GetWeaponName( intWeapon ) + ")" );
				playa[ iPlayer.ID ].Wanted ++;
				iPlayer.WantedLevel 	=	playa[ iPlayer.ID ].Wanted;
				if ( iNPC.CuffPlayer ) iNPC.CuffPlayer.Frozen = false, iNPC.CuffTimer.Delete( ), iNPC.CuffTimer = null, iNPC.Cuff = null;
				iNPC.iInstance.Delete( );
				NPCs.rawdelete( iObject.ID );
			
			};
			
			Announce( "~y~-" + intDetuction + " ~r~HP. ~r~HP left: ~y~" + intLeftHP, iPlayer, 1 );
			if ( !playa[ iPlayer.ID ].ToiToiToi )
			{
			
				MsgAll( 6, Lang.SusSucess, "[#0000FF]NPC " + iNPC.szName, GetIngameTag( iPlayer ), "Assaulting an officer" );
				EchoMessage( "3** " + iNPC.szName + " has suspected " + iPlayer.Name + " (Assaulting an officer)" );
				playa[ iPlayer.ID ].Suspect = "Assaulting an officer";
				playa[ iPlayer.ID ].AddWanted( iPlayer, 1 );
				playa[ iPlayer.ID ].ToiToiToi			=	true;
				
			}
		
		};
	
	};

};

function onObjectBump( iObject, iPlayer )
{

	if ( NPCs.rawin( iObject.ID ) )
	{
	
		local
			iNPC					=	NPCs.rawget( iObject.ID );
			
		if ( iNPC.iInstance.ID == iObject.ID )
		{
		
			if ( !iPlayer.Vehicle ) iNPC.CuffAPlayer( iPlayer );
			else
			{
			
				local
					intDetuction	=	rand( ) % 30 + 1,
					intLeftHP		=	null;
					
				if ( iNPC.intArmour >= 1 ) iNPC.intArmour 	-=	intDetuction;
				else iNPC.intHealth							-=	intDetuction;
			
				intLeftHP				=	( iNPC.intHealth + iNPC.intArmour );
				if ( intLeftHP < 0 ) intLeftHP = 0
				
				if ( intLeftHP == 0 )
				{
			
					Message( "[#990000][Kill] " + ::GetIngameTag( iPlayer ) + " [#ffffff]killed [#0000FF]NPC " + iNPC.szName + " [#ffffff]with a [#33cc33]" + ::GetVehicleNameFromModel( iPlayer.Vehicle.Model ) + "." );
					EchoMessage( "4 " + iPlayer.Name + " killed NPC " + iNPC.szName + ". (" + GetVehicleNameFromModel( iPlayer.Vehicle.Model ) + ")" );
					playa[ iPlayer.ID ].Wanted ++;
					iPlayer.WantedLevel 	=	playa[ iPlayer.ID ].Wanted;
					if ( iNPC.CuffPlayer ) iNPC.CuffPlayer.Frozen		=	false, iNPC.CuffTimer.Delete( ), iNPC.CuffTimer = null, iNPC.Cuff = null;
					iNPC.iInstance.Delete( );
					NPCs.rawdelete( iObject.ID );
				
				};
			
				Announce( "~y~-" + intDetuction + " ~r~HP. ~r~HP left: ~y~" + intLeftHP, iPlayer, 1 );
				
				if ( !playa[ iPlayer.ID ].ToiToiToi )
				{
				
					MsgAll( 6, Lang.SusSucess, "[#0000FF]NPC " + iNPC.szName, GetIngameTag( iPlayer ), "Ramming an officer" );
					EchoMessage( "3** " + iNPC.szName + " has suspected " + iPlayer.Name + " (Ramming an officer)" );
					playa[ iPlayer.ID ].Suspect = "Ramming an officer";
					playa[ iPlayer.ID ].AddWanted( iPlayer, 1 );
					playa[ iPlayer.ID ].ToiToiToi		=	true;
				
				}
			
			};
		
		};
	
	};

};

function GetNearestPD( PosX, PosY )
{

	switch( GetDistrictName( PosX, PosY ) )
	{
	
		case "Viceport":
		case "Little Havana":
		case "Little Haiti":
		
			return Vector( -877.96, -678.159, 11.2101 );
			
		break;
			
		case "Downtown Vice City":
	   
			return Vector( -661.222, 767.597, 11.1652 );
			
		break;
			
		case "Prawn Island":
		case "Vice Point":
		
			return Vector( 501.397, 512.665, 11.4859 );
			
		break;
			
		case "Ocean Beach":
		case "Starfish Island":
		case "Washington Beach":
		
			return Vector( 405.916, -477.516, 10.0662 );
			
		break;
			
		default:
			
			return Vector( 405.916, -477.516, 10.0662 );
			
		break;
		
	}
}
