class CWorld extends CContext
{
	Title = null;
	Body = null;
	CloseB = null;
	Info = null;
	
	TitleText = null;
	BodyContent = null;
	CloseText = null;
	InfoText = null;
	
	TextA = null;
	TextB = null;
	CheckboxA = null;
	CheckboxB = null;
	
	CostText = null;
	
	ButtonBuy = null;
	ButtonBuyText = null;
	
	WorldID = 0;
	Price = 1500;
	IsAdmin = false;
	IsFPS = false;
	
	Status = null;
	
	function constructor( Key )
	{
		base.constructor();
		this.Key = Key;
	}

	function Create()
	{
		this.Title = GUIWindow();
		this.Title.Pos = VectorScreen.Relative( 150, 100 );
		this.Title.Size = VectorScreen.Relative( 300, 28 ); 
		this.Title.Colour = Colour( 40,43,48, 150 );
		this.Title.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
		
		this.Body = GUIWindow();
		this.Body.Pos = VectorScreen.Relative( 150, 130 );
		this.Body.Size = VectorScreen.Relative( 300, 180 ); 
		this.Body.Colour = Colour( 40,43,48, 150 );
		this.Body.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
	
		this.CloseB = GUIWindow();
		this.CloseB.Pos = VectorScreen.Relative( 390, 312 );
		this.CloseB.Size = VectorScreen.Relative( 60, 25 ); 
		this.CloseB.Colour = Colour( 40,43,48, 150 );
		this.CloseB.AddFlags( GUI_FLAG_MOUSECTRL );
		this.CloseB.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
		
		this.Info = GUIWindow();
		this.Info.Pos = VectorScreen.Relative( 150, 312 );
		this.Info.Size = VectorScreen.Relative( 177, 25 ); 
		this.Info.Colour = Colour( 40,43,48, 150 );
		this.Info.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
		
		this.CreateContent();
		this.CreateBody();
		
		GUI.SetMouseEnabled( true );
	}

	
	function CreateContent()
	{
		this.TitleText = GUILabel();
		this.TitleText.Text = "Purchase world - " + this.WorldID;
		this.TitleText.TextColour = Colour( 255,255,255 );
		this.Title.AddChild( this.TitleText );
		this.TitleText.TextAlignment = GUI_ALIGN_LEFT;
		this.TitleText.Pos = VectorScreen.Relative( 10, 3 );
		this.TitleText.FontSize = VectorScreen.FontSize( 11 );
		

		this.CloseText = GUILabel();
		this.CloseText.Text = "Close";
		this.CloseText.TextColour = Colour( 255,255,255 );
		this.CloseB.AddChild( this.CloseText );
		this.CloseText.TextAlignment = GUI_ALIGN_LEFT;
		this.CloseText.Pos = VectorScreen.Relative( 10, 1 );
		this.CloseText.FontSize = VectorScreen.FontSize( 11 );
		this.CloseText.AddFlags( GUI_FLAG_MOUSECTRL );

						
		this.InfoText = GUILabel();
		this.InfoText.Text = "";
		this.InfoText.TextColour = Colour( 255,255,255 );
		this.Info.AddChild( this.InfoText );
		this.InfoText.TextAlignment = GUI_ALIGN_LEFT;
		this.InfoText.Pos = VectorScreen.Relative( 5, 1 );
		this.InfoText.FontSize = VectorScreen.FontSize( 9 );
		this.InfoText.AddFlags( GUI_FLAG_TEXT_TAGS );
				
	}

	function CreateBody()
	{
		this.TextA = GUILabel();
		this.TextA.Text = "World command manager";
		this.TextA.TextColour = Colour( 255,255,255 );
		this.Body.AddChild( this.TextA );
		this.TextA.TextAlignment = GUI_ALIGN_LEFT;
		this.TextA.Pos = VectorScreen.Relative( 20, 10 );
		this.TextA.FontSize = VectorScreen.FontSize( 11 );
		

		this.TextB = GUILabel();
		this.TextB.Text = "FPS/Ping kick system";
		this.TextB.TextColour = Colour( 255,255,255 );
		this.Body.AddChild( this.TextB );
		this.TextB.TextAlignment = GUI_ALIGN_LEFT;
		this.TextB.Pos = VectorScreen.Relative( 20, 35 );
		this.TextB.FontSize = VectorScreen.FontSize( 11 );
		
		this.CheckboxA = GUICheckbox();
		this.Body.AddChild( this.CheckboxA );
		this.CheckboxA.Pos = VectorScreen.Relative( 250, 16 );
		this.CheckboxA.Size = VectorScreen.Relative( 12, 12 );
		this.CheckboxA.Colour = Colour( 72,75,82, 255 );


		this.CheckboxB = GUICheckbox();
		this.Body.AddChild( this.CheckboxB );
		this.CheckboxB.Pos = VectorScreen.Relative( 250, 40 );
		this.CheckboxB.Size = VectorScreen.Relative( 12, 12 );
		this.CheckboxB.Colour = Colour( 72,75,82, 255 );

		this.ButtonBuy = GUIWindow();
		this.Body.AddChild( this.ButtonBuy );
		this.ButtonBuy.Pos = VectorScreen.Relative( 70, 125 );
		this.ButtonBuy.Size = VectorScreen.Relative( 155, 40 ); 
		this.ButtonBuy.Colour = Colour( 32,34,37, 255 );
		this.ButtonBuy.AddFlags( GUI_FLAG_MOUSECTRL );
		this.ButtonBuy.RemoveFlags( GUI_FLAG_WINDOW_TITLEBAR | GUI_FLAG_WINDOW_CLOSEBTN | GUI_FLAG_WINDOW_RESIZABLE );
		
		this.CostText = GUILabel();
		this.CostText.Text = "Cost: " + Price + " Vice Coin";
		this.CostText.TextColour = Colour( 255,255,255 );
		this.Body.AddChild( this.CostText );
		this.CostText.TextAlignment = GUI_ALIGN_CENTER;
		this.CostText.Pos = VectorScreen.Relative( 80, 90 );
		this.CostText.FontSize = VectorScreen.FontSize( 14 );
		
		this.ButtonBuyText = GUILabel();
		this.ButtonBuyText.Text = "Buy";
		this.ButtonBuyText.TextColour = Colour( 255,255,255 );
		this.ButtonBuy.AddChild( this.ButtonBuyText );
		this.ButtonBuyText.TextAlignment = GUI_ALIGN_CENTER;
		this.ButtonBuyText.Pos = VectorScreen.Relative( 55, 5 );
		this.ButtonBuyText.FontSize = VectorScreen.FontSize( 15 );

	}
	
	function onElementRelease( element, mouseX, mouseY )
	{
		if( this.Title )
		{
			switch( element )
			{
				case this.CloseB:
				case this.CloseText:
				this.CloseAll();
				break;
				
				case this.ButtonBuy:
				case this.ButtonBuyText:
				
				switch( this.Status )
				{
					case "Buy":
					local data = Stream();
					data.WriteInt( 100 );
					data.WriteString( this.WorldID + "-" + this.Price + "-" + this.IsAdmin + "-" + this.IsFPS );
					Server.SendData( data );
					break;
				
					case "Mod":
					local data = Stream();
					data.WriteInt( 102 );
					data.WriteString( this.WorldID + "-" + this.Price + "-" + this.IsAdmin + "-" + this.IsFPS );
					Server.SendData( data );
					break;
				}
				break;
			}
		}
	}
	
	function CloseAll()
	{
		this.Title = null;
		this.Body = null;
		this.CloseB = null;
		this.Info = null;
	
		this.TitleText = null;
		this.BodyContent = null;
		this.CloseText = null;
		this.InfoText = null;
	
		this.TextA = null;
		this.TextB = null;
		this.CheckboxA = null;
		this.CheckboxB = null;
	
		CostText = null;
		this.ButtonBuy = null;
		this.ButtonBuyText = null;
	
		this.WorldID = 0;
		this.Price = 1500;
		this.IsAdmin = false;
		this.IsFPS = false;
		
		this.Status = null;
		
		GUI.SetMouseEnabled( false );
	}
	
	function onElementHoverOver( element )
	{
		if( this.Title )
		{
			switch( element )
			{
				case CloseB:
				case CloseText:
				CloseB.Colour =  Colour( 255,255,255,150 );
				CloseText.TextColour = Colour( 0,0,0 );
				//this.InfoText.Text = "Cancel purchase?";
				this.InfoText.TextColour = Colour( 255,255,255 );
				if( this.InfoText.Text.len() > 34 ) this.InfoText.FontSize = VectorScreen.FontSize( (11-5) );
				else this.InfoText.FontSize = VectorScreen.FontSize( 9 );
				break;
				
				case ButtonBuy:
				case ButtonBuyText:
				
				switch( this.Status )
				{
					case "Buy":
			//		this.InfoText.Text = "Purchase the world?";
					break;
					
					case "Mod":
			//		this.InfoText.Text = "Purchase selected item?";
					break;
				}
				
				ButtonBuy.Colour = Colour( 255,255,255,150 );
				ButtonBuyText.TextColour = Colour( 0,0,0 );
				this.InfoText.TextColour = Colour( 255,255,255 );
				if( this.InfoText.Text.len() > 34 ) this.InfoText.FontSize = VectorScreen.FontSize( (11-5) );
				else this.InfoText.FontSize = VectorScreen.FontSize( 9 );
				break;
			
				case TextA:
				case CheckboxA:
			//	this.InfoText.Text = "Adding world admin command.";
				this.InfoText.TextColour = Colour( 255,255,255 );
				if( this.InfoText.Text.len() > 34 ) this.InfoText.FontSize = VectorScreen.FontSize( (11-5) );
				else this.InfoText.FontSize = VectorScreen.FontSize( 9 );
				break;
				
				case TextB:
				case CheckboxB:
			//	this.InfoText.Text = "Adding customize FPS/Ping kick system.";
				this.InfoText.TextColour = Colour( 255,255,255 );
				if( this.InfoText.Text.len() > 34 ) this.InfoText.FontSize = VectorScreen.FontSize( (11-5) );
				else this.InfoText.FontSize = VectorScreen.FontSize( 9 );
				break;
			}
		}
	}
	
	function onElementHoverOut( element )
	{
		if( this.Title )
		{
			switch( element )
			{
				case CloseB:
				case CloseText:
				CloseB.Colour = Colour( 40,43,48, 150 );
				CloseText.TextColour = Colour( 255,255,255 );
				break;
				
				case ButtonBuy:
				case ButtonBuyText:
				ButtonBuy.Colour = Colour( 32,34,37, 150 );
				ButtonBuyText.TextColour = Colour( 255,255,255 );
				break;
			}
			this.InfoText.Text = "";
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 100:
			local stripValue = split( str, "$" );
			
			this.Price = stripValue[0].tointeger();
			this.WorldID = stripValue[1];
			this.Status = "Buy";
			this.Create();
			break;
			
			case 101:
			this.WorldID = str;
			break;
			
			case 102:
			this.CloseAll();
			break;
			
			case 103:
			this.InfoText.Text = str;
			if( this.InfoText.Text.len() > 34 ) this.InfoText.FontSize = VectorScreen.FontSize( (11-5) );
			else this.InfoText.FontSize = VectorScreen.FontSize( 9 );
			this.InfoText.TextColour = Colour( 255,0,0 );
			break;
			
			case 104:
			local stripValue = split( str, "$" );
			
			this.Price = 0;
			this.Create();
			this.Status = "Mod";
			this.TitleText.Text = stripValue[0];
			this.WorldID = stripValue[1];
			if( stripValue[2] == "true" ) this.CheckboxA.RemoveFlags( GUI_FLAG_VISIBLE );
			if( stripValue[3] == "true" ) this.CheckboxB.RemoveFlags( GUI_FLAG_VISIBLE );
			break;
		}
	}
	
	function onCheckboxToggle( element, checked )
	{
		if( this.Title )
		{
			switch( element )
			{
				case this.CheckboxA:
				if( checked )
				{
					this.Price += 250;
					this.IsAdmin = true;
					this.CostText.Text = "Cost: " + this.Price + " Vice Coin";
				}
				else
				{
					this.Price -= 250;
					this.IsAdmin = false;
					this.CostText.Text  = "Cost: " + this.Price + " Vice Coin";
				}
				break;
				
				case this.CheckboxB:
				if( checked )
				{
					this.Price += 450;
					this.IsFPS = true;
					this.CostText.Text  = "Cost: " + this.Price + " Vice Coin";
				}
				else
				{
					this.Price -= 450;
					this.IsFPS = false;
					this.CostText.Text  = "Cost: " + this.Price + " Vice Coin";
				}
				break;
			}
		}
	}
}