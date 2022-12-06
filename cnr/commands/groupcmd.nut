function onGroupCommand( player, cmd, text )
{
	//local Lang = Lang;
	
	if( cmd == "creategroup" )
	{
		if( playa[ player.ID ].Admin < 2 ) MsgPlr( 2, player, Lang.CmdInvalid );
		else if( !text ) MsgPlr( 2, player, Lang.gCreategroupSyntax );
		else
		{
			local founder = GetTok( text, " ", 1 ), type = GetTok( text, " ", 2 ), gang = GetTok( text, " ", 3, NumTok( text, " " ) );
			local types = [ "normal", "gang" ];
			if( !founder || !gang || !type ) MsgPlr( 2, player, Lang.gCreategroupSyntax );
			else if( ::FindGang( gang ) == true ) MsgPlr( 2, player, Lang.gAlreadyExist );
			else if( types.find( type ) == null ) MsgPlr( 2, player, Lang.gWrongType );
			else
			{
				Msg.AdminAll( Lang.Adminv2CreateNewGroup, playa[ player.ID ].Rank, player.Name, gang );
				::GangCreate( gang, founder, type );
			}
		}
	}

    else if( cmd == "groupinfo" )
    {
		local group = text;
		if( !group ) MsgPlr( 2, player, Lang.gInfoSyntax );
		else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
		else
		{
			MsgPlr( 3, player, Lang.gInfo, group, gangv2[ group ].Name, gangv2[ group ].Type, player );
			if( gangv2[ group ].Description != "(null : 0x0000000000000000)" ) MsgPlr( 3, player, Lang.gInfo1, group, gangv2[ group ].Description, player );
		}
    }

    else if( cmd == "groupmembers" )
    {
		local group = text;
		if( !group ) MsgPlr( 2, player, Lang.gMembersSyntax );
		else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
		else
		{
			foreach( kiki in gangv2[ group ].Rank )
			{
				local a = null;
				foreach( b in gangv2[ group ].Members )
				{
					if( b.Rank == kiki.Name ) 
					{
						if( a ) a = a + ", " + mysqldb.GetNameFromID( b.Name );
						else a = mysqldb.GetNameFromID( b.Name );
					}
				}
				if( a ) /* MsgPlr( 3, player, Lang.gMember, kiki.Name, a, group, player ); */ MsgPlr( 3, player, Lang.gMember, kiki.Name, a, group );
			}
		}
    }

    else if( cmd == "groupranks" )
    {
		if( !text ) MsgPlr( 2, player, Lang.gRankSyntax );
		else 
		{
			local group = GetTok( text, " ", 1 );
			if( !group ) MsgPlr( 2, player, Lang.gRankSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else
			{
				foreach( kiki in gangv2[ group ].Rank )
				{
					//MsgPlr( 3, player, Lang.gRank, kiki.Name, kiki.Level.tostring() group, player );
					MsgPlr( 3, player, Lang.gRank, kiki.Name, kiki.Level.tostring() );
				}
			}
		}
    }
    
    else if( cmd == "groupjoin" )
    {
        local group = text;
		if( !group ) MsgPlr( 2, player, Lang.gJoinSyntax );
		else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
		else if( playa[ player.ID ].GroupPending.find( group ) == null ) MsgPlr( 2, player, Lang.gNoInvite );
		else if( playa[ player.ID ].Group.find( group ) >= 0 ) MsgPlr( 2, player, Lang.gAlreadyIn );			
		else
		{
			::GangInsertMember( group, playa[ player.ID ].ID, "default" );
			playa[ player.ID ].Group.push( group );
					
			MsgGangAll( group, Lang.gJoined, player.Name );
			SaveGroupData( group );
			playa[ player.ID ].GroupPending = "";
		}
    }

    else if( cmd == "groupleave" )
    {
		local group = text;
		if( !group ) MsgPlr( 2, player, Lang.gLeaveSyntax );
		else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
		else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
		else
		{
			MsgGangAll( group, Lang.gLeave, player.Name );
					
			::GangRemoveMember( group, playa[ player.ID ].ID );
			playa[ player.ID ].Group.remove( playa[ player.ID ].Group.find( group ) );
					
            SaveGroupData( group );
		}
    }

    else if( cmd == "groupinvite" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gInviteSyntax );
        else 
        {
            local group = GetTok( text, " ", 1 ), plr = GetTok( text, " ", 2 );
            if( !group || !plr ) MsgPlr( 2, player, Lang.gInviteSyntax );
            else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
            else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
            else if( ::GangGetLevelFromRank( group, gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.ganginvite.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
            else
            {
                plr = FindPlayer( plr );
                if( !plr )  MsgPlr( 2, player, Lang.UnknownPlr );
                else if( playa[ plr.ID ].Level == 0 ) MsgPlr( 2, player, Lang.UnknownPlr );
                else if( playa[ plr.ID ].Logged == false ) MsgPlr( 2, player, Lang.UnknownPlr );
                else if( playa[ plr.ID ].GroupPending.find( group ) >= 0 ) MsgPlr( 2, player, Lang.gAlreadyInvite );
                else if( playa[ plr.ID ].Group.find( group ) >= 0 ) MsgPlr( 2, player, Lang.gInviteAlreadyIn );			
                else
                {
                    playa[ plr.ID ].GroupPending = group;

                    MsgGangAll( group, Lang.gInvite, player.Name, plr.Name );
                            
                    MsgPlr( 3, plr, Lang.gGotInvite, player.Name, gangv2[ group ].Name, group );
                    MsgPlr( 3, player, Lang.gSendInvite, plr.Name );
                }
            }
        }
    }

    else if( cmd == "groupkick" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gKickSyntax );
        else 
        {
            local group = GetTok( text, " ", 1 ), plr = GetTok( text, " ", 2 );
            if( !group || !plr ) MsgPlr( 2, player, Lang.gKickSyntax );
            else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
            else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );			
            else if( ::GangGetLevelFromRank( group, gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangkick.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
            else
            {
                plr = FindPlayer( plr );
                if( !plr ) MsgPlr( 2, player, Lang.GotoInvalidPlr ); 
                else if( playa[ plr.ID ].Level == 0 ) MsgPlr( 2, player, Lang.UnknownPlr );
                else if( playa[ plr.ID ].Logged == false ) MsgPlr( 2, player, Lang.UnknownPlr );
                else if( playa[ plr.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gPlrNotIn );			
                else
                {
                    ::GangRemoveMember( group, playa[ plr.ID ].ID );
                    playa[ plr.ID ].Group.remove( playa[ plr.ID ].Group.find( group ) );
                    MsgGangAll( group, Lang.gKick, player.Name, plr.Name );
                    MsgPlr( 3, plr, Lang.gGetKicked, group, player.Name, group, plr );
                    SaveGroupData( group );
                }
            }
        }
    }

    else if( cmd == "groupaddrank" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gAddRankSyntax );
        else 
        {
		    local group = GetTok( text, " ", 1 ), rank = GetTok( text, " ", 2 ), rankname = GetTok( text, " ", 3, NumTok( text, " " ) );
			if( !group || !rank || !rankname ) MsgPlr( 2, player, Lang.gAddRankSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangsetaddrank.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else if( ::GangFindRank( group, rankname ) != null ) MsgPlr( 2, player, Lang.gRankExist, player )
			else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
			else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
			else
			{
				::GangCreateNewRank( group, rankname, rank );
				MsgGangAll( group, Lang.gAddRank, player.Name, rankname );
				MsgPlr( 3, player, Lang.gAddRankP, rankname, rank );
				SaveGroupData( group );
			}
        }
    }

    else if( cmd == "groupdelrank" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gDelRankSyntax );
        else 
        {
			local group = GetTok( text, " ", 1 ), rankname = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( !group || !rankname ) MsgPlr( 2, player, Lang.gDelRankSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangdeleterank.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else if( ::GangFindRank( group, rankname ) == null ) MsgPlr( 2, player, Lang.gRankNotExist, player )
			else
			{
				::GangRemoveRank( group, rankname );
				MsgGangAll( group, Lang.gDelRank, player.Name, rankname );
				MsgPlr( 3, player, Lang.gDelRankP, rankname );
				SaveGroupData( group );
			}
        }
    }

    else if( cmd == "groupeditranklevel" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gSetRankSyntax );
        else 
        {
			local group = GetTok( text, " ", 1 ), rank = GetTok( text, " ", 2 ), rankname = GetTok( text, " ", 3, NumTok( text, " " ) );
			if( !group || !rank || !rankname ) MsgPlr( 2, player, Lang.gSetRankSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group, gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangsetrank.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else if( ::GangFindRank( group, rankname ) == null ) MsgPlr( 2, player, Lang.gRankNotExist, player )
			else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
			else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
			else
			{
				gangv2[ group ].Rank[ GangFindRank( group, rankname ) ].Level = rank.tointeger();
				MsgGangAll( group, Lang.gChangeRankLevel, player.Name, rankname, rank );
				MsgPlr( 3, player, Lang.gCCRankP, rankname, rank );
				SaveGroupData( group );
			}
        }
    }

    else if( cmd == "groupeditperm" || cmd == "groupeditpermission" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gChangePermSyntaxOne );
        else 
        {
			local group = GetTok( text, " ", 1 ), perm = GetTok( text, " ", 2 ), rank = GetTok( text, " ", 3 );
			if( !group || !perm ) MsgPlr( 2, player, Lang.gChangePermSyntaxOne );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangsetcmdlevel.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else
			{
				switch( perm )
				{
					case "bank":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "Group Bank", gangv2[ group ].Permission.gangchat.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangchat = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "Group Bank", rank );	
						SaveGroupData( group );
					}
					break;

					case "description":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "description", gangv2[ group ].Permission.gangdescription.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangdescription = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "description", rank );	
						SaveGroupData( group );
					}
					break;

					case "kick":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm, player ), MsgPlr( 2, player, Lang.gCurrentLevel, "kick", gangv2[ group ].Permission.gangkick.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangkick = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "kick", rank );		
						SaveGroupData( group );
					}
					break;

					case "setplayerrank":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "setplayerrank", gangv2[ group ].Permission.gangsetplayerrank.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangsetplayerrank = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "setplayerrank", rank );			
						SaveGroupData( group );
					}
					break;

					case "addrank":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "addrank", gangv2[ group ].Permission.gangsetaddrank.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangsetaddrank = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "addrank", rank );	
						SaveGroupData( group );
					}
					break;

					case "delrank":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "delrank", gangv2[ group ].Permission.gangdeleterank.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangdeleterank = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "delrank", rank );	
						SaveGroupData( group );
					}
					break;

					case "usevehicle":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "Use Vehicle", gangv2[ group ].Permission.ganglock.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.ganglock = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "Use Vehicle", rank );
						SaveGroupData( group );						
					}
					break;

					case "invite":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "invite", gangv2[ group ].Permission.ganginvite.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.ganginvite = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "invite", rank );		
						SaveGroupData( group );
					}
					break;

					case "setpermission":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "setpermission", gangv2[ group ].Permission.gangsetcmdlevel.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangsetcmdlevel = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "setpermission", rank );	
						SaveGroupData( group );
					}
					break;

					case "hqstorage":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "HQ Storage", gangv2[ group ].Permission.ganghousemanage.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.ganghousemanage = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "HQ Storage", rank );	
						SaveGroupData( group );
					}
					break;

					case "changeranklevel":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "changeranklevel", gangv2[ group ].Permission.gangsetrank.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangsetrank = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "changeranklevel", rank );	
						SaveGroupData( group );
					}
					break;

					case "vehiclemanage":
					if( !rank ) MsgPlr( 2, player, Lang.gChangePermSyntax, perm ), MsgPlr( 2, player, Lang.gCurrentLevel, "Manage Vehicle", gangv2[ group ].Permission.ganghousemanage.tostring() );
					else if( !::IsNum( rank ) ) MsgPlr( 2, player, Lang.gRankNotNum );
					else if( rank.tointeger() > 100 || rank.tointeger() < 0 ) MsgPlr( 2, player, Lang.gRankBetween0n100 );
					else
					{
						gangv2[ group ].Permission.gangchangecolor = rank.tointeger();
						MsgPlr( 3, player, Lang.gNewLevel, "Manage Vehicle", rank );	
						SaveGroupData( group );
					}
					break;

					default: MsgPlr( 2, player, Lang.gChangePermSyntaxOne ); break;				
				}
			}
        }
    }
	
    else if( cmd == "groupsetplayerrank" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gSetPlrSyntax );
        else 
        {
			local group = GetTok( text, " ", 1 ), plr = GetTok( text, " ", 2 ), rankname = GetTok( text, " ", 3, NumTok( text, " " ) );
			if( !group || !plr || !rankname ) MsgPlr( 2, player, Lang.gSetPlrSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangsetplayerrank.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else
			{
				local plr1 = FindPlayer( plr );
				if( !plr1 ) MsgPlr( 2, player, Language[0].GotoInvalidPlr ); 
				else if( playa[ plr1.ID ].Level == 0 ) MsgPlr( 2, player, Lang.UnknownPlr );
				else if( playa[ plr1.ID ].Logged == false ) MsgPlr( 2, player, Lang.UnknownPlr );
				else if( playa[ plr1.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gPlrNotIn );			
				else if( ::GangFindRank( group, rankname ) == null ) MsgPlr( 2, player, Lang.gRankNotExist ); 
				else if( gangv2[ group ].Members[ ::GangFindMember( group, playa[ plr1.ID ].ID ) ].Rank == rankname ) MsgPlr( 2, player, Lang.gPlrSameRank );
				else
				{
					gangv2[ group ].Members[ ::GangFindMember( group, playa[ plr1.ID ].ID ) ].Rank = rankname;
					MsgGangAll( group, Lang.gChangePlayerRank, player.Name, plr1.Name, rankname );
					MsgPlr( 3, player, Lang.gChangeRankPls, plr1.Name, rankname );
					SaveGroupData( group );
				}
		    }
        }
	}


    else if( cmd == "groupdescription" )
    {
        if( !text ) MsgPlr( 2, player, Lang.gDesSyntax );
        else 
        {
			local group = GetTok( text, " ", 1 ), rankname = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( !group || !rankname ) MsgPlr( 2, player, Lang.gDesSyntax );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn );
			else if( ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, playa[ player.ID ].ID ) ].Rank ) < gangv2[ group ].Permission.gangdescription.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd );
			else
			{
				gangv2[ group ].Description = rankname;
				MsgPlr( 3, player, Lang.gDescription );
				SaveGroupData( group );
			}
        }
    }
	/*else if( cmd == "gm" )
	{
		if( !text ) MsgPlr( 2, player, Lang.gChatSyntaxWithoutGroup ) );
		else
		{
			local group = GetTok( text, " ", 1 ), rankname = GetTok( text, " ", 2, NumTok( text, " " ) );
			if( psetting[ player.ID ].GroupChat == "x" && !group ) MsgPlr( 2, player, Lang.gChatSyntaxWithoutGroup ) );
			else if( psetting[ player.ID ].GroupChat != "x" && !text ) MsgPlr( 2, player, Lang.gChatSyntax ) );
			else if( psetting[ player.ID ].GroupChat == "x" && ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist ) );
			else if( psetting[ player.ID ].GroupChat == "x" &&  playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn ) );
			else if( psetting[ player.ID ].GroupChat == "x" && ::GangGetLevelFromRank( group,gangv2[ group ].Members[ ::GangFindMember( group, player.Name ) ].Rank ) < gangv2[ group ].Permission.gangchat.tointeger() ) MsgPlr( 2, player, Lang.gCantChat ) );
			else if( psetting[ player.ID ].GroupChat != "x" && ::FindGang( psetting[ player.ID ].GroupChat ) == false ) MsgPlr( 2, player, Lang.gNotExist ) );
			else if( psetting[ player.ID ].GroupChat != "x" &&  playa[ player.ID ].Group.find( psetting[ player.ID ].GroupChat ) == null ) MsgPlr( 2, player, Lang.gNotIn ) );
			else if( psetting[ player.ID ].GroupChat != "x" && ::GangGetLevelFromRank( psetting[ player.ID ].GroupChat,gangv2[ psetting[ player.ID ].GroupChat ].Members[ ::GangFindMember( psetting[ player.ID ].GroupChat, player.Name ) ].Rank ) < gangv2[ psetting[ player.ID ].GroupChat ].Permission.gangchat.tointeger() ) MsgPlr( 2, player, Lang.gCantChat ) );
			else
			{
				if( psetting[ player.ID ].GroupChat == "x" )
				{
					local getText = GetTok( text, " ", 2, NumTok( text, " " ) );
					MsgGangAll( group, Lang.GangChat, player.Name, getText ) );
					AdminMessage( "6[" + group + "] " + player.Name + ": " + text.slice( 1 ) );
					FBIWire( "**[" + group + "] " + player.Name + "** . **Message** " + text.slice( 1 ), "group" );
				}
				
				else 
				{
					MsgGangAll( group, Lang.GangChat, player.Name, text ), psetting[ player.ID ].GroupChat );
					AdminMessage( "6[" + psetting[ player.ID ].GroupChat + "] " + player.Name + ": " + text );
					FBIWire( "**[" + psetting[ player.ID ].GroupChat + "] " + player.Name + "** . **Message** " + text, "group" );
				}
			}
		}
	}

	else if( cmd == "setgm" )
	{
		if( !text ) MsgPlr( 2, player, Lang.gSetgmSyntax ) );
		else
		{
			switch( text )
			{
				case "none":
				psetting[ player.ID ].GroupChat = "x";
				MsgPlr( 3, player, Lang.gSetGmNone, text ) );
				break;
				
				default:
				if( ::FindGang( text ) == false ) MsgPlr( 2, player, Lang.gNotExist ) );
				else if( playa[ player.ID ].Group.find( text ) == null ) MsgPlr( 2, player, Lang.gNotIn ) );
				else
				{
					psetting[ player.ID ].GroupChat = text;
					MsgPlr( 3, player, Lang.gSetGm, text ) );
				}
			}
		}
	}

	else if ( cmd == "setgrouphouse" )
	{
		if( !player.IsSpawned ) MsgPlr( 2, player, Language[0].CmdNoSpawn ) );
		else if( player.Vehicle ) MsgPlr( 2, player, Language[0].CmdInvehicle ) );
		else if( playa[ player.ID ].Interior == null ) MsgPlr( 2, player, Language[0].CmdNotInInterior ) );
		else if( playa[ player.ID ].Event > 0 ) MsgPlr( 2, player, Language[0].CmdIsOnEvent ) );
		else if( !text ) MsgPlr( 2, player, Lang.gSetGHouseSyntax ) );
		else
		{
			local verify_house = split( pickup[ playa[ player.ID ].Interior ].Type, " " );
			if( verify_house[0] != "2" ) MsgPlr( 2, player, Language[0].HouseNotAHouse ) ); 
			else if( pickup[ playa[ player.ID ].Interior ].Owner != player.Name ) MsgPlr( 2, player, Language[0].HouseNotOwner ) );
			else if( ::FindGang( text ) == false ) MsgPlr( 2, player, Lang.gNotExist ) );
			else if( playa[ player.ID ].Group.find( text ) == null ) MsgPlr( 2, player, Lang.gNotIn ) );
			else if( ::GangGetLevelFromRank( text ,gangv2[ text ].Members[ ::GangFindMember( text, player.Name ) ].Rank ) < gangv2[ text ].Permission.ganghousemanage.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd ) );
			else
			{
				local ID = playa[ player.ID ].Interior;
						
				pickup[ ID ].Owner = text + " (Group)";
					
				MsgGangAll( group, Lang.gAddGangHouse, player.Name, pickup[ ID ].Name ), text );
				MsgPlr( 3, player, Lang.gAddGangHousePlayer, pickup[ ID ].Name ) );
				
				::SaveThePickup( playa[ player.ID ].Interior );
			}
		}
	}

	else if( cmd == "remgrouphouse" )
	{
		if( !player.IsSpawned ) MsgPlr( 2, player, Language[0].CmdNoSpawn ) );
		else if( player.Vehicle ) MsgPlr( 2, player, Language[0].CmdInvehicle ) );
		else if( playa[ player.ID ].Interior == null ) MsgPlr( 2, player, Language[0].CmdNotInInterior ) );
		else if( playa[ player.ID ].Event > 0 ) MsgPlr( 2, player, Language[0].CmdIsOnEvent ) );
		else
		{
			local verify_house = split( pickup[ playa[ player.ID ].Interior ].Type, " " ), group = Misc.ReplaceChar( pickup[ playa[ player.ID ].Interior ].Owner, " (Group)", "" );
			if( verify_house[0] != "2" ) Msg.Warn( format(Language[0].HouseNotAHouse ) ); 
			else if(::IsGangHouse( player, playa[ player.ID ].Interior ) == false  ) MsgPlr( 2, player, Lang.gNotGroupHouse ) );
			else if( ::FindGang( group ) == false ) MsgPlr( 2, player, Lang.gNotExist ) );
			else if( playa[ player.ID ].Group.find( group ) == null ) MsgPlr( 2, player, Lang.gNotIn ) );
			else if( ::GangGetLevelFromRank( group ,gangv2[ group ].Members[ ::GangFindMember( group, player.Name ) ].Rank ) < gangv2[ group ].Permission.ganghousemanage.tointeger() ) MsgPlr( 2, player, Lang.gNotAllowedCmd ) );
			else
			{
				local ID = playa[ player.ID ].Interior;
						
				pickup[ ID ].Owner = player.Name;
					
				MsgGangAll( group, Lang.gARemGangHouse, player.Name, pickup[ ID ].Name ) );
				MsgPlr( 3, player, Lang.gRemGangHousePlayer, pickup[ ID ].Name ) );
				
				::SaveThePickup( playa[ player.ID ].Interior );
			}
		}
	}*/
	
	else if( cmd == "groups" )
	{
		if( text )
		{
			local plr = FindPlayer( GetTok( text, " ", 1 ) ), reason = GetTok( text, " ", 2 );
			if( !plr ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( playa[ plr.ID ].Logged == false ) MsgPlr( 2, player, Lang.UnknownPlr );
			else if( playa[ plr.ID ].Level == 0 ) MsgPlr( 2, player, Lang.UnknownPlr );
			else
			{
				local group = GangPlayerLoad( playa[ plr.ID ].ID );
				
				if( group.len() == 0 ) MsgPlr( 3, player, Lang.gNotGroupFound );
				else
				{
					MsgPlr( 3, player, Lang.gGroup, playa[ plr.ID ].ID );

					foreach( kiki in group )
					{
						if( !FindGang( kiki ) ) continue;
						
						MsgPlr( 3, player, Lang.gGroupFound, gangv2[ kiki ].Name,  ( gangv2[ kiki ].Members[ kiki ].Members[ ::GangFindMember( kiki, playa[ plr.ID ].ID ) ].Rank == "default" ) ? "None" : gangv2[ kiki ].Members[ ::GangFindMember( kiki,playa[ plr.ID ].ID ) ].Rank );
					}
				}
			}
		}
		else
		{
			local group = GangPlayerLoad( playa[ player.ID ].ID );
				
			if( group.len() == 0 ) MsgPlr( 3, player, Lang.gNotGroupFound );
			else
			{
				MsgPlr( 3, player, Lang.gGroupOwn );

				foreach( kiki in group )
				{
					if( !FindGang( kiki ) ) continue;
						
					MsgPlr( 3, player, Lang.gGroupFound, gangv2[ kiki ].Name, ( gangv2[ kiki ].Members[ ::GangFindMember( kiki, playa[ player.ID ].ID ) ].Rank == "default" ) ? "None" : gangv2[ kiki ].Members[ ::GangFindMember( kiki, playa[ player.ID ].ID ) ].Rank );
				}
			}
		}
	}
	
	else if( cmd == "creategang" )
	{
		MsgPlr( 2, player, Lang.gCannotCreateGang );
	}
}