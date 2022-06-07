// a panel to associate an image with a label, everything horizontally
// auto-resizing with a callback so it can be centered
class YAF1_UIStatPanel extends UIPanel;

struct StringPair
{
	var string A;
	var string B;
};

var array<UIImage> Images;
var array<UIText> Labels;

var string strColor;

var int maxWidth;
var int iconSize;

var bool bRequireNotify;


delegate SizeChanged();

simulated function YAF1_UIStatPanel InitStatPanel(int initIconSize, optional int numStart, optional int limitWidth = -1)
{
	InitPanel();
	maxWidth = limitWidth;
	iconSize = initIconSize;
	Height = iconSize;
	SetNum(numStart);

	return self;
}

simulated function SetNum(int num)
{
	local UIImage Image;
	local UIText Text;
	local int i;

	while (Images.Length < num)
	{
		Image = Spawn(class'UIImage', self).InitImage('');
		Image.SetSize(iconSize, iconSize);
		Image.SetColor(strColor);
		Images.AddItem(Image);

		Text = Spawn(class'UIText', self).InitText();
		Text.SetY(-1);
		Labels.AddItem(Text);
	}

	for (i = 0; i < Images.Length; i++)
	{
		if (i < num)
		{
			Images[i].Show();
			Labels[i].Show();
		}
		else
		{
			Images[i].Hide();
			Labels[i].Hide();
		}
	}
}

simulated function UIPanel SetColor(string clr)
{
	local int i;
	if (strColor != clr)
	{
		strColor = clr;
		for (i = 0; i < Images.Length; i++)
		{
			Images[i].SetColor(strColor);
		}
	}
	return self;
}

simulated function SetData(array<StringPair> data)
{
	local int i;
	SetNum(data.Length);
	for (i = 0; i < data.Length; i++)
	{
		Images[i].LoadImage(data[i].A);
		Labels[i].SetHTMLText(data[i].B, OnTextSizeRealized, true);
	}
	bRequireNotify = true;
}

// yes, we are doing this 8 times
// no, I don't have a better plan
// although some calls will be filtered internally
simulated function OnTextSizeRealized()
{
	local int runningX;
	local int runningY;
	local int i;

	runningX = 0;
	runningY = 0;
	for (i = 0; i < Images.Length && Images[i].bIsVisible; i++)
	{
		// if we have a max width and already something in our line, start a new line
		// you can specify a MaxWidth of 1 and have it place everything on a separate line
		if (maxWidth > 0 && runningX > 0)
		{
			// no +15, we don't need to check for empty space at the end?
			if (runningX + Images[i].Width + 2 + Labels[i].Width > maxWidth)
			{
				runningY += 2;
				runningX = 0;
			}
		}

		if (runningX == 0)
		{
			runningY += iconSize;
		}

		Images[i].SetPosition(runningX, runningY - iconSize);
		runningX += Images[i].Width + 2;

		Labels[i].SetPosition(runningX, runningY - iconSize - 2);
		runningX += Labels[i].Width + 15;
	}

	Width = runningX;
	Height = runningY;

	bRequireNotify = true;
}

event Tick(float fDeltaTime)
{
	if (bRequireNotify)
	{
		bRequireNotify = false;
		if (SizeChanged != none)
			SizeChanged();
	}
}

defaultproperties
{
	strColor="FFFFFF"	
}