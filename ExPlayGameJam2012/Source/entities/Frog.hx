package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;

class Frog extends FlxSprite
{
	public function new(X : Int, Y : Int)
	{
		super(X, Y);

		this.makeGraphic(20, 20, 0xffff0000);
		this.maxVelocity.x = 80;
		this.maxVelocity.y = 200;
		this.acceleration.y = 200;
		this.drag.x = this.maxVelocity.x / 2;
	}

	public function jumpLeft()
	{
		this.velocity.x = -200;
		this.velocity.y = -this.maxVelocity.y * 0.75;
	}

	public function jumpRight()
	{
		this.velocity.x = 200;
		this.velocity.y = -this.maxVelocity.y * 0.75;
	}

	override public function update()
	{
		this.acceleration.x = 0;
		if (FlxG.keys.LEFT && this.isTouching(FlxObject.FLOOR))
		{
			this.jumpLeft();
		}
		if (FlxG.keys.RIGHT && this.isTouching(FlxObject.FLOOR))
		{
			this.jumpRight();
		}
	}
}