package entities;

import org.flixel.FlxSprite;

class Hand extends FlxSprite
{
	public var currentIndex : Int;

   	public function new(X : Int, Y : Int)
	{
		super(X, Y);

		this.currentIndex = 0;
		loadGraphic("assets/HandSprite-1.png", true, false, 48, 48, true);
		addAnimation("idle", [0,1,2,3], 4, true);
		play("idle");
	}
}