package;

import nme.display.Sprite;
import nme.Lib;

import org.flixel.FlxGame;

/**
 * @author James Frost
 */
class Main extends Sprite 
{
	
	public function new () 
	{
		super();
		
		var game:FlxGame = new FrogGame();
		addChild(game);
	}
	
	// Entry point
	public static function main() {
		
		Lib.current.addChild(new Main());
	}
	
}