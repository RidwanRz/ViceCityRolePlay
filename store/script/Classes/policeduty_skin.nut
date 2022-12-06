
skin <-
{
    Skins = null
    Skin1 = null
    Skin2 = null
    Skin3 = null
    Skin4 = null
    Skin5 = null
    Skin6 = null
    Skin7 = null
    Skin8 = null        
}

function skinnull()
{
    skin.Skins = null;
 skin.Skin1 = null;
 skin.Skin2 = null;
 skin.Skin3 = null;
    skin.Skin4 = null;
    skin.Skin5 = null;
    skin.Skin6 = null;
    skin.Skin7 = null;
    skin.Skin8 = null;
    GUI.SetMouseEnabled( false );
}

sX <- GUI.GetScreenSize().X;
sY <- GUI.GetScreenSize().Y;

function skinsgui()
{
   
skin.Skins = GUIWindow( VectorScreen( sX * 0.0896094, sY * 0.114583 ), VectorScreen( sX * 0.720000, sY * 0.794271 ), Colour( 255, 255, 255 ), "Select Skins" );
skin.Skins.TextColour = Colour( 255, 255, 255 );
skin.Skins.FontSize = 11;

skin.Skin1 = GUISprite( );
skin.Skin1.SetTexture( "skin1.png" );
skin.Skin1.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin1.Pos = VectorScreen( sX * 0.020, sY * 0.009 );

skin.Skin2 = GUISprite( );
skin.Skin2.SetTexture( "Police.png" );
skin.Skin2.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin2.Pos = VectorScreen( sX * 0.200, sY * 0.009 );

skin.Skin3 = GUISprite( );
skin.Skin3.SetTexture( "Swat.png" );
skin.Skin3.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin3.Pos = VectorScreen( sX * 0.380, sY * 0.009 );

skin.Skin4 = GUISprite( );
skin.Skin4.SetTexture( "Tommy.png" );
skin.Skin4.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin4.Pos = VectorScreen( sX * 0.550, sY * 0.009 );

skin.Skin5 = GUISprite( );
skin.Skin5.SetTexture( "black.png" );
skin.Skin5.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin5.Pos = VectorScreen( sX * 0.020, sY * 0.4 );

skin.Skin6 = GUISprite( );
skin.Skin6.SetTexture( "blue.png" );
skin.Skin6.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin6.Pos = VectorScreen( sX * 0.200, sY * 0.4 );

skin.Skin7 = GUISprite( );
skin.Skin7.SetTexture( "lance.png" );
skin.Skin7.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin7.Pos = VectorScreen( sX * 0.380, sY * 0.4 );

skin.Skin8 = GUISprite( );
skin.Skin8.SetTexture( "taxi.png" );
skin.Skin8.Size = VectorScreen( sX * 0.15111, sY * 0.311111 );
skin.Skin8.Pos = VectorScreen( sX * 0.550, sY * 0.4 );


skin.Skin1.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin2.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin3.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin4.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin5.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin6.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin7.AddFlags( GUI_FLAG_MOUSECTRL );
skin.Skin8.AddFlags( GUI_FLAG_MOUSECTRL );

skin.Skins.AddChild( skin.Skin1 );
skin.Skins.AddChild( skin.Skin2 );
skin.Skins.AddChild( skin.Skin3 );
skin.Skins.AddChild( skin.Skin4 );
skin.Skins.AddChild( skin.Skin5 );
skin.Skins.AddChild( skin.Skin6 );
skin.Skins.AddChild( skin.Skin7 );
skin.Skins.AddChild( skin.Skin8 );

GUI.SetMouseEnabled( true );
}