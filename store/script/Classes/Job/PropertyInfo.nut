class CPropertyInfo extends CContext
{
	Background = null;
	Title = null;
    Owner = null;
    Info = null;
	Value = null;

	IsHidden = false;
	Timeout = 0;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUISprite();
        this.Background.SetTexture( "alert-bg.png" );
		this.Background.Pos = VectorScreen( rel.X * 0.15625, rel.Y * 0.5555555555555556 );
		this.Background.Size = VectorScreen( rel.X * 0.5729166666666667, rel.Y * 0.5277777777777778 );
	    Handler.Handlers.GUIElement.centerX( this.Background );

        this.Title = GUILabel();
		this.Background.AddChild( Title );
		this.Title.TextColour = Colour( 255, 255, 255 );
		this.Title.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.1990740740740741 );		
		this.Title.TextAlignment = GUI_ALIGN_CENTER;
		this.Title.FontFlags = GUI_FFLAG_BOLD;		
		this.Title.Text = "Clothing Store";
		this.Title.FontName = "Tahoma";
		this.Title.FontSize = ( rel.Y * 0.0231481481481481 );
		Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Title );

        this.Owner = GUILabel();
		this.Background.AddChild( Owner );
		this.Owner.TextColour = Colour( 255, 255, 255 );
		this.Owner.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2361111111111111 );		
		this.Owner.TextAlignment = GUI_ALIGN_CENTER;
		this.Owner.FontFlags = GUI_FFLAG_BOLD;		
		this.Owner.Text = "Clothing Store";
		this.Owner.FontName = "Tahoma";
		this.Owner.FontSize = ( rel.Y * 0.0185185185185185 );
		Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Owner );

        this.Value = GUILabel();
		this.Background.AddChild( Value );
		this.Value.TextColour = Colour( 255, 255, 255 );
		this.Value.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2638888888888889 );		
		this.Value.TextAlignment = GUI_ALIGN_CENTER;
		this.Value.FontFlags = GUI_FFLAG_BOLD;		
		this.Value.Text = "Clothing Store";
		this.Value.FontName = "Tahoma";
		this.Value.FontSize = ( rel.Y * 0.0185185185185185 );
		Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Value );

        this.Info = GUILabel();
		this.Background.AddChild( Info );
		this.Info.TextColour = Colour( 255, 184, 77 );
		this.Info.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2962962962962963 );		
		this.Info.TextAlignment = GUI_ALIGN_CENTER;
		this.Info.FontFlags = GUI_FFLAG_BOLD;		
		this.Info.Text = "Press [H] to enter.";
		this.Info.FontName = "Tahoma";
		this.Info.FontSize = ( rel.Y * 0.0185185185185185 );
		Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Info );

        this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Title.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Owner.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Info.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Value.RemoveFlags( GUI_FLAG_VISIBLE );
    }

    function Show( title, value, owner )
    {
        this.Background.AddFlags( GUI_FLAG_VISIBLE );
        this.Title.AddFlags( GUI_FLAG_VISIBLE );
        this.Owner.AddFlags( GUI_FLAG_VISIBLE );
        this.Info.AddFlags( GUI_FLAG_VISIBLE );
        this.Value.AddFlags( GUI_FLAG_VISIBLE );

        this.Title.Text = title;
        this.Owner.Text = owner;
        this.Value.Text = value;
		this.Background.Alpha = 255;

        Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Title );
        Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Owner );
        Handler.Handlers.GUIElement.centerinchildX( this.Background, this.Value );

		this.IsHidden = false;
		this.Timeout = System.GetTimestamp();
    }

    function Hide()
    {
        this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Title.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Owner.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Info.RemoveFlags( GUI_FLAG_VISIBLE );
        this.Value.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Timeout = 0;
		this.IsHidden = true;
    }

	function onScriptProcess() 
	{
		local rel = GUI.GetScreenSize();

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) > 2 )
		{
			this.Background.Alpha -= 5;

			if( this.Background.Alpha < 1 )
			{
				this.Hide();
			}
		}
	}

    function onServerData( type, str )
	{
		switch( type )
		{
			case 11000:
			local sp = split( str, ";" );
			this.Show( sp[0], sp[1], sp[2] );
			break;
			
			case 11010:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 11020:
			this.Hide();
			break;
		}
    }
}

