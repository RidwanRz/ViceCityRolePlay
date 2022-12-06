class CProgress extends CContext
{
	Background = null;

	Title = null;

	Textline = null;
	Textline2 = null;

	IsHidden = true;

	Timeout = 0;

	getHash = null;

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
		this.Background.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.5989583333333333 );
		this.Background.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.2799479166666667 ); 
		this.Background.Colour = Colour( 0, 0, 0, 255 );

		this.Title = GUILabel();
		this.Title.TextColour = Colour( 255, 0, 0 );
		this.Title.Pos = VectorScreen( 0, rel.Y * 0.1041666666666667 );
		this.Title.Text = "Healing in process";
		this.Title.FontName = "Tahoma";
		this.Title.FontFlags = GUI_FFLAG_BOLD;
		this.Title.FontSize = ( rel.X * 0.0131771595900439 );
		this.Background.AddChild( this.Title );
		this.centerinchildX( this.Background, this.Title );

		this.Textline = GUIProgressBar();
		this.Textline.Pos = VectorScreen( 0, rel.Y * 0.7486979166666667 );
		this.Textline.Size = VectorScreen( rel.X * 0.212298682284041, rel.Y * 0.01953125 ); 
		this.Textline.Colour = Colour( 169, 170, 172, 150 );
		this.Textline.EndColour = Colour( 169, 170, 172, 150 );
		this.Textline.StartColour = Colour( 169, 170, 172, 150 );
		this.Textline.MaxValue = 10;
		this.Textline.Thickness = 1;
		this.Textline.BackgroundShade = 0;
		this.centerX( this.Textline );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show( title, cd )
	{
		local rel = GUI.GetScreenSize();

		this.Title.Text = title;

		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

		this.IsHidden = false;
		this.Timeout = System.GetTimestamp();

		if( this.Background.Alpha != 255 ) this.Background.Pos.Y = ( rel.Y * 0.5989583333333333 ) + 40 ;
		this.Background.Alpha = 255;

		this.centerX( this.Background );

		this.centerinchildX( this.Background, this.Title );

		Timer.Destroy( getHash );

		local cooldown = cd;

		this.Textline.MaxValue = cd;

		getHash = Timer.Create( this, function() 
		{
			cooldown --;
			this.Textline.Value +=1

			if( cooldown < 0 ) this.Hide();
		}, 1000, 0 );
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.RemoveFlags( GUI_FLAG_VISIBLE );

		this.Timeout = 0;
		this.IsHidden = true;

		this.Textline.Value = 0;

		Timer.Destroy( getHash );
	}

	function onScriptProcess() 
	{
	/*	local rel = GUI.GetScreenSize();

		if( this.Background.Pos.Y != ( rel.Y * 0.5989583333333333 ) ) 
		{
			this.Background.Pos.Y -= 5;
		}
	

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) > 5 )
		{
			this.Background.Alpha -= 5;

			if( this.Background.Alpha < 1 )
			{
				this.Hide();
			}
		}

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) < 15 )
		{
			this.Textline.Value +=1
			Console.Print( this.Textline.Value );
		//	if( this.Textline.Value > 399 ) this.Hide();
		}		*/
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 6300:
			local se = split( str, ":" );
			if( this.IsHidden ) this.Show( se[0], se[1].tointeger() );
		/*	else 
			{
				this.Textline.Value += 10;

				if( this.Textline.Value > 99 ) this.Hide();
			}*/
			break;

			case 6310:
			this.Hide();
			break;
		}
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

	function getTextWidth( element ) 
	{
		local size = element.Size;
		return size.X;
	}

	function centerinchildX( parents, child )
	{
		local parentElement = parents.Size;
		local childElement = child.Size;
		local x = ( parentElement.X/2 )-( childElement.X/2 );

		child.Pos.X = x;
	}
}