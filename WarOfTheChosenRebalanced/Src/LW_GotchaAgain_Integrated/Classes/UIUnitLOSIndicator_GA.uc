class UIUnitLOSIndicator_GA extends UIIcon;

var UIUnitFlag ParentUnitFlag;
var EIndicatorValue CurrentIndicatorValue;

public function UIUnitLOSIndicator_GA InitIndicator(UIUnitFlag ParentUnitFlagInstance) {
    ParentUnitFlag = ParentUnitFlagInstance;
    InitIcon(, , false, false, 32);
    SetDisabled(true);
    SetX(-12);
    SetY(-60);
    CurrentIndicatorValue = eNotVisible;
    return self;
}


public function SetIcon(IconPack_GA IconPack, EIndicatorValue IndicatorValue) {
    if(ParentUnitFlag.m_bConcealed) {
        if(X != -12 || Y != -25) {
            SetX(-12);
            SetY(-25);
        }
    } else if(XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(ParentUnitFlag.StoredObjectId)).IsBleedingOut()) {
        if(X != -20 || Y != -19) {
            SetX(-20);
            SetY(-19);
        }
    } else if(X != -12 || Y != -60) {
        SetX(-12);
        SetY(-60);
    }

    if(IndicatorValue != CurrentIndicatorValue) {
        LoadIcon(IconPack.GetIconFromIconSet(eUnitIconSet, IndicatorValue));
        CurrentIndicatorValue = IndicatorValue;
    }
}