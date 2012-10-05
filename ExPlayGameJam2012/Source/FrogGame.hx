package;
import org.flixel.FlxG;
import org.flixel.FlxGame;

class FrogGame extends FlxGame
{
	public function new()
	{
		super(800, 480, PlayState, 1); //Create a new FlxGame object at 800x480 with 1x pixels, then load PlayState
		#if !neko
		FlxG.bgColor = 0x000000;
		#end
		forceDebugger = true;
	}
}