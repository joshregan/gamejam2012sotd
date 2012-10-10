package ;
import org.flixel.FlxTimer;
import org.flixel.system.input.MapObject;
import org.flixel.FlxGame;

/**
 * ...
 * @author Ellie
 */

class ScoreSystem
{
	// Declare scores for player 1 and player 2
	// If time, be better to make into a list to allow more than 2 players
	public var numPlayers:Int;
	public var p1Current:Int;
	public var p2Current:Int;
	public var p1Total:Int;
	public var p2Total:Int;
	
	// Numbering system for gaining points
	public var winningScore:Int;
	public var bugNormal:Int;
	public var bugLightning:Int;
	public var selectOtherPlayer:Int;
	
	// Winning score = 200
	// score when you reveal other player dependent on time
	// = time in seconds, max 60;
	
	public function new() 
	{
		//super();
		//initialise all variables
		numPlayers = 2;
		p1Current = 0;
		p2Current = 0;
		p1Total = 0;
		p2Total = 0;
		bugNormal = 100;
		bugLightning = 200;
		winningScore = 1000;
		
		
	}
	
	// function to increase score when collect bug
	// If there is lightning, then the score is lower, as bug is easier to see
	public function collectBug(player:Int, lightning:Bool):Void {
		switch (player) {
			case 1:
				if (lightning) {
			      p1Current = p1Current + bugLightning;
				}
				else {
					p1Current = p1Current + bugNormal;
				}
				
		case 2:
			if (lightning) {
			p2Current = p2Current + bugLightning;
			}
		    else {
			p2Current = p2Current + bugNormal;	
			}
			
		}
	
	}
	
	// function to get points for guessing the other player
	// triggered by pressing special key and then selecting the frog
	// this is equal to elapsed number of seconds, max 60
	public function guessWinner (player:Int, isCorrect :Bool): Void {
		
		///var numSeconds:Int;
	//	numSeconds = new Int(timer.getProgress);
		
		switch (player) {
		case 1:
			if (isCorrect) {
			p1Current = p1Current + winningScore ;
			}
			else {
			p2Current = p2Current + winningScore ;
			}
			
		case 2:
			if (isCorrect) {
			p2Current = p2Current + winningScore ;
			}
			else {
					p1Current = p1Current + winningScore ;
			}
		}
		
	}
	
	// function to get the current score
	// returns the score
	
	public function getCurrentScore (player:Int):Int {
		
		switch (player) {
		case 1:
			return p1Current ;
		case 2:
			return p2Current ;
		default:
			return 0;
		}
			
	}
	
	
	// function to get the total score
	// returns the score
	public function getTotalScore (player:Int):Int {
		switch (player) { 
		case 1 :
			return p1Total ;
		case 2 :
		    return p2Total ;
		default:
			return 0;
		}	
	}
	
	
	// function to work out winner for the round
	public function getRoundWinner ():Int {
		if (p1Current > p2Current) {
			return 1;
		}else if  (p2Current > p1Current){
			return 2;
		}
		// in the unlikely event of a draw
		return 0;
	}
	
	// function to trigger win state
	// if either P1 or P2 reach the winning score, trigger win state
	public function triggerWinState (void):Bool {
		if (p1Total >= winningScore ) {
		return true;
		}
		else if (p2Total >= winningScore) {
			return true;
		} else {
		return false;
		}
	}
	
	
	// function to work out winner for the game
	public function getTotalWinner ():Int {
		if (p1Total > p2Total ){
			return 1;
		}else if ( p2Total > p1Total) {
			return 2;
		}
		// in the unlikely event of a draw
		return 0;
	}
	
	// End of each round, increment each players score
	public function workoutEndRoundScore () {
		p1Total = p1Total + p1Current;
		p2Total = p2Total + p2Current;

		p1Current = 0;
		p2Current = 0;
	}
	
}