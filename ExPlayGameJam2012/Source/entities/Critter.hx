package entities;

/**
 * ...
 * @author Ellie
 */

import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import Assets;

class Critter extends FlxSprite
{
	public function new(X : Int, Y : Int)
	{
		super(X, Y);
		this.makeGraphic(2, 2);
		//this.setSolid();
		

		
	}


}