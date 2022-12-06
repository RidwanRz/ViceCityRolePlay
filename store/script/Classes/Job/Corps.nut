class CCorpsTD extends CContext
{
	Lists = null;
	LoadTime = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Lists = {};

		this.LoadTime = Script.GetTicks();

		for( local i = -1; i < 200; i++ )
		{
			this.AddText( i, "", "", 100000, 100000, 100000 );
		}
	}

	function AddText( index, text, value, x, y, z )
	{
		if( !this.Lists.rawin( index ) )
		{
            local element = GUICanvas();
            element.Size = VectorScreen( 500, 200 );
            element.Colour = Colour( 255, 255, 255, 0 );

            local textelement = GUILabel();
			textelement.Alpha = 255;
			textelement.TextColour = Colour( 255, 255, 255 );
			textelement.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement.TextAlignment = GUI_ALIGN_CENTER;
			textelement.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement.FontName = "Tahoma";
			textelement.Text = text;
            element.AddChild( textelement );
            Handler.Handlers.GUIElement.centerinchild( element, textelement );

            local textelement1 = GUILabel();
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
            textelement1.Pos.Y += 20;

			this.Lists.rawset( index, 
			{
				Element = element,
                TextElement = textelement,
                TextElement1 = textelement1,
				Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() ),
				Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) ),
			});

            element.RemoveFlags( GUI_FLAG_VISIBLE );
		}

		else 
		{
			this.Lists[ index ].TextElement.Text = text;
			this.Lists[ index ].TextElement1.Text = value;
            Handler.Handlers.GUIElement.centerinchild( this.Lists[ index ].Element, this.Lists[ index ].TextElement );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement1 );
            this.Lists[ index ].Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() );
            this.Lists[ index ].Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) );
		}
	}

	function RemovePlayer( index )
	{
		if( this.Players.rawin( index ) ) this.Players.rawdelete( index );
	}

	function onScriptProcess() 
	{
		try
		{
			local lplayer = World.FindLocalPlayer();
			local lpos = lplayer.Position, spos;
			local lbl, wpts, z1 = Vector( 0, 0, 0.5 );
			
			foreach( index, value in this.Lists )
			{
				local player = World.FindLocalPlayer(), ppos = player.Position, vehpos = value.Pos, vehpos1 = value.Pos1;

				if( Distance( ppos.X, ppos.Y, ppos.Z, vehpos.X, vehpos.Y, vehpos.Z ) < 5 )
				{
					local screenpos = GUI.WorldPosToScreen( vehpos + z1 );
							
					if( screenpos.Z < 1 ) 
					{
						value.Element.AddFlags( GUI_FLAG_VISIBLE );

						value.Element.Position = VectorScreen( screenpos.X - 20, screenpos.Y ); 
					}
					else value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
				}

				else 
				{
					value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
				}
			}
		}
		catch( _ ) _;
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 9300:
			local sp = split( str, ";" );
			AddText( sp[0].tointeger(), sp[1], sp[2], sp[3].tointeger(), sp[4].tointeger(), sp[5].tointeger() );
			break;

            case 9301:
            local sp = split( str, ";" );
            local ID = sp[0].tointeger();

            this.Lists[ ID ].TextElement.Text = sp[1];
			this.Lists[ ID ].TextElement1.Text = sp[2];
            break;

            case 9302:
            local ID = str.tointeger();

            this.Lists[ ID ].TextElement.Text = "";
			this.Lists[ ID ].TextElement1.Text = "";
            this.Lists[ ID ].Pos = Vector( 1000, 1000, 1000 );
			this.Lists[ ID ].Pos1 = Vector( 1000, 1000, 1000 );
            break;
		}
	}
}