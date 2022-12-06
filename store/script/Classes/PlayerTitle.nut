class CPTitle extends CContext
{
	Players = null;

	function constructor( Key )
	{
		base.constructor();

		this.Players = {};
	}

	function AddPlayer( player, text )
	{
		if( !this.Players.rawin( player ) )
		{
			local element = GUILabel();
			
			element.Alpha = 255;
			element.TextColour = Colour( 255, 255, 255 );
			element.FontSize = ( GUI.GetScreenSize().X * 0.0073206442166911 );
			element.TextAlignment = GUI_ALIGN_LEFT;
			element.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			element.AddFlags( GUI_FLAG_TEXT_TAGS );
			element.FontName = "Tahoma";
			element.Text = text;

			this.Players.rawset( player, 
			{
				Element = element,
			});
		}
		else this.Players[ player ].Element.Text = text;
	}
	
	function RemovePlayer( index )
	{
		if( this.Players.rawin( index ) ) this.Players.rawdelete( index );
	}

	function onScriptProcess() 
	{
		local lplayer = World.FindLocalPlayer(), sender;
		local lpos = lplayer.Position, spos;
		local lbl, wpts, z1 = Vector( 0, 0, 0.5 );
		
		foreach( index, value in this.Players )
		{
			sender = World.FindPlayer( index );
			if( sender )
			{
	            local player = World.FindLocalPlayer(), ppos = player.Position, vehpos = sender.Position;

	            if( player.ID != sender.ID )
	            {
		            if( Distance( ppos.X, ppos.Y, ppos.Z, vehpos.X, vehpos.Y, vehpos.Z ) < 5 )
		            {
		                local screenpos = GUI.WorldPosToScreen( vehpos + z1 );
						local alpha = 255;
						
						if( screenpos.Z > 1 ) alpha = 0;

		                value.Element.Alpha = alpha;

		                value.Element.Position = VectorScreen( screenpos.X - 20, screenpos.Y ); 
		            }
		            else value.Element.Alpha = 0;
		        }
		        else value.Element.Alpha = 0;
			}
			else value.Element.Alpha = 0;
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 1030:
			local sp = split( str, ";" );
			this.AddPlayer( sp[0].tointeger(), ( sp.len() > 1 ) ? sp[1] : "" );
			break;

			case 1031:
			this.RemovePlayer( str.tointeger() );
			break;
		}
	}
}