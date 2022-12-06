class Killmsgs
{
	PosY		=	null;
	TextInfo	=	null;
	TextInfo2	=	null;
	SpriteInfo	=	null;
	space		=	null;
	sX          =   null;
	sY          =   null;
	leftNamePos = 1.1;
	rightNamePos = 1.2;
	centerNamePos = 1.3;
	
	function constructor()
	{
		this.PosY	=	[0.3,0.35,0.4,0.45,0.5];
		this.TextInfo	=	array(5);
		this.TextInfo2	=	array(5);
		this.SpriteInfo	=	array(5);
		this.space		=		0;
		this.sX = GUI.GetScreenSize().X;
		this.sY = GUI.GetScreenSize().Y;

		this.UpdateCount();
	}
	
	function GetFontSize()
	{
		local f = 9;
		local size = f.tofloat() * (sqrt((this.sX.tofloat() * this.sY.tofloat()) / (640*480).tofloat())).tofloat();
		return size;
	}
	
	function GetTFontSize()
	{
		local f = 14;
		local size = f.tofloat() * (sqrt((this.sX.tofloat() * this.sY.tofloat()) / (640*480).tofloat())).tofloat();
		return size;
	}
	
	function UpdateCount()
	{
		this.SpriteInfo[4] 				=	GUISprite("lobby.png", VectorScreen.Relative(centerNamePos,0.5));
		this.SpriteInfo[4].Size			=	VectorScreen.Relative(20.0/640.0, 20/480.0);
		this.SpriteInfo[4].Alpha		=	0;
		this.TextInfo[4] 				=	GUILabel();
		this.TextInfo[4].Text			=	"Test";
		this.TextInfo[4].FontSize		=	GetFontSize();
		this.TextInfo[4].Alpha 			= 	0;
		this.TextInfo[4].FontFlags		=   GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
		this.TextInfo[4].Position		=	VectorScreen.Relative((this.leftNamePos*this.sX.tofloat() - this.TextInfo[4].TextSize.X.tofloat())/this.sX.tofloat(), 0.5);
		this.TextInfo2[4] 				=	GUILabel();
		this.TextInfo2[4].Position		=	VectorScreen.Relative((rightNamePos * this.sX.tofloat() + ((20.0/640.0)*this.sX.tofloat()))/this.sX.tofloat(), 0.5);
		this.TextInfo2[4].Text			=	"LLLLLLLLLLLLLLLLLLLLLLL";
		this.TextInfo2[4].FontSize		=	GetFontSize();
		this.TextInfo2[4].Alpha 		= 	0;
		this.TextInfo2[4].FontFlags		=   GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
		
		this.space						=	(this.sX.tofloat() - (this.TextInfo2[4].Position.X.tofloat() + this.TextInfo2[4].TextSize.X.tofloat())).tofloat() - GetTFontSize();
	}
	
	function DeathWindow(leftName, reason, rightName )
	{
		if( reason == "43" ) preReason = "44";
		
	//	image <- "" + reason + ".png"; 
		local image = "lobby.png"; 
		if (this.TextInfo[0]) 
		{
			this.TextInfo[0] 	=	null;
		}
		if(this.SpriteInfo[0])
		{
			this.SpriteInfo[0] 	=	null;
		}
		if (this.TextInfo2[0]) 
		{
			this.TextInfo2[0]	=	null;
		}
		for (local i=0; i<4; i++)
		{
			if (TextInfo[i+1])
			{
				this.TextInfo[i]			=	this.TextInfo[i+1];
				this.TextInfo[i].Position	=	VectorScreen.Relative((this.leftNamePos*this.sX.tofloat() - this.TextInfo[4].TextSize.X.tofloat() + space.tofloat())/this.sX.tofloat(), this.PosY[i]);
			}
  
			if(SpriteInfo[i+1])
			{
				this.SpriteInfo[i]			=	this.SpriteInfo[i+1];
				this.SpriteInfo[i].Position	=	VectorScreen.Relative(((centerNamePos * this.sX.tofloat()) + space.tofloat())/this.sX.tofloat(),this.PosY[i]);
			}
  
			if(TextInfo2[i+1])
			{	
				this.TextInfo2[i] 			=	this.TextInfo2[i+1];
				this.TextInfo2[i].Position	=	VectorScreen.Relative((rightNamePos * this.sX.tofloat() + ((20.0/640.0)*this.sX.tofloat()) + space.tofloat())/this.sX.tofloat(), this.PosY[i]);
			}
		}

		this.SpriteInfo[4] 				=	GUISprite(image, VectorScreen.Relative(((centerNamePos * this.sX.tofloat()) + space.tofloat())/this.sX.tofloat(), 0.5));
		this.SpriteInfo[4].Size			=	VectorScreen.Relative(20.0/640.0, 20/480.0);
		this.TextInfo[4] 				=	GUILabel();
		this.TextInfo[4].Text			=	leftName;
		this.TextInfo[4].FontSize		=	GetFontSize();
	//	this.TextInfo[4].TextColour 	= 	Colour(r.tointeger(), g.tointeger(), b.tointeger());
		this.TextInfo[4].FontFlags		=   GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
		this.TextInfo[4].Position		=	VectorScreen.Relative((this.leftNamePos*this.sX.tofloat() - this.TextInfo[4].TextSize.X.tofloat() + space.tofloat())/this.sX.tofloat(), 0.5);
		this.TextInfo2[4] 				=	GUILabel();
		this.TextInfo2[4].Position		=	VectorScreen.Relative((rightNamePos * this.sX.tofloat() + ((20.0/640.0)*this.sX.tofloat()) + space.tofloat())/this.sX.tofloat(), 0.5);
		this.TextInfo2[4].Text			=	rightName;
		this.TextInfo2[4].FontSize		=	GetFontSize();
	//	this.TextInfo2[4].TextColour 	= 	Colour(r1.tointeger(), g1.tointeger(), b1.tointeger());
		this.TextInfo2[4].FontFlags		=   GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE;
	}
}

