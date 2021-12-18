package;

import flixel.FlxSprite;

//class HealthIconOLD extends FlxSprite
//{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	//public var sprTrackerOLD:FlxSprite;

	//public function new(charOLD:String = 'bf', isPlayerOLD:Bool = false)
	//{
	//	super();
		
	//	loadGraphic(Paths.image('iconGrid'), true, 150, 150);

	//	antialiasing = true;
		//animation.add('eevee', [24, 25], 0, false, isPlayerOLD);
		//animation.add('shade', [26, 27], 0, false, isPlayerOLD);
		//animation.add('cloud', [53, 54], 0, false, isPlayerOLD);
		//animation.add('noctapolar', [55, 56], 0, false, isPlayerOLD);
		//animation.add('ron', [57], 0, false, isPlayerOLD);
		//animation.add('retro', [58, 59], 0, false, isPlayerOLD);
		//animation.play(charOLD);

	//	switch(charOLD)
	//	{
	//		case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit' | 'gf-pixel':
	//			antialiasing = false;
	//	}

	//	scrollFactor.set();
	//}

	//override function update(elapsed:Float)
	//{
	//	super.update(elapsed);

	//	if (sprTracker != null)
	//		setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	//}
//}
		
class HealthIcon extends FlxSprite
{
	public var char:String = 'bf';
	public var isPlayer:Bool = false;
	public var isOldIcon:Bool = false;

	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(?char:String = "bf", ?isPlayer:Bool = false)
	{
		super();

		this.char = char;
		this.isPlayer = isPlayer;

		isPlayer = isOldIcon = false;

		antialiasing = true;

		changeIcon(char);
		scrollFactor.set();
	}

	public function swapOldIcon()
	{
		(isOldIcon = !isOldIcon) ? changeIcon("bf-old") : changeIcon(char);
	}

	public function changeIcon(char:String)
	{
		if (char != 'bf-pixel' && char != 'bf-old')
			char = char.split("-")[0];

		loadGraphic(Paths.image('icons/icon-' + char), true, 150, 150);
		//if(char.endsWith('-pixel') || char.startsWith('senpai') || char.startsWith('spirit'))
		//	antialiasing = false
		//else
			antialiasing = true;
		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
