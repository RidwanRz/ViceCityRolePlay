class CPlayerTD extends CContext
{
	Lists = null;
	LoadTime = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Lists = {};

		this.LoadTime = Script.GetTicks();

		for( local i = -1; i < 100; i++ )
		{
			this.AddText( i, "", "" );
		}
	}

	function AddText( index, text, value = "" )
	{
		if( !this.Lists.rawin( index ) )
		{
            local element = GUILabel();

            element.Alpha = 255;
            element.Text = text;
            element.TextColour = Colour(255, 255, 255);
            element.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
            element.TextAlignment = GUI_ALIGN_CENTER;
            element.AddFlags( GUI_FLAG_TEXT_TAGS );
            element.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;

        /*    local textelement1 = GUILabel();
			textelement1.Alpha = 255;
			textelement1.TextColour = Colour( 255, 255, 255 );
			textelement1.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement1.TextAlignment = GUI_ALIGN_CENTER;
			textelement1.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement1.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement1.FontName = "Tahoma";
			textelement1.Text = text;
            element.AddChild( textelement1 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement1 );
            textelement1.Pos.Y += 20;*/

			this.Lists.rawset( index, 
			{
				Element = element,
                Time = 0,
            /*    TextElement = textelement,
                TextElement1 = textelement1,*/
			//	Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() ),
			//	Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) ),
			});

            element.RemoveFlags( GUI_FLAG_VISIBLE );
		}

		else 
		{
			this.Lists[ index ].Element.Text = text;
            this.Lists[ index ].Time = System.GetTimestamp();
		//	this.Lists[ index ].TextElement1.Text = value;
        //    Handler.Handlers.GUIElement.centerinchild( this.Lists[ index ].Element, this.Lists[ index ].TextElement );
        //    Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement1 );
       //     this.Lists[ index ].Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() );
        //    this.Lists[ index ].Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) );
		}
	}

	function RemovePlayer( index )
	{
		if( this.Players.rawin( index ) ) this.Players.rawdelete( index );
	}

	function onScriptProcess() 
	{
		local lplayer = World.FindLocalPlayer();
		local lpos = lplayer.Position, spos;
		local lbl, wpts, z1 = Vector( 0, 0, 0.9 );
		
		foreach( index, value in this.Lists )
		{
	        local player = World.FindLocalPlayer(), sender, ppos = player.Position, vehpos;

			sender = World.FindPlayer( index );
			if( sender )
			{
                vehpos = sender.Position;
                if( Distance( ppos.X, ppos.Y, ppos.Z, vehpos.X, vehpos.Y, vehpos.Z ) < 15 )
                {
                    local screenpos = GUI.WorldPosToScreen( vehpos + z1 );
                            
                    if( screenpos.Z < 1 ) 
                    {
                        value.Element.AddFlags( GUI_FLAG_VISIBLE );

                        value.Element.Position = VectorScreen( screenpos.X, screenpos.Y );

                        if( System.GetTimestamp() - value.Time > 6 ) value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
                    }
                    else value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
                }

                else 
                {
                    value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
                }
            }

            if( sender == player ) value.Element.RemoveFlags( GUI_FLAG_VISIBLE );

           // else value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 15000:
			local sp = split( str, ";" );
			AddText( sp[0].tointeger(), sp[1] );
			break;

            case 15001:
            local sp = split( str, ";" );
            local ID = sp[0].tointeger();

            this.Lists[ ID ].TextElement.Text = sp[1];
			this.Lists[ ID ].TextElement1.Text = sp[2];
            break;

            case 15002:
            local ID = str.tointeger();

            this.Lists[ ID ].TextElement.Text = "";
			this.Lists[ ID ].TextElement1.Text = "";
            this.Lists[ ID ].Pos = Vector( 1000, 1000, 1000 );
			this.Lists[ ID ].Pos1 = Vector( 1000, 1000, 1000 );
            break;
		}
	}
}