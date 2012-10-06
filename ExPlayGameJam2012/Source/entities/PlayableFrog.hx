package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import Assets;

class PlayableFrog extends Frog
{
	public function new(X : Int, Y : Int)
	{
		super(X, Y);
	}

	override public function update()
	{
		this.acceleration.x = 0;
		if (FlxG.keys.LEFT && this.isTouching(FlxObject.FLOOR))
		{
			this.walkLeft();
		}
		else if (FlxG.keys.RIGHT && this.isTouching(FlxObject.FLOOR))
		{
			this.walkRight();
		}
		else if (FlxG.keys.UP && this.isTouching(FlxObject.FLOOR))
		{
			this.jump();
		}
		else if (this.isTouching(FlxObject.FLOOR))
		{
			idle();
		}
	}
}