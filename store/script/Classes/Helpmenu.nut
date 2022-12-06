class CHelpmenu extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Membox = null;

	Close = null;
	Closetext = null;

	Close1 = null;
	Closetext1 = null;

	Scrollbar = null;
	Membox1 = null;

	Status = "main";
	
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
		this.Titletext.Text = "Help Menu";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.4921875 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Membox = GUIListbox();
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_KBCTRL );
		this.Membox.FontName = "Tahoma";
		this.Membox.FontSize = ( rel.X * 0.0087847730600293 );
		this.Membox.Pos = VectorScreen( 0, rel.Y * 0.1783854166666667 );
		this.Membox.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3971354166666667 );
		this.Membox.Colour = Colour( 66, 70, 71, 255 );
		this.Membox.TextColour = Colour( 255, 255, 255 );
		this.Membox.SelectedColour = Colour( 47, 49, 54, 255 );
		this.centerX( this.Membox, this.Titlebar );

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

		this.Close1 = GUICanvas();
		this.Close1.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.5989583333333333 );
		this.Close1.Size = VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.0455729166666667 );
		this.Close1.Colour = Colour( 66, 70, 71, 255 );
		this.Close1.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Closetext1 = GUILabel();
		this.Close1.AddChild( Closetext1 );
		this.Closetext1.TextColour = Colour( 255, 255, 255 );
		this.Closetext1.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext1.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext1.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext1.FontSize = ( rel.X * 0.0087847730600293 );
		this.Closetext1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		this.Closetext1.Text = "<";
		this.centerinchild( this.Close1, this.Closetext1 );

		this.Scrollbar = GUIScrollbar();
		this.Scrollbar.Colour = Colour( 66, 70, 71, 255 );
		this.Scrollbar.Size = VectorScreen( rel.X * 0.0146412884333821, rel.Y * 0.3971354166666667 );
		this.Scrollbar.Pos = VectorScreen( rel.X * 0.4136163982430454, 0 );

		this.Membox1 = GUIMemobox();
		this.Membox1.FontFlags = GUI_FFLAG_BOLD;
		this.Membox1.FontName = "Tahoma";
		this.Membox1.HistorySize = 255;
		this.Membox1.Pos = VectorScreen( 0, rel.Y * 0.1783854166666667 );
		this.Membox1.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3971354166666667 );
		this.Membox1.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_SCROLLABLE | GUI_FLAG_SCROLLBAR_HORIZ );
		this.Membox1.TextPaddingTop = 10;
		this.Membox1.TextPaddingBottom = 4;
		this.Membox1.TextPaddingLeft = 10;
		this.Membox1.TextPaddingRight = 25;
		this.Membox1.Colour = Colour( 66, 70, 71, 255 );
		this.Membox1.TextColour = Colour( 255, 255, 255 );
		this.Membox1.FontSize = ( rel.X * 0.0109809663250366 );
		this.centerX( this.Membox1, this.Titlebar );
		this.Membox1.AddChild( Scrollbar );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
	}


	function Show()
	{
		this.Membox.Clean();

		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE );

		this.Membox.AddItem( "About this server" );
		this.Membox.AddItem( "Account" );
		this.Membox.AddItem( "Miscs" );
		this.Membox.AddItem( "Jobs" );
		this.Membox.AddItem( "Vehicles" );
		this.Membox.AddItem( "Items/Weapon" );
		this.Membox.AddItem( "House" );
		this.Membox.AddItem( "Property" );
		this.Membox.AddItem( "Rules" );
		this.Membox.AddItem( "Credits" );

		this.Status = "main";
		this.Titletext.Text = "Help Menu";

		GUI.SetMouseEnabled( true );
	}

	function Hide()
	{
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Membox1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE );

		GUI.SetMouseEnabled( false );
	}
	
	function onListboxSelect( element, listbox )
	{
		if( element == this.Membox )
		{
			switch( listbox )
			{
				case "About this server":
				CreateTextBox( "about", "About This Server", "menu" );
				break;

				case "Account":
				SetSubmenu( "menu", "Account" );

				this.Membox.AddItem( "Change your account password" );
				this.Membox.AddItem( "Change your account name" );
				break;

				case "Change your account password":
				CreateTextBox( "changepass", "Account", "menuacc" );
				break;

				case "Change your account name":
				CreateTextBox( "changename", "Account", "menuacc" );
				break;

				case "Miscs":
				SetSubmenu( "menu", "Miscs" );

				this.Membox.AddItem( "Misc commands" );
				this.Membox.AddItem( "Chat commands" );
				break;

				case "Misc commands":
				CreateTextBox( "misccmds", "Misc Commands", "menumisc" );
				break;

				case "Chat commands":
				CreateTextBox( "chatcmds", "Chat Commands", "menumisc" );
				break;

				case "Vehicles":
				SetSubmenu( "menu", "Vehicles" );

				this.Membox.AddItem( "Purchasing vehicle" );
				this.Membox.AddItem( "Using vehicle" );
				this.Membox.AddItem( "Pay n Spray" );
				break;
			
				case "Purchasing vehicle":
				CreateTextBox( "buyveh", "Purchasing Vehicles", "menuveh" );
				break;

				case "Using vehicle":
				CreateTextBox( "vehcmds", "List of vehicle command", "menuveh" );
				break;

				case "Pay n Spray":
				CreateTextBox( "vehpns", "Pay n Spray", "menuveh" );
				break;


			}
		}
	}
	
	function CreateTextBox( table, title, status )
	{
		this.Membox.Clean();
		this.Membox1.Clear();

		this.Status = status;

		this.Scrollbar.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox1.AddFlags( GUI_FLAG_VISIBLE );
		this.Close1.AddFlags( GUI_FLAG_VISIBLE );

		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );

		foreach( value in ::split( ::HelpMenu[ table ], "\n" ) ) this.Membox1.AddLine( value );

		this.Titletext.Text = "Help Menu - " + title;
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Membox1.DisplayPos = 1;
	}

	function SetSubmenu( status, title )
	{
		this.Membox.Clean();
		this.Membox1.Clear();

		this.Status = status;
		this.Titletext.Text = "Help Menu - " + title;
		this.Close1.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );

		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Membox1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Scrollbar.RemoveFlags( GUI_FLAG_VISIBLE );
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
			switch( this.Status )
			{
				case "menu":
				this.Membox.Clean();

				this.Membox.AddFlags( GUI_FLAG_VISIBLE );

				this.Membox1.RemoveFlags( GUI_FLAG_VISIBLE );
				this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
				this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );

				this.Membox.AddItem( "About this server" );
				this.Membox.AddItem( "Account" );
				this.Membox.AddItem( "Miscs" );
				this.Membox.AddItem( "Jobs" );
				this.Membox.AddItem( "Vehicles" );
				this.Membox.AddItem( "Items/Weapon" );
				this.Membox.AddItem( "House" );
				this.Membox.AddItem( "Property" );
				this.Membox.AddItem( "Rules" );
				this.Membox.AddItem( "Credits" );

				this.Status = "main";

				this.Titletext.Text = "Help Menu";
				this.centerinchildX( this.Titlebar, this.Titletext );
				break;

				case "menuacc":
				ShowSubmenu2( "Account" );

				this.Membox.AddItem( "Change your account password" );
				this.Membox.AddItem( "Change your account name" );
				break;

				case "menumisc":
				ShowSubmenu2( "Miscs" );

				this.Membox.AddItem( "Misc commands" );
				this.Membox.AddItem( "Chat commands" );
				break;

				case "menuveh":
				SetSubmenu( "menu", "Vehicles" );

				this.Membox.AddItem( "Purchasing vehicle" );
				this.Membox.AddItem( "Using vehicle" );
				this.Membox.AddItem( "Pay n Spray" );
				break;















			}
			break;
		}
	}

	function ShowSubmenu2( title )
	{
		this.Membox.Clean();

		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox1.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Status = "menu";

		this.Titletext.Text = "Help Menu - " + title;

		this.centerinchildX( this.Titlebar, this.Titletext );
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 600: 
			this.Show();
			break;
			
			case 601:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 602:
			this.Hide();
			break;

			case 603:
			this.Membox.AddItem( str );
			break;

			case 604:
			this.Status = 1;
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