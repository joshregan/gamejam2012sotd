package ;

import org.flixel.FlxG;
import org.flixel.FlxParticle;
import org.flixel.FlxEmitter;
import org.flixel.FlxTimer;
import org.flixel.FlxSound;
import org.flixel.plugin.TimerManager;

/*
 * @author Josh
 */
class EffectsManager {
	// Variables for rain emitter creation
	var effectsTimerManager:TimerManager;
	var isCreatingTimers:Bool;
	var timerCreationCounter:Int;
	var timerCreationThreshold:Int;
	var rainDuration:Int;
	
	var counter:Int;
	var weatherPhaseTimer:Int;
	
	var isShowingLightningFlash:Bool;
	
	public function new () 
	{
		// Setup timer manager
		effectsTimerManager = new TimerManager();
		isCreatingTimers = false;
		timerCreationCounter = 0;
		timerCreationThreshold = 30;
		
		counter = 0;
		weatherPhaseTimer = Std.random(900) % 1 + 800;
		
		isShowingLightningFlash = false;
	}		

	public function showLightningEffect():Void
	{
		isShowingLightningFlash = true;
		FlxG.flash(0xffffff, 0.2, showSecondaryLightningFlash, false); 
	}
	
	private function showSecondaryLightningFlash():Void
	{
		FlxG.flash(0xffffff, 0.3, null, false); 
	}
	
	private function stopShowingLightningFlash():Void
	{
		isShowingLightningFlash = false;
	}
	
	public function checkIfShowingLightningFlash():Bool
	{
		return isShowingLightningFlash;
	}
	
	public function showRainEffect(duration:Int):Void
	{
		isCreatingTimers = true;
		rainDuration = duration;
	}
	
	private function createRainEmitter():Void
	{
		var rainEmitter : FlxEmitter = new FlxEmitter(0,0,10);
		rainEmitter.width = FlxG.width+180;
		rainEmitter.setXSpeed(-70,-80);
		rainEmitter.setYSpeed(70,80);
		rainEmitter.setRotation(0, 0);
		rainEmitter.gravity = 80;
		rainEmitter.bounce = 0.2;

		var rainDropPixel : FlxParticle;
		for (i in 0...rainEmitter.maxSize) 
		{
		    rainDropPixel = new FlxParticle();
		    rainDropPixel.makeGraphic(2, 2, 0xff0000ff);
		    rainDropPixel.visible = false;
		    rainEmitter.add(rainDropPixel);
		}

		FlxG.state.add(rainEmitter);
		rainEmitter.start(true, 5);
	}
	
	private function onTimer(Timer:FlxTimer):Void
	{
		createRainEmitter();
	}

	public function update():Void
	{
		if (counter < weatherPhaseTimer)
		{
			counter++;
		}
		else
		{
			counter = 0;
			weatherPhaseTimer = Std.random(900) % 1 + 800;
			
/*			var weatherType:Int = Std.random(2);
			if (weatherType == 0)
			{
				this.showRainEffect(12);
				FlxG.log(weatherPhaseTimer);
			}
			else
			{*/
				this.showLightningEffect();
/*			}*/
		}
	
		if (isCreatingTimers)
		{
			if (timerCreationCounter < timerCreationThreshold)
			{
				var rainEffectTimer:FlxTimer = new FlxTimer();
				rainEffectTimer.start(1, rainDuration, onTimer);
				effectsTimerManager.add(rainEffectTimer);
			
				timerCreationCounter++;
			}
			else
			{
				timerCreationCounter = 0;
				isCreatingTimers = false;
			}
		}
	
		effectsTimerManager.update();
	}

}
