package;

import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxG;

class PlayState extends FlxState		//The class declaration for the main game state
{
	var t:FlxText;

	//This is where we create the main game state!
	override public function create():Void
	{
		#if neko
		FlxG.camera.bgColor = { rgb: 0x000000, a: 0xff };
		#end
		
		t = new FlxText(0, Std.int(FlxG.height/2), FlxG.width, "Testing");
		t.alignment = "center";
		add(t);
	}
	
	//This is the main game loop function, where all the logic is done.
	override public function update():Void
	{	
		//This just says if the user clicked on the game to hide the cursor
		if(FlxG.mouse.justPressed())
			FlxG.mouse.hide();
		
		
		//THIS IS SUPER IMPORTANT and also easy to forget.  But all those objects that we added
		// to the state earlier (i.e. all of everything) will not get automatically updated
		// if you forget to call this function.  This is basically saying "state, call update
		// right now on all of the objects that were added."
		super.update();
	}
}