class CNews extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Membox = null;

	Close = null;
	Closetext = null;

	Scrollbar = null;

	Hidden = true;
	
	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Titlebar = GUICanvas();
		this.Titlebar.Pos = VectorScreen( rel.X * 0.2862371888726208, rel.Y * 0.1328125 );
		this.Titlebar.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.0455729166666667 );
		this.Titlebar.Colour = Colour( 32, 34, 37, 255 );

		this.Titletext = GUILabel();
		this.Titlebar.AddChild( Titletext );
		this.Titletext.TextColour = Colour( 255, 255, 255 );
		this.Titletext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0104166666666667 );		
		this.Titletext.TextAlignment = GUI_ALIGN_CENTER;
		this.Titletext.FontFlags = GUI_FFLAG_BOLD;		
		this.Titletext.Text = "News";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.4856770833333333 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Membox = GUIMemobox();
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.FontName = "Tahoma";
		this.Membox.HistorySize = 255;
		this.Membox.Pos = VectorScreen( 0, rel.Y * 0.1783854166666667 );
		this.Membox.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3971354166666667 );
		this.Membox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_SCROLLABLE | GUI_FLAG_SCROLLBAR_HORIZ );
		this.Membox.TextPaddingTop = 10;
		this.Membox.TextPaddingBottom = 4;
		this.Membox.TextPaddingLeft = 10;
		this.Membox.TextPaddingRight = 10;
		this.Membox.Colour = Colour( 66, 70, 71, 255 );
		this.Membox.TextColour = Colour( 255, 255, 255 );
		this.centerX( this.Membox, this.Titlebar );

		this.Scrollbar = GUIScrollbar();
		this.Scrollbar.Colour = Colour( 66, 70, 71, 255 );
		this.Scrollbar.Size = VectorScreen( rel.X * 0.0146412884333821, rel.Y * 0.3971354166666667 );
		this.Membox.AddChild( Scrollbar );
		this.Scrollbar.Pos = VectorScreen( rel.X * 0.4136163982430454, 0 );

		this.Close = GUICanvas();
		this.Close.Pos = VectorScreen( 0, rel.Y * 0.5989583333333333 );
		this.Close.Size = VectorScreen( rel.X * 0.2598828696925329, rel.Y * 0.0455729166666667 );
		this.Close.Colour = Colour( 66, 70, 71, 255 );
		this.Close.AddFlags( GUI_FLAG_MOUSECTRL );
		this.centerX( this.Close, this.Titlebar );

		this.Closetext = GUILabel();
		this.Close.AddChild( Closetext );
		this.Closetext.TextColour = Colour( 255, 255, 255 );
		this.Closetext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext.Text = "Close";
		this.Closetext.FontSize = ( rel.X * 0.0087847730600293 );
		this.Closetext.AddFlags( GUI_FLAG_MOUSECTRL );
		this.centerinchild( this.Close, this.Closetext );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
	}

	function Hide()
	{
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE );

		GUI.SetMouseEnabled( false );

		this.Hidden = true;
	}

	function Show()
	{
		this.Hidden = false;

		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE );

		this.Membox.Clear();

		GUI.SetMouseEnabled( true );

		Timer.Create( this, function() 
		{
			if( !this.Hidden ) GUI.SetMouseEnabled( true );
		}, 2000, 1 );
	}

	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.Close:
			case this.Closetext:

			this.Close.Colour = Colour( 255, 255, 255, 255 );
			this.Closetext.TextColour = Colour( 66, 70, 71, 255 );
			break;
		}
	}

	function onElementHoverOut( element )
	{
		switch( element )
		{
			case this.Close:
			case this.Closetext:

			this.Close.Colour = Colour( 66, 70, 71, 255 );
			this.Closetext.TextColour = Colour( 255, 255, 255, 255 );
			break;
		}
	}

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.Close:
			case this.Closetext:
			local data = Stream();
			data.WriteInt( 1060 );
			data.WriteString( "3" );
			Server.SendData( data );
			this.Hide();

			break;
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 2100:
			this.Show();

			this.Titletext.Text = "News";
			this.centerinchildX( this.Titlebar, this.Titletext );
			break;

			case 2101:
			local stripValue = split( str, "$" );
			
			foreach( value in stripValue ) this.Membox.AddLine( value );
			break;

			case 2102:
			this.Membox.AddLine( str );

			this.Membox.DisplayPos = 1;
			break;
		}
	}

	function onScrollbarScroll( scrollbar, position, change )
	{
		if( scrollbar == this.Scrollbar ) this.Membox.DisplayPos = 1 - position;
	}


	function center( instance, instance2 = null )
	{
		if( !instance2 ) 
		{
			local size = instance.Size;
			local screen = ::GUI.GetScreenSize();
			local x = (screen.X/2)-(size.X/2);
			local y = (screen.Y/2)-(size.Y/2);
			
			instance.Position = ::VectorScreen(x, y);
		}

		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X)/2;
			instance.Position.Y = (position.Y + (position.Y + size.Y) - instance.Size.Y)/2;
		}
	}

	function centerX( instance, instance2 = null )
	{
		if( !instance2 ) 
		{
			local size = instance.Size;
			local screen = ::GUI.GetScreenSize();
			local x = (screen.X/2)-(size.X/2);
			
			instance.Position.X = x;
		} 

		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = (position.X + (position.X + size.X) - instance.Size.X)/2;
		}
	}

	function left( instance, instance2 = null ) 
	{
		if( !instance2 ) instance.Position.X = 0;
		else 
		{
			local position = instance2.Position;
			local size = instance2.Size;
			instance.Position.X = position.X;
		}
	}

	function centerinchild( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );
		local y = ( parentElement.Y/2 )-( childElement.Y/2 );

		child.Pos = ::VectorScreen( x, y );
	}

	function centerinchildX( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );

		child.Pos.X = x;
	}		
}