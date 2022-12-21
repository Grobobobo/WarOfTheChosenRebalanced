
class UIArmory_LoadoutItem_GTO extends UIPanel;

var array<string> Images;
var array<UIImage> SpawnedImages;
var string PrototypeIcon;

var X2ItemTemplate ItemTemplate;

var UIPanel UpgradeContainer;

var int TooltipID;

simulated function UIArmory_LoadoutItem_GTO InitLoadoutItem(X2ItemTemplate Template)
{
	InitPanel();
	
	ItemTemplate=Template;
	PopulateData();

	return self;
}

simulated function PopulateData()
{
	SetImage(ItemTemplate); // passing none to SetImage clears the image
}

simulated function UIArmory_LoadoutItem_GTO SetImage(X2ItemTemplate Item)
{
	local int i;
	local bool bUpdate;
	local array<string> NewImages;
    local UIImage NewImage;
	ItemTemplate = Item;
	if(Item == none)
	{
		HideAllImages();
		return self;
	}

	NewImages = GetWeaponPanelImages(Item);


	bUpdate = false;
	for( i = 0; i < NewImages.Length; i++ )
	{
		if( Images.Length <= i || Images[i] != NewImages[i] )
		{
			bUpdate = true;
			break;
		}
	}

	//If no image at all is defined, mark it as empty 
	if( NewImages.length == 0 )
	{
		NewImages.AddItem("");
		bUpdate = true;
	}

	if(bUpdate)
	{
        for( i = 0; i < SpawnedImages.Length; i++ ){
			//SpawnedImages[i].Hide();
            SpawnedImages[i].Remove();
        }
        SpawnedImages.Length = 0;

		Images = NewImages;
		
		for( i = 0; i < Images.Length; i++ ){
			NewImage = Spawn(class'UIImage',self);
			NewImage.bAnimateOnInit=false;
			NewImage.InitImage(,Images[i]).setSize(410,174);
            SpawnedImages.AddItem(NewImage);
		}
	}
	return self;
}

simulated function HideAllImages(){
    local int i;
    
		for( i = 0; i < SpawnedImages.Length; i++ ){
		SpawnedImages[i].Hide();
		SpawnedImages[i].Remove();
        }
        SpawnedImages.Length = 0;
		Images.Length = 0;

}

simulated function array<string> GetWeaponPanelImages(X2ItemTemplate Template)
{
	local array<string> ImagesToGet; 
	local X2WeaponTemplate WeaponTemplate; 
	local int i; 
	local bool bUpgradeImageFound;

	if (Template.IsA('X2WeaponTemplate'))
	{
		WeaponTemplate = X2WeaponTemplate(Template); 

		if (Template.strImage != "")
			ImagesToGet.AddItem(Template.strImage);
		else if( X2WeaponTemplate(Template).WeaponPanelImage != "" )
			ImagesToGet.AddItem(X2WeaponTemplate(Template).WeaponPanelImage);

		//Cycle through base images
		for( i = 0; i < WeaponTemplate.DefaultAttachments.length; i++ )
		{
			bUpgradeImageFound = false;

			// If an upgrade image has already been added for that slot, don't add it to the stack
			if (!bUpgradeImageFound && WeaponTemplate.DefaultAttachments[i].AttachIconName != "")
				ImagesToGet.AddItem(WeaponTemplate.DefaultAttachments[i].AttachIconName);			
		}
	}
	else
	{
		if (Template.strImage != "")
			ImagesToGet.AddItem(Template.strImage);
		else if( X2WeaponTemplate(Template).WeaponPanelImage != "" )
			ImagesToGet.AddItem(X2WeaponTemplate(Template).WeaponPanelImage);
	}

	return ImagesToGet; 
}


// simulated function OnReceiveFocus()
// {
// 	if( !IsLocked && !bIsFocused )
// 	{
// 		bIsFocused = true;
// 		MC.FunctionVoid("onReceiveFocus");
// 	}
// }

// simulated function OnLoseFocus()
// {
// 	if( bIsFocused )
// 	{
// 		bIsFocused = false;
// 		MC.FunctionVoid("onLoseFocus");
// 	}
// }

// function OnDropItemClicked(UIButton kButton)
// {
// 	local XComGameState NewGameState;
// 	local XComGameState_HeadquartersXCom XComHQ;
// 	local XComGameState_Item ItemState; //ReplacementItemState; // Issue #171, not needed
// 	local XComGameState_Unit OwnerState;
// //	local array<X2EquipmentTemplate> BestGearTemplates; // Issue #171, not needed
// //	local bool bUpgradeSucceeded;

// 	if(UIArmory_Loadout_MP(Screen) != none)
// 	{
// 		UIArmory_Loadout_MP(Screen).OnStripItemsDialogCallback('eUIAction_Accept');
// 		return;
// 	}

// 	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Drop Item From Unit Loadout");
	
// 	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
// 	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	
// 	ItemState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', ItemRef.ObjectID));

// 	if (ItemState.OwnerStateObject.ObjectID != 0)
// 	{
// 		OwnerState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', ItemState.OwnerStateObject.ObjectID));
		
// 		if (OwnerState.RemoveItemFromInventory(ItemState, NewGameState))
// 		{
// 			XComHQ.PutItemInInventory(NewGameState, ItemState); // Add the dropped item back to the HQ
// 			// Issue #171 Start
// 			// Item is now re-equipped in ValidateLoadout, don't update ItemRef or ItemTemplate because UIArmory_Loadout(Screen).UpdateData(true) will destroy this anyways
// 			// bUpgradeSucceeded = false;
// 			OwnerState.ValidateLoadout(NewGameState);
// 			// Issue #171 End

// 			`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
// 			/* Issue #171 not needed
// 			if (bUpgradeSucceeded)
// 			{
// 				ItemRef = ReplacementItemState.GetReference();
// 				ItemTemplate = ReplacementItemState.GetMyTemplate();
// 			}
// 			else
// 			{
// 				ItemRef.ObjectID = 0;
// 				ItemTemplate = None;
// 			}*/

// 			UIArmory_Loadout(Screen).UpdateData(true);
// 			return;
// 		}
// 	}

// 	`XCOMHISTORY.CleanupPendingGameState(NewGameState);
// }

// simulated function OnCommand(string cmd, string arg)
// {
// 	if(cmd == "DropItemClicked")
// 		OnDropItemClicked(DropItemButton);
// }

defaultproperties
{
	Width = 410;
	Height = 174;
	bAnimateOnInit = false;
	bProcessesMouseEvents = false;
}