class CProperty extends CContext
{
	Lists = null;
	LoadTime = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Lists = {};
	}

	function AddText( index, text, value, value2, value3, value4, value5, x, y, z )
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
			textelement1.Text = value;
            element.AddChild( textelement1 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement1 );
            textelement1.Pos.Y += 20;

            local textelement2 = GUILabel();
			textelement2.Alpha = 255;
			textelement2.TextColour = Colour( 255, 255, 255 );
			textelement2.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement2.TextAlignment = GUI_ALIGN_CENTER;
			textelement2.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement2.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement2.FontName = "Tahoma";
			textelement2.Text = value2;
            element.AddChild( textelement2 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement2 );
            textelement2.Pos.Y += 40;

            local textelement3 = GUILabel();
			textelement3.Alpha = 255;
			textelement3.TextColour = Colour( 255, 255, 255 );
			textelement3.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement3.TextAlignment = GUI_ALIGN_CENTER;
			textelement3.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement3.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement3.FontName = "Tahoma";
			textelement3.Text = value3;
            element.AddChild( textelement3 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement3 );
            textelement3.Pos.Y += 60;

            local textelement4 = GUILabel();
			textelement4.Alpha = 255;
			textelement4.TextColour = Colour( 255, 255, 255 );
			textelement4.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement4.TextAlignment = GUI_ALIGN_CENTER;
			textelement4.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement4.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement4.FontName = "Tahoma";
			textelement4.Text = value4;
            element.AddChild( textelement4 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement4 );
            textelement4.Pos.Y += 80;

            local textelement5 = GUILabel();
			textelement5.Alpha = 255;
			textelement5.TextColour = Colour( 255, 255, 255 );
			textelement5.FontSize = ( GUI.GetScreenSize().Y * 0.0148148148148148 );
			textelement5.TextAlignment = GUI_ALIGN_CENTER;
			textelement5.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			textelement5.AddFlags( GUI_FLAG_TEXT_TAGS );
			textelement5.FontName = "Tahoma";
			textelement5.Text = value5;
            element.AddChild( textelement5 );
            Handler.Handlers.GUIElement.centerinchild( element, textelement5 );
            textelement5.Pos.Y += 100;

			this.Lists.rawset( index, 
			{
				Element = element,
                TextElement = textelement,
                TextElement1 = textelement1,
                TextElement2 = textelement2,
				TextElement3 = textelement3,
				TextElement4 = textelement4,
				TextElement5 = textelement5,
				Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() ),
				Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) ),
			});

            element.RemoveFlags( GUI_FLAG_VISIBLE );
		}

		else 
		{
			this.Lists[ index ].TextElement.Text = text;
			this.Lists[ index ].TextElement1.Text = value;
			this.Lists[ index ].TextElement2.Text = value2;
			this.Lists[ index ].TextElement3.Text = value3;
			this.Lists[ index ].TextElement4.Text = value4;
			this.Lists[ index ].TextElement5.Text = value5;

            Handler.Handlers.GUIElement.centerinchild( this.Lists[ index ].Element, this.Lists[ index ].TextElement );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement1 );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement2 );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement3 );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement4 );
            Handler.Handlers.GUIElement.centerinchildX( this.Lists[ index ].Element, this.Lists[ index ].TextElement5 );
            this.Lists[ index ].Pos = Vector( x.tofloat(), y.tofloat(), z.tofloat() );
            this.Lists[ index ].Pos1 = Vector( x.tofloat(), y.tofloat(), ( z.tofloat() - 0.2 ) );
		}
	}

	function RemovePlayer( index )
	{
		if( this.Players.rawin( index ) ) this.Players.rawdelete( index );
	}

	function onScriptLoad()
	{
	   	local data = Stream();

		data.WriteInt( 6020 );
		data.WriteString( "" );
		Server.SendData( data );
	}

	function onScriptProcess() 
	{
		local lplayer = World.FindLocalPlayer();
		local lpos = lplayer.Position, spos;
		local lbl, wpts, z1 = Vector( 0, 0, 0.5 );
		
		foreach( index, value in this.Lists )
		{
	        local player = World.FindLocalPlayer(), ppos = player.Position, vehpos = value.Pos, vehpos1 = value.Pos1;

		    if( Distance( ppos.X, ppos.Y, ppos.Z, vehpos.X, vehpos.Y, vehpos.Z ) < 15 )
		    {
		        local screenpos = GUI.WorldPosToScreen( vehpos + z1 );
						
				if( screenpos.Z < 1 ) 
				{
					value.Element.AddFlags( GUI_FLAG_VISIBLE );

					value.Element.Position = VectorScreen( screenpos.X, screenpos.Y ); 
				}
				else value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
		    }

		    else 
		    {
		    	value.Element.RemoveFlags( GUI_FLAG_VISIBLE );
		    }
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 6020:
			local sp = split( str, ";" );
            AddText( sp[0], sp[1], sp[2], sp[3], sp[4], sp[5], sp[6], sp[7].tofloat(), sp[8].tofloat(), sp[9].tofloat() );
			break;
		}
	}
}