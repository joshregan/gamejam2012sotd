package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import Assets;

class AIFrog extends Frog
{
	var counter:Int;
	var timeUntilNextMovementPhase:Int;
	var currentMovementType:Int;

	public function new(X : Int, Y : Int)
	{
		super(X, Y);
		counter = 0;
		timeUntilNextMovementPhase = 0;
	}

	override public function update()
	{
		if (counter < timeUntilNextMovementPhase)
		{
			counter++;
		}
		else
		{
			counter = 0;
			timeUntilNextMovementPhase = Std.random(100) % 1 + 60;
			currentMovementType = Std.random(4);
		}
		
		if (this.isTouching(FlxObject.FLOOR))
		{
			switch(currentMovementType)
			{
				case 0:
					this.walkLeft();
				case 1:
					this.walkRight();
				case 2:
					this.jump();
				case 3:
					this.idle();
			}
		}
	}
}