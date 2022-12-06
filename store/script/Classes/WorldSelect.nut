class CWorldSelector extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Membox = null;

	Close = null;
	Closetext = null;

	Close1 = null;
	Closetext1 = null;

	ErrorText = null;

	State = 0;
	
	Page = "none";

	Mode = "none";

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Titlebar = GUICanvas();
		this.Titlebar.Pos = VectorScreen( rel.X * 0.2862371888726208, rel.Y * 0.30859375 );
		this.Titlebar.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.0455729166666667 );
		this.Titlebar.Colour = Colour( 32, 34, 37, 255 );

		this.Titletext = GUILabel();
		this.Titlebar.AddChild( Titletext );
		this.Titletext.TextColour = Colour( 255, 255, 255 );
		this.Titletext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0104166666666667 );		
		this.Titletext.TextAlignment = GUI_ALIGN_CENTER;
		this.Titletext.FontFlags = GUI_FFLAG_BOLD;		
		this.Titletext.Text = "Spawn Selector";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3294270833333333 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Membox = GUIListbox();
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_KBCTRL );
		this.Membox.FontName = "Tahoma";
		this.Membox.FontSize = ( rel.X * 0.0087847730600293 );
		this.Membox.Pos = VectorScreen( 0, rel.Y * 0.3541666666666667 );
		this.Membox.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.2018229166666667 );
		this.Membox.Colour = Colour( 66, 70, 71, 255 );
		this.Membox.TextColour = Colour( 255, 255, 255 );
		this.Membox.SelectedColour = Colour( 47, 49, 54, 255 );
		this.centerX( this.Membox, this.Titlebar );

		this.Close = GUICanvas();
		this.Close.Pos = VectorScreen( 0, rel.Y * 0.6119791666666667 );
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

		this.ErrorText = GUILabel();
		this.Titlebar.AddChild( ErrorText );
		this.ErrorText.TextColour = Colour( 255, 255, 255 );
		this.ErrorText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2604166666666667 );		
		this.ErrorText.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText.FontName = "Tahoma";
		this.ErrorText.Text = "You cannot carry anymore.";
		this.ErrorText.FontSize = ( rel.X * 0.0080527086383602 );
		this.centerinchildX( this.Titlebar, this.ErrorText );

		this.Close1 = GUICanvas();
		this.Close1.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.6119791666666667 );
		this.Close1.Size = VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.0455729166666667 );
		this.Close1.Colour = Colour( 66, 70, 71, 255 );
		this.Close1.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Closetext1 = GUILabel();
		this.Close1.AddChild( Closetext1 );
		this.Closetext1.TextColour = Colour( 255, 255, 255 );
		this.Closetext1.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext1.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext1.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext1.Text = "<";
		this.Closetext1.FontSize = ( rel.X * 0.0087847730600293 );
		this.Closetext1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		this.centerinchild( this.Close1, this.Closetext1 );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
	}


	function Show( type )
	{
		this.Membox.Clean();

		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );

		this.ErrorText.Text = "";
		this.Page = "none";
		this.State = 0;
		this.Mode = type;

		switch( type )
		{
			case "join":
			this.Membox.AddItem( "Random spawn" );
			this.Membox.AddItem( "Owned or shared house" );
			this.Membox.AddItem( "Owned property" );
			break;

			case "dead":
			this.Membox.AddItem( "Nearest hospital" );
			this.Membox.AddItem( "Owned or shared house" );
			this.Membox.AddItem( "Owned property" );
			break;
		}

		Timer.Create( this, function() 
		{
			GUI.SetMouseEnabled( true );
		}, 500, 1 );

		Handler.Handlers.PlayerHud.HideHud();
	}

	function Hide()
	{
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );

		GUI.SetMouseEnabled( false );

		Handler.Handlers.PlayerHud.ShowHud();
	}
	
	function onListboxSelect( element, listbox )
	{
		if( element == this.Membox )
		{
			switch( listbox )
			{
				case "Nearest hospital":
			//	this.Hide();

				local data = Stream();
				data.WriteInt( 7200 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

				case "Owned or shared house":
				this.ErrorText.Text = "";
				this.Page = "house";

				local data = Stream();
				data.WriteInt( 7201 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

				case "Owned property":
				this.ErrorText.Text = "";
				this.Page = "prop";
				
				local data = Stream();
				data.WriteInt( 7202 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

				case "Random spawn":
			//	this.Hide();

				local data = Stream();
				data.WriteInt( 7205 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

				default:
				switch( this.Page )
				{
					case "house":
					local data = Stream();
					local sp = split( listbox, " " );

					data.WriteInt( 7203 );
					data.WriteString( sp[0] );
					Server.SendData( data );
					break;

					case "prop":
					local data = Stream();
					local sp = split( listbox, " " );

					data.WriteInt( 7204 );
					data.WriteString( sp[0] );
					Server.SendData( data );
					break;
				}
				break;
			}
		}
	}
	
	
	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.Close:
			case this.Closetext:

			this.Close.Colour = Colour( 255, 255, 255, 255 );
			this.Closetext.TextColour = Colour( 66, 70, 71, 255 );

			local data = Stream();
			data.WriteInt( 7206 );
			data.WriteString( "" );
			Server.SendData( data );
			break;

			case this.Close1:
			case this.Closetext1:

			this.Close1.Colour = Colour( 255, 255, 255, 255 );
			this.Closetext1.TextColour = Colour( 66, 70, 71, 255 );
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

			case this.Close1:
			case this.Closetext1:

			this.Close1.Colour = Colour( 66, 70, 71, 255 );
			this.Closetext1.TextColour = Colour( 255, 255, 255, 255 );
			break;
		}
	}

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.Close:
			case this.Closetext:
			this.Hide();
			break;

			case this.Close1:
			case this.Closetext1:
			this.State = 0;
			this.Membox.Clean();

			switch( this.Mode )
			{
				case "join":
				this.Membox.AddItem( "Random spawn" );
				this.Membox.AddItem( "Owned or shared house" );
				this.Membox.AddItem( "Owned property" );
				break;

				case "dead":
				this.Membox.AddItem( "Nearest hospital" );
				this.Membox.AddItem( "Owned or shared house" );
				this.Membox.AddItem( "Owned property" );
				break;
			}

			this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );
			break;
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 6800: 
			this.Show( str );
			break;
			
			case 6810:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 6820:
			this.Hide();
			break;

			case 6830:
			if( this.State == 0 )
			{
				this.State = 1;
				this.Membox.Clean();

				this.Close1.AddFlags( GUI_FLAG_VISIBLE );
				this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );

				this.Membox.AddItem( str );
			}
			else this.Membox.AddItem( str );
			break;

			case 6840:
			this.State = 1;
			this.Membox.Clean();

			this.Close1.AddFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
			break;
		}
	}

	function setErrorText( text )
	{
		this.ErrorText.Text = text;
		this.centerinchildX( this.Titlebar, this.ErrorText );
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