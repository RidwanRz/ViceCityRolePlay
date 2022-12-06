class CDeathspawn extends CContext
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
	
	Page = "none";

    Job = false;
    Property = false;
    GroupHQ = false;

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
		this.Titletext.Text = "Select your spawn";
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
		this.Closetext.Text = "Close";
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
		this.Closetext1.Text = "Back";
		this.Closetext1.FontSize = ( rel.Y * 0.0148148148148148 );
		this.Closetext1.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		Handler.Handlers.GUIElement.centerinchild( this.Close1, this.Closetext1 );

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

	function Show( job, prop, group )
	{
		this.Membox.Clean();

		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
	//	this.Close.AddFlags( GUI_FLAG_VISIBLE );
	//	this.Closetext.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );

		this.ErrorText.Text = "";
		this.Page = "main";

        this.Membox.AddItem( "Spawn at hospital" );
        if( job == "true" ) this.Job = true, this.Membox.AddItem( "Spawn at job" );
        if( prop == "true" ) this.Property = true, this.Membox.AddItem( "Spawn at property" );
        if( group == "true" ) this.GroupHQ = true, this.Membox.AddItem( "Spawn at group HQ" );

        GUI.SetMouseEnabled( true );

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
				case "Spawn at hospital":
				local data = Stream();
				data.WriteInt( 9400 );
				data.WriteString( "" );
				Server.SendData( data );

                this.Hide();
				break;

                case "Spawn at job":
 				local data = Stream();
				data.WriteInt( 9401 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

                case "Spawn at property":
 				local data = Stream();
				data.WriteInt( 9402 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

                case "Spawn at group HQ":
 				local data = Stream();
				data.WriteInt( 9403 );
				data.WriteString( "" );
				Server.SendData( data );
				break;

                default:
                switch( this.Page )
                {
                    case "job":
                    local data = Stream();
                    data.WriteInt( 9404 );
                    data.WriteString( listbox );
                    Server.SendData( data );
				    break;

                    case "property":
                    local data = Stream();
                    data.WriteInt( 9405 );
                    data.WriteString( listbox );
                    Server.SendData( data );
				    break;

                    case "grouphq":
                    local data = Stream();
                    data.WriteInt( 9406 );
                    data.WriteString( listbox );
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
			this.Page = "main";
			this.Membox.Clean();

            this.Membox.AddItem( "Spawn at hospital" );
            if( this.Job ) this.Membox.AddItem( "Spawn at job" );
            if( this.Property ) this.Membox.AddItem( "Spawn at property" );
            if( this.GroupHQ ) this.Membox.AddItem( "Spawn at group HQ" );

			this.Close1.AddFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
            break;
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 9400:
            local sp = split( str, ";" );

			if( Handler.Handlers.PoliceDutySS.Body.Flags == 0 ) this.Show( sp[0], sp[1], sp[2] );
			break;
			
			case 9401:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 9402:
			this.Hide();
			break;

            case 9403:
            this.Membox.Clean();
            this.Page = "job";

			this.Close1.AddFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );

            local sp = split( str, ";" );

            foreach( value in sp )
            {
                this.Membox.AddItem( value );
            }
            break;

            case 9404:
            this.Membox.Clean();
            this.Page = "property";

			this.Close1.AddFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );

            local sp = split( str, ";" );

            foreach( value in sp )
            {
                this.Membox.AddItem( value );
            }
            break;

            case 9405:
            this.Membox.Clean();
            this.Page = "grouphq";

			this.Close1.AddFlags( GUI_FLAG_VISIBLE );
			this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );

            local sp = split( str, ";" );

            foreach( value in sp )
            {
                this.Membox.AddItem( value );
            }
            break;

			case 9406:
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

			case 9407:
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
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );
	}

}