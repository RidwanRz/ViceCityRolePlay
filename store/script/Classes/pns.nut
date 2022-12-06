class CPaint extends CContext
{
	window = null;
	_11 = null;
	_12 = null; 
	_13 = null;
	_14 = null;
	_15 = null;
	_16 = null;
	_17 = null;
	_18 = null;
	
	_21 = null;
	_22 = null;
	_23 = null;
	_24 = null;
	_25 = null;
	_26 = null;
	_27 = null;
	_28 = null;
	
	_31 = null;
	_32 = null;
	_33 = null;
	_34 = null;
	_35 = null;
	_36 = null;
	_37 = null;
	_38 = null;
	
	box = null;
	box1 = null;
	label = null;
	
	label1 = null;
	label2 = null;
	fixbutton = null;
	withbtn = null;
	
	checkbox = 1;
	
	vpos = null;
	
	function constructor( Key )
	{
		base.constructor();

		this.Load();
	}

	function Load()
	{
		local rel = GUI.GetScreenSize();

		window = GUIWindow();
		window.Size = VectorScreen( rel.X * 0.4941434846266471, rel.Y * 0.4427083333333333 );
		window.Text = "Pay and Spray";
		window.Colour = Colour( 47, 49, 54, 255 );
		window.TitleColour = Colour( 32, 34, 37, 255 );
		window.FontFlags = GUI_FFLAG_BOLD;
		window.TextAlignment = GUI_ALIGN_CENTER;
		window.FontName = "Tahoma";
		window.TextColour = Colour( 255, 255, 255 );
		window.RemoveFlags( GUI_FLAG_WINDOW_RESIZABLE | GUI_FLAG_BORDER | GUI_FLAG_TEXT_SHADOW );
		this.center( this.window );
		
		_11 = GUICanvas();
		_11.Colour = Colour( 225, 0, 225 );
		_11.Pos = VectorScreen( rel.X * 0.0146412884333821, rel.Y * 0.0260416666666667 );
		_11.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_11.AddFlags( GUI_FLAG_MOUSECTRL );
		_12 = GUICanvas();
		_12.Colour = Colour( 225, 0, 81 );
		_12.Pos = VectorScreen( rel.X * 0.0732064421669107, rel.Y * 0.0260416666666667 );
		_12.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_12.AddFlags( GUI_FLAG_MOUSECTRL );
		_13 = GUICanvas();
		_13.Colour = Colour( 225, 225, 0 );
		_13.Pos = VectorScreen( rel.X * 0.1317715959004392, rel.Y * 0.0260416666666667 );
		_13.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_13.AddFlags( GUI_FLAG_MOUSECTRL );
		_14 = GUICanvas();
		_14.Colour = Colour( 144, 0, 225 );
		_14.Pos = VectorScreen( rel.X * 0.1903367496339678, rel.Y * 0.0260416666666667 );
		_14.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_14.AddFlags( GUI_FLAG_MOUSECTRL );
		_15 = GUICanvas();
		_15.Colour = Colour( 144, 81, 36 );
		_15.Pos = VectorScreen( rel.X * 0.2489019033674963, rel.Y * 0.0260416666666667 );
		_15.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_15.AddFlags( GUI_FLAG_MOUSECTRL );
		_16 = GUICanvas();
		_16.Colour = Colour( 144, 225, 9 );
		_16.Pos = VectorScreen( rel.X * 0.3074670571010249, rel.Y * 0.0260416666666667 );
		_16.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_16.AddFlags( GUI_FLAG_MOUSECTRL );
		_17 = GUICanvas();
		_17.Colour = Colour( 144, 0, 0 );
		_17.Pos = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.0260416666666667 );
		_17.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_17.AddFlags( GUI_FLAG_MOUSECTRL );
		_18 = GUICanvas();
		_18.Colour = Colour( 81, 36, 225 );
		_18.Pos = VectorScreen( rel.X * 0.424597364568082, rel.Y * 0.0260416666666667 );
		_18.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_18.AddFlags( GUI_FLAG_MOUSECTRL );

		_21 = GUICanvas();
		_21.Colour = Colour( 81, 0, 225 );
		_21.Pos = VectorScreen( rel.X * 0.0146412884333821, rel.Y *  0.1041666666666667 );
		_21.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_21.AddFlags( GUI_FLAG_MOUSECTRL );
		_22 = GUICanvas();
		_22.Colour = Colour( 81, 0, 81 );
		_22.Pos = VectorScreen( rel.X * 0.0732064421669107, rel.Y * 0.1041666666666667 );
		_22.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_22.AddFlags( GUI_FLAG_MOUSECTRL );
		_23 = GUICanvas();
		_23.Colour = Colour( 81, 225, 9 );
		_23.Pos = VectorScreen( rel.X * 0.1317715959004392, rel.Y * 0.1041666666666667 );
		_23.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_23.AddFlags( GUI_FLAG_MOUSECTRL );
		_24 = GUICanvas();
		_24.Colour = Colour( 9, 225, 0 );
		_24.Pos = VectorScreen( rel.X * 0.1903367496339678, rel.Y * 0.1041666666666667 );
		_24.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_24.AddFlags( GUI_FLAG_MOUSECTRL );
		_25 = GUICanvas();
		_25.Colour = Colour( 9, 0, 9 );
		_25.Pos = VectorScreen( rel.X * 0.2489019033674963, rel.Y * 0.1041666666666667 );
		_25.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_25.AddFlags( GUI_FLAG_MOUSECTRL );
		_26 = GUICanvas();
		_26.Colour = Colour( 9, 9, 81 );
		_26.Pos = VectorScreen( rel.X * 0.3074670571010249, rel.Y * 0.1041666666666667 );
		_26.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_26.AddFlags( GUI_FLAG_MOUSECTRL );
		_27 = GUICanvas();
		_27.Colour = Colour( 9, 9, 144 );
		_27.Pos = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.1041666666666667 );
		_27.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_27.AddFlags( GUI_FLAG_MOUSECTRL );
		_28 = GUICanvas();
		_28.Colour = Colour( 36, 144, 225 );
		_28.Pos = VectorScreen( rel.X * 0.424597364568082, rel.Y * 0.1041666666666667 );
		_28.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_28.AddFlags( GUI_FLAG_MOUSECTRL );

		_31 = GUICanvas();
		_31.Colour = Colour( 225, 144, 225 );
		_31.Pos = VectorScreen( rel.X * 0.0146412884333821, rel.Y * 0.1822916666666667 );
		_31.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_31.AddFlags( GUI_FLAG_MOUSECTRL );
		_32 = GUICanvas();
		_32.Colour = Colour( 225, 225, 225 );
		_32.Pos = VectorScreen( rel.X * 0.0732064421669107, rel.Y * 0.1822916666666667 );
		_32.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_32.AddFlags( GUI_FLAG_MOUSECTRL );
		_33 = GUICanvas();
		_33.Colour = Colour( 144, 9, 0 );
		_33.Pos = VectorScreen( rel.X * 0.1317715959004392, rel.Y * 0.1822916666666667 );
		_33.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_33.AddFlags( GUI_FLAG_MOUSECTRL );
		_34 = GUICanvas();
		_34.Colour = Colour( 81, 81, 81 );
		_34.Pos = VectorScreen( rel.X * 0.1903367496339678, rel.Y * 0.1822916666666667 );
		_34.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_34.AddFlags( GUI_FLAG_MOUSECTRL );
		_35 = GUICanvas();
		_35.Colour = Colour( 36, 225, 225 );
		_35.Pos = VectorScreen( rel.X * 0.2489019033674963, rel.Y * 0.1822916666666667 );
		_35.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_35.AddFlags( GUI_FLAG_MOUSECTRL );
		_36 = GUICanvas();
		_36.Colour = Colour( 36, 36, 225 );
		_36.Pos = VectorScreen( rel.X * 0.3074670571010249, rel.Y * 0.1822916666666667 );
		_36.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_36.AddFlags( GUI_FLAG_MOUSECTRL );
		_37 = GUICanvas();
		_37.Colour = Colour( 144, 225, 36 );
		_37.Pos = VectorScreen( rel.X * 0.3660322108345534, rel.Y * 0.1822916666666667 );
		_37.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_37.AddFlags( GUI_FLAG_MOUSECTRL );
		_38 = GUICanvas();
		_38.Colour = Colour( 225, 225, 81 );
		_38.Pos = VectorScreen( rel.X * 0.424597364568082, rel.Y * 0.1822916666666667 );
		_38.Size = VectorScreen( rel.X * 0.0505124450951684, rel.Y * 0.0651041666666667 );
		_38.AddFlags( GUI_FLAG_MOUSECTRL );
		
		box = GUICheckbox();
		box.Pos = VectorScreen( rel.X * 0.1756954612005857, rel.Y * 0.3190104166666667 );
		box.Size = VectorScreen( rel.X * 0.0124450951683748, rel.Y * 0.0208333333333333 );
		box.AddFlags( GUI_FLAG_CHECKBOX_CHECKED );
		
		box1 = GUICheckbox();
		box1.Pos = VectorScreen( rel.X * 0.2635431918008785, rel.Y * 0.3190104166666667 );
		box1.Size = VectorScreen( rel.X * 0.0124450951683748, rel.Y * 0.0208333333333333 );

		label = GUILabel();
		label.Text = "$500 per colour.";
		label.FontSize = ( rel.X * 0.0080527086383602 );
		label.TextColour = Colour( 255, 255, 255 );
		label.FontFlags = GUI_FFLAG_BOLD;
		label.TextAlignment = GUI_ALIGN_CENTER;
		label.FontName = "Tahoma";
		label.Pos.Y = rel.Y * 0.3580729166666667;
		this.centerinchildX( this.window, this.label );

		label1 = GUILabel();
		label1.Text = "Colour 1";
		label1.Size = VectorScreen( rel.X * 0.4319180087847731, rel.Y * 0.6536458333333333 );
		label1.TextColour =  Colour( 255, 255, 255 );
		label1.FontFlags =  GUI_FFLAG_BOLD;
		label1.FontSize = ( rel.X * 0.0080527086383602 );
		label1.FontName = "Tahoma";
		label1.TextAlignment = GUI_ALIGN_CENTER;
		
		label2 = GUILabel();
		label2.Text = "Colour 2";
		label2.Size = VectorScreen( rel.X * 0.6076134699853587, rel.Y * 0.6536458333333333 );
		label2.TextColour =  Colour( 255, 255, 255 );
		label2.FontFlags =  GUI_FFLAG_BOLD;
		label2.FontSize = ( rel.X * 0.0080527086383602 );
		label2.FontName = "Tahoma";
		label2.TextAlignment = GUI_ALIGN_CENTER;

		withbtn = GUIButton(),
		withbtn.Pos = VectorScreen( rel.X * 0.3733528550512445, rel.Y * 0.3046875 );
		withbtn.Size = VectorScreen( rel.X * 0.0732064421669107, rel.Y * 0.0390625 );
		withbtn.Colour = Colour( 66, 70, 71, 255 );
		withbtn.Text = "Fix Veh",
		withbtn.TextColour = Colour( 255, 255, 255 ),
		withbtn.FontFlags = GUI_FFLAG_BOLD,
		withbtn.TextAlignment = GUI_ALIGN_CENTER;
		withbtn.FontName = "Tahoma";

		window.AddChild( _11 );
		window.AddChild( _12 );
		window.AddChild( _13 );
		window.AddChild( _14 );
		window.AddChild( _15 );
		window.AddChild( _16 );
		window.AddChild( _17 );
		window.AddChild( _18 );

		window.AddChild( _21 );
		window.AddChild( _22 );
		window.AddChild( _23 );
		window.AddChild( _24 );
		window.AddChild( _25 );
		window.AddChild( _26 );
		window.AddChild( _27 );
		window.AddChild( _28 );

		window.AddChild( _31 );
		window.AddChild( _32 );
		window.AddChild( _33 );
		window.AddChild( _34 );
		window.AddChild( _35 );
		window.AddChild( _36 );
		window.AddChild( _37 );
		window.AddChild( _38 );

		window.AddChild( box );
		window.AddChild( box1 );
		window.AddChild( label );
		window.AddChild( label1 );
		window.AddChild( label2 );
		window.AddChild( withbtn );

		window.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_11.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_12.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL ); 
		_13.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_14.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_15.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_16.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_17.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_18.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_21.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_22.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_23.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_24.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_25.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_26.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_27.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_28.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_31.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_32.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_33.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_34.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_35.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_36.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_37.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_38.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		box.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		box1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		label.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );			
	}

	function Create()
	{
		window.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_11.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_12.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL ); 
		_13.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_14.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_15.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_16.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_17.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_18.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_21.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_22.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_23.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_24.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_25.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_26.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_27.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_28.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_31.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_32.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_33.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_34.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_35.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_36.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_37.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_38.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		box.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		box1.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		label.AddFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );

		this.checkbox = 1;
		
		GUI.SetMouseEnabled( true );
	}

	function Hide()
	{
		local message = Stream();

		window.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_11.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_12.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL ); 
		_13.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_14.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_15.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_16.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_17.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_18.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_21.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_22.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_23.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_24.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_25.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_26.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_27.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_28.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		_31.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_32.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_33.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_34.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_35.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_36.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_37.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		_38.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		box.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		box1.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		label.RemoveFlags( GUI_FLAG_VISIBLE | GUI_FLAG_KBCTRL );
		
		GUI.SetMouseEnabled( false );
		
		message.WriteInt( 500 );
		Server.SendData( message );
		
	}
	
	function onWindowClose( window )
	{
		this.Hide();
	}
	
	function onElementHoverOver( element )
	{
		if( window != null )
		{
			switch( element )
			{
				case _11:
				case _12: 
				case _13:
				case _14:
				case _15:
				case _16:
				case _17:
				case _18:
				case _21:
				case _22:
				case _23:
				case _24:
				case _25:
				case _26:
				case _27:
				case _28:
				case _31:
				case _32:
				case _33:
				case _34:
				case _35:
				case _36:
				case _37:
				case _38:
				element.Size.X+=4;
				element.Size.Y+=4;
				break;
				
				case withbtn:
				label.Text = "Fix vehicle - $1000";
				break;
			}
		}
	}
	
	function onElementHoverOut( element )
	{
		if( window != null )
		{
			switch( element )
			{
				case _11:
				case _12: 
				case _13:
				case _14:
				case _15:
				case _16:
				case _17:
				case _18:
				case _21:
				case _22:
				case _23:
				case _24:
				case _25:
				case _26:
				case _27:
				case _28:
				case _31:
				case _32:
				case _33:
				case _34:
				case _35:
				case _36:
				case _37:
				case _38:
				element.Size.X-=4;
				element.Size.Y-=4;
				break;
				
				case withbtn:
				label.Text = "$500 per colour.";
				break;
			}
		}
	}
	
	function onElementClick( element, mouseX, mouseY )
	{
		if( window != null )
		{
			switch( element )
			{
				case _11:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "105:"+checkbox );
				Server.SendData(message);
				break;
				case _12:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "111:"+checkbox );
				Server.SendData(message);
				break;
				case _13:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "118:"+checkbox );
				Server.SendData(message);
				break;
				case _14:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "129:"+checkbox );
				Server.SendData(message);
				break;
				case _15:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "138:"+checkbox );
				Server.SendData(message);
				break;
				case _16:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "142:"+checkbox );
				Server.SendData(message);
				break;
				case _17:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "147:"+checkbox );
				Server.SendData(message);
				break;
				case _18:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "151:"+checkbox );
				Server.SendData(message);
				break;
				
				case _21:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "153:"+checkbox );
				Server.SendData(message);
				break;
				case _22:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "59:"+checkbox );
				Server.SendData(message);
				break;
				case _23:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "166:"+checkbox );
				Server.SendData(message);
				break;
				case _24:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "196:"+checkbox );
				Server.SendData(message);
				break;
				case _25:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "195:"+checkbox );
				Server.SendData(message);
				break;
				case _26:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "188:"+checkbox );
				Server.SendData(message);
				break;
				case _27:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "182:"+checkbox );
				Server.SendData(message);
				break;
				case _28:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "173:"+checkbox );
				Server.SendData(message);
				break;

				case _31:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "101:"+checkbox );
				Server.SendData(message);
				break;
				case _32:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "100:"+checkbox );
				Server.SendData(message);
				break;
				case _33:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "146:"+checkbox );
				Server.SendData(message);
				break;
				case _34:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "156:"+checkbox );
				Server.SendData(message);
				break;
				case _35:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "172:"+checkbox );
				Server.SendData(message);
				break;
				case _36:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "175:"+checkbox );
				Server.SendData(message);
				break;
				case _37:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "136:"+checkbox );
				Server.SendData(message);
				break;
				case _38:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "106:"+checkbox );
				Server.SendData(message);
				break;

				case withbtn:
				local message = Stream();
				message.WriteInt( 160 );
				message.WriteString( "fixveh" );
				Server.SendData(message);
				break;

			}
		}
	}
	
	function onServerData( type, str )
	{
		switch( type )
		{
			case 161:
			this.Create();
			break;
		}
	}

	function onCheckboxToggle( element, checked )
	{
		if( element == box && checked == true ) box1.RemoveFlags( GUI_FLAG_CHECKBOX_CHECKED ), checkbox = 1;
		else if( element == box1 && checked == true ) box.RemoveFlags( GUI_FLAG_CHECKBOX_CHECKED ), checkbox = 2;
		//else if( checked == false ) element.AddFlags( GUI_FLAG_CHECKBOX_CHECKED );
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
		

				
