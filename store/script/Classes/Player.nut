class CPlayerHud extends CContext
{
	Background	= null;

	HealthBar	= null;
	ArmourBar	= null;

	Countdown	= null;
	CountdownText = null;

	WeaponName	= null;
	WeaponLogo  = null;

	LobbyLogo	= null;
	DonatorT	= null;
	Donor 		= null;

	LobbyText   = null;

	F3Key 		= null;
	IsHidden 	= false;

	HudType 	= 1;
	
	HKey 		= null;

	function constructor( Key )
	{
		base.constructor();

		HKey = KeyBind( 0x48 );

	}

	function Load()
	{

	}

	function onScriptProcess() 
	{

	}

	function LoadLobbyText()
	{
		foreach( index, value in this.LobbyText )
		{
			value.Element = GUILabel();
			value.Element.TextColour = Colour( 255, 0, 255 );
			value.Element.FontSize = 12;
			value.Element.TextAlignment = GUI_ALIGN_CENTER;
			value.Element.FontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
			value.Element.Text = index;
		}
	}

	function RemoveLobbyText()
	{
		foreach( index, value in this.LobbyText )
		{
			value.Element = null;
			value.Element = "xxx";
		}
	}

	function onServerData( type, str )
	{
		switch( type )
		{
			case 267:
			System.SetClipboardText( str );
			break;
		}
	}

	function onScriptLoad()
	{
		this.Load();
	
	   local data = Stream();

		data.WriteInt( 69 );
		data.WriteString( "" );
		Server.SendData( data );
	}

	function onKeyBindDown( key )
	{
		if( key == HKey )
		{
			local data = Stream();

			data.WriteInt( 6700 );
			data.WriteString( "" );
			Server.SendData( data );
		}
	}
	
	function ShowHud()
	{
		Hud.AddFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR | HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_WANTED );
	}
	
	function HideHud()
	{
		Hud.RemoveFlags( HUD_FLAG_HEALTH | HUD_FLAG_WEAPON | HUD_FLAG_RADAR | HUD_FLAG_CASH | HUD_FLAG_CLOCK | HUD_FLAG_WANTED );
	}

	function onPlayerShoot( player, weapon, hitEntity, hitPosition )
	{	

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

	function right( instance, instance2 = null ) 
	{
		if( !instance2 ) 
		{
			local size = instance.Size;
			local screen = ::GUI.GetScreenSize();
			local x = screen.X-220;
			
			instance.Position.X = x;

		}

		else 
		{
			local position = instance2.Position;

			instance.Position.X = position.X - 20 ;
		}
	}

	function getTextWidth( element ) 
	{
		local size = element.Size;
		return size.X;
	}

}