function onAnimCmd( player, cmd , text )
{
	if( playa[ player.ID ].Logged == false ) return MsgPlr( 2, player, Lang.InvalidCmd );
	else 
    {
        switch( cmd.tolower() )
        {
            case "sur":
            if( player.IsSpawned )
            {
                if( !playa[ player.ID ].Knocked.IsKnocked )
                {
                    player.SetAnim( 0, 161 );
                }
                else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
            }
            else MsgPlr( 2, player, Lang.NotSpawned );
            break;

            case "sit":
            if( player.IsSpawned )
            {
                if( !playa[ player.ID ].Knocked.IsKnocked )
                {
                    player.SetAnim( 0, 167 );
                }
                else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
            }
            else MsgPlr( 2, player, Lang.NotSpawned );
            break;

            case "talk":
            case "buy":
            if( player.IsSpawned )
            {
                if( !playa[ player.ID ].Knocked.IsKnocked )
                {
                    player.SetAnim( 0, 167 );
                }
                else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
            }
            else MsgPlr( 2, player, Lang.NotSpawned );
            break;

            case "fu":
            if( player.IsSpawned )
            {
                if( !playa[ player.ID ].Knocked.IsKnocked )
                {
                    player.SetAnim( 0, 163 );
                }
                else MsgPlr( 2, player, Lang.CantUseCmdKnocked );
            }
            else MsgPlr( 2, player, Lang.NotSpawned );
            break;

            
        }
    }
}
