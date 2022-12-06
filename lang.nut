/* 

	EXAMPLE TO ADD YOUR OWN LANGAUGE:
	xx = [ "language", "your_new_lang_here" ]
	
	NOTE:
	You must keep the '%s' and hex codes just like english string
	
*/

Lang <- {

	// onPlayerJoin
	JoinAll = [ "[#808080]%s [#808080]joined the server." ],
	
	// onPlayerRequestSpawn
	Cop250Skill = [ "You need at least [#ffffff]250 copskill [#e60000]to with this spawn."],
	Cop500Skill = [ "You need at least [#ffffff]500 copskill [#e60000]to with this spawn."],
	WantedCop = [ "You cant spawn with this skin." ],
	GivePin = [ "You receiving [#ffffff]5 bobby pin." ]
	WelcomeMessage = [ "[#ffffff]Welcome to Virtual Reality RolePlay!" ]
	// onPlayerPart
	PartAll = [ "[#ffffff]%s [#009933]has [#ffffff]%s" ],

	// onPlayerDeath
	DeathAll = [ "[#ffffff]%s [#3366ff]has died. Possible cause [#ffffff]%s" ],
	
	// onPlayerKill / onPlayerTeamKill
	KillAll = [ "[#ffffff]%s [#999999]killed [#ffffff]%s [#999999]with [#ffffff]%s" ],
	
	// onPlayerChat
	MutedCantChat = [ "You cannot talk because you are muted!" ],
	MutedCantType = [ "You cannot use any command because you are muted!" ]
	
	// onPlayerCommand
	InvalidCmd = [ "Unknown command. Use /cmds" ],
	Stats = [ "Your stats" ]
	StatsDM1 = [ "Your DM stats" ]
	Stats1 = [ "[#009933]XP [#ffffff]%s/%s [#009933]Level [#ffffff]%s [#009933]Wantedlevel [#ffffff]%s [#009933]Copskill [#ffffff]%s" ],
	StatsSyntax = [ "Syntax, /stats [acc/cnr]" ]
	StatsAcc = [ "Your account" ]
	StatsAcc1 = [ "Position [#ffffff]%s [#009933]Total playtime [#ffffff]%s" ]
	StatsAcc2 = [ "Date Req [#ffffff]%s (%s ago)"]
	StatsDM = [ "DM Arena stats: [#009933]Kills [#ffffff]%s [#009933]Deaths [#ffffff]%s [#009933]Ratio [#ffffff]%s" ]
	StatsGang = [ "Gang [#ffffff]%s" ],
	CashInHad = [ "You have $%d in hand." ],
	BankInHad = [ "You have $%d in bank." ],
	BankNo = [ "You dont have bank account." ],
	SurNotInSphere = [ "You need to be inside VCPD sphere." ],
	CashDropped = [ "You dropped [#ffffff]$%s [#009933]on the floor." ],
	DropNotEnoughCash = [ "You dont have enough cash." ],
	DropCashSyntax = [ "Syntax, /dropcash [amount]" ],
	DMDes = [ "First you need some weapon before entering arena, you wont get any weapon while in arena. After you had weapons, you can goto DM Arena(Skull icon on radar)." ]
	
	HelpCmd = [ "(/) gencmds, playercmds, vehiclecmds, groupcmds, househelp, msgcmds, jobcmds" ]
	
	GPSHELP = [ "(/) loc(GPS LEVEL 1+), dis(GPS LEVEL 2+), checkcar(GPS LEVEL 3)" ]
		
	PropHelp = [ "(/) buyprop, property, collect, setpropmsg, sellprop, forsale" ]
	
	GenHelp = [ "(/) changepass, discord, forum, admins" ]

	IRCLink = [ "Discord invite link: https://discord.gg/S2VmYKuphp" ]
	ServerInfo = [ "[#ffffff]Kat & King Cops and Robbers [#009933]Version [#ffffff]v1.2" ]
	ServerCredits = [ "Server Owner [#ffffff]Kool_Kat, [#009933]Developed By[#ffffff] JMM(Jones), ImKiKi, [#009933]Mapped By [#ffffff]JMM(Jones)." ]
	ForumURL = [ "http://cnr.pl-community.com" ]
	
	PHelp = [ "(/) cash, bank, deposit, withdraw, paycheck, invent(inventory/items), use" ]

	VehHelp = [ "(/) car, parkcar, mycars, getcar, sellcar" ]

	JobHelp = [ "(/) cophelp, crimecmds, medichelp" ]
	
	HouseHelp = [ "(/) house, buyhouse, setwelcomemessage, sharehouse, delsharehouse, sethousepass, storewep, viewstorage, getwep, storeitem, getitem, addobject, objectlist, editsens, sellhouse, forsale" ]
	
	GangHelp = [ "(/) groups, g, gmanage" ]

	CopHelp = [ "Arrest any nearest criminal by pressing RIGHT CLICK, and then take him/her to nearest police station(big sphere)." ]
	CopHelp1 = [ "Commands: (/) coprules, wanted, coprules, sus, unsus, r, m(megaphone), restock" ]
	
	Medhelp = [ "Heal any player and earn cash by using right click." ]
	Medhelp1 = [ "Commands: /r " ]

	RPCmd = [ "(/) ad, me, call, sms, l, s, lw" ]
	
	// PlayerRob
	RobFail = [ "Robbery failed. Someone has robbed this place, pleast try again later." ]
	RobWait = [ "Pleast do not move while robbing." ]
	RobSucess = [ "[#ffffff]%s [#ff3399]has robbed [#ffffff]$%s [#ff3399]from [#ffffff]%s." ]
	RobAll = [ "[#ffffff]%s [#ff3399]has robbed [#ffffff]$%s [#ff3399]from [#ffffff]%s." ]
	
	// GetItemByList
	NoItem = [ "You got no item." ]
	Item = [ "[#ffffff]%s [#009933]Amount [#ffffff]%s" ]
	Item1 = [ "[#ffffff]%s, [#ffffff]%s [#009933]Amount [#ffffff]%s" ]
	
	// HandleSpawn
	F4 = [ "You can press [#ffffff]F4 [#00cc99]key to disable auto spawn." ]
	
	// RightHeal
	HealWithCash = [ "You healed [#ffffff]%s [#009933]and earned [#ffffff]$10." ]
	Heal = [ "You healed [#ffffff]%s." ]
	HealPlr = [ "You has been healed by [#ffffff]%s." ]
	HealNotAround = [ "You need near at injured player." ]
	
	// onMedicCmd
	NotCopORMedic = [ "You must be part of cop or medic to use this command." ]
	RadioSyntax = [ "Syntax, /r [text]" ]
	PoliceR = [ "[#668cff]%s %s: [#ffffff]%s" ]
	MedicR = [ "[Medic Radio] [#ffffff]%s: [#ffffff]%s" ]
	
	NotSpawn = [ "You must be spawned to use this command." ]
	Syntax911 = [ "Syntax, /911 [text]" ]
	Call911 = [ "[#ffffff]%s [#00cc99]is calling 911 in [#ffffff]%s" ]
	Call9111 = [ "For reason [#ffffff]%s" ]
	Call9112 = [ "Emergency team has been notified." ]
	
	// EnterToHeal
	FullHeal = [ "Your health is already full, you don't need to heal." ]
	HealWait = [ "You will be healed in 10 seconds." ]
	
	// Heal
	NoMoney = [ "You need [#ffffff]$%s [#e60000]to heal." ]
	FullyHealed = [ "You are fully healed." ]
	
	// onPickupPickedUp
	HouseForSale = [ "This house is for sale for $%d" ]
	HouseWelcomeMessage = [ "House: [#ffffff]%s" ]
	CashPickup = [ "You are picked [#ffffff]$%s, [#009933]Dropped by [#ffffff]%s." ]
	WeaponPickup = [ "You are picked [#ffffff]%s [#009933]with [#ffffff]%s ammo, [#009933]Dropped by [#ffffff]%s." ]
	BankPickup = [ "You are picked [#ffffff]$%s, [#ff3399]Total [#ffffff]$%s" ]
	NotEnoughHouse = [ "You need [#ffffff]$%s [#e60000]to buy this house." ]
	HouseBrough = [ "You successfully brough this house." ]
	
	// CheckArea
	NotInVault = [ "Get back to the vault!" ]
	PropWel = [ "[#ffffff]Shop Clerk says: %s" ]
	RobReward = [ "You got [#ffffff]$%s [#009933]from vault."]
	
	// onBizz
	NotInProperty = [ "You need to be inside business to use this command." ]
	PropNotForSale = [ "This business is not for sale." ]
	PropNotEnoughCash = [ "You need [#ffffff]$%s [#e60000]to [#e60000]buy this property." ]
	PropForSale = [ "This property is for sale for [#ffffff]$%s."]
	PropInfo = [ "Property ID [#ffffff]%s [#e6e600]Type [#ffffff]%s" ]
	PropHelp1 = [ "Owner [#ffffff]%s [#e6e600]Income [#ffffff]$%s" ]
	PropHelp2 = [ "Welcome message [#ffffff]%s" ]
	PropNotOwner = [ "You are not this property owner." ]
	NotIncome = [ "Nothing to collect." ]
	SetMsgPropSyntax = [ "Syntax, /setpropmsg [text]" ]
	SetMsgProp = [ "You changed property welcome message to [#ffffff]%s."]
	CollectPropIncome = [ "You collected $%d from %s." ]
	SellProp = [ "You sell your business %s and got $%d."]
	PropIncome = [ "Business: %s income: $%d" ]
	ChangeBizName = [ "You sucessfully changed this business name."]
	SetBizName = [ "Syntax, /setbizname [text]" ]
	SetBizWelcomeMessage = [ "You changed business welcome message to: %s." ]
	SetBizWelcomeMessageSyntax = [ "Syntax, /bizwelcomemessage [text]"]


	// BuyProp
	BuyProp = [ "You purchased business %s for $%d."]
	BuyProp1 = [ "Type /prophelp to learn more about property." ]
	PropNotEnoughCash = [ "You need $%d to purchase this business." ]


	// onCheckpointExited
	RobFailMove = [ "Robbery failed because you move." ]
	
	// BuyVehicle
	VehicleNotEnoughCash = [ "You need [#ffffff]$%s [#e60000]to buy this vehicle." ]
	VehicleBuyed = [ "You purchased [#ffffff]%s." ]
	
	// onVehicleCommand
	SucessPark = [ "Sucessfully parked your vehicle." ]
	SucessParkA = [ "Sucessfully parked this vehicle. Owner [#ffffff]%s [#009933]ID [#ffffff]%s" ]
	NotOwner = [ "You are not owner of this vehicle or you dont have permission to manage group vehicle." ]
	NotInVehicle = [ "You are not in vehicle." ]
	VehicleInfo = [ "Owner: %s Share: %s" ]
	VehicleInfo1 = [ "Vehicle: %s (ID:%s) Health: %d"]
	MyVehicle = [ "%s, %s (ID: %s)"]
	MyVehicle1 = [ "%s (ID: %s)" ]
	MyVehicle3 = [ "Your vehicle: %s" ]
	MyVehicleNoVehicle = [ "You don't own any vehicle." ]
	CantEnterCopCar = [ "You need to be cop to enter this car." ]
	
	InvalidIDNum = [ "ID must be in number." ]
	CantUseInInterior = [ "You cant use this command inside interior." ]
	GetcarSyntax = [ "Syntax, /getcar [id]" ]
	Getcar = [ "You are getting your vehicle [#ffffff]%s." ]
	GetcarIDNotFound = [ "Vehicle ID not found." ]
	
	ForSale = [ "For sale: House [#ffffff]%s [#009933]Property [#ffffff]%s" ]
	// onPlayerEnterVehicle
	VehicleEnter = [ "You are entering [#ffffff]%s, [#009933]Owned by [#ffffff]%s." ]
	VehicleEnterNoOwner = [ "This vehicle is unowned." ]
	
	// RightCuff
	CuffTakeFirst = [ "Take [#ffffff]%s [#3366ff]to nearest police station first." ]
	CuffSucess = [ "You cuffed [#ffffff]%s, [#009933]take him/her to nearest police station. (RED SPHERE) " ]
	CuffSucessCrime = [ "You have been cuffed. Use /paycaution after getting jailed to break out of prison." ]
	CuffNoNear = [ "You need near at wanted player." ]
	CuffCooldown = [ "You cannot cuff that player in less that 1 minute." ]
	// FindCuffedPlayer
	Uncuff = [ "You had been uncuffed." ]
	
	// FindCuffPlayer
	CuffFail = [ "Cuff failed, [#ffffff]%s [#3366ff]left the server." ]
	
	// Jail
	UnjailAll = [ "[#ffffff]%s [#3366ff]has been released from jail." ]
	
	
	// HandleCopReward
	JailReward = [ "You jailed %s. $%d will be added to your next paycheck." ]
	
	// Sur
	NoWanted = [ "You dont have any wanted level." ]
	SurJail = [ "[#ffffff]%s [#3366ff]has been jailed for [#ffffff]%s, [#3366ff]after surrendering." ]
	
	// JailSpawn
	JailSpawn = [ "[#ffffff]%s [#3366ff]has been jailed for [#ffffff]%s." ]
	
	// onCopCommand
	NotACop = [ "You are not on law enforcement duty." ]
	
	SusSyntax = [ "Syntax, /sur [player] [reason]" ]
	UnknownPlr = [ "Unknown player." ]
	PlrNotSpawned = [ "This player is not spawned." ]
	CantSusJailedPlr = [ "You cant suspect jailed player." ]
	CantSusPlr = [ "You cant suspect that player." ]
	SusSucess = [ "[#ffffff]%s [#3366ff]has suspected [#ffffff]%s [#3366ff]Reason [#ffffff]%s" ]
	
	UnSusSyntax = [ "Syntax, /unsus [player] [reason]" ]
	UnSusSucess = [ "[#ffffff]%s [#3366ff]has unsus [#ffffff]%s [#3366ff]Reason [#ffffff]%s" ]
	CantUnsusPlr = [ "You cant unsus that player." ]
	
	PayCauNeedCash = [ "You need [#ffffff]$%s [#e60000]to use this command." ]
	PayCauNotJailed = [ "You are not jailed." ]
	PayCauRel = [ "[#ffffff]%s [#3366ff]has been released from jail using /paycaution" ]
	
	WantedList = [ "[#ffffff]%s, [#009933]Player [#ffffff]%s [#009933]Wantedlevel [#ffffff]%s" ]
	WantedList1 = [ "[#009933]Player [#ffffff]%s [#009933]Wantedlevel [#ffffff]%s" ]
	WantedList2 = [ "Wanted player online: %s" ]
	WantedList3 = [ "To check their crime use /crime" ]
	WantedNoWanted = [ "No online wanted player."]
	
	// ReFillVCPD
	RefillVCPD = [ "Refilled weapon ammo and armour." ]
	
	// onHouseCommand
	NotInHouse = [ "You need to be inside house." ]
	HouseNotForSale = [ "This house is not sale." ]
	
	SpawnHouseSyntax = [ "Syntax, /spawnhouse [on/off]" ]
	NotOwnerShared = [ "You are not owner or shared." ]
	NotOwnerShared2 = [ "You are not owner or you dont have permission to manage group HQ." ]
	SpawnHouseAlreadyOn = [ "House spawn already enable." ]
	SpawnHouseAlreadyOff = [ "House spawn already disable." ]
	SpawnHouseOn = [ "You enabled spawn house." ]
	SpawnHouseOff = [ "You disable spawn house." ]
	
	HouseInfo = [ "This house is owned by %s." ]
	HouseInfo1 = [ "House name: %s" ]
	HouseInfo2 = [ "Welcome message: %s" ]
	HouseType = [ "House type: [#ffffff]%s" ]
	HouseInfo3 = [ "Currently share with: %s" ]
	HouseOwned = [ "You own this house." ]

	HWelSyntax = [ "Syntax, /setwelcomemessage [text]" ]
	HWelSucess = [ "You set your house welcome message to: %s." ]
	
	ShareHouseSyntax = [ "Syntax, /sharehouse [player]" ]
	ShareHouseAlreadyShared = [ "You already shared your house to this player." ]
	HouseNotOwner = [ "You are not owner." ]
	HouseShare = [ "You are shared your house %s to %s." ]
	HouseShare1 = [ "%s has shared his/her house %s to you." ]
	
	DelShareSyntax = [ "Syntax, /delsharehouse [player] " ]
	DelShareNotInShareList = [ "This player is not in house share list." ]
	DelShareSucess = [ "You delshare your house %s to %s." ]
	DelShareSucess1 = [ "%s has delshared his/her house %s to you." ]
	
	SetHPassSyntax = [ "Syntax, /sethousepass [password]" ]
	SetHPassSucess = [ "You changed your house password to [#ffffff]%s." ]
	
	WepStorage = [ "%s, %s (%s)" ]
	WepStorage1 = [ "%s (%s)" ]
	WepStorage3 = [ "Storage in this house: %s" ]
	WepStorageNo = [ "You dont have anything in storage." ]
	
	StorewepSyntax = [ "Syntax, /store [quatity] [item]" ]
	StorewepUnarmed = [ "You cant store this weapon." ]
	StorewepNoAmmo = [ "You dont have enough ammo." ]
	StorewepNoNum = [ "Ammo must be in number." ]
	StorewepSucess = [ "You are stored weapon [#ffffff]%s [#009933]with ammo [#ffffff]%s [#009933]into storage." ]
	AmmoLimit = [ "House storage limit is exceeded. Max %d"]
	
	GetwepSyntax = [ "Syntax, /load [quatity] [item]" ]
	GetwepInvalidAmmo = [ "You dont have enough ammo in your storage." ]
	GetwepInvalidAmmo = [ "Invalid ammo. " ]
	GetwepNotExist = [ "This weapon is not exist in storage." ]
	GetwepSucess = [ "You got weapon [#ffffff]%s [#009933]with ammo [#ffffff]%s [#009933]from your storage." ]
	DontHaveEnoughItemInStorage = [ "You dont have require amount in storage." ]
	DontHaveSuchItemInStorage = [ "You dont have such item in storage." ]

	SellHouse = [ "You sold your house and you for $%d."]
	
	StoreItemSyntax = [ "Syntax, /storeitem [item] [amount]" ]
	InvalidItemx2 = [ "Invalid item." ]
	InvalidItemx3 = [ "Valid item should be [#ffffff]bomb, bobby, kitkat, medickit, lockpick [#e60000]OR [#ffffff]funiture ID." ]
	StoreItemNoNum = [ "Amount must be in number." ]
	StoreItemLimit = [ "Item storage limit is exceeded. Max [#ffffff]%s"]
	StoreItem = [ "You stored %s (%d) into your property." ]
	StoreItemInvalidAmout = [ "Invalid amount." ]
	
	GetItemSyntax = [ "Syntax, /getitem [item] [amount]" ]
	GetItemInvalidAmmo = [ "You dont have enough amount in storage." ]
	GetItemDoesNotExist = [ "This item does not exit in storage." ]
	GetItem = [ "You getting item [#ffffff]%s [#009933]with amount [#ffffff]%s." ]
	
	StorageSyntax = [ "Syntax, /viewstorage [weapon/item]"]
	ItemStorage = [ "Item storage: %s" ]
	NOItemStorage = [ "There is no item in this storage." ]
	ItemStorage1 = [ "[#009933]Item [#ffffff]%s [#009933]Amount [#ffffff]%s"]
	ItemStorage2 = [ "[#ffffff]%s, [#009933]Item [#ffffff]%s [#009933]Amount [#ffffff]%s" ]


	// BuyHouse
	BuyhouseNotEnoughCash = [ "You need [#ffffff]$%s [#e60000]to buy this house." ]
	BuyHouse = [ "You purchased this house." ]
	BuyHouse1 = [ "Type /househelp to learn more about house system." ]
	
	// CheckHousePass
	WrongHPass = [ "Wrong house password." ]
	ChangeHPass = [ "You changed your house password to [#ffffff]%s." ]
	
	// Class: Player
	AutoLogged = [ "You were auto logged." ]
	LoggedAs = [ "%s [#00cc99]has logged as [#ffffff]%s" ]
	AutoLoggedAs = [ "%s [#00cc99]has auto logged as [#ffffff]%s" ]
	Register = [ "You are registered." ]
	Logged = [ "You are logged." ]
	
	// CreateBankAccount
	BankCreated = [ "Successfully created bank account!" ]
	BankCantCreate = [ "You need [#ffffff]$1000 [#e60000]to create a bank account." ]
	
	// ProcessBank
	CashNotInNum = [ "Amount be be in number." ]
	CashNotEnough = [ "You dont have enough cash." ]
	CashDeposit = [ "You are deposited $%d." ]
	
	BankNotEnough = [ "You dont have enough bank cash to withdraw." ]
	BankWithdraw = [ "You are withdrew $%d from the bank." ]
	NotInBank = [ "You need to be at bank to use this command." ]

	// BuyWeapon
	WepNotEnoughCash = [ "You need [#ffffff]$%s [#e60000]to buy this weapon." ]
	BombNotEnoughXP = [ "You need at least [#ffffff]200 XP [#e60000]to buy this bomb." ]
	BuyBomb = [ "You purchased Bomb." ]
	BuyWep = [ "You purchased [#ffffff]%s." ]

	// BuyItem
	ItemNotECash = [ "You need [#ffffff]$%s [#e60000]to buy this item." ]
	ItemBuy = [ "You purchase item [#ffffff]%s."]
	
	// onPlayerCmd 
	WepCantDrop = [ "You cant drop this weapon." ]
	WepDropSyntax = [ "Syntax, /dropwep [ammo]" ]
	WepDropDuty = [ "You cannot drop any weapon while on cop duty." ]
	WepDropNoAmmo = [ "You dont have enough ammo." ]
	WepDrop = [ "You dropped weapon [#ffffff]%s [#009933]with ammo [#ffffff]%s [#009933]on the ground." ]
	
	AdNeedCash = [ "You need $500 to use this command." ]
	AdSyntax = [ "Syntax, /ad [text]" ]
	Ad = [ "[#ffffff]%s, [#00cc99]Contact [#ffffff]%s" ]
	
	MeNeedCash = [ "You need $100 to use this command." ]
	MeSyntax = [ "Syntax, /me [text]" ]
	
	SmsNeedCash = [ "You need $10 to use this command." ]
	SmsSyntax = [ "Syntax, /sms [player] [text]" ]
	SmsTo = [ "Sending message to [#ffffff]%s [#009933]with text [#ffffff]%s" ]
	SmsRev = [ "Recving message from [#ffffff]%s [#00cc99]with text [#ffffff]%s" ]
	PlrNeedSpawn = [ "This player need to be spawned." ]
	
	PlantbombNeedVault = [ "You need to at bank vault to plant bomb." ]
	NoBomb = [ "You dont have any bomb." ]
	BankRobInProcess = [ "Robbery in process, pleast try again later." ]
	BankRobWait = [ "Pleast wait [#ffffff]%s [#e60000]before you can crack the vault door." ]
	Plantbomb = [ "Planting a bomb, do not leave the vault. Bomb will explode in 15 seconds." ]
	
	ItemsS = [ "Your item: [#ffffff]%s" ]
	
	NoAdminOnline = [ "None of the staff is online but we are still watching you!" ]
	AdminOnline = [ "Staff online: " ]
	
	NoBob = [ "You need bobby pin to use this command." ]
	NoGPS1 = [ "You need a Level 1 or higher GPS to use this command." ]
	NoGPS2 = [ "You need a Level 2 or higher GPS to use this command." ]
	NoGPS3 = [ "You need a Level 3 GPS to use this command." ]
	NoCuff = [ "You are not cuffed." ]
	BreakCuff1	= [ "%s [#e60000]has broke the cuff." ]
	
	// ExplodeVault 
	BanrobFail = [ "Robbery failed, you are not in vault." ]
	Banrob = [ "[#ffffff]%s [#ff3399]has cracked the vault door." ]

	// F4
	F4Dis = [ "You disable auto spawn." ]
	F4Ena = [ "You enable auto spawn."]
	
	// onGange
	AlreadyGang = [ "You already in a gang." ]
	CopNotAllow = [ "Cop cannot use this command." ]
	GangNieExist = [ "This gang does not exist." ]
	NotGangLeader = [ "You are not gang leader." ]
	NotInGang = [ "You are not in any gang." ]
	GangAlreadyExist = [ "This gang already exist." ]
	
	NeedCashToGang = [ "You need [#ffffff]$50000 [#e60000]to create a gang." ]
	CreategangSyntax = [ "Syntax, /creategang [gangname]" ]
	Creategang = [ "Sucessfully founded gang [#ffffff]%s (gangtag: %s), [#009933]use /ganghelp for more information." ]
	
	SetgangircSyntax = [ "Syntax, /setgangirc [irc channel]" ]
	SetgangircUsed = [ "This channel already used by other gang." ]
	Setgangirc = [ "You has set [#ffffff]%s [#009933]as irc echo. Type !verifygang to comfirm your gang irc. NOTE: You must be channel owner to use this command." ]
	
	GanginfoSyntax = [ "Syntax, /ganginfo [group tag]" ]
	GanginfoInvalidGangTag = [ "Invalid gang tag." ]
	Ganginfo = [ "Gang tag [#ffffff]%s [#93a5c1]Name [#ffffff]%s" ]
	Ganginfo1 = [ "Leader[#ffffff] %s [#93a5c1]Members [#ffffff]%s" ]
	Ganginfo2 = [ "Gang cash [#ffffff]$%s [#93a5c1]Skin [#ffffff]%s" ]
	
	GanginviteSyntax = [ "Syntax, /ganginvite [player]" ]
	GanginviteNotLogged = [ "This player is not logged." ]
	GanginviteAlreadyIngang = [ "This player already in a gang." ]
	GanginvitePending = [ "This player already have pending gang request." ]
	Ganginvite = [ "You are invite %s [#009933]to your gang." ]
	Ganginvite1 = [ "%s [#93a5c1]are invite you to gang [#ffffff]%s" ]
	Ganginvite2 = [ "Type /gangaccept to join OR /gangreject to deny request." ]
	
	GangNotPending = [ "You dont have any pending request." ]
	
	GangJoin = [ "%s joined the gang." ]
	GangReject = [ "%s has rejected the gang join request." ]
	
	GangkickSyntax = [ "Syntax, /gangkick [player]" ]
	GangkickSelf = [ "You cannot kick yourself." ]
	GangkickNonGangMember = [ "This player is not gang member." ]
	Gangkick = [ "Leader %s [#93a5c1]has kicked [#ffffff]%s [#93a5c1]from gang." ]
	
	GangHouse = [ "%s [#93a5c1]has set [#ffffff]%s [#93a5c1]as gang house." ]
	
	NotAGangHouse = [ "This is not a gang house." ]
	StoregangcashSyntax = [ "Syntax, /storegangcash [amount]" ]
	Storegangcash = [ "%s [#93a5c1]has stored [#ffffff]$%s [#93a5c1]into gang house." ]
	
	GetgangcashSyntax = [ "Syntax, /getgangcash [amount]" ]
	Getgangcash = [ "%s [#93a5c1]has withdraw [#ffffff]$%s [#93a5c1]from gang house." ]
	
	SetgangskinSyntax = [ "Syntax, /setgangskin [id]" ]
	SetgangskinNoNum = [ "Skin id must be in number." ]
	SetgangskinInvalid = [ "Skin id must between 1 and 150." ]
	Setgangskin = [ "Leader %s [#93a5c1]has set skin id [#ffffff]%s [#93a5c1]as gang skin." ]
	
	SetgangcarSyntax = [ "Syntax, /setgangcar [1/2]" ]
	SetgangcarSlotNoNum = [ "Slot must be in number." ]
	Setgangcar = [ "Leader [#ffffff]%s [#93a5c1]has set vehicle [#ffffff]%s [#93a5c1]as gang vehicle." ]
	Setgangcar1 = [ "Leader [#ffffff]%s [#93a5c1]has set vehicle [#ffffff]%s [#93a5c1]as second gang vehicle."]
	
	GetgangcarInsideCar = [ "You cannot use this commands while in vehicle." ]
	GetgangcarSlotNotAva = [ "Ask gang leader to set gang vehicle." ]
	GetgangcarSyntax = [ "Syntax, /getgangcar [1/2]" ]
	GetgangcarSlotNotAva1 = [ "Ask gang leader to set second gang vehicle." ]
	Getgangcar = [ "You are getting your gang vehicle [#ffffff]%s." ]
	
	LeavegangLeader = [ "Leader are not allow to leave gang." ]
	Leavegang = [ "%s [#93a5c1]has left the gang." ]
	
	Listgang = [ "List of gang" ]
	Listgang1 = [ "Gang tag [#ffffff]%s [#93a5c1]Name [#ffffff]%s [#93a5c1]Leader [#ffffff]%s" ]
	EndGanglist = [ "End of gang list." ]
	
	ChangegangnameSyntax = [ "Syntax, /changegangname [text]" ]
	Changegangname = [ "Leader [#ffffff]%s [#93a5c1]has change gang name to [#ffffff]%s." ]
	
	// GangHelp
	GangNeedHelp = [ "%s [#93a5c1]need help at [#ffffff]%s [#93a5c1]Distance [#ffffff]%s" ]
	
	GangChat = [ "Gang chat: %s: [#ffffff]%s"]
	
	// Event
	E1_Start = [ "The military has loaded some military equipment into truck in Vice Port."]
	AccWrongPass = [ "Wrong password." ]
	E1_CopEnter = [ "Drive this truck to [#ffffff]military base." ]
	E1_CivEnter = [ "Drive this truck to [#ffffff]colonel lockup, Little Havana." ]
	E1_CopSucess = [ "You successfully delivered this truck and got [#ffffff]$1000, 5XP [#009933]and [#ffffff]1 Copskill."]
	E1_CopSucessAll = [ "The truck has been arrived safety." ]
	E1_CivSucess = [ "You successfully delivered this truck and got [#ffffff]$100, 2XP [#009933]and weapon [#ffffff]MP5, M60."]
	E1_CivSucessAll = [ "The truck has been stolen." ]
	E1_Destroy = [ "The truck has been destroyed." ]
	
	NeedXP = [ "You need at least [#ffffff]level %s [#e60000]to use this command." ]
	NeedXPWeapon = [ "You need [#ffffff]50XP [#e60000]to buy weapon."]
	
	PaintCar = [ "Changed your vehicle colour." ]
	PaintNotEnoughCash = [ "You need [#ffffff]$500 [#e60000]to change your vehicle colour." ]
	
	FixVeh = [ "Fixed your vehicle." ]
	FixAlready100 = [ "You no need to fix your vehicle." ]
	FixNotEnoughCash = [ "You need [#ffffff]$1000 [#e60000]to fix your vehicle." ]
	
	EnterDMCop = [ "Cop are not allow to enter." ]
	EnterDMNoCash = [ "You need [#ffffff]$500 [#e60000]to enter arena." ]
	EnterDM = [ "You entered DM arena. Type /stats DM to check your DM arena stats." ]
	ExitDM = [ "You exited DM arena." ]
	KillDM = [ "You killed [#ffffff]%s. [#009933]Weapon [#ffffff]%s [#009933]Bodypart [#ffffff]%s [#009933]Distance [#ffffff]%s" ]
	KillDM1 = [ "You killed by [#ffffff]%s. [#009933]Weapon [#ffffff]%s [#009933]Bodypart [#ffffff]%s [#009933]Distance [#ffffff]%s" ]

	ObjectNotExist = [ "This object does not exist." ]
	ObjDel = [ "Object deleted." ]
	ObjSave = [ "Object saved." ]
	
	AddObjectSyntax = [ "Syntax, /addobject [object id]" ]
	ObjNotNum = [ "Object id must be in number." ]
	AddObjEx = [ "Object id must between 100 and 103."]
	InvalidItem = [ "You dont have any [#ffffff]%s." ]
	AddObject = [ "Adding object [#ffffff]%s."]
	Objectlist = [ "[#009933]Model [#ffffff]%s [#009933]ID [#ffffff]%s" ]
	Objectlist1 = [ "%s, [#009933]Model [#ffffff]%s [#009933]ID [#ffffff]%s"]
	Objectlist3 = [ "Object list: %s" ]
	Objectlistnoobject = [ "There is no object in this house." ]
	EditObjectSyntax = [ "Syntax, /editobject [id]" ]
	ObjNotNum = [ "ID must be in number." ]
	EditObjStillEdit = [ "You are still editing object." ]
	EditObjectSomeoneEdit = [ "Someone is editing this object." ]
	EditObject = [ "You are editing object [#ffffff]%s." ]
	
	CopCantRob = [ "Cops cannot rob bank." ]	
	
	//admin v2
	KickbanTimered1						= [ "Your ban is set to expire on [#ffffff]%s" ]
	UnbanForum							= [ "Post an unban appeal on [#ffffff]%s" ]
	MuteNotice							= [ "You are currently muted by [#ffffff]%s %sReason [#ffffff]%s %sOn [#ffffff]%s" ]
	UnmuteForum 						= [ "Post unshun appeal on [#ffffff]%s" ]
	UnmuteDuration						= [ "You mute is set to expire on [#ffffff]%s" ]
	InstanceExeeded						= [ "Your account registration limit has exeeded." ]
	AMuteTimeredAll						= [ "Admin [#ffffff]%s [#00cc99]has muted [#ffffff]%s [#00cc99]Reason [#ffffff]%s [#00cc99]Duration [#ffffff]%s" ]
	WorldUnbanPlrNotBanned				= [ "Target player is not banned." ]
	ATargetNotFound						= [ "Target player account not found." ]
	AKickSyntax							= [ "Syntax, /kick [player] [reason]" ]
	ABanSyntax 							= [ "Syntax, /ban [player] [y/w/d/h/m] [reason]" ]
	AMuteSyntax							= [ "Syntax, /mute [player/all] [y/w/d/h/m] [reason]" ]
	AMuteSyntaxMod						= [ "Syntax, /mute [player] [y/w/d/h/m] [reason]" ]	
	AUnmuteSyntax						= [ "Syntax, /unmute [player/all]" ]
	AUnmuteSyntaxMod					= [ "Syntax, /unmute [player]" ]
	AGotoSyntax 						= [ "Syntax, /agoto [player]" ]
	AGotolocSyntax						= [ "Syntax, /agotoloc [location]" ]
	AGotoworldSyntax					= [ "Syntax, /gotoworld [world]" ]
	ASetpermissionSyntax				= [ "Syntax, /setpermission [player] [admin/mapper] [level]" ]
	ASetrankSyntax						= [ "Syntax, /setrank [player] [admin/mapper] [name]" ]
	AGetSyntax							= [ "Syntax, /get [player/all/allworld]" ]
	AGetSyntaxMod 						= [ "Syntax, /get [player/allworld]" ] 
	ARewardCashSyntax					= [ "Syntax, /rewardcash [player] [amount]" ]
	ARewardCoinSyntax					= [ "Syntax, /rewardcoin [player] [amount]" ]
	AExecuteSyntax						= [ "Syntax, /exe [code]" ]
	AExecuteClientSyntax				= [ "Syntax, /exec [code]" ]
	ASetTimeSyntax						= [ "Syntax, /settime [hour] [minute]" ]
	ASetWeatherSyntax					= [ "Syntax, /setweather [id]" ]
	AHealSyntax							= [ "Syntax, /sethp [player/all/allworld] [value]" ]
	AHealSyntaxMod						= [ "Syntax, /sethp [player/allworld] [value]" ]	
	AAnnSyntax							= [ "Syntax, /ann [player/all/allworld] [text]" ]
	ASpawnvehSyntax						= [ "Syntax, /spawnveh [model]" ]
	ASetWepSyntax						= [ "Syntax, /setwep [player/all/allworld] [weapon] [ammo]" ]
	ASetWepSyntaxMod					= [ "Syntax, /setwep [player/allworld] [weapon] [ammo]" ]
	ASetspawnlocSyntax					= [ "Syntax, /setspawnloc [player] [set/off/location]" ]
	AUnbanSyntax						= [ "Syntax, /unban [full name]" ]
	ASetVIPSyntax						= [ "Syntax, /setvip [player] [temp/permanent/take]" ]
	ASetPlayerOptionSyntax				= [ "Syntax, /setplayeroption [player/all/allworld] [canattack/cantattack/canmove/cantmove]" ]
	ASetPlayerOptionSyntaxMod			= [ "Syntax, /setplayeroption [player/allworld] [canattack/cantattack/canmove/cantmove]" ]	
	ASetArmSyntax						= [ "Syntax, /setarm [player/all/allworld] [value]" ]
	AKickAll							= [ "Admin %s [#e60000]has kicked [#ffffff]%s [#e60000]Reason [#ffffff]%s" ]
	CantUseOnHighCmd					= [ "You cannot use this command on higher staff." ]
	CantUseCommandSelf					= [ "You cant use this command on yourself." ]
	AWrongTimeFormat					= [ "Wrong time format. It should be ?y/?w/?d/?h/?m." ]
	AUnbanAll							= [ "[#ffffff]%s %s %shas unbanned [#ffffff]%s" ]
	ATargetNotBanned					= [ "Target player is not banned." ]
	ATargetNotFound						= [ "Target player account not found." ]
	AMuteAll 							= [ "[#ffffff]%s %s %shas muted all players. Reason [#ffffff]%s %sDuration [#ffffff]%s" ]
	AUnmuteAll							= [ "[#ffffff]%s %s %shas unmuted all players." ]
	AUnmuteAllPlr						= [ "[#ffffff]%shas unmuted [#ffffff]%s" ]
	ATargetNotMuted						= [ "Target player is not muted." ]
	StaffGotoPlr						= [ "[#ffffff]%s %s %shas teleport to [#ffffff]%s" ]
	StaffGotoWorld						= [ "[#ffffff]%s %s %shas switched to world [#ffffff]%s" ]
	StaffSetAdminLevel					= [ "[#ffffff]%s %s %shas set [#ffffff]%s %sadmin permission to [#ffffff]%s" ]
	StaffLevelInvalid					= [ "Admin level must between 0 and 5." ]
	StaffSetRank						= [ "[#ffffff]%s %s %shas set [#ffffff]%s %sadmin rank to [#ffffff]%s" ]
	StaffGetPlr							= [ "[#ffffff]%s %s %sis getting [#ffffff]%s" ]
	AGotoloc 							= [ "[#ffffff]%s %s %shas gotoloc [#ffffff]%s" ]
	AAddCashAll							= [ "[#ffffff]%s %s %shas rewarded [#ffffff]%s [#ffffff]$%s." ]
	AAddCoinAll							= [ "[#ffffff]%s %s %shas rewarded [#ffffff]%s [#ffffff]%s Myriad Coin." ]
	AExec 								= [ "Code [#ffffff]%s %shas sucessfully executed." ]
	AExecError 							= [ "Execute error [#ffffff]%s" ]
	ASetTimeAll							= [ "[#ffffff]%s %s %shas changed server time to [#ffffff]%d:%d" ]
	InvalidMinute						= [ "Minute should between 0 and 60." ]
	InvalidHour 						= [ "Hour should between 0 and 23." ]
	ASetWeatherAll						= [ "[#ffffff]%s %s %shas changed server weather to [#ffffff]%d" ]
	AHealAll							= [ "[#ffffff]%s %s %shas set all player hp to [#ffffff]%d." ]
	AHealWorldAll						= [ "[#ffffff]%s %s %shas set all player hp in world [#ffffff]%d %sto [#ffffff]%d." ]
	AHealWorldAll1 						= [ "[#ffffff]%s %s %shas set all player hp in this world to [#ffffff]%d." ]
	SetHP 								= [ "[#ffffff]%s %s %shas changed your hp to [#ffffff]%d" ]
	SetHealPlrStaff						= [ "[#ffffff]%s %s %shas set [#ffffff]%s %sto [#ffffff]%d." ]
	AAnnAll								= [ "[#ffffff]%s %s %shas sending announcement [#ffffff]%s %sto all players." ]
	AAnnWorld							= [ "[#ffffff]%s %s %shas sending announcement [#ffffff]%s %sto world [#ffffff]%d" ]
	AAnnPlr 							= [ "[#ffffff]%s %s %shas sending announcement [#ffffff]%s %sto [#ffffff]%s" ]
	ASpawnVeh 							= [ "[#ffffff]%s %s %shas spawned vehicle [#ffffff]%s" ]
	InvalidVehModel 					= [ "Invalid vehicle model." ]
	AGiveWepAll 						= [ "[#ffffff]%s %s %shas given weapon [#ffffff]%s %swith [#ffffff]%d ammo %sto all players." ]
	AGiveWepWorld						= [ "[#ffffff]%s %s %shas given weapon [#ffffff]%s %swith [#ffffff]%d ammo %sto world [#ffffff]%d" ]
	AGiveWepWorld1						= [ "[#ffffff]%s %s %shas given weapon [#ffffff]%s %swith [#ffffff]%d ammo %sto this world." ]
	AGiveWepPlr							= [ "[#ffffff]%s %s %shas given weapon [#ffffff]%s %swith [#ffffff]%d ammo %sto [#ffffff]%s" ]
	SetWepPlrWorld 						= [ "[#ffffff]%s %s %shas given you weapon [#ffffff]%s %swith [#ffffff]%d ammo"]
	ASpawnlocOnPlr 						= [ "[#ffffff]%s %s %shas changed [#ffffff]%s %sspawn location." ]
	SpawnlocLocAdminOn 					= [ "[#ffffff]%s %s %shas changed your spawn location." ]
	SpawnlocLocAdminOff 				= [ "[#ffffff]%s %s %shas disabled [#ffffff]%s %sspawn location." ]
	ASpawnlocOffPlr					 	= [ "[#ffffff]%s %s %shas disabled your spawn location." ]
	TargetSpawnlocAlreadyOff			= [ "Target player spawn location already off." ]
	SpawnlocLocAdmin 					= [ "[#ffffff]%s %s %shas changed your spawn location to location [#ffffff]%s" ]
	ASpawnlocLocPlr						= [ "[#ffffff]%s %s %shas changed [#ffffff]%s %sspawn location to [#ffffff]%s" ]
	ASetVIPPlr							= [ "[#ffffff]%s %s %shas changed [#ffffff]%s %sVIP status to [#ffffff]%s" ]
	SetVIPTarget						= [ "[#ffffff]%s %s %shas changed your VIP status to [#ffffff]%s" ]
	ASetVIPPlr							= [ "[#ffffff]%s %s %shas changed [#ffffff]%s %sVIP status to [#ffffff]%s" ]
	SetVIPTarget1 						= [ "Your VIP status will lasts for [#ffffff]%s." ]
	SetVIPTargetOff 					= [ "[#ffffff]%s %s %shas revoke your VIP status." ]
	ATakeVIPPlr 						= [ "[#ffffff]%s %s %shas revoked [#ffffff]%s %sVIP status." ]
	ACanAttackAll 						= [ "[#ffffff]%s %s %shas enable all players attack ability." ]
	ACantAttackAll						= [ "[#ffffff]%s %s %shas disable all players attack ability." ]
	ACanMoveAll							= [ "[#ffffff]%s %s %shas unfroze all players." ]
	ACantMoveAll						= [ "[#ffffff]%s %s %shas freeze all players." ]
	PlrOptionAllSyntax 					= [ "Syntax, /setplayeroption all [canattack/cantattack/canmove/cantmove]" ]
	ACanAttackWorld 					= [ "[#ffffff]%s %s %shas enable all players attack ability in this world." ]
	ACanAttackWorld1					= [ "[#ffffff]%s %s %shas enable all players attack ability in world [#ffffff]%d." ]
	ACantAttackWorld 					= [ "[#ffffff]%s %s %shas disabled all players attack ability in this world." ]
	ACantAttackWorld1					= [ "[#ffffff]%s %s %shas disabled all players attack ability in world [#ffffff]%d." ]
	ACanMoveWorld 						= [ "[#ffffff]%s %s %shas unfroze all players attack ability in this world." ]
	ACanMoveWorld1						= [ "[#ffffff]%s %s %shas unfroze all players attack ability in world [#ffffff]%d." ]
	ACantMoveWorld 						= [ "[#ffffff]%s %s %shas freeze all players attack ability in this world." ]
	ACantMoveWorld1						= [ "[#ffffff]%s %s %shas freeze all players attack ability in world [#ffffff]%d." ]
	PlrOptionWorldSyntax				= [ "Syntax, /setplayeroption allworld [canattack/cantattack/canmove/cantmove]" ]
	CanAttackTarget 					= [ "[#ffffff]%s %s %shas enable your attack ability." ]
	ACanAttackPlr 						= [ "[#ffffff]%s %s %shas enable [#ffffff]%s %sattack ability." ]
	CantAttackTarget 					= [ "[#ffffff]%s %s %shas disabled your attack ability." ]
	ACantAttackPlr 						= [ "[#ffffff]%s %s %shas disabled [#ffffff]%s %sattack ability." ]
	CanMoveTarget 						= [ "[#ffffff]%s %s %shas unfroze you." ]
	ACanMovePlr 						= [ "[#ffffff]%s %s %shas unfroze [#ffffff]%s" ]
	CantMoveTarget 						= [ "[#ffffff]%s %s %shas freeze your attack ability." ]
	ACantMovePlr 						= [ "[#ffffff]%s %s %shas freeze [#ffffff]%s" ]
	PlrOptionTargetSyntax				= [ "Syntax, /setplayeroption [player] [canattack/cantattack/canmove/cantmove]" ]
	AArmAll 							= [ "[#ffffff]%s %s %shas set all player armour value to [#ffffff]%d." ]
	AArmWorldAll 						= [ "[#ffffff]%s %s %shas set all player in this world armour value to [#ffffff]%d." ]
	SetArmStaff							= [ "[#ffffff]%s %s %shas set all players armour value to [#ffffff]%d %sin world [#ffffff]%d." ]
	SetArm 								= [ "[#ffffff]%s %s %shas changed your armour value to [#ffffff]%d." ]
	SetArmPlrStaff 						= [ "[#ffffff]%s %s %shas changed [#ffffff]%s %sarmour value to [#ffffff]%d." ]
	AAdminDutyOff 						= [ "[#ffffff]%s %s %snot longer on admin duty." ]
	AAdminDutyOn						= [ "[#ffffff]%s %s %sis now on admin duty." ]
	NoPermissionUseCmd 					= [ "You dont have permission to use this command." ]
	ASpecAll							= [ "[#ffffff]%s %s %shas spectating [#ffffff]%s." ]
	SpecPlayer 							= [ "You are now spectating [#ffffff]%s %sType /exitspec to exit spectate mode." ]
	TargetDisallowSpec 					= [ "Target player disabled spectate." ]
	NotSpecAnyTarget 					= [ "You are not spectating any player." ]
	ExitSpec 							= [ "You exited spectate mode." ]
	GetUIDTitle 						= [ "UID1 and UID2 of [#ffffff]%s" ]
	GetUID1 							= [ "[#ffffff]%s %sUID1" ]
	GetUID2 							= [ "[#ffffff]%s %sUID2"]
	TargetAccNotExist 					= [ "Given name does not exist in database." ]
	GetInfoTitle 						= [ "Player info of [#ffffff]%s %sAccount ID [#ffffff]%d" ]
	GetInfo1 							= [ "IP [#ffffff]%s %sCountry [#ffffff]%s" ]
	GetInfo2 							= [ "Away [#ffffff]%s %sWorld [#ffffff]%d" ]
	GetInfo3 							= [ "Cash [#ffffff]$%s %sCoin [#ffffff]%s" ]
	AGetInfoSyntax 						= [ "Syntax, /getinfo [player/account name]" ]
	AGetUIDSyntax						= [ "Syntax, /getuid [player/account name]" ]
	NotOnLobbySpec 						= [ "You must be in the lobby to spectate player." ]
	StaffSetAdminMapperLevel			= [ "[#ffffff]%s %s %shas set [#ffffff]%s %sadmin permission to [#ffffff]%s" ]
	MapperLevelInvalid					= [ "Mapper level must be between 0 and 1." ]
	AAdminChatSyntax 					= [ "Syntax, /ac [text]" ]
	AMapperChatSyntax 					= [ "Syntax, /mc [text]" ]
	AVIPChatSyntax 						= [ "Syntax, /vipchat [text]" ]
	AStaffChatSyntax 					= [ "Syntax, /sc [text]" ]
	ChangePermissionAdminTarget 		= [ "[#ffffff]%s %s %shas set your admin permission to [#ffffff]%s." ]
	StaffSetMapperLevel					= [ "[#ffffff]%s %s %shas set [#ffffff]%s %smapper permission to [#ffffff]%s" ]
	ChangePermissionMapperTarget		= [ "[#ffffff]%s %s %shas set your mapper permission to [#ffffff]%s." ]
	ChangeRankTarget 					= [ "[#ffffff]%s %s %shas changed your admin rank to [#ffffff]%s." ]
	ATransferAll 						= [ "[#ffffff]%s %s %shas transfered [#ffffff]%s %saccount to [#ffffff]%s" ]
	TransferTarget 						= [ "[#ffffff]%s %s %shas changed your name to [#ffffff]%s" ]
	NewAccountExist 					= [ "New account already exists." ]
	OldAccountNotExist 					= [ "Old account does not exist." ]
	AAdminChat 							= [ "[#ffffff]%s %s: %s" ]
	AResetPassSyntax 					= [ "Syntax, /genpass [player]" ]
	GenerateRandomPassScs 				= [ "Sending random generated password to [#ffffff]%s" ]
	GenerateRandomPass 					= [ "Your new password is [#ffffff]%s" ]
	TargetAlreadyLogged 				= [ "Target player already logged." ]
	AAliasSyntax 						= [ "Syntax, /alias [player] [uid1/uid2]" ]
	ASetVIPTimeredSyntax 				= [ "Syntax, /setvip [player] [temp] [y/w/d/h/m]" ]
	StaffSetRankMapper 					= [ "[#ffffff]%s %s %shas set [#ffffff]%s %smapper rank to [#ffffff]%s" ]
	ChangeMapperRankTarget				= [ "[#ffffff]%s %s %shas changed your mapper rank to [#ffffff]%s." ]


	CDrownSyntax = [ "Syntax, /drown [player/id] [reason]" ]



	DepositSyntax = [ "Syntax, /deposit [amount/all]" ]
	WithdrawSyntax = [ "Syntax, /withdraw [amount/all]" ]
	AnnounceLevelUp = [ "[#00cc99]You has been level up to %d!" ]
	EditSensSyntax = [ "Syntax, /editsens [value]" ]
	EditSensNotIntOrFt = [ "Value must be float or integer." ]
	EditSens = [ "You changed object edit sensitive to [#ffffff]%s" ]

	CantChatNotLogged = [ "You need to register or login into your account to able to chat." ]

	CopKillReward = [ "You killed [#ffffff]%s [#009933]and got [#ffffff]$%s [#009933]from suspect and [#ffffff]%s copskill." ]
	KillAllC = [ "[#ffffff]%s [#999999]killed suspect[#ffffff] %s [#999999]with [#ffffff]%s" ],
	CuffCantCuffAbove40 = [ "Suspect must put his hands up first." ],
	OnlineMan = [ "Online Manager(s) %s" ]
	OnlineOwner = [ "Online Owner(s) %s" ],
	OnlineDev = [ "[#34ebd8]Online Developer(s) %s" ],
	OnlineMapper = [ "[#34ebd8]Online Mapper(s) %s" ],
	OnlineTester = [ "[#34ebd8]Online Tester(s) %s" ],
	OnlineAdmin = [ "Online Administrator(s) %s" ],
	OnlineMod = [ "Online Moderator(s) %s" ],
	OnlineGhost = [ "No staff online." ],
	NoMapperOnline = [ "There are no mappers online." ],
	NoDevOnline = [ "There are no developers online." ],
	NoTesterOnline = [ "There are no testers online." ],
	CHangepassSucs = [ "You sucessfully changed your account password." ],
	CHangepassNotLonger = [ "Password length must greater than 6 character." ],
	CHangepassWrongPass = [ "Wrong old password." ],
	CHangepassSyntax = [ "Syntax, /changepass [old password] [new password]" ],
	AccNotLogged = [ "You must log in into your account to use this command." ],
	DeathMsg = [ "%s [#999999]has died." ],
	CantuseLSelf = [ "Are you lonely? Are you lonely? Are you lonely?" ],
	WrongHousePass = [ "Wrong house password." ],
	NotAllowLogin = [ "You are not allowed to login, contract administrator for more information." ]

	ATargetNotCop = [ "Target player is not a cop." ]
	CopkickSyntax = [ "Syntax, /suspendcop [player] [reason]" ]
	CantEnterCopCar2 = [ "You need at least [#ffffff]250 copskill [#e60000]to enter this vehicle." ]
	Sellcar = [ "You sold this vehicle for $%d." ]

	Kickban = [ "You have been banned from server by [#ffffff]%s [#e60000]for reason [#ffffff]%s [#e60000]on [#ffffff]%s" ]
	UnbanForum = [ "Visit [#ffffff]%s [#e60000]to make appeal." ]
	KickbanTimered = [ "You need to wait [#ffffff]%s [#e60000]for your ban expire." ]
	MuteNotice = [ "You have been muted by [#ffffff]%s [#e60000]for reason [#ffffff]%s [#e60000]on [#ffffff]%s" ]
	UnmuteDuration = [ "You need to wait [#ffffff]%s [#e60000]for your mute expire." ]
	Unlockcar = [ "You unlocked the vehicle." ]
	lockcar = [ "You locked the vehicle." ]
	CantEnterCarLocked = [ "This vehicle is locked." ]
	JailPlr2 = [ "You lost [#ffffff]$%s [#e60000]as penalty." ]
	NeedOutVehToArrest = [ "You need to get out vehicle to arrest." ]
	JailReward3 = [ "You jailed [#ffffff]%s [#009933]and got [#ffffff]$%s [#009933]and [#ffffff]%s copskill." ]
	KillAllTeam = [ "[#ffffff]%s [#999999]team killed[#ffffff] %s [#999999]with [#ffffff]%s" ],
	WarningTeamKill = [ "You lost [#ffffff]$%s [#e60000]as penalty for team killing." ]
	DropCashKilled = [ "You dropped [#ffffff]$%s [#e60000]on the floor." ]
	CopKillReward2 = [ "You killed [#ffffff]%s [#009933]and got [#ffffff]$%s [#009933]and [#ffffff]%s copskill." ]
	WeaponRestore = [ "Weapon restore: %s" ]
	NotNearEnforcer = [ "You need to be near enforcer to restock." ]
	JailCons = [ "Your illegal items has been confiscated." ]
	Plantbomb2 = [ "Planting a bomb. It will detonate in 15 seconds." ]
	NoItem2 = [ "You dont have item %s." ]
	HealDontMove5 = [ "Consuming Kit Kat, please do not move." ]
	ScsHeal = [ "Sucessfully healed." ]
	FailHealMove = [ "You failed to heal because you move." ]
	HealingInProcesslol = [ "Healing already in process." ]
	UseSyntax = [ "Syntax, /use [item]" ]
	NoNeedToUseHeal = [ "You no need to heal." ]
	CantUseThisMoreThan40 = [ "You cannot use this item when having more than 40HP." ]
	HealDontMove15 = [ "Healing yourself with medic kit, please do not move." ]
	CopCantUse = [ "Cop cannot use this command." ]
	CantPickUnlock = [ "This vehicle cant be lock picked." ]
	ScsPicked = [ "You sucessfully lock picked this vehicle." ]
	NotNearAnyCar = [ "You must near any vehicle." ]
	CantPickOwnCar = [ "You cannot lock pick your own vehicle." ]
	InvalidItem = [ "Invalid item." ]
	Need2ToEnterBM = [ "You need Level 2 to enter black market." ]

	ADrownAll = [ "Admin %s [#e60000]has drowned [#ffffff]%s [#e60000]Reason [#ffffff]%s" ]
	ABanAll	= [ "[#ffffff]%s %s %shas been banned [#ffffff]%s Reason [#ffffff]%s" ]
	ABannedKick	= [ "You have been banned from the server. Post an unban appeal on [#ffffff]%s" ]
	ABanTimeredAll	= [ "Admin [#ffffff]%s [#e60000]has banned [#ffffff]%s [#e60000]Reason [#ffffff]%s [#e60000]Duration [#ffffff]%s" ]
	AMuteAll= [ "Admin [#ffffff]%s [#e60000]has muted [#ffffff]%s [#e60000]Reason [#ffffff]%s" ]

	ChangeMusickit = [ "You changed music kit to [#ffffff]%s. [#009933]Music will play after you arrest someone." ]
	NoMusicKit = [ "You dont have music kit [#ffffff]%s" ]
	RemoveMusicKit = [ "You removed active music kit. No sound will play after you arrest someone." ]
	InvalidMusicKit = [ "Invalid music kit. Music kit should be insult1, insult2, insult3, mvp1, mvp2" ]
	UseMSyntax = [ "Syntax, /usemusickit [insult1/insult2/insult3/mvp1/mvp2]" ]
	BankPickup2 = [ "Leave the bank when you finish to get cash." ]
	IgnoreAll = [ "%s [#ff9933]ignored %s" ]
	IgnoreSelf = [ "You ignored %s" ]
	AlreadyIgnore = [ "You already ignored %s" ]
	CantIgnoreLSelf = [ "You cannot ignore yourself, stupid!" ]
	IgnoreSyntax = [ "Syntax, /ignore [player]" ]
	UnIgnoreAll = [ "%s [#ff9933]not longer ignored %s" ]
	UnIgnoreSelf = [ "You unignored %s" ]
	NotIgnore = [ "You didnt ignore %s" ]
	UnCantIgnoreLSelf = [ "You already unignore yourself." ]
	UnIgnoreSyntax = [ "Syntax, /unignore" ]
	FPSPlr = [ "%s [#009933]FPS [#ffffff]%s" ]
	FPSelf = [ "Your FPS [#ffffff]%s" ]
	FPSSyntax = [ "Syntax, /fps [player]" ]
	CarStolen = [ "%s [#e60000]has stolen your vehicle."]
	PlrCopCantSus = [ "Target player cant be sus." ]
	SusStolen = [ "%s [#3366ff]has been sus for stealing %s [#3366ff]vehicle." ]
	Cop1kSkill = [ "You need at least [#ffffff]1000 copskill [#e60000]to with this spawn." ]
	NoCuffAlert = [ "Cuff wanted player with right click and bring him/her to here." ]
	CopHelp2 = [ "Type /cophelp for more commands related to cop." ]
	CopHelp1 = [ "Commands: (/) coprules, wanted, coprules, sus, unsus, r, m(megaphone), restock" ]
	MedicHelp2 = [ "Type /medichelp for more commands related to medic." ]
	ARewardAll = [ "Admin %s [#e60000]rewarded all players [#ffffff]$%s" ]
	CarStolen2 = [ "Your vehicle is currently used by %s" ]
	MyVehicle4 = [ "Your shared vehicle: %s" ]
	OurVehicle = [ "[#ffffff]%s, [#009933]Vehicle [#ffffff]%s (%s[#ffffff]) [#009933]ID [#ffffff]%s" ]
	OurVehicle1 = [ "[#009933]Vehicle [#ffffff]%s (%s[#ffffff]) [#009933]ID [#ffffff]%s" ]
	NotOwner1 = [ "You are not owner or shared of this vehicle." ]
	VehicleShare = [ "You shared your vehicle %s (ID:%s) to %s" ]
	VehicleShare1 = [ "%s has shared vehicle %s (ID:%s) with you."]
	VehicleAlreadyShare = [ "You already shared this vehicle to this player." ]
	VehicleCantShareSelf = [ "You cannot share to yourself!" ]
	SharecarSyntax = [ "Syntax, /sharevehkey [player]" ]
	AlreadyShareVehicle = [ "You already shared this vehicle to this player." ]
	VehicleUnShare = [ "You delshare your vehicle %s (ID:%s) with %s" ]
	VehicleUnShare1 = [ "%s not longer share vehicle %s (ID:%s) with you."]
	AlreadyShareUnVehicle = [ "You didnt share this vehicle to this player." ]
	UnShareSelf = [ "Are you high or what?" ]
	SharecarSyntax = [ "Syntax, /removevehkey [player]" ]
	VehicleGive = [ "You transferred ownership of vehicle %s (ID:%s) to %s" ]
	VehicleGive1 =  [ "%s has transferred ownership of vehicle %s (ID:%s) to you."]
	GivecarSyntax = [ "Syntax, /giveveh [player]" ]
	PickupHeader = [ "This drop is dropped by %s[#009933]. It contain following item:" ]
	PickList = [ "ID [#ffffff]%s [#009933]Item [#ffffff]%s [#009933]Quaitity [#ffffff]%s" ]
	PickAlert = [ "Type /pick [ID] or /pick all to pick item from this drop." ]
	AlreadyActiveMusickit = [ "You already activated this music kit." ]
	CashPickup2 = [ "You are picked [#ffffff]$%s, [#009933]from dead drop of [#ffffff]%s." ]
	WeaponPickup2 = [ "You are picked [#ffffff]%s [#009933]with [#ffffff]%s ammo, [#009933]from dead drop of [#ffffff]%s." ]
	WeaponPickup3 = [ "You are picked [#ffffff]%s [#009933]ammo of [#ffffff]%s, [#009933]from dead drop of [#ffffff]%s." ]
	ItemPickup2 = [ "You are picked [#ffffff]%s [#009933]with [#ffffff]%s, [#009933]from dead drop of [#ffffff]%s." ]
	DeaddopNotFound = [ "No dead drop nearby." ]
	PickIDNotNum = [ "ID must be in integer. (or use /pick all)" ]
	PickSyntax = [ "Syntax, /pick [ID/all]" ]
	DeaddopInvalidID = [ "Invalid ID." ]
	AFKOn = [ "%s [#009933]currently AFK." ]
	AFKOff = [ "%s [#009933]is not AFK." ]
	AFKSyntax = [ "Syntax, /checkafk [player]" ]
	AFKSelf = [ "What do you think?" ]
	WeaponPickup4 = [ "You are picked [#ffffff]%s [#009933]with [#ffffff]%s ammo." ]
	AdutyCantDuty = [ "Player currently on admin duty." ]
	OnTheRadar = [ "%s [#ff9933]is now show on the radar." ]
	OffTheRadar = [ "%s [#ff9933]not longer shown on radar." ]
	NeedAtLeastLevel9 = [ "You need at least level 10 to use this command." ]
	StoreAll = [ "You stored all item and weapon into storage." ]
	NoItemToStore = [ "You dont have any item to store." ]

	ChangeEditMode = [ "You changed map edit mode to [#ffffff]%s." ]
	InvalidItem32 = [ "Valid item should be funiture ID." ]
	InvalidItem64 = [ "You dont have item [#ffffff]%s" ]
	GiveHouse = [ "You are given ownership of %s to %s." ]
	GiveHouse1 = [ "%s has gave you ownership of %s" ]
	GivehouseSyntax = [ "Syntax, /givehouse [player]" ]

	JoinAll2 = [ "[#ffffff]%s [#808080]joined the server for the first time." ],

	// ===================== pd ====================

	PoliceRobbery = [ "[#668cff]CCTV detected someone trying crack the safe at %s, %s." ]
	PSA = [ "[#3333ff][PSA] %s" ]
	PSA2 = [ "[#3333ff][PSA] Published by %s  %s" ]
	PSASyntax = ["Syntax, /psa [text]" ]
	NotAllowedUseCmd2 = [ "You are not allowed to use this command." ]
	JailPlr = [ "[#3333ff][NEWS] %s have been jailed for %s." ]
	PoliceSuspect = [ "[#668cff]%s has suspected %s for %s." ]
	SuspectTarget = [ "%s has suspected you for: %s."]
	PoliceUnSuspect = [ "[#668cff]%s has removed all suspection from %s for %s." ]
	UnSuspectTarget = [ "%s has removed all suspection on you."]
	EquipPlrLocal = [ "[#d580ff]* %s has equip %s  %s with %d ammo." ]
	EquipPlr = [ "You equipped %s %s with %d ammo." ]
	EquipSelf = [ "You equipped yourself %s with %d ammo." ]
	EquipInvalidAmmo = [ "Ammo must between 1 and 500." ]
	EquipInvalidWep = [ "Invalid weapon." ]
	EquipSyntax = [ "Syntax, /equip [weapon/armour] [ammo] [player(optional)]" ]
	CmdNotInPD = [ "You must in Police Department to use this command." ]
	CmdNotInPDOrRancher = [ "You must in Police Department or near FBI Rancher or Enforcer to use this command." ]
	NotPartOfLaw = [ "Target player not part of Law enforment." ]
	UnEquip = [ "You unequipped %s." ]
	UnEquipLocal = [ "[#d580ff]* %s unequip %s." ]
	UneqNoWep = [ "You need to have weapon in hand to unequip." ]
	PoliceROutside = [ "[#d580ff]%s (Radio): %s"]
	PolicePanic = [ "[#668cff]%s pressed a panic button. Trace: %s" ]
	PolicePanicOutside = [ "[#d580ff]* %s clicked a button on the radio."]
	PoliceRefillDutyEq = [ "You took duty equipment." ]
	PoliceRefillDutyEqOutside = [ "[#d580ff]* %s took their duty equipment."]
	ArrestInvalidNum = [ "Duration must between 20 - 300." ]
	ArrestNotNum = [ "Duration must be in number." ]
	ArrestSyntax = [ "Syntax, /jail [player] [duration in second]" ]
	DontHaveCuffPlr = [ "You need to cuff suspect first." ]
	NotInJail = [ "You must be in jail to use this command." ]
	PoliceJail = [ "[#668cff]%s has jailed %s for %s." ]
	NotClosePlr = [ "You need near to that player." ]
	SurList = [ "#%d - %s - Suspected by: %s" ]
	SurListHeader2 = [ "Suspection of %s" ]
	NotSu = [ "That player is not suspected." ]
	SurListHeader = [ "Your suspection" ]
	EquipArmPlr = [ "You equipped %s with armour." ]
	EquipArmPlrLocal2 = [ "[#d580ff]* %s has equip %s with armour." ]
	EquipArmSelf = [ "You took armour." ]
	EquipArmPlrLocal = [ "[#d580ff]* %s took armour." ]
	LawEDuty = [ "You are now on %s duty." ]
	QuitJob = [ "You quit the job." ]
	AlreadyInJob = [ "You already in job." ]
	FBIShowBadge = [ "[#d580ff]* %s shows their FBI badge which displays: FBI %s %s." ]
	PDShowBadge = [ "[#d580ff]* %s shows their VCPD badge which displays: VCPD %s %s." ] 
	FBIHideBadge = [ "[#d580ff]* %s conceals their badge." ]
	NotOnUndercover = [ "You not longer on undercover." ]
	OnUndercover = [ "You are now on undercover." ]
	VehicleOwnedByJob = [ "You are not on right job to enter this vehicle."]
	VehicleEnterOwnedByJob = [ "This vehicle is owned by job." ]


	// ==================== gang =========================
	gNotExist = [ "This group does not exist." ]
	gNotGang = [ "This is not gang." ]
	gNotAllowedCmd = [ "You are not allowed to use this command." ]

	gCreategroupSyntax = [ "Syntax, /creategroup [founder name] [gang/normal] [group name]" ]
	gAlreadyExist = [ "This group is already exist." ]
	gWrongType = [ "Group type should be 'gang' or 'normal'." ]
	Adminv2CreateNewGroup = [ "%s :%s [#ff66ff]created new group :%s" ]

	gGroupSyntax = [ "Syntax, /g [info/members/rank/stats/join/leave/invite/kick]" ]
	gInfoSyntax = [ "Syntax, /groupinfo [group name]" ]
	gInfo = [ "[#99bbff][%s] Name: %s  Type: %s" ]
	gInfo1 = [ "[#99bbff][%s] %s" ]
	Description = [ "[#99bbff][%s] %s" ]

	gMembersSyntax = [ "Syntax, /groupmembers [group]" ]
	gRankSyntax = [ "Syntax. /groupranks [group]" ]

	gStatsSyntax = [ "Syntax, /g stats [group]" ]
	gStats = [ "Kills %s Deaths %s Ratio %.2f" ]

	gJoined = [ "%s joined the group." ]

	gLeaveSyntax = [ "Syntax, /groupleave [group]" ]
	gNotIn = [ "You not in this group." ]
	gLeave = [ "%s has left the group." ]

	gInviteSyntax = [ "Syntax, /groupinvite [group] [player/id]" ]
	gAlreadyInvite = [ "Someone already invited this player." ]
	gInviteAlreadyIn = [ "This player already in this group." ]
	gGotInvite = [ "%s has invite you to %s.Type /groupjoin %s to join this group." ]
	gInvite = [ "%s invited %s to the group." ]
	gSendInvite = [ "You sending group invite to %s." ]

	gKickSyntax = [ "Syntax, /groupkick [group] [player/id]" ]
	gKick = [ "%s kicked %s from the group." ]
	gGetKicked = [ "You have been kicked from the group %s by %s" ]

	gJoinSyntax = [ "Syntax, /groupjoin [group]" ]
	gAlreadyIn = [ "You already in this group." ]
	gNoInvite = [ "You got no invite from this group." ]

	gGroupManageSyntax = [ "Syntax, /gmanage [addrank/delrank/changeranklevel/changeperm/setplayerrank/color/description]" ]

	gAddRankSyntax = [ "Syntax, /groupaddrank [group] [level] [rank name]" ]
	gRankExist = [ "This rank already exist." ]
	gRankNotNum = [ "Level must be in number." ]
	gRankBetween0n100 = [ "Level must between 0 and 100." ]
	gAddRank = [ "%s added rank %s" ]
	gAddRankP = [ "You added rank %s with level %s." ]

	gDelRankSyntax = [ "Syntax, /groupdelrank [group] [rank]" ]
	gRankNotExist = [ "This rank is not exist." ]
	gDelRank = [ "%s deleted rank %s" ]
	gDelRankP = [ "You deleted rank %s." ]

	gChangePermSyntaxOne = [ "Syntax, /groupeditperm [group] [bank/description/kick/setplayerrank/addrank/delrank/usevehicle/invite/setpermission/hqstorage/changeranklevel/vehiclemanage] [level]" ]
	gChangePermSyntax = [ "Syntax, /groupeditperm [group] %s [level]" ]
	gCurrentLevel = [ "Permission %s [#cc0000]current level is %s." ]
	gNewLevel = [ "Permission %s new level is now %s." ]

	gSetPlrSyntax = [ "Syntax, /groupsetplayerrank [group] [player/id] [rank]" ]
	gPlrSameRank = [ "This player already got same rank." ]
	gChangePlayerRank = [ "%s has set %s rank to %s." ]
	gChangeRankPls = [ "You changed %s rank to %s." ]

	gColorSyntax = [ "Syntax, /gmanage color [group] [R] [G] [B]" ]
	gChangeColor = [ "Sucessfully updated group color." ]

	gDesSyntax = [ "Syntax, /groupdescription [group] [text]" ]
	gDescription = [ "Sucessfully updated group description." ]

	gChatSyntaxWithoutGroup = [ "Syntax, /gm [group] [text]" ]
	gChatSyntax = [ "Syntax, /gm [text]" ]
	gCantChat = [ "You dont have permission to chat in this group." ]
	GangChat = [ "%s: %s" ]

	gSetgmSyntax = [ "Syntax, /setgm [group/none]" ]
	gSetGm = [ "You set default group message to %s." ]

	gSetGHouseSyntax = [ "Syntax, /setgrouphouse [group]" ]
	gAddGangHouse = [ "%s added house %s as group house." ]
	gAddGangHousePlayer = [ "You added %s as group house." ]

	gRemGHouseSyntax = [ "Syntax, /remgrouphouse [group]" ]
	gARemGangHouse = [ "%s removed group house %s" ]
	gRemGangHousePlayer = [ "You removed group house %s." ]

	gGroup = [ "Group of %s" ]
	gNotGroupFound = [ "Group not found." ]
	gGroupFound = [ "%s (%s)" ]
	gGroupOwn = [ "Your groups" ]
	gInfo2 = [ "%s" ]
	gNotGroupHouse = [ "This is not a group house." ]
	gPlrNotIn = [ "This player is not in group." ]

	gSetGmNone = [ "You set default group message to none." ]

	gSetRankSyntax = [ "Syntax, /groupeditranklevel [group] [new level] [rank name]" ]
	gChangeRankLevel = [ "%s has changed %s level to %s" ]
	gCCRankP = [ "You changed %s level to %s." ]

	gNotSetDefaultChat = [ "You didnt set default group message, use /setgm to set." ]

	gMember = [ "Rank %s Members %s" ]
	gRank = [ "Rank %s Level %s" ]

	gCannotCreateGang = [ "This command not longer useable. Please post gang request application on forum." ]
	gRemGHouseSyntax = [ "Syntax, /remgrouphouse" ]

	// =============== vehicle =====================
	VehicleEnterHasOwner = [ "This vehicle is owned by %s." ]
	GroupVehicleNotPerm = [ "You dont have permission to enter this vehicle." ]
	GroupVehicleCantEnterNotPart = [ "You need part of '%s' to enter this vehicle." ]
	VehicleEnterHasOwner2 = [ "This vehicle is owned by you." ]
	
	RespawnHospital = [ "You respawned at hospital." ]
	RespawnJob = [ "You respawned at job." ]
	RespawnHQ = [ "You spawned at group HQ." ]
	RespawnHouse = [ "You spawned at your house." ]

	// ================== medic ===============
	CarryBody = [ "You are now carry a body." ]
	BodyNotBody = [ "This corps havent bag yet." ]
	NotNearCorps = [ "You need to be near the corps." ]
	InvalidCorpsID = [ "Invalid corps ID." ]
	CarryBodyNotNum = [ "ID must be in number." ]
	CarryBodySyntax = [ "Syntax, /carrybody [ID]" ]
	AlreadyCarryBody = [ "You already carry a body." ]
	NotMedic = [ "You must be in EMS to use this command." ]
	BagBodySyntax = [ "Syntax, /bagbody [ID]" ]
	StoreBody = [ "You stored the body into %s." ]
	StorebodyLocal = [ "%s stored the body into %s." ]
	NoAmbulanceNearby = [ "You can only store body into Ambulance." ]
	NotCarryBody = [ "You are not carry a body." ]
	UnloadBody = [ "You unloaded the body from %s." ]
	UnloadbodyLocal = [ "%s unloaded the body from %s." ]
	NoBodyStoreInAm = [ "There is no body stored in %s." ]
	EMSNoVehicleNearby = [ "You are not near the vehicle." ]
	CremateBody = [ "You put the body into cremate queue. You get extra $%d in your next paycheck." ]
	NotInHospital = [ "You are not inside hospital." ]
	OnEMSDuty = [ "You are on EMS duty." ]
	MedicR = [ "%s %s: %s"]
	ReviveScsMedic = [ "You revived %s. You get extra $%d in your next paycheck." ]
	ReviveScsMedic2 = [ "%s has revive you for $%d." ]
	ReviveFailMove = [ "Revive process has stopped because you move." ]
	RevivePlayer = [ "Begin reviving %s.." ]
	ReviveScs = [ "You revived %s." ]
	ReviveScs2 = [ "%s has revive you." ]
	ReviveNotHaveKit = [ "You need Revive Kit to able revive someone." ]
	ReviveNotHaveKitOrNearAmbulance = [ "You need Revive Kit or near Ambulance to revive someone." ]
	TargetBeingRevive = [ "Target being revived." ]
	ReviveNotClosePlr = [ "You need to be close on knocked player." ]
	ReviveInCar = [ "You must be on foot to able to revive." ]
	CantReviveSelf = [ "You cant revive yourself." ]
	ReviveSyntax = [ "Syntax, /revive [player]" ]

	// ======================= trucker ========================
	TruckerDeliver = [ "You delivered %s. $%d will be added in your next paycheck." ]
	NotTrucker = [ "You are not trucker." ]
	OnTruckerDuty = [ "You are now on trucker duty." ]
	PaycheckNotice = [ "You got $%d paycheck. Go collect at bank!" ]
	TruckAboveLegalWeight = [ "Warning! You reached legal weight limit of truck, police might arrest you after they check your truck." ]
	TruckExeedWeightLimit = [ "You cannot carry any cargo anymore." ]
	TruckerNotInRightVehicle = [ "You are not in right job vehicle." ]



	// ============ rp cmd =============
	LocalChat = [ "[#d580ff]%s says: %s" ]
	LocalChatSyntax = [ "Syntax, /l [text]" ]
	CantUseCmdKnocked = [ "You cannot use this comand because you are knocked." ]
	ShoutChat = [ "[#d580ff]%s shouts: %s!" ]
	WhisperSelf = [ "[#e6e600]Whisper to %s: %s" ]
	WhisperTarget = [ "[#e6e600]%s whispers to you: %s" ]
	WhisperPublic = [ "[#d580ff]%s whispers something to %s." ]
	CantWisperSelf = [ "You cant whisper to yourself." ]
	WhisperSyntax = [ "Syntax, /w [player] [text]" ]
	ShoutChatSyntax = ["Syntax, /s [text]" ]
	LocalWhisper = [ "[#d580ff]%s locally whisper: %s" ]
	LocalWhisperSyntax = [ "Syntax, /lw [text]" ]
	MegaChat = [ "%s [#999999][megaphone][#ffffff]: %s" ]
	MegaChatSyntax = [ "Syntax, /%s [text]" ]
	MeChat = [ "[#d580ff]* %s %s" ]
	MeSyntax = [ "Syntax, /me [text]" ]
	OOCLocalChat = [ "[#d580ff](( %s: %s ))" ]
	OOCLocalSyntax = [ "Syntax, /b [text]" ]

	// === shop ===
	NothingForSale = [ "You cant buy anything here." ]
	NotInsideShop = [ "You must be inside business to use this command." ]
	ReStockItem = [ "You restocked item %s for $%d." ]
	NotEnoughCashRestock = [ "You need $%d to stock this item." ]
	ReStockCantExceed = [ "This item cannot exceed %d." ]
	ReStockInvalidItem = [ "Invalid item." ]
	ReStockInvalidQuatity = [ "Invalid quatity." ]
	ReStockQuatityNotNum = [ "Quatity must be in number." ]
	RestockSyntax = [ "Syntax, /restock [quatity] [item]" ]
	NotBizOwner = [ "You are not owner of this business." ]
	SetStockPrice = [ "You set %s price to $%d." ]
	SetPriceCantExceed = [ "Price cannot exceed $%d." ]
	SetPriceInvalidQuatity = [ "Invalid price." ]
	SetStockPriceNotNum = [ "Price must be in number." ]
	SetStockPriceSyntax = [ "Syntax, /setstockprice [price] [item]" ]


	NotValidRPName = [ "You must change your name to 'Firstname_Lastname' format and can only contain alphabets before you can play here." ]
	WithdrawPaycheck = [ "You collected $%d paycheck from the bank." ]
	NoPaycheck = [ "You dont have any pending paycheck to collect." ]
	NotSpawned = [ "You need to be spawned to use this command." ]
	PostAD = [ "[#ff9900][Advertisement] %s" ]
	PostAD2 = [ "[#ff9900][Advertisement] Contact: %d" ]
	AdNeedCash = [ "You need $%d to post an advertisement." ]
	AdNeedWait = [ "Please wait a while before you can post advertisement." ]
	AdNeedPhone = [ "You need phone to use this command." ]
	AdSyntax = [ "Syntax, /ad [text]" ]
	Chatmode = [ "You have set your chatmode to %s." ]
	ChatmodeSyntax = [ "Syntax, /chatmode [local/public]" ]
	NotInJobWithRadio = [ "You dont have a job radio to speak into." ]
	
	CallingTarget = [ "You are now calling %d." ]
	CallingTarget2 = [ "%d has calling you." ]
	CallingTarget3 = [ "Use /pickup to pickup or /hangup to reject call." ]
	CallingLocal = [ "[#d580ff]* %s's phone begins to ring." ]
	CalledFailedToPickup = [ "Target failed to pickup the phone." ]
	CalledFailedToPickup2 = [ "You failed to pickup the phone." ]
	TargetOnCall = [ "Target is on call right now." ]
	CantCallSelf = [ "You cant call yourself." ]
	PhoneNotExist = [ "Phone number does not exist." ]
	PhoneNotNum = [ "Phone number must be in number." ]
	CallAlreadyOnCall = [ "You already on call." ]
	CallSyntax = [ "Syntax, /call [number]" ]
	CallPickup = [ "You pickup the phone." ]
	CallPickup2 = [ "%d has pickup the phone." ]
	CallingPickup = [ "[#d580ff]* %s takes out a cell phone and picks up." ]
	AlreadyOnCall = [ "You already on call." ]
	NoOneCalling = [ "No one is calling you." ]
	RejectCall = [ "You rejected the call." ]
	RejectCall2 = [ "Target has rejected the call." ]
	CallerHangup = [ "You hung up." ]
	CallerHangup2 = [ "Target has hung up the phone." ]
	NotInCall = [ "You are not in any call." ]
	OnPhoneTarget = [ "[#e6e600]%d on phone says: %s" ]
	OnPhone = [ "[#e6e600]You on phone says: %s" ]
	OnPhoneLocal = [ "[#d580ff]%s (phone): %s" ]
	SMSLocal = [ "[#d580ff]* %s's phone vibrates." ]
	SMSFrom = [ "[#e6e600]SMS from %d: %s" ]
	SMSTo = [ "[#e6e600]SMS send to %d: %s" ]
	CantSMSSelf = [ "You cant sms to yourself." ]
	SMSSyntax = [ "Syntax, /sms [number] [text]" ]
	MegaphoneLoud = [ "[#e67300]** %s o<: %s **" ]
	MegaphoneSyntax = [ "Syntax, /megaphone [text]" ]
	VehicleNotSupportMegaphone = [ "This vehicle does not have megaphone installed." ]
	MegaphoneNotInJob = [ "You are not in correct job to use megaphone." ]
	SMSLocal2 = [ "[#d580ff]* %s types up a message on their phone." ]
	CallingLocal2 = [ "[#d580ff]* %s takes out a cell phone and dials a number." ]
	RobItemLocal = [ "[#d580ff]* %s has robs a(n) %s from %s." ]
	RobItem = [ "You robbed %s (%d) from %s." ]
	RobItem2 = [ "%s has robbed %s (%d) from you." ]
	TargetDontHaveItem = [ "Target dont have such item." ]
	CantRobInCar = [ "You cant rob player while in vehicle." ]
	CantRobSelf = [ "You cannot rob yourself." ]
	RobSyntax = [ "Syntax, /rob [player] [item]" ]
	NotNearPlr = [ "You are not near that player." ]
	CantFriskSelf = [ "You cant frisk yourself." ]
	FriskSyntax = [ "Syntax, /frisk [player]" ]
	CantAcceptDeath = [ "You cannot accept death yet." ]
	NotKnocked = [ "You are not knocked." ]
	AcceptSyntax = [ "Syntax, /accept [death]" ]

	KnockedMsg = [ "You have been severely wounded." ]
	KnockedMsg2 = [ "After 120 seconds, you can '/accept death' if you wish to give up on life."]
	

	DoChat = [ "[#d580ff]* %s (%s)" ]
	doMESyntax = [ "Syntax, /%s [text]" ]
	PublicchatSyntax = [ "Syntax, /p [text]" ]
	AskChat = [ "[#ff66ff][Ask] %s %s: [#ffffff]%s" ]
	AskChatSyntax = [ "Syntax, /ask [question]" ]
	GiveCash1 = [ "You give $%d to %s." ]
	GiveCash2 = [ "%s has given you $%d." ]
	GiveCashLocal = [ "[#d580ff]* %s hands over some money to %s." ]
	GiveCashNotEnoughCash = [ "You dont have enough cash." ]
	GiveCashInvalidAmount = [ "Invalid amount." ]
	CantGiveCashSelf = [ "You cannot give cash to yourself." ]
	GiveCashSyntax = [ "Syntax, /givecash [player] [amount]" ]
	GiveItemTo = [ "[#d580ff]* %s hands over %s to %s." ]
	GiveItem = [ "You given %s (%d) to %s." ]
	GiveItem2 = [ "%s gave you %s (%d)." ]
	MustHoldWeapon = [ "You must hold that weapon." ]
	DontHaveEnoughItem = [ "You dont have enough quatity." ]
	QuatityNotNum = [ "Quatity must be in number." ]
	GiveItemSelf = [ "You cannot give item to yourself." ]
	GiveItemSyntax = [ "Syntax, /give [player] [quatity] [item]" ]
	DontHaveSuchItem = [ "You dont have such item." ]
	BodyAlreadyBag = [ "This body already bagged." ]

	AccountCmd = [ "[#e6e600]Account cmds: [#ffffff]/stats /changepass /chatmode /invent /paycheck /deposit /withdraw /send /give" ]
	OtherCmd = [ "[#e6e600]Other cmds: [#ffffff]/discord /admins /credits" ]
	ChatCmd = [ "[#e6e600]Chat cmds: [#ffffff](In Character: /l /w /lw /s /sms /phone) (Out Of Character: /p /b /ask)" ]
	ShopCmd = [ "[#e6e600]Business cmds: [#ffffff]/buy /browse /buybiz /bizname /bizwelcomemessage /sellbiz /restock /setstockprice /income /collectincome" ]
	HouseCmd = [ "[#e6e600]House/HQ cmds: [#ffffff]/buyhouse /storage /store /load /lockhouse /upgradehouse /givehouse /sharehouse /delsharehouse /sellhouse /housename /setwelcomemessage" ]
	GroupCmd = [ "[#e6e600]Group cmds: [#ffffff]/group /listgroups /groupinfo /groupmembers /groupranks /groupjoin /groupinvite /groupkick /groupleave /groupaddrank /groupdelrank /groupeditranklevel /groupeditperm /groupsetplayerrank /groupdescription /groupbank" ]
	VehicleCmd = [ "[#e6e600]Vehicle cmds: [#ffffff]/veh /repair /sellveh /myveh /parkveh /lockveh /sharevehkey /removevehkey /giveveh /givevehtogroup /changevehcolor /towgroupveh /listgroupveh" ]
	JobCmd = [ "[#e6e600]For job commands use [#ffffff]/jobcmd" ]
	RadioCmd = [ "[#e6e600]Radio commands: [#ffffff]/setfreq /crmembers /cr /cralert /crpanic /crregister /crkick /crban /crlock /crdescription" ]

	gBankCheckBal = [ "Bank balance of account %s: $%d." ]
	gBankDeposit = [ "You deposited $%d into bank account of %s." ]
	gBankDepositSyntax = [ "Syntax, /groupbank %s %s [value]" ]
	gBankWithdraw = [ "You withdraw $%d from bank account of %s." ]
	gBankNotEnough = [ "You dont have enough cash in group bank." ]
	GroupBankSyntax = [ "Syntax, /groupbank [group] [balance/deposit/withdraw]" ]

	StatsOwn = [ "[#e6e600]Your stats:" ]
	StatsOwn1 = [ "[#e6e600]XP: (%d/%d) Level %d" ]
	StatsOwn2 = [ "[#e6e600]Session playtime: %s Total playtime: %s" ]
	StatsOwn3 = [ "[#e6e600]Phone number: %d" ]

	CantChatKnocked = [ "You cannot talk because you knocked." ]
	WantedCantGoDuty = [ "You cannot go on police duty." ]

	JobDontHaveCmd = [ "This job does not have special command." ]
	MedicCmds = [ "[#e6e600]Medic cmds: [#ffffff]/revive /bagbody /carrybody /storebody /unloadbody /cremate /r /dep /m" ]
	HighRankCopCmd = [ "[#e6e600]PD cmds: [#ffffff]/su /sus /unsus /r /dep /wanted /crime /m /jail /tg /equip /unequip /psa /ucright /pdsetrank /pdsetlevel" ]	
	FreeCopCmd = [ "[#e6e600]PD cmds: [#ffffff]/su /sus /unsus /r /dep /wanted /crime /m /jail /tg " ]	
	FBICmd = [ "[#e6e600]FBI cmds: [#ffffff]/su /sus /unsus /r /dep /wanted /crime /m /jail /tg /equip /unequip /psa /sb /uclist" ]	
	JobNotInJobToCmd = [ "You are not in job." ]

	DepSyntax = [ "Syntax, /dep [text]" ]
	DEPRadio = [ "%s %s: %s" ]
	GroupHQCantEntere = [ "This property is currently locked." ]

	RadioFregJoin = [ "%s joined the channel." ]
	RadioFregJoined = [ "You joined radio channel %d. This channel is owned by %s." ]
	RadioFregJoined1 = [ "You joined radio channel %d. This channel is unowned." ]
	RadioFregJoined2 = [ "Channel description: %s" ]
	RadioFregBanned = [ "You are banned from that channel." ]
	RadioFregLocked = [ "This channel is locked." ]
	RadioFregNotCorrect = [ "Channel must between 0 and 9999." ]
	RadioSlotAlreadyJoined = [ "You already joined that channel." ]
	RadioSlotNotCorrect = [ "Slot must between 1 and 5." ]
	SetFregSlotOrChannelNotNum = [ "Slot and Channel must be in number." ]
	SetFregSyntax = [ "Syntax, /setfreq [slot] [channel]" ]
	NeedRadio = [ "You need to own a radio to use this command." ]
	CRRegisterAll = [ "%s registered this channel." ]
	CRRegister = [ "You registered radio channel %d." ]
	CRAlreadyOwned = [ "This channel already owned." ]
	CRNotInChannel = [ "You are not in that channel." ]
	CRChannelNotNum = [ "Channel must be in number." ]
	CRRegisterSyntax = [ "Syntax, /crregister [channel]" ]
	CRCantRegister = [ "You cannot register this channel." ]
	CRSendMsg = [ "%s: %s" ]
	CRCantTalk = [ "You cannot talk in this channel." ]
	CRTalkSyntax = [ "Syntax, /cr [slot] [text]" ]
	CRLock = [ "%s has locked this channel." ]
	CRUnLock = [ "%s has unlocked this channel." ]
	RadioCantUseCmd = [ "You cannot use this command in this channel." ]
	CRSlotNotNum = [ "Slot must be in number." ]
	CRLockSyntax = [ "Syntax, /crlock [slot]" ]
	CRPanic = [ "%s pressed panic button on %s." ]
	CRPanicSyntax = [ "Syntax, /crpanic [slot]" ]
	CRSendMsgR = [ "%s: [#ff3300]%s"]
	CRAlertSyntax = [ "Syntax, /cralert [slot] [text]" ]
	RadioFregLeft = [ "%s left the channel." ]
	CRUpdateDescription = [ "%s updated this channel desciption to: %s" ]
	CRSetLevel = [ "%s has set %s level to %d." ]
	CRLevelInvalid = [ "Level must between 0 to 3." ]
	CRLevelNotNum = [ "Level must be in number." ]
	TargetNotInChannel = [ "Target player not in this channel." ]
	CRCantSetSelfLevel = [ "You cant use this command on yourself." ]
	CRSetlevelSyntax = [ "Syntax, /crsetlevel [slot] [player] [level]" ]
	CRMembers = [ "List of user(s) in [ %d | %d ]" ]
	CRMembers1 = [ "User(s): %s" ]
	CRMembers2 = [ "Total user(s): %d" ]
	CRMemberSyntax = [ "Syntax, /crmembers [slot]" ]

	UnboxLocal = [ "[#d580ff]* %s has opened an %s." ]
	CaseUnbox = [ "You used a(n) %s." ]
	NoNeedArmour = [ "You dont need extra armour." ]
	Breakline = [ "============================" ]
	PlantSeed = [ "You planted a weed seed." ]
	PlantweedLocal = [ "[#d580ff]* %s start diging a hole and put weed seed into soil." ]
	PlantseedCantNearPlant = [ "You need 2 meters between weed plant." ]
	NeedAtWeeField = [ "You are not at weed field." ]
	HarvestWeed = [ "You harvested %d gram(s) of weed." ]
	WeedNotReady = [ "This plant is not ready to harvest." ]
	NotNearWeedPlant = [ "You must near weed plant to harvest." ]
	NotOnFoot = [ "You must on foot to use this command." ]

	EngineBroke = [ "The engine of this vehicle is broken." ]

	RepairingVehicle = [ "Your vehicle will be repaired in 10 seconds." ]
	RepairVehicle = [ "You repaired this vehicle for $%d." ]
	PnSOutOfStock = [ "This Pay 'n' Spray is out of stock." ]
	NeedCashRepair = [ "You need $%d to repair." ]
	NoNeedRepair = [ "You dont need to repair this vehicle." ]
	NotInPns = [ "You must be in Pay 'n' Spray to repair vehicle." ]
	NotEnoughBuyCar = [ "You need $%d to purchase this vehicle." ]	
	VehileLimitExceeded = [ "You cannot own more than 5 vehicles." ]
	PurchaseVehicle = [ "You purchased vehicle %s for $%d." ]
	NotAtVehShowroom = [ "You need to be at vehicle dealership to use this command." ]
	AlreadyInVehBrowse = [ "You already browse a vehicle." ]
	UnLockVehLocal = [ "* %s has unlocked their %s." ]
	LockVehLocal = [ "* %s has locked their %s." ]
	NotNearOwnVeh = [ "You must near your vehicle to use this command." ]
	ChangevehColor = [ "You sucessfully changed vehicle color for $500." ]
	ChangevehColorNotEnough = [ "You need $%d to change vehicle color." ]
	ChangevehColorNotNum = [ "Color ID must be in number." ]
	ChangevehColorSyntax = [ "Syntax, /changevehcolor [primary color] [secondary color]" ]
	SetPnsPrice = [ "You set PnS price to $%d." ]
	SetPnsStockPriceSyntax = [ "Syntax, /setpnsfee [amount]" ]
	NotInPns2 = [ "You must be in Pay 'n' Spray to use this command." ]
	RestockPnsSyntax = [ "Syntax, /restockpns [quatity]" ]

	StoreItemLocal = [ "[#d580ff]* %s stores %s into the property." ]
	LoadItemLocal = [ "[#d580ff]* %s loaded %s from the property." ]
	LoadItem = [ "You loaded %s(%d) from the property." ]
	PropertyLocked = [ "Property locked." ]
	PropertyUnLocked = [ "Property unlocked." ]
	HouseRenameSyntax = [ "Syntax, /housename [text]" ]
	HouseRename = [ "You renamed this house." ]
	RepairInProgress = [ "Repair already in progress." ]
	GivecarToGroupSyntax = [ "Syntax, /givevehtogroup [group]" ]

	BodySpot1 = [ "[#668cff]A body has been spotted at %s!" ]
	BodySpot = [ "A body has been spotted at %s!" ]


	PDLevelInvalid = [ "Level must grater than 0." ]
	PDLevelNotNum = [ "Level must be in number." ]
	PDSetLevelSyntax = [ "Syntax, /pdsetlevel [player] [level]" ]
	PDSetlevelCantSetSelf = [ "You cant use this command on yourself." ]
	PDSetLevel1 = [ "You set %s's PD level to %d." ]
	PDSetLevel = [ "%s has changed your PD level to %d." ]
	TargetNotPDDuty = [ "Target player not on Police duty." ]
	NotPDDuty2 = [ "You are not on Police duty." ]
	SWATSetLevel1 = [ "You set %s's SWAT level to %d." ]
	SWATSetLevelSyntax = [ "Syntax, /swatsetlevel [player] [level]" ]
	PDSetRank = [ "%s has set your PD rank to %s." ]
	PDSetRank1 = [ "You set %s PD Rank to %s." ]
	PDSetRankSyntax = [ "Syntax, /setpdrank [player] [rank]" ]
	SWATSetRank = [ "%s has set your SWAT rank to %s." ]
	SWATSetRank1 = [ "You set %s SWAT Rank to %s." ]
	SWATSetRankSyntax = [ "Syntax, /swatsetrank [player] [rank]" ]
	RevokeUCRight = [ "%s has your revoked undercover right." ]
	RevokeUCRight1 = [ "You revoked %s's undercover right." ]
	GainUCRight = [ "%s has gained you undercover right." ]
	GainUCRight1 = [ "You gained %s undercover right." ]
	UCRightSyntax = [ "Syntax, /ucright [player]" ]

	Listgroupveh = [ "List of %s vehicle(s): %s" ]
	MyVehicleNoVehicle2 = [ "This group does not have any vehicle." ]
	ListgroupvehSyntax = [ "Syntax, /listgroupveh [group]" ]
	GroupTow = [ "You respawned group vehicle %s(ID:%s) for $5000." ]
	NeedCashFortow = [ "You need $5000 to respawn vehicle." ]
	VehicleHasDriver = [ "Target vehicle currently have driver." ]
	GroupVehIDNotFound = [ "Vehicle ID not found." ]
	GroupVehIDNotNum = [ "Vehicle ID must be in number." ]
	TowGroupVehSyntax = [ "Syntax, /towgroupveh [group] [veh id]" ]
	SucesfullyHalfRepair = [ "Vehicle have been sucessfully repaired to certain level." ]
	FailRepairMove = [ "Repair failed because you move." ]
	FailRepairTargetVehicleNotNear = [ "Repair failed because you are not near target vehicle." ]
	NotInsideVeh = [ "You must outside vehicle to use this command." ]
	RepairDontMove10 = [ "Repair begin, please do not move." ]
	NotNearvehicle2 = [ "You must near vehicle to repair." ]
	NoNeedRepair2 = [ "You dont need to fix this vehicle." ]

	SoldWeed = [ "You sold %dg weed(s) for $%d." ]
	NotEnoughWeed = [ "You dont have enough weed." ]
	SellSyntax = [ "Syntax, /sell [weed] [quatity]" ]
	QuatityNotNum = [ "Quatity must be in number." ]
	NotInBlackMarket = [ "You must be inside black market to use this command." ]
	BMCops = [ "Law enforcement are not allow to enter this place." ]



}

RandomMsg <-
{
	Text = [ 
		"You can store your items/weapons at house with /storewep or /storeitem", 
		"You can purchase bike at Biker Bar.",
		"You can purchase heli at stadium helipad.",
		"You need at least level 2 to purchase bomb. It can be used to crack bank vault.",
		"Surrender is safest way if you hold too much cash.",
		"You need bomb to crack the bank vault.",
		"Visit our forum [#ffffff]http://cnr.pl-community.com",
		"Remember to report bug on forum or we cant fix!",
		"Got any suggestion? Request it on forum."
		"Devils Inside Me",
		"Robbery point need time to generate cash.",
		"We are now recuiting new staff! Visit our forum for more info.",
		"Need to decoration your house? Visit furniture store at Little Haiti! (Beside Pay n Spray)",
		"Wonder how many property/house left for sale? Use /forsale",
		"The more player purchase at your propeties, the more income you get.",
	//	"You can create your own gang with /creategang",
		"If you arrested your illegal weapon will be confiscated, and you will lose 20% inhand cash.",
		"You can restock your cop gear neear enforcer.",
		"Consumers has been added to 24/7 which can help you while combat.",
		"You will drop weapon/item/cash on the ground when you get killed.",
		"Missing update? Type you can type /news ",
		"You can plant bomb everywhere with /plantbomb.",
		"You can ignore someone with /ignore",
		"Weapons are now saved after death/left server.",
		"You can now share your vehicle with other with /sharecar",
		"You can hide from radar with /hide",
		"Besure to store your item/weapon in house before going battle!",
		"You can purchase boats at Vice Port Boat Yard.",
		"You can gift car to someone with /sellcar",
		"You can customise/fix your heli at Airport Helipad.",
		"You can customise/fix your boats at Vice Port Boat Yard.",
		"You can purchase music kit at North Point Mall Music Shop.",
		"You need to active music kit with /usemusickit",
		"Deathmatch is allowed on this server.",
	]

	Count = 0,

}

UpdateLog <-
@" 
Version v2.4 Changelog (16/9/2019)  

- Change on mapping script
x Tweak on key pressing, now just press instead tapping to control object movement
x Added F2 key to switch between Position and Angle edit mode, now only arrow keys and page up/down will be used
x /editsens now accepts float value 

- added /storeall, to dump all item and weapon into storage
- added /givehouse
- increased bank robbery cash
- allowed attack inside VCPD
- gps/funiture/musickit not longer dropped when killed
- fixed cuffed player get jailed after being killed
- fixed exploit on /storeitem and /storewep
- fixed player job value not reset after respawn as civilian

Version v2.3 Changelog (16/9/2019)  
 
- added boat dealership in Vice Port Board Yard
- added boat PnS in Vice Port Board Yard
- added heli Pns in Airport Helipad
- added new music kit (apEX insult/insult3) in North Point Mall Music Shop
- added /ignore and /unignore
- added /sharecar and /delsharecar
- added /givecar, to give vehicle ownership to other
- added /hide, it remove player marker from radarmap
- disabled attack ability in black market
- lowered 50% deduce cash penalty to 15% when jailed
- cops will get (wanted*1000) when suspect dont have cash in hand  
- player will drop 50% weapon ammo, 15% cash, items in had when killed. Use /pick on dead drop to pick dead drop item.
- rocket laucher now require at least level 5 to purchase  
- custom weapon now show properly on kill message
- tweaked /use item name  
- fixed /usemusickit unable to active music kit  
- fixed /withdraw can be used everywhere
- fixed bank robbery detonation timer
- fixed /plantbomb bank robbery radius detection
"
