class CAmmu extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Membox = null;

	Buy = null;
	Buytext = null;

	Close = null;
	Closetext = null;

	Itemtext = null;
	Pricetext = null;
	ErrorText = null;

	State = 0;

	Item = 0;
	
	Select = null;
	
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
		this.Titletext.Text = "Ammu Nation";
		this.Titletext.FontName = "Tahoma";
		this.Titletext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerinchildX( this.Titlebar, this.Titletext );

		this.Body = GUICanvas();
		this.Titlebar.AddChild( Body );
		this.Body.Pos = VectorScreen( 0, rel.Y * 0.0455729166666667 );
		this.Body.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.55078125 );
		this.Body.Colour = Colour( 47, 49, 54, 255 );

		this.Membox = GUIListbox();
		this.Membox.FontFlags = GUI_FFLAG_BOLD;
		this.Membox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_KBCTRL );
		this.Membox.FontName = "Tahoma";
		this.Membox.FontSize = ( rel.X * 0.0087847730600293 );
		this.Membox.Pos = VectorScreen( rel.X * 0.3008784773060029, rel.Y * 0.2044270833333333 );
		this.Membox.Size = VectorScreen( rel.X * 0.1390922401171303, rel.Y * 0.4921875 );
		this.Membox.Colour = Colour( 66, 70, 71, 255 );
		this.Membox.TextColour = Colour( 255, 255, 255 );
		this.Membox.SelectedColour = Colour( 47, 49, 54, 255 );

		this.Buy = GUICanvas();
		this.Buy.Pos = VectorScreen( rel.X * 0.4582723279648609, rel.Y * 0.6510416666666667 );
		this.Buy.Size = VectorScreen( rel.X * 0.1939970717423133, rel.Y * 0.0455729166666667 );
		this.Buy.Colour = Colour( 66, 70, 71, 255 );
		this.Buy.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Buytext = GUILabel();
		this.Buy.AddChild( Buytext );
		this.Buytext.TextColour = Colour( 255, 255, 255 );
		this.Buytext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Buytext.TextAlignment = GUI_ALIGN_CENTER;
		this.Buytext.FontFlags = GUI_FFLAG_BOLD;		
		this.Buytext.Text = "Buy";
		this.Buytext.FontSize = ( rel.X * 0.0087847730600293 );
		this.Buytext.AddFlags( GUI_FLAG_MOUSECTRL );
		this.centerinchild( this.Buy, this.Buytext );

		this.Close = GUICanvas();
		this.Close.Pos = VectorScreen( rel.X * 0.6734992679355783, rel.Y * 0.6510416666666667 );
		this.Close.Size = VectorScreen( rel.X * 0.0256222547584187, rel.Y * 0.0455729166666667 );
		this.Close.Colour = Colour( 255, 0, 0, 255 );
		this.Close.AddFlags( GUI_FLAG_MOUSECTRL );

		this.Closetext = GUILabel();
		this.Close.AddChild( Closetext );
		this.Closetext.TextColour = Colour( 255, 255, 255 );
		this.Closetext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.0065104166666667 );		
		this.Closetext.TextAlignment = GUI_ALIGN_CENTER;
		this.Closetext.FontFlags = GUI_FFLAG_BOLD;		
		this.Closetext.Text = "X";
		this.Closetext.FontSize = ( rel.X * 0.0087847730600293 );
		this.Closetext.AddFlags( GUI_FLAG_MOUSECTRL | GUI_FLAG_KBCTRL );
		this.centerinchild( this.Close, this.Closetext );

		this.Item = GUISprite();
		this.Item.Pos = VectorScreen( rel.X * 0.4575402635431918, rel.Y *  0.2083333333333333 );
		this.Item.Size = VectorScreen( rel.X * 0.2452415812591508, rel.Y * 0.2473958333333333 );

		this.Itemtext = GUILabel();
		this.Itemtext.TextColour = Colour( 255, 255, 255 );
		this.Itemtext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.46875 );		
		this.Itemtext.TextAlignment = GUI_ALIGN_CENTER;
		this.Itemtext.FontFlags = GUI_FFLAG_BOLD;		
		this.Itemtext.FontName = "Tahoma";
		this.Itemtext.Text = "";
		this.Itemtext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerX( this.Itemtext, this.Item );

		this.Pricetext = GUILabel();
		this.Pricetext.TextColour = Colour( 255, 255, 255 );
		this.Pricetext.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.5078125 );		
		this.Pricetext.TextAlignment = GUI_ALIGN_CENTER;
		this.Pricetext.FontFlags = GUI_FFLAG_BOLD;		
		this.Pricetext.FontName = "Tahoma";
		this.Pricetext.Text = "";
		this.Pricetext.FontSize = ( rel.X * 0.0087847730600293 );
		this.centerX( this.Pricetext, this.Item );

		this.ErrorText = GUILabel();
		this.ErrorText.TextColour = Colour( 255, 255, 255 );
		this.ErrorText.Pos =  VectorScreen( rel.X * 0.1976573938506589, rel.Y * 0.5859375 );		
		this.ErrorText.TextAlignment = GUI_ALIGN_CENTER;
		this.ErrorText.FontFlags = GUI_FFLAG_BOLD;		
		this.ErrorText.FontName = "Tahoma";
		this.ErrorText.Text = "You cannot carry anymore.";
		this.ErrorText.FontSize = ( rel.X * 0.0080527086383602 );
		this.centerX( this.ErrorText, this.Item );

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Buy.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Buytext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Item.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Itemtext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Pricetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );		
	}


	function Show()
	{
		this.Membox.Clean();

		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );
		this.Buy.AddFlags( GUI_FLAG_VISIBLE );
		this.Buytext.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Itemtext.AddFlags( GUI_FLAG_VISIBLE );
		this.Pricetext.AddFlags( GUI_FLAG_VISIBLE );		

		this.ErrorText.Text = "";
		this.Pricetext.Text = "";
		this.Itemtext.Text = "";

		this.Membox.AddItem( "Colt .45" );
		this.Membox.AddItem( "Python" );
		this.Membox.AddItem( "Tec 9" );
		this.Membox.AddItem( "Uzi" );
		this.Membox.AddItem( "Shotgun" );
		this.Membox.AddItem( "Ruger" );
		this.Membox.AddItem( "Sniper Rifle" );
		this.Membox.AddItem( "AK-47" );
		this.Membox.AddItem( "M14" );

		GUI.SetMouseEnabled( true );
	}

	function Hide()
	{
		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_BORDER | GUI_FLAG_KBCTRL );
		this.Buy.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Buytext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Item.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Itemtext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Pricetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );		

		GUI.SetMouseEnabled( false );

		local message = Stream();

		message.WriteInt( 500 );
		Server.SendData( message );
	}
	
	function onListboxSelect( element, listbox )
	{
		if( element == this.Membox )
		{
			switch( listbox )
			{
				case "Colt .45":
				Item.SetTexture( "Weapon_17.png" );

				this.SetItemPriceText( "Colt .45", 200 );
				
				this.Select = "colt:200:3";
				break;

				case "Python":
				Item.SetTexture( "Weapon_18.png" );

				this.SetItemPriceText( "Python", 300 );
				
				this.Select = "python:300:3";
				break;

				case "Tec 9":
				Item.SetTexture( "Weapon_22.png" );

				this.SetItemPriceText( "Tec 9", 350 );
				
				this.Select = "tec:350:5";
				break;

				case "Uzi":
				Item.SetTexture( "Weapon_23.png" );

				this.SetItemPriceText( "Uzi", 500 );
				
				this.Select = "uzi:500:5";
				break;

				case "Shotgun":
				Item.SetTexture( "Weapon_19.png" );

				this.SetItemPriceText( "Shotgun", 700 );
				
				this.Select = "sho:700:4";
				break;

				case "Ruger":
				Item.SetTexture( "Weapon_27.png" );

				this.SetItemPriceText( "Ruger", 2000 );
				
				this.Select = "ruger:2000:6";
				break;

				case "Sniper Rifle":
				Item.SetTexture( "Weapon_28.png" );

				this.SetItemPriceText( "Sniper Rifle", 6500 );
				
				this.Select = "sniper:6500:8";
				break;

				case "Bomb":
				Item.SetTexture( "Object_582.png" );

				this.SetItemPriceText( "Bomb", 15000 );
				
				this.Select = "bomb:15000:8";
				break;
				
				case "AK-47":
				//Item.SetTexture( "Object_582.png" );

				this.SetItemPriceText( "ak-47", 2500 );
				
				this.Select = "ak-47:2500:6";
				break;
				
				case "M14":
				//Item.SetTexture( "Object_582.png" );

				this.SetItemPriceText( "m14", 5000 );
				
				this.Select = "m14:5000:7";
				break;

			}
			
			this.setErrorText( "" );
			this.Item.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		}
	}
	
	
	function onElementHoverOver( element )
	{
		switch( element )
		{
			case this.Buy:
			case this.Buytext:

			this.Buy.Colour = Colour( 255, 255, 255, 255 );
			this.Buytext.TextColour = Colour( 66, 70, 71, 255 );
			break;

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
			case this.Buy:
			case this.Buytext:

			this.Buy.Colour = Colour( 66, 70, 71, 255 );
			this.Buytext.TextColour = Colour( 255, 255, 255, 255 );
			break;

			case this.Close:
			case this.Closetext:

			this.Close.Colour = Colour( 255, 0, 0, 255 );
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
			this.Hide();
			break;

			case this.Buy:
			case this.Buytext:
			if( this.Select == null ) this.setErrorText( "Choose a item from the list." );
			else 
			{
				local message = Stream();

				message.WriteInt( 110 );
				message.WriteString( this.Select );
				Server.SendData( message );
			}
			break;
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 120: 
			this.Show();
			break;
			
			case 1010:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;

			case 1011:
			this.setSucessText( str );
			this.ErrorText.TextColour = Colour( 0,255,0 );
			break;
						
			case 1012:
			this.Hide();
			break;
		}
	}

	function setErrorText( text )
	{
		this.ErrorText.Text = text;
		this.ErrorText.TextColour = Colour( 255, 0, 0 );

		this.centerX( this.ErrorText, this.Item );
	}
	
	function setSucessText( text )
	{
		this.ErrorText.Text = text;
		this.ErrorText.TextColour = Colour( 0, 255, 0 );

		this.centerX( this.ErrorText, this.Item );
	}
	
	function SetItemPriceText( item, price )
	{
		this.Itemtext.Text = item;
		this.Pricetext.Text = "$" + price;
		
		this.centerX( this.Itemtext, this.Item );
		this.centerX( this.Pricetext, this.Item );
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