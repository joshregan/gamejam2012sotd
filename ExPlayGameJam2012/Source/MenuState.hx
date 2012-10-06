package;

import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxG;

/**
 * @author Josh Regan
 */
class MenuState extends FlxState
{
	var startGameInstructionText:FlxText;
	var titleText:FlxText;
	var howToPlayText:FlxText;
	var player1ControlsText:FlxText;
	var player2ControlsText:FlxText;

	override public function create():Void
	{
		#if neko
		FlxG.camera.bgColor = { rgb: 0x000000, a: 0xff };
		#end
		
		// Create text for the game title
		titleText = new FlxText(0, 20, FlxG.width, "Frog Game (Working Title!)");
		titleText.size = 36;
		titleText.alignment = "center";
		add(titleText);
		
		// Create text for the start game instructions
		startGameInstructionText = new FlxText(0, Std.int(FlxG.height/3), FlxG.width, "Press SPACE to start your froggy adventure!");
		startGameInstructionText.size = 24;
		startGameInstructionText.alignment = "center";
		add(startGameInstructionText);
		
		// Create how to play text
		howToPlayText = new FlxText(0, FlxG.height - Std.int(FlxG.height/2), FlxG.width, "How To Play:");
		howToPlayText.size = 22;
		howToPlayText.alignment = "center";
		add(howToPlayText);
		
		// Create text for player 1 controls
		player1ControlsText = new FlxText(0, FlxG.height - Std.int(FlxG.height/3), FlxG.width, "Player 1 Controls\nA = Move Left\nD = Move Right\nW = Jump\nL SHIFT = Action");
		player1ControlsText.size = 20;
		player1ControlsText.alignment = "left";
		add(player1ControlsText);
		
		// Create text for player 2 controls
		player2ControlsText = new FlxText(0, FlxG.height - Std.int(FlxG.height/3), FlxG.width, "Player 2 Controls\nLEFT = Move Left\nRIGHT = Move Right\nUP = Jump\nR SHIFT = Action");
		player2ControlsText.size = 20;
		player2ControlsText.alignment = "right";
		add(player2ControlsText);
	}
	
	override public function update():Void
	{	
		if(FlxG.mouse.justPressed())
			FlxG.mouse.hide();
		
		// Start game if spacebar is pressed and change to PlayState
		if (FlxG.keys.SPACE)
		{
			FlxG.switchState(new PlayState());
		}
		else if (FlxG.keys.ONE)
		{
			FlxG.switchState(new TestState());
		}
		
		super.update();
	}
}
