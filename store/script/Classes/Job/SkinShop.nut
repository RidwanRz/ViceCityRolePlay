class CSkinShop extends CContext
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
	ErrorText1 = null;

    SkinPre = null;

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
		this.Titletext.Text = "Clothing Store";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.Y * 0.0148148148148148 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.3294270833333333 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Membox = GUIListbox();
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_KBCTRL );
		this.Membox.FontName = "Tahoma";
		this.Membox.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Membox.Pos = VectorScreen( 0, rel.Y * 0.3541666666666667 );
		this.Membox.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.2018229166666667 );
		this.Membox.Colour = Colour( 66, 70, 71, 255 );
		this.Membox.TextColour = Colour( 255, 255, 255 );
		this.Membox.SelectedColour = Colour( 47, 49, 54, 255 );
		Handler.Handlers.GUIElement.centerX( this.Membox, this.Titlebar );

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
		this.Closetext.Text = "Buy Item";
		this.Closetext.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Closetext.AddFlags( GUI_FLAG_MOUSECTRL );
		Handler.Handlers.GUIElement.centerinchild( this.Close, this.Closetext );

		this.ErrorText = GUILabel();
		this.Titlebar.AddChild( ErrorText );
		this.ErrorText.TextColour = Colour( 255, 0, 0 );
		this.ErrorText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2731481481481481 );		
		this.ErrorText.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText.FontName = "Tahoma";
		this.ErrorText.Text = "You cannot carry anymore.";
		this.ErrorText.FontSize = ( rel.Y * 0.0138888888888889 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );

		this.ErrorText1 = GUILabel();
		this.Titlebar.AddChild( ErrorText1 );
		this.ErrorText1.TextColour = Colour( 255, 255, 255 );
		this.ErrorText1.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2509259259259259 );		
		this.ErrorText1.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText1.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText1.FontName = "Tahoma";
		this.ErrorText1.Text = "Price: $500 Stock: 15";
		this.ErrorText1.FontSize = ( rel.Y * 0.0138888888888889 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText1 );

		this.Close1 = GUICanvas();
		this.Close1.Pos = VectorScreen( rel.X * 0.31875, rel.Y * 0.6119791666666667 );
		this.Close1.Size = VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.0455729166666667 );
		this.Close1.Colour = Colour( 66, 70, 71, 0 );
		this.Close1.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Closetext1 = GUILabel();
		this.Close1.AddChild( Closetext1 );
		this.Closetext1.TextColour = Colour( 255, 255, 255 );
		this.Closetext1.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext1.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext1.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext1.Text = "Close Menu";
		this.Closetext1.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Closetext1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		Handler.Handlers.GUIElement.centerinchild( this.Close1, this.Closetext1 );

		this.SkinPre = GUISprite();
		this.SkinPre.Pos = VectorScreen( rel.X * 0.7161458333333333, rel.Y * 0.3564814814814815 );
		this.SkinPre.Size = VectorScreen( rel.X * 0.0677083333333333, rel.Y * 0.1944444444444444 );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.SkinPre.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
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
		this.Close1.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText1.AddFlags( GUI_FLAG_VISIBLE );
		this.SkinPre.AddFlags( GUI_FLAG_VISIBLE );

		this.ErrorText.Text = "";
		this.ErrorText1.Text = "";
		this.Page = "none";
		this.State = 0;
		this.Mode = "";
        this.SkinPre.SetTexture( "SkinS/0.jpg" );

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
		this.SkinPre.RemoveFlags( GUI_FLAG_VISIBLE );

		GUI.SetMouseEnabled( false );

		Handler.Handlers.PlayerHud.ShowHud();
	}
	
	function onListboxSelect( element, listbox )
	{
		if( element == this.Membox )
		{
			switch( listbox )
			{
                default:
                this.Mode = listbox;
				this.ErrorText.Text = "";
				
                local data = Stream();
                data.WriteInt( 9901 );
                data.WriteString( listbox );
                Server.SendData( data );
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
			break;

			case this.Close1:
			case this.Closetext1:

		//	this.Close1.Colour = Colour( 255, 255, 255, 255 );
			this.Closetext1.TextColour = Colour( 255, 0, 0, 255 );
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

		//	this.Close1.Colour = Colour( 66, 70, 71, 255 );
			this.Closetext1.TextColour = Colour( 255, 255, 255, 255 );
			break;
		}
	}

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.Close1:
			case this.Closetext1:
			this.Hide();
			break;

			case this.Close:
			case this.Closetext:
            if( this.Mode != "" )
            {
                local data = Stream();
                data.WriteInt( 9900 );
                data.WriteString( this.Mode );
                Server.SendData( data );
            }
            else this.setErrorText( "Select item from menu." );
			break;

		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 9900:
			this.Show();
			break;
			
			case 9901:
			this.setErrorText( str );
			break;
						
			case 9902:
			this.Hide();
			break;

			case 9903:
            local sp = split( str, ";" );

            this.SkinPre.SetTexture( "SkinS/" + sp[1] + ".jpg" );
        	this.setStockText( sp[0] );
			break;

			case 9904:
			this.Membox.AddItem( str );
			break;

			case 9905:
			this.setErrorText2( str );
			break;
		}
	}

	function setErrorText( text )
	{
		this.ErrorText.Text = text;
		this.ErrorText.TextColour = Colour( 255, 0, 0 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );
	}

	function setErrorText2( text )
	{
		this.ErrorText.Text = text;
		this.ErrorText.TextColour = Colour( 255, 255, 255 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );
	}

	function setStockText( text )
	{
		this.ErrorText1.Text = text;
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText1 );
	}

}