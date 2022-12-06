dofile( "Miscs/Context.nut" );
dofile( "Miscs/ContextManager.nut" );
dofile( "Miscs/Handler.nut" );
dofile( "Miscs/Misc.nut" );
dofile( "Miscs/Execute.nut" );
dofile( "Miscs/Timer.nut" );
dofile( "Miscs/GUIElements.nut" );

dofile( "Events/Events.nut" );

/*dofile( "Classes/World.nut" );
dofile( "Classes/Memo.nut" );
dofile( "Classes/BuyVehicle.nut" );
dofile( "Classes/GetVeh.nut" );*/
dofile( "Classes/Player.nut" );
/*dofile( "Classes/Gagjik.nut" );
dofile( "Classes/TopPlayer.nut" );
dofile( "Classes/WorldSelect.nut" );*/
dofile( "Classes/Register.nut" );
dofile( "Classes/Login.nut" );
/*dofile( "Classes/ModeSelector.nut" );
dofile( "Classes/PlayerTitle.nut" );
dofile( "Classes/News.nut" );
dofile( "Classes/Lobbycredits.nut" );*/
dofile( "Classes/Announce.nut" );
dofile( "Classes/Robbery.nut" );
dofile( "Classes/Jailtime.nut" );
/*dofile( "Classes/Ammu.nut" );
dofile( "Classes/Tool.nut" );
dofile( "Classes/Items.nut" );
dofile( "Classes/Heli.nut" );
dofile( "Classes/Sunshine.nut" );
dofile( "Classes/Bike.nut" );
dofile( "Classes/Fun.nut" );
dofile( "Classes/Invent.nut" );
dofile( "Classes/Pns.nut" );
dofile( "Classes/Objlist.nut" );*/
dofile( "Classes/Property.nut" );
/*dofile( "Classes/Genrules.nut" );
dofile( "Classes/Housepass.nut" );*/
dofile( "Classes/Announce.nut" );
/*dofile( "Classes/Blackmarket.nut" );*/
dofile( "Classes/Progressbar.nut" );
/*dofile( "Classes/Musicshop.nut" );*/
dofile( "Classes/Alert.nut" );
/*dofile( "Classes/Helpmenu.nut" );
dofile( "Classes/HelpmenuText.nut" );
dofile( "Classes/Boat.nut" );*/
dofile( "Classes/ServerTD.nut" );
//dofile( "Classes/editor.nut" );

dofile( "Classes/Job/PoliceDuty.nut" );
dofile( "Classes/Job/PoliceDutySkinSelect.nut" );
dofile( "Classes/Job/Quitjob.nut" );
dofile( "Classes/Job/Corps.nut" );
dofile( "Classes/Job/DeathSpawn.nut" );
dofile( "Classes/Job/EMSSkinSelect.nut" );
dofile( "Classes/Job/TruckerMenu.nut" );
dofile( "Classes/Job/TruckerSkinSelect.nut" );
dofile( "Classes/Job/Shop.nut" );
dofile( "Classes/Job/SkinShop.nut" );
dofile( "Classes/Job/ReadOnlyMenu.nut" );
dofile( "Classes/Job/PropertyInfo.nut" );
dofile( "Classes/Job/VehicleShowroom.nut" );
dofile( "Classes/Job/VehicleShowroomMenu.nut" );
dofile( "Classes/Job/FAQMenu.nut" );
dofile( "Classes/Job/PlayerTD.nut" );

seterrorhandler( errorHandling );

ContextManager <- CContextManager();
Handler <- CHandler();

Handler.Create( "Excute", CExecute( "CExecute" ) );
Handler.Create( "GUIElement", CGUIElements( "GUIElement" ) );

//Handler.Create( "Memobox", CMemobox( "Memobox" ) );
Handler.Create( "PlayerHud", CPlayerHud( "PlayerHud" ) );
Handler.Create( "Register", CRegister( "Register" ) );
Handler.Create( "Login", CLogin( "Login" ) );
//Handler.Create( "Spawnselect", CWorldSelector( "Spawnselect" ) );
//Handler.Create( "Playertitle", CPTitle( "Playertitle" ) );
//Handler.Create( "News", CNews( "News" ) );
Handler.Create( "Announce", CAnnounce( "Announce" ) );
Handler.Create( "Robbery", CRobbery( "Robbery" ) );
Handler.Create( "Jail", CJailtime( "Jail" ) );
//Handler.Create( "Ammu", CAmmu( "Ammu" ) );
//Handler.Create( "Tool", CTool( "Tool" ) );
//Handler.Create( "Items", CItems( "Items" ) );
//Handler.Create( "Heli", CHeli( "Heli" ) );
//Handler.Create( "Car", CCar( "Car" ) );
//Handler.Create( "Bike", CBike( "Bike" ) );
//Handler.Create( "Fun", CFun( "Fun" ) );
//Handler.Create( "Invent", CInvent( "Invent" ) );
//Handler.Create( "Paint", CPaint( "Paint" ) );
//Handler.Create( "Objlist", CObjlist( "Objlist" ) );
Handler.Create( "Property", CProperty( "Property" ) );
//Handler.Create( "Rules", CRules( "Rules" ) );
//Handler.Create( "HousePass", CHPass( "HousePass" ) );
//Handler.Create( "Blackmarket", CBM( "Blackmarket" ) );
Handler.Create( "Progress", CProgress( "Progress" ) );
//Handler.Create( "Music", CMusic( "Music" ) );
Handler.Create( "Alert", CAlert( "Alert" ) );
//Handler.Create( "Help", CHelpmenu( "Help" ) );
//Handler.Create( "Boat", CBoat( "Boat" ) );
Handler.Create( "ServerTD", CServerTD( "ServerTD" ) );


Handler.Create( "PoliceDuty", CPoliceDuty( "PoliceDuty" ) );
Handler.Create( "PoliceDutySS", CPoliceDutySS( "PoliceDutySS" ) );
Handler.Create( "QuitJob", CQuitJob( "QuitJob" ) );
Handler.Create( "Corps", CCorpsTD( "Corps" ) );
Handler.Create( "Deathspawn", CDeathspawn( "Deathspawn" ) );
Handler.Create( "EMSDutySkinSelect", CEMSDutySkinSelect( "EMSDutySkinSelect" ) );
Handler.Create( "Trucking", CTrucking( "Trucking" ) );
Handler.Create( "TruckerSkinSelect", CTruckerDutySkinSelect( "TruckerSkinSelect" ) );
Handler.Create( "Shop", CShop( "Shop" ) );
Handler.Create( "SkinShop", CSkinShop( "SkinShop" ) );
Handler.Create( "ReadMenu", CMenu( "ReadMenu" ) );
Handler.Create( "PropertyInfo", CPropertyInfo( "PropertyInfo" ) );
Handler.Create( "VehicleShowroom", CVehicleShowroom( "VehicleShowroom" ) );
Handler.Create( "VehicleShowroomMenu", CShowroomMenu( "VehicleShowroomMenu" ) );
Handler.Create( "faq", CFaq( "faq" ) );
Handler.Create( "PlayerTD", CPlayerTD( "PlayerTD" ) );

