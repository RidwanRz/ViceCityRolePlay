class CFaq extends CContext
{
	Titlebar = null;
	Titletext = null;

	Body = null;

	Close = null;
	Closetext = null;

	Close1 = null;
	Closetext1 = null;

	ErrorText = null;

    Membox = null;
    Textbox = null;
	
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
		this.Titletext.Text = "Frequently Ask Question";
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
		this.ErrorText.Text = "";
		this.ErrorText.FontSize = ( rel.Y * 0.0138888888888889 );
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );

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

		this.Textbox = GUIMemobox();
		this.Textbox.FontFlags = GUI_FFLAG_BOLD;
		this.Textbox.FontName = "Tahoma";
		this.Textbox.HistorySize = 255;
		this.Textbox.Pos = VectorScreen( 0, rel.Y * 0.3541666666666667 );
		this.Textbox.Size = VectorScreen( rel.X * 0.4282576866764275, rel.Y * 0.2018229166666667 );
		this.Textbox.AddFlags( GUI_FLAG_TEXT_TAGS | GUI_FLAG_SCROLLABLE | GUI_FLAG_SCROLLBAR_HORIZ );
		this.Textbox.TextPaddingTop = 10;
		this.Textbox.TextPaddingBottom = 4;
		this.Textbox.TextPaddingLeft = 10;
		this.Textbox.TextPaddingRight = 25;
		this.Textbox.Colour = Colour( 66, 70, 71, 255 );
		this.Textbox.TextColour = Colour( 255, 255, 255 );
		this.Textbox.FontSize = ( rel.Y * 0.0148148148148148 );
		Handler.Handlers.GUIElement.centerX( this.Textbox, this.Titlebar );

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

		this.Titlebar.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Titletext.RemoveFlags( GUI_FLAG_VISIBLE );
		this.Body.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.ErrorText.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Close1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

        this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Textbox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

        this.Membox.AddItem( "How i find my first job?" );
        this.Membox.AddItem( "How i find shop such as 24/7, Gun Shop?" );
        this.Membox.AddItem( "My car is broken, what can i do?" );
        this.Membox.AddItem( "How i rank up as Police Officer?" );
        this.Membox.AddItem( "How do i earn paycheck?" );
        this.Membox.AddItem( "How do i equip myself as PD?" );
        this.Membox.AddItem( "Why i knocked?" );
        this.Membox.AddItem( "How do i revive knocked player?" );
        this.Membox.AddItem( "How do i heal myself?" );
        this.Membox.AddItem( "Can i rob a store?" );
        this.Membox.AddItem( "How do i plant weed seed?" );
        this.Membox.AddItem( "How do i create group?" );
        this.Membox.AddItem( "What is scripted group?" );

	}

	function Show()
	{
		this.Titlebar.AddFlags( GUI_FLAG_VISIBLE );
		this.Titletext.AddFlags( GUI_FLAG_VISIBLE );
		this.Body.AddFlags( GUI_FLAG_VISIBLE );
		this.Close.AddFlags( GUI_FLAG_VISIBLE );
		this.Closetext.AddFlags( GUI_FLAG_VISIBLE );
		this.ErrorText.AddFlags( GUI_FLAG_VISIBLE );
		this.Membox.AddFlags( GUI_FLAG_VISIBLE );

		Timer.Create( this, function() 
		{
			GUI.SetMouseEnabled( true );
		}, 500, 1 );

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
        this.Membox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		this.Textbox.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

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

            case this.Close1:
            case this.Closetext1:
            this.Close1.RemoveFlags( GUI_FLAG_VISIBLE );
            this.Closetext1.RemoveFlags( GUI_FLAG_VISIBLE );
		    this.Textbox.RemoveFlags( GUI_FLAG_VISIBLE );
		    
            this.Membox.AddFlags( GUI_FLAG_VISIBLE );


            break;
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 14000: 
			this.Show();
			break;
			
			case 14001:
			this.setErrorText( str );
			this.ErrorText.TextColour = Colour( 255,0,0 );
			break;
						
			case 14002:
			this.Hide();
			break;

		}
	}

	function setErrorText( text )
	{
		this.ErrorText.Text = text;
		Handler.Handlers.GUIElement.centerinchildX( this.Titlebar, this.ErrorText );
	}

	function onListboxSelect( element, listbox )
	{
		if( element == this.Membox )
		{
			switch( listbox )
			{
                case "How i find my first job?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can go to Vice Port Truck Depot (red marker on radar) and become Trucker." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How i find shop such as 24/7, Gun Shop?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can follow yellow marker on your radar map." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How i rank up as Police Officer?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] Only PD supervisor can promote/demote PD officer based on work, attude. Ask Any departmant supervisor for more information." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i earn paycheck?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] Paycheck will be given every 30mins. Extra paychecks can be earn by doing task (eg: Jail wanted player as PD, Cremate corps as EMS etc). You can collect it inside bank using /paycheck" );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i equip myself as PD?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can use /tg inside any PD, which give you Nightstick, Colt and MP5. High rank officers have access to /equip which allow them to equip more powerful weapons." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "Why i knocked?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] If you get injured by someone too much you will knocked, while you knocked other player can either revive you or rob you (PD can seize your illegal item). If you knocked status too long you will start loosing blood and finally died." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i revive knocked player?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can use /revive to revive knocked player. Please note that you need revive kit(can be brought from 24/7) or as EMS(You need to be near ambulance)" );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i heal myself?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can consume kit kat or using First Aid Kit (which can be brought from 24/7)" );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "Can i rob a store?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] Yes, you can rob store in some shop around city. Just go on red sphere to start robbing. However, when you start robbing whole PD will be notified. They can arrest you if they spotted you. (Please note that to initializing store robbery at least 1 cop needed in server. After store get robbed there is 10 minutes cool down before it can be robbed again.)" );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i create group?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can post create group application on discord. Please not that you need to have at least 3 members to able receive scripted group" );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "What is scripted group?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] Group can have HQ which allow group member to store their items, or as respawn point. Group vehicle can be used by group members only. Criminal group leaders can access black market which allow them to buy/sell exotic items such as Heavy Weapon Cases, Weed seeds etc." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "My car is broken, what can i do?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] You can use toolkit (which can be brought from Tools Shop) to repair vehicle, it will restore vehicle health to certain level. Also you can call mechanic to fully repair your vehicle. You can use Pay 'n' Spray too but would be expensive. Please note that you cannot repair vehicle by exploding the vehicle, push it into water. It will remain broken even after respawn." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;

                case "How do i plant weed seed?":
                this.Textbox.Clear();
                this.Textbox.AddLine( "[Q] " + listbox + "\n\n\n" );
                this.Textbox.AddLine( "[A] First you need to buy weed seed in black market, then find weed field around Vice City. To plant the seed use /plantseed. There are total 2 state to grow and harvest, each state takes 30 mins. After plant fully grown you can use /harvestweed to harvest. You can sell weed to criminal group member or inside black market using /sell." );

                this.Close1.AddFlags( GUI_FLAG_VISIBLE );
                this.Closetext1.AddFlags( GUI_FLAG_VISIBLE );
                this.Textbox.AddFlags( GUI_FLAG_VISIBLE );
                
                this.Membox.RemoveFlags( GUI_FLAG_VISIBLE );
                break;
              
            }
        }
    }
}