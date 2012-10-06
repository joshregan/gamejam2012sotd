package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import Assets;

class Frog extends FlxSprite
{
	public function new(X : Int, Y : Int)
	{
		super(X, Y);

		//this.makeGraphic(20, 20, 0xffff0000);
		this.maxVelocity.x = 200;
		this.maxVelocity.y = 200;
		this.acceleration.y = 200;
		this.drag.x = this.maxVelocity.x;

		loadGraphic("assets/adjustedfrog.png", true, true, 48, 48, true);
		addAnimation("idle", [0,1,2,3,4,5,6,7], 8, true);
		addAnimation("jump", [13,14,15,16], 16, false);
		addAnimation("walk", [13,14,15,16,17,18,19], 16, true);

		play("walk");
	}

	public function jump()
	{
		play("jump");
		
		if (this.facing == FlxObject.RIGHT)
			this.velocity.x = -300;
		else
			this.velocity.x = 300;

		this.velocity.y = -this.maxVelocity.y * 0.75;
		this.drag.x = this.maxVelocity.x / 2;
	}

	public function walkLeft()
	{
		play("walk");
		this.facing = FlxObject.RIGHT;
		this.velocity.x = -100;
	}

	public function walkRight()
	{
		play("walk");
		this.facing = FlxObject.LEFT;
		this.velocity.x = 100;
	}

	public function idle()
	{
		play("idle");
		this.drag.x = this.maxVelocity.x;
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