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
import entities.Frog;
import entities.Critter;
import entities.Hand;
import entities.Frog.FrogColor;
import org.flixel.FlxU;
import org.flixel.FlxTimer;
import flash.display.BlendMode;

class PlayState extends FlxState		//The class declaration for the main game state
{
	public var player1 : PlayableFrog;
	public var player2 : PlayableFrog;

	public var land : FlxSprite;
	public var background : FlxSprite;
	public var aiFrogs : FlxGroup;
	public var scenery : FlxGroup;
	public var players : FlxGroup;
	public var critters : FlxGroup;
	public var allFrogs : FlxGroup;
	public var selectFrogsArray : Array<Dynamic>;

	var timer:FlxTimer;
	
	public var scores : ScoreSystem;
	var player1TotalScore:FlxText;
	var player2TotalScore:FlxText;
	var player1Score:Int;
	var player2Score:Int;

	var pausedPlayer : Int;
	var hand : Hand;
	var frogHighlight : FlxSprite;

	//This is where we create the main game state!
	override public function create():Void
	{
		#if neko
		FlxG.camera.bgColor = { rgb: 0x000000, a: 0xff };
		#end
		
		Global.paused = false;

		// Initialise timer per game
		timer = new FlxTimer();
		timer.start(60);
		
		// Initialise the score system, all totals set to 0
		scores = new ScoreSystem();
		
		aiFrogs = new FlxGroup();

		scenery = new FlxGroup();

		players = new FlxGroup();
		critters = new FlxGroup();
		allFrogs = new FlxGroup();

		background = new FlxSprite(0,0,"assets/scenery/BG.png");
		add(background);

		// Temporary frog

		var selectedColors : Array<FrogColor> = new Array<FrogColor>();

		for (i in 0...4)
		{
			var color : FrogColor = FrogColor.Green;

			switch (Std.random(6)) {
				case 0:
					color = FrogColor.Brown;
				case 1:
					color = FrogColor.Green;
				case 2:
					color = FrogColor.Grey;
				case 3:
					color = FrogColor.Plum;
				case 4:
					color = FrogColor.Purple;
				case 5:
					color = FrogColor.Turquoise;
			}

			selectedColors.push(color);

			for (k in 0...4)
			{
				var f : AIFrog = new AIFrog(Std.int(Math.random () * FlxG.width), 300, color);
				aiFrogs.add(f);
				allFrogs.add(f);
				var j : Int = Std.int(Math.random() * 50);

				if (j < 25)
					f.facing = FlxObject.LEFT;
				else
					f.facing = FlxObject.RIGHT;
				}
		}

		add(aiFrogs);

		player1 = new PlayableFrog(Std.int(Math.random() * FlxG.width), FlxG.height - 100, selectedColors[0], 1);
		player2 = new PlayableFrog(Std.int(Math.random() * FlxG.width), FlxG.height - 100, selectedColors[1], 2);
		
		players.add(player1);
		players.add(player2);

		allFrogs.add(player1);
		allFrogs.add(player2);
		add(players);

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
		
		// temporarily add the timer
		
		// Loop to add Critters, using the 4 different images
		//var e_debug :String = new String ("");
	    for (k in 0...5)
		{
		
			for (l in 1...5) {
				//	e_debug = e_debug + " ( " + k+ ", " + l + ") ";
			var critter:Critter;
			critter = new entities.Critter(Std.int(Math.random () * FlxG.width), Std.int(Math.random () * FlxG.height), l);
			// adding gravity to crittes, so they eventually be reached
            //critter.acceleration.y = 50;
			critters.add(critter);
			}
			
			
		}
		add(critters);

		hand = new Hand(0,0);
		add(hand);
		hand.visible = false;

		//	FlxG.log (" DEBUG:  " + e_debug);

	}
	
	//This is the main game loop function, where all the logic is done.
	override public function update():Void
	{	
		//This just says if the user clicked on the game to hide the cursor
		if(FlxG.mouse.justPressed())
			FlxG.mouse.hide();
		
		if ((FlxG.keys.TAB || FlxG.keys.ENTER) && !Global.paused)
		{
			Global.paused = true;

			for (i in 0...aiFrogs.countLiving())
			{
				var f : Frog = cast(aiFrogs.members[i], Frog);
				f.pause();
			}
			player1.pause();
			player2.pause();

			hand.visible = true;

			selectFrogsArray = allFrogs.members;
			selectFrogsArray.sort(function (x : FlxObject, y : FlxObject) : Int {
					if (x.x < y.x)
						return 1;
					else if (x.x > y.x)
						return -1;
					else
						return 0;
				});

			this.positionHand();

			if (FlxG.keys.TAB)
			{
				pausedPlayer = 1;
			} else if (FlxG.keys.ENTER)
			{
				// PLAYER 2
				pausedPlayer = 2;
			}
		}

		if (Global.paused)
		{
			if (FlxG.keys.justPressed("LEFT"))
				this.positionHand(1);
			else if (FlxG.keys.justPressed("RIGHT"))
				this.positionHand(-1);
			else if (FlxG.keys.justPressed("A"))
				this.positionHand(1);
			else if (FlxG.keys.justPressed("D"))			
				this.positionHand(-1);
			else if (FlxG.keys.justPressed("SPACE"))
			{
				guessOtherPlayer();
			}
		}

		//THIS IS SUPER IMPORTANT and also easy to forget.  But all those objects that we added
		// to the state earlier (i.e. all of everything) will not get automatically updated
		// if you forget to call this function.  This is basically saying "state, call update
		// right now on all of the objects that were added."
		super.update();

		FlxG.collide(players, scenery);
		FlxG.collide(aiFrogs, scenery);
			
		//check if any player is touching a critter
		FlxG.overlap(critters, players, collectCritter);

		player1TotalScore.text = "Player 1: " + scores.p1Current;
		player2TotalScore.text = "Player 2: " + scores.p2Current;
	}

	public function collectCritter (critter:FlxObject, player:FlxObject): Void {
		//effectsManager.showCritterCollectEffect(critter);
		critter.kill();
	    scores.collectBug (cast(player, PlayableFrog).playerNumber, false);
	}
	
	public function guessOtherPlayer() : Void {
		
		var o : Frog = cast(selectFrogsArray[hand.currentIndex], Frog);

		if (pausedPlayer == 1)
		{
			if (o == player2)
			{
				// WIN!
				//scores.guessWinner(1, true);
				player2.end();
			}
			else
			{
				// LOSE
				//scores.guessWinner(1, false);
				player1.end();
			}
		}
		else if (pausedPlayer == 2)
		{
			if (o == player1)
			{
				// WIN!
				//scores.guessWinner(2, true);
				player1.end();
			}
			else
			{
				// LOSE
				//scores.guessWinner(2, false);
				player2.end();
			}
		}
	}

	public function positionHand(offset : Int = 0)
	{
		var old : FlxSprite = cast(selectFrogsArray[hand.currentIndex], FlxSprite);
		old.color = 0xffffffff;
		hand.currentIndex += offset;

		if (hand.currentIndex < 0)
			hand.currentIndex = selectFrogsArray.length - 1;
		else if (hand.currentIndex >= selectFrogsArray.length)
			hand.currentIndex = 0;


		var o : FlxSprite = cast(selectFrogsArray[hand.currentIndex], FlxSprite);

		hand.x = o.x;
		hand.y = o.y - 60;

		o.color = 0xff00ff00;
	}
}