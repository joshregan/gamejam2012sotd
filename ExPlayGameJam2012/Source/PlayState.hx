package;

import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxTimer;
import entities.AIFrog;
import entities.PlayableFrog;

class PlayState extends FlxState		//The class declaration for the main game state
{
	public var player1 : PlayableFrog;
	public var player2 : PlayableFrog;

	public var land : FlxSprite;
	public var background : FlxSprite;
	public var aiFrogs : FlxGroup;
	public var scenery : FlxGroup;
	public var players : FlxGroup;

	public var scores : ScoreSystem;
	var player1TotalScore:FlxText;
	var player2TotalScore:FlxText;
	var player1Score:Int;
	var player2Score:Int;

	//This is where we create the main game state!
	override public function create():Void
	{
		#if neko
		FlxG.camera.bgColor = { rgb: 0x000000, a: 0xff };
		#end
		
		// Initialise the score system, all totals set to 0
		scores = new ScoreSystem();
		
		aiFrogs = new FlxGroup();

		scenery = new FlxGroup();

		players = new FlxGroup();

		background = new FlxSprite(0,0,"assets/Background1.png");
		add(background);

		// Temporary frog
		player1 = new PlayableFrog(100, 30, 1);
		player2 = new PlayableFrog(700, 30, 2);
		
		players.add(player1);
		players.add(player2);
		add(players);

		for (i in 0...16)
		{
			var f : AIFrog = new AIFrog(Std.int(Math.random () * FlxG.width), 300);
			aiFrogs.add(f);
			var j : Int = Std.int(Math.random() * 50);
			if (j < 25)
				f.facing = FlxObject.LEFT;
			else
				f.facing = FlxObject.RIGHT;
		}
		add(aiFrogs);

		// Temporary landscape
		land = new FlxSprite(0, FlxG.height - 6);
		land.width = FlxG.width;
		land.height = 100;
		land.makeGraphic(FlxG.width, 100, 0x0000ff00);
		land.immovable = true;
		scenery.add(land);

		var leftBorder : FlxObject =  new FlxObject(-20, 0, 20, FlxG.height);
		leftBorder.immovable = true;
		scenery.add(leftBorder);

		var rightBorder : FlxObject =  new FlxObject(FlxG.width, 0, 20, FlxG.height);
		rightBorder.immovable = true;
		scenery.add(rightBorder);
		add(scenery);
		
		// Create text for player 1 score
		player1Score = scores.getCurrentScore (1);
		player1TotalScore = new FlxText(0, 10, FlxG.width, "Player 1: " + player1Score);
		player1TotalScore.alignment = "left";
		player1TotalScore.size = 20;
		add(player1TotalScore);
		
		// Create text for player 2 score
		player2Score = scores.getCurrentScore (2);
		player2TotalScore = new FlxText(0, 10, FlxG.width, "Player 2: " + player2Score);
		player2TotalScore.alignment = "right";
		player2TotalScore.size = 20;
		add(player2TotalScore);
		
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

		FlxG.collide(players, scenery);
		FlxG.collide(aiFrogs, scenery);

		player1TotalScore.text = "Player 1: " + player1Score;
		player2TotalScore.text = "Player 2: " + player2Score;
	}

	public function guessOtherPlayer(player : Int) : Void
	{

	}
}