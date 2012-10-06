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
	public function new(X : Int, Y : Int, beetleNum: Int)
	{
		super(X, Y);
		
		// choose one of the four different critters
		switch (beetleNum) {
		case 1 :
		loadGraphic("assets/Beetle.png", false);
		case 2 :
		loadGraphic("assets/Beetle2.png", false);
		case 3 :
		loadGraphic("assets/Beetle3.png", false);
		case 4 :
		loadGraphic("assets/Beetle4.png", false);
		}
		

		
	}


}