// tooltip group to keep our tooltips in a good position
class YAF1_UITooltipGroup_TopStacking_FixPosition extends UITooltipGroup;


var float fixX, startY;

var bool bDisableReposition;

delegate OnRepositioned();

simulated function int Add(UITooltip Tooltip)
{
	return super.Add(Tooltip);
}

simulated function Notify()
{
	local UITooltip CurrentTooltip;
	local int Index;
	local float runningY;


	runningY = startY;

	for (Index = 0; Index < Group.Length; ++Index)
	{
		CurrentTooltip = Group[Index];
		CurrentTooltip.SetPosition(fixX, runningY);
		if (CurrentTooltip.bIsVisible)
		{
			runningY += CurrentTooltip.Height;
		}
	}

	if (OnRepositioned != none && !bDisableReposition)
		OnRepositioned();
}