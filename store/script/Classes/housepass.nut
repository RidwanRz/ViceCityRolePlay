class CHPass extends CContext
{
	Background = null;

	Titlebar = null;
	Titletext = null;

	Body = null;

	Inputbox = null;

	Button = null;
	ButtonText = null;

	ErrorText = null;

	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		this.Background = GUISprite();
	//	this.Background.SetTexture( "login-bg.jpg" );
		this.Background.Pos = VectorScreen( 0, 0 );
		this.Background.Size = VectorScreen( rel.X, rel.Y );
	//	this.Background.Colour = Colour( 0, 0, 0, 155 );

		this.Titlebar = GUICanvas();
		this.Titlebar.Pos = VectorScreen( rel.X * 0.2862371888726208, rel.Y * 0.1328125 );
		this.Titlebar.Size = VectorScreen( rel.X * 0.2818448023426061, rel.Y * 0.2057291666666667 );
		this.Titlebar.Colour = Colour( 32, 34, 37, 255 );
		this.center( this.Titlebar );

		this.Titletext = GUILabel();
		this.Titlebar.AddChild( Titletext );
		this.Titletext.TextColour = Colour( 255, 255, 255 );
		this.Titletext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0104166666666667 );		
		this.Titletext.TextAlignment = GUI_ALIGN_CENTER;
		this.Titletext.FontFlags = GUI_FFLAG_BOLD;		
		this.Titletext.Text = "House Password";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.04557291666666677 );
		this.Body.Size = VectorScreen( rel.X * 0.2818448023426061, rel.Y * 0.2057291666666667 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Inputbox = GUIEditbox();
	//	this.Titlebar.AddChild( Inputbox );
		this.Inputbox.TextColour = Colour( 255, 255, 255 );
		this.Inputbox.Colour = Colour( 66, 70, 71, 255 );
		this.Inputbox.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.4752604166666667 );
		this.Inputbox.Size = VectorScreen( rel.X * 0.2598828696925329, rel.Y * 0.0455729166666667 );
		this.Inputbox.TextAlignment = GUI_ALIGN_CENTER;
		this.Inputbox.FontFlags = GUI_FFLAG_BOLD;		
		this.Inputbox.FontName = "Tahoma";
		this.Inputbox.Text = "";
		this.Inputbox.FontSize = ( rel.X * 0.0087847730600293 );
		this.Inputbox.AddFlags( GUI_FLAG_EDITBOX_MASKINPUT );
		this.centerX( this.Inputbox );

		this.Button = GUICanvas();
		this.Titlebar.AddChild( Button );
		this.Button.Pos = VectorScreen( 0, rel.Y * 0.1432291666666667 );
		this.Button.Size = VectorScreen( rel.X * 0.2598828696925329, rel.Y * 0.0455729166666667 );
		this.Button.Colour = Colour( 66, 70, 71, 255 );
		this.Button.AddFlags( GUI_FLAG_MOUSECTRL );
		this.centerinchildX( this.Titlebar, this.Button );

		this.ButtonText = GUILabel();
		this.Button.AddChild( ButtonText );
		this.ButtonText.TextColour = Colour( 255, 255, 255 );
		this.ButtonText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.ButtonText.TextAlignment = GUI_ALIGN_CENTER;
		this.ButtonText.FontFlags = GUI_FFLAG_BOLD;		
		this.ButtonText.Text = "Login";
		this.ButtonText.FontName = "Tahoma";
		this.ButtonText.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchild( this.Button, this.ButtonText );

		this.ErrorText = GUILabel();
		this.Titlebar.AddChild( ErrorText );
		this.ErrorText.TextColour = Colour( 255, 0, 0 );
		this.ErrorText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.2083333333333333 );		
		this.ErrorText.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText.FontName = "Tahoma";
		this.ErrorText.FontSize = ( rel.X * 0.0080527086383602 );
		this.centerinchildX( this.Titlebar, this.ErrorText );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Inputbox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER );
		this.Button.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ButtonText.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show()
	{
		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Inputbox.AddFlags( GUI_FLAG_VISIBLE );
		this.Button.AddFlags( GUI_FLAG_VISIBLE );
		this.ButtonText.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );

		GUI.SetFocusedElement( this.Inputbox );

		this.Inputbox.Text = "";
		this.ErrorText.Text = "";

		GUI.SetMouseEnabled( true );
		
		Handler.Handlers.PlayerHud.HideHud();
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Inputbox.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Button.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ButtonText.RemoveFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE );

		Handler.Handlers.PlayerHud.ShowHud();

		GUI.SetMouseEnabled( false );
	}

	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.Button:
			case this.ButtonText:

			this.Button.Colour = Colour( 255, 255, 255, 255 );
			this.ButtonText.TextColour = Colour( 66, 70, 71, 255 );
			break;
		}
	}

	function onElementHoverOut( element )
	{
		switch( element )
		{
			case this.Button:
			case this.ButtonText:

			this.Button.Colour = Colour( 66, 70, 71, 255 );
			this.ButtonText.TextColour = Colour( 255, 255, 255, 255 );
			break;
		}
	}

	function onElementRelease( element, x, y )
	{
		switch( element )
		{
			case this.Button:
			case this.ButtonText:

			if( this.Inputbox.Text.len() > 0 )
			{
				local data = Stream();
				data.WriteInt( 320 );
				data.WriteString( this.Inputbox.Text );
				Server.SendData( data );
				
				this.Hide();
			}
			else this.Hide();
			break;
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 2060:
			this.Show();
			break;

			case 2061:
			this.Hide();
			break;

			case 2062:
			this.Show();
			
			this.setErrorText( str );
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