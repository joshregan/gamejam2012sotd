package entities;

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import Assets;
import Global;
import entities.Frog.FrogColor;

class PlayableFrog extends Frog
{
	public var playerNumber : Int;

	public function new(X : Int, Y : Int, color : FrogColor, playerNum : Int)
	{
		super(X, Y, color);

		this.playerNumber = playerNum;
	}

	private function leftKey() : Bool
	{
		if (this.playerNumber == 1)
			return FlxG.keys.LEFT;
		else 
			return FlxG.keys.A;
	}

	private function rightKey() : Bool
	{
		if (this.playerNumber == 1)
			return FlxG.keys.RIGHT;
		else 
			return FlxG.keys.D;
	}

	private function jumpKey() : Bool
	{
		if (this.playerNumber == 1)
			return FlxG.keys.UP;
		else 
			return FlxG.keys.W;
	}

	override public function update()
	{
		if (!Global.paused)
		{
			this.acceleration.x = 0;
			if (this.leftKey() && this.isTouching(FlxObject.FLOOR))
			{
				this.walkLeft();
			}
			else if (this.rightKey() && this.isTouching(FlxObject.FLOOR))
			{
				this.walkRight();
			}
			else if (this.isTouching(FlxObject.FLOOR))
			{
				idle();
			}
			
			if (this.jumpKey() && this.isTouching(FlxObject.FLOOR))
			{
				this.jump();
			}
		}
	}
}