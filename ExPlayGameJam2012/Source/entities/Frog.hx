package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import org.flixel.FlxTimer;
import Assets;

 enum FrogColor {
        Brown;
        Green;
        Grey;
        Plum;
        Purple;
        Turquoise;
    }

class Frog extends FlxSprite
{
   	public function new(X : Int, Y : Int, color : FrogColor)
	{
		super(X, Y);

		//this.makeGraphic(20, 20, 0xffff0000);
		this.unpause();

		var frogImage : String = "";

		switch (color) {
			case Brown:
				frogImage = "assets/frogs/BrownFrog.png";
			case Green:
				frogImage = "assets/frogs/GreenFrog.png";
			case Grey:
				frogImage = "assets/frogs/GreyFrog.png";
			case Plum:
				frogImage = "assets/frogs/PlumFrog.png";
			case Purple:
				frogImage = "assets/frogs/PurpleFrog.png";
			case Turquoise:
				frogImage = "assets/frogs/TurquoiseFrog.png";
			default:

		}

		loadGraphic(frogImage, true, true, 48, 48, true);
		addAnimation("idle", [0,1,2,3,4,5,6,7], 8, true);
		addAnimation("jump", [13,14,15,16], 16, false);
		addAnimation("walk", [13,14,15,16,17,18,19], 16, true);
		addAnimation("death", [39, 40], 4, true);

		var animationDelay : Float = Math.random() * 2;
		var timer : FlxTimer = new FlxTimer();
		timer.start(animationDelay, 0, function(timer : FlxTimer) {
			play("idle");
		});
	}

	public function pause()
	{
		this.frame = 0;
		this.velocity.x = 0;
		this.velocity.y = 0;
		this.acceleration.y = 0;
		this.acceleration.x = 0;
	}

	public function unpause()
	{
		this.maxVelocity.x = 200;
		this.maxVelocity.y = 200;
		this.acceleration.y = 200;
		this.drag.x = this.maxVelocity.x;
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

	public function end()
	{
		play("death");
		this.velocity.y = -20;
	}

	override public function update()
	{
		// this.acceleration.x = 0;
		// if (FlxG.keys.LEFT && this.isTouching(FlxObject.FLOOR))
		// {
		// 	this.walkLeft();
		// }
		// else if (FlxG.keys.RIGHT && this.isTouching(FlxObject.FLOOR))
		// {
		// 	this.walkRight();
		// }
		// else if (FlxG.keys.UP && this.isTouching(FlxObject.FLOOR))
		// {
		// 	this.jump();
		// }
		// else if (this.isTouching(FlxObject.FLOOR))
		// {
		// 	idle();
		// }
	}
}