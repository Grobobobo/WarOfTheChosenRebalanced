class IconPack_GA extends Object;

// Order here is important since it defines the initial value for UIUnitLOSIndicator_GA icons
enum EIndicatorValue {
    eNotVisible,
    eSpotted,
    eSquadsight,
    eFlanked,
    eSquadsightFlanked,
    eSpottedByEnemy,
    eHackable,
    eAlreadyHacked,
    eSpottedFriendly,
    eLoneWolfActive
};

enum EIconSetIdentifier {
    eNoIconSet,
    eDestroyAlienFacility,
    eKillVIP,
    eRecoverItem,
    eHackWorkstation,
    eHackUFO,
    eHackBroadcast,
    eHackAdventTower,
    eUnitIconSet
};

struct ArrowIndicatorIconSet {
    var EIconSetIdentifier Identifier;
    var string DefaultIcon,
               SpottedIcon,
               FlankedIcon,
               SquadsightIcon,
               SquadsightFlankedIcon,
               HackableIcon,
               AlreadyHackedIcon;
};

struct UnitIndicatorIconSet {
    var string SpottedIcon,
               FlankedIcon,
               SquadsightIcon,
               SquadsightFlankedIcon,
               HackableIcon,
               SpottedFriendlyIcon,
               SpottedByEnemyIcon,
               LoneWolfActiveIcon;
};

var ArrowIndicatorIconSet IconSetDestroyAlienFacility,
                          IconSetKillVIP,
                          IconSetRecoverItem,
                          IconSetHackWorkstation,
                          IconSetHackUFO,
                          IconSetHackBroadcast,
                          IconSetHackAdventTower;

var UnitIndicatorIconSet IconSetUnits;

var private array<ArrowIndicatorIconSet> IconSets;


public function Init() {
    IconSets.AddItem(IconSetDestroyAlienFacility);
    IconSets.AddItem(IconSetKillVIP);
    IconSets.AddItem(IconSetRecoverItem);
    IconSets.AddItem(IconSetHackWorkstation);
    IconSets.AddItem(IconSetHackUFO);
    IconSets.AddItem(IconSetHackBroadcast);
    IconSets.AddItem(IconSetHackAdventTower);
}


public function EIconSetIdentifier IdentifyIconSet(XcomGameState_IndicatorArrow Arrow) {
    local string IconName;
    local int i;

    // This relies on the icon-paths only containing a single "."
    // It is only used for identifying arrow icons which follow this rule
    IconName = Split(Arrow.Icon, ".", true);

    for(i = 0; i < IconSets.Length; i++) {
        if(InStr(IconSets[i].DefaultIcon, IconName) > -1 ||
           InStr(IconSets[i].SpottedIcon, IconName) > -1 ||
           InStr(IconSets[i].SquadsightIcon, IconName) > -1 ||
           InStr(IconSets[i].FlankedIcon, IconName) > -1 ||
           InStr(IconSets[i].SquadsightFlankedIcon, IconName) > -1 ||
           InStr(IconSets[i].HackableIcon, IconName) > -1 ||
           InStr(IconSets[i].AlreadyHackedIcon, IconName) > -1) {  
            return IconSets[i].Identifier;
        }
    }
    return eNoIconSet;
}


public function string GetIconFromIconSet(EIconSetIdentifier IconSetIdentifier, EIndicatorValue IndicatorValue) {
    if(IconSetIdentifier == eUnitIconSet) return GetIconFromUnitIconSet(IndicatorValue);

    switch(IndicatorValue) {
        case eNotVisible:           return GetIconSet(IconSetIdentifier).DefaultIcon;
        case eSpotted:              return GetIconSet(IconSetIdentifier).SpottedIcon;
        case eSquadsight:           return GetIconSet(IconSetIdentifier).SquadsightIcon;
        case eFlanked:              return GetIconSet(IconSetIdentifier).FlankedIcon;
        case eSquadsightFlanked:    return GetIconSet(IconSetIdentifier).SquadsightFlankedIcon;
        case eHackable:             return GetIconSet(IconSetIdentifier).HackableIcon;
        case eAlreadyHacked:        return GetIconSet(IconSetIdentifier).AlreadyHackedIcon;

        default:
            `log("Gotcha Again: Error! Requested icon for unsupported EIndicatorValue");
    }
}

private function string GetIconFromUnitIconSet(EIndicatorValue IndicatorValue) {
    switch(IndicatorValue) {
        case eNotVisible:           return "";
        case eSpotted:              return IconSetUnits.SpottedIcon;
        case eSquadsight:           return IconSetUnits.SquadsightIcon;
        case eFlanked:              return IconSetUnits.FlankedIcon;
        case eSquadsightFlanked:    return IconSetUnits.SquadsightFlankedIcon;
        case eHackable:             return IconSetUnits.HackableIcon;
        case eSpottedFriendly:      return IconSetUnits.SpottedFriendlyIcon;
        case eSpottedByEnemy:       return IconSetUnits.SpottedByEnemyIcon;
        case eLoneWolfActive:       return IconSetUnits.LoneWolfActiveIcon;

        default:
            `log("Gotcha Again: Error! Requested icon in UnitIconSet for unsupported EIndicatorValue");
    }
}

public function ArrowIndicatorIconSet GetIconSet(EIconSetIdentifier IconSet) {
    switch (IconSet) {
        case eDestroyAlienFacility:  return IconSetDestroyAlienFacility;
        case eKillVIP:               return IconSetKillVIP;
        case eRecoverItem:           return IconSetRecoverItem;
        case eHackWorkstation:       return IconSetHackWorkstation;
        case eHackUFO:               return IconSetHackUFO;
        case eHackBroadcast:         return IconSetHackBroadcast;
        case eHackAdventTower:       return IconSetHackAdventTower;

        default:
            `log("Gotcha Again: Error! Requested iconset for unsupported EIconSetIdentifier");
    }
}


public static function IconPack_GA LoadIconPack() {
    local IconPack_GA IconPack;

    switch(class'LW_GotchaAgain_IntegratedSettings'.default.sIconPack) {
        case "lewe1":
            IconPack = new class'IconPack_GA_lewe1';
            break;
        case "lewe2":
            IconPack = new class'IconPack_GA_lewe2';
            break;
        case "lewe3":
            IconPack = new class'IconPack_GA_lewe3';
            break;
        case "lewe4":
            IconPack = new class'IconPack_GA_lewe4';
            break;
        case "lewe5":
            IconPack = new class'IconPack_GA_lewe5';
            break;
        case "vhs0":
            IconPack = new class'IconPack_GA_vhs0';
            break;
        case "vhs1":
            IconPack = new class'IconPack_GA_vhs1';
            break;
        case "vhs2":
            IconPack = new class'IconPack_GA_vhs2';
            break;

        default:
            IconPack = new class'IconPack_GA';
            break;
    }
    
    IconPack.Init();
    return IconPack;
}


// These defaults are copied from the default iconpack (vhs2), so there is something to fall back on if
// an iconpack does not specify a specific icon.
defaultproperties
{
    IconSetDestroyAlienFacility = {(
        Identifier            = eDestroyAlienFacility,
        DefaultIcon           = "img:///UILibrary_GA_vhs2.Objective_DestroyAlienFacility",
        SpottedIcon           = "img:///UILibrary_GA_vhs2.Objective_DestroyAlienFacility_spotted",
        SquadsightIcon        = "img:///UILibrary_GA_vhs2.Objective_DestroyAlienFacility_squadsight",
    )};
    
    IconSetKillVIP = {(
        Identifier            = eKillVIP,
        DefaultIcon           = "img:///UILibrary_GA_vhs2.Objective_VIP",
        SpottedIcon           = "img:///UILibrary_GA_vhs2.Objective_VIP_spotted",
        FlankedIcon           = "img:///UILibrary_GA_vhs2.Objective_VIP_flanked",
        SquadsightIcon        = "img:///UILibrary_GA_vhs2.Objective_VIP_squadsight",
        SquadsightFlankedIcon = "img:///UILibrary_GA_vhs2.Objective_VIP_squadsight_flanked",
    )};

    IconSetRecoverItem = {(
        Identifier            = eRecoverItem,
        DefaultIcon           = "img:///UILibrary_Common.Objective_RecoverItem",
        HackableIcon          = "img:///UILibrary_GA_vhs2.Objective_RecoverItem_hackable",
    )};

    IconSetHackWorkstation = {(
        Identifier            = eHackWorkstation,
        DefaultIcon           = "img:///UILibrary_GA_vhs2.Objective_HackWorkstation",
        HackableIcon          = "img:///UILibrary_GA_vhs2.Objective_HackWorkstation_hackable",
    )};

    IconSetHackUFO = {(
        Identifier            = eHackUFO,
        DefaultIcon           = "img:///UILibrary_GA_vhs2.Objective_UFO",
        HackableIcon          = "img:///UILibrary_GA_vhs2.Objective_UFO_hackable",
    )};

    IconSetHackBroadcast = {(
        Identifier            = eHackBroadcast,
        DefaultIcon           = "img:///UILibrary_Common.Objective_Broadcast",
        HackableIcon          = "img:///UILibrary_GA_vhs2.Objective_Broadcast_hackable",
    )};

    IconSetHackAdventTower = {(
        Identifier            = eHackAdventTower,
        DefaultIcon           = "img:///UILibrary_GA_vhs2.Objective_HackAdventTower",
        HackableIcon          = "img:///UILibrary_GA_vhs2.Objective_HackAdventTower_hackable",
        AlreadyHackedIcon     = "img:///UILibrary_GA_vhs2.Objective_HackAdventTower_alreadyHacked",
    )};

    IconSetUnits = {(
        SpottedIcon           = "img:///UILibrary_GA.UnitIndicators.T2D_SpottedIcon",
        FlankedIcon           = "img:///UILibrary_GA.UnitIndicators.T2D_SpottedFlankedIcon",
        SquadsightIcon        = "img:///UILibrary_GA.UnitIndicators.T2D_SquadsightSpottedIcon",
        SquadsightFlankedIcon = "img:///UILibrary_GA.UnitIndicators.T2D_SquadsightSpottedFlankedIcon",
        HackableIcon          = "img:///UILibrary_GA.UnitIndicators.T2D_SquadsightHackableIcon",
        SpottedFriendlyIcon   = "img:///UILibrary_GA.UnitIndicators.T2D_SpottedFriendlyIcon",
        SpottedByEnemyIcon    = "img:///gfxUnitFlag.alert_green",
        LoneWolfActiveIcon    = "img:///UILibrary_GA.UnitIndicators.T2D_LoneWolfIcon",
    )};        
}