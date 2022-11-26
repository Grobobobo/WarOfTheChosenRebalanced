class UIUnitActivationIndicator_GA extends UIIcon;

enum EActivationIcon {
    eNone,
    eOverwatchTriggered,
    ePodActivated,
    eSuppressionTriggered,
};

const OverwatchTriggeredIconPath = "img:///UILibrary_GA.UnitIndicators.T2D_TriggeredOverwatchIcon";
const ActivationTriggeredIconPath = "img:///UILibrary_GA.UnitIndicators.T2D_TriggeredActivationIcon";
const SuppressionTriggeredIconPath = "img:///UILibrary_GA.UnitIndicators.T2D_TriggeredSuppressionIcon";

var private EActivationIcon CurrentIcon;

public function UIUnitActivationIndicator_GA InitIndicator() {
    InitIcon(, , false, false, 32);
    SetDisabled(true);
    // This places it exactly on top of the current overwatch icon
    SetX(20);
    SetY(-28);
    return self;
}

public function SetIcon(EActivationIcon ActivationType) {
    if(CurrentIcon == ActivationType) return;
    
    CurrentIcon = ActivationType;

    switch(CurrentIcon) {
        case eNone:
            LoadIcon("");
            break;
        case eOverwatchTriggered:
            LoadIcon(OverwatchTriggeredIconPath);
            break;
        case ePodActivated:
            LoadIcon(ActivationTriggeredIconPath);
            break;
        case eSuppressionTriggered:
            LoadIcon(SuppressionTriggeredIconPath);
            break;
    }
}