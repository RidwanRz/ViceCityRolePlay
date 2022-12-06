class CEMSDutySkinSelect extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Close = null;
	Closetext = null;

	Close1 = null;
	Closetext1 = null;

	ErrorText = null;
	
	Mode = "none";

    Slot1 = null;
    Slot2 = null;
    Slot3 = null;
    Slot4 = null;
    Slot5 = null;

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
		this.Titletext.Text = "Select Skin";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.Y * 0.0148148148148148 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3294270833333333 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Close = GUICanvas();
		this.Close.Pos = VectorScreen( 0, rel.Y * 0.6119791666666667 );
		this.Close.Size = VectorScreen( rel.X * 0.2598828696925329, rel.Y * 0.0455729166666667 );
		this.Close.Colour = Colour( 66, 70, 71, 255 );
		this.Close.AddFlags( GUI_FLAG_MOUSECTRL );
		Handler.Handlers.GUIElement.centerX( this.Close, this.Titlebar );

		this.Closetext = GUILabel();
		this.Close.AddChild( Closetext );
		this.Closetext.TextColour = Colour( 255, 255, 255 );
		this.Closetext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext.Text = "Close Menu";
		this.Closetext.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Closetext.AddFlags( GUI_FLAG_MOUSECTRL );
		Handler.Handlers.GUIElement.centerinchild( this.Close, this.Closetext );

		this.ErrorText = GUILabel();
		this.Titlebar.AddChild( ErrorText );
		this.ErrorText.TextColour = Colour( 255, 255, 255 );
		this.ErrorText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2604166666666667 );		
		this.ErrorText.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText.FontName = "Tahoma";
		this.ErrorText.Text = "You cannot carry anymore.";
		this.ErrorText.FontSize = ( rel.Y * 0.0138888888888889 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );

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
		this.Closetext1.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Closetext1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		Handler.Handlers.GUIElement.centerinchild( this.Close1, this.Closetext1 );

		this.Slot1 = GUISprite();
		this.Slot1.Pos = VectorScreen( rel.X * 0.296875, rel.Y * 0.3796296296296296 );
		this.Slot1.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1851851851851852 );
		this.Slot1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );

		this.Slot2 = GUISprite();
		this.Slot2.Pos = VectorScreen( rel.X * 0.3697916666666667, rel.Y * 0.3796296296296296 );
		this.Slot2.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1851851851851852 );
		this.Slot2.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );

		this.Slot3 = GUISprite();
		this.Slot3.Pos = VectorScreen( rel.X * 0.4427083333333333, rel.Y * 0.3796296296296296 );
		this.Slot3.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1851851851851852 );
		this.Slot3.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );

		this.Slot4 = GUISprite();
		this.Slot4.Pos = VectorScreen( rel.X * 0.515625, rel.Y * 0.3796296296296296 );
		this.Slot4.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1851851851851852 );
		this.Slot4.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );

		this.Slot5 = GUISprite();
		this.Slot5.Pos = VectorScreen( rel.X * 0.5885416666666667, rel.Y * 0.3796296296296296 );
		this.Slot5.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1851851851851852 );
		this.Slot5.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

        this.Slot1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Slot2.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Slot3.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Slot4.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Slot5.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );

	}

	function Show()
	{
		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );

		this.ErrorText.Text = "";
		this.Mode = type;

		Timer.Create( this, function() 
		{
			GUI.SetMouseEnabled( true );
		}, 500, 1 );

		Handler.Handlers.PlayerHud.HideHud();
        Handler.Handlers.PoliceDuty.Hide();

        this.Titletext.Text = "EMS Duty";

        this.Slot1.SetTexture( "LawE/5.jpg" );

        this.Slot1.AddFlags( GUI_FLAG_VISIBLE );

		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.Titletext );
	}

	function Hide()
	{
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );

        this.Slot1.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Slot2.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Slot3.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Slot4.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Slot5.RemoveFlags( GUI_FLAG_VISIBLE  );

		GUI.SetMouseEnabled( false );

		Handler.Handlers.PlayerHud.ShowHud();
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

            case this.Slot1:
            local data = Stream();
            data.WriteInt( 9500 );
            data.WriteString( "medic" );
            Server.SendData( data );
            break;
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 9500: 
			this.Show();
			break;
			
			case 9501:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 9502:
			this.Hide();
			break;

		}
	}

	function setErrorText( text )
	{
		this.ErrorText.Text = text;
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );
	}

}