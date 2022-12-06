class CAnnounce extends CContext
{
	Background = null;

	Textline = null;
	Textline2 = null;

	IsHidden = true;

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
		this.Background.Pos = VectorScreen( rel.X * 0.3294289897510981, rel.Y * 0.2083333333333333 );
		this.Background.Size = VectorScreen( rel.X * 0.369692532942899, rel.Y * 0.2408854166666667 ); 
		this.Background.Colour = Colour( 0, 0, 0, 255 );

		this.Textline = GUILabel();
		this.Textline.TextColour = Colour( 255, 255, 255 );
		this.Textline.Pos =  VectorScreen( 0, rel.Y * 0.1432291666666667 );		
		this.Textline.FontFlags = GUI_FFLAG_BOLD;
		this.Textline.AddFlags( GUI_FLAG_TEXT_TAGS );
		this.Textline.Text = "";
		this.Textline.FontName = "Tahoma";
		this.Textline.FontSize = ( rel.X * 0.0102489019033675 );
	//	this.Background.AddChild( this.Textline );
		this.center( this.Textline, this.Background );

		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
	}

	function Show( text )
	{
		local rel = GUI.GetScreenSize();

		this.Background.AddFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

		this.Textline.Size.X = 0;

		this.Textline.Text = text;

		//if( this.getTextWidth( this.Title ) > this.getTextWidth( this.Textline ) ) this.Background.Size.X = this.getTextWidth( this.Title ) * 2;
		this.Background.Size.X = this.getTextWidth( this.Textline ) * 2;

		this.IsHidden = false;
		this.Timeout = System.GetTimestamp();

		this.centerX( this.Background );

		this.center( this.Textline, this.Background );

		this.Background.Alpha = 255;
		this.Textline.Alpha = 255;
	}

	function Hide()
	{
		this.Background.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Textline.AddFlags( GUI_FLAG_VISIBLE );

		this.Timeout = 0;
		this.IsHidden = true;
	}

	function onScriptProcess() 
	{
		local rel = GUI.GetScreenSize();

		if( !this.IsHidden && ( System.GetTimestamp() - this.Timeout ) > 5 )
		{
			this.Background.Alpha -= 5;
			this.Textline.Alpha -= 5;

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
			case 6080:
			this.Show( str );
			break;

			case 6081:
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