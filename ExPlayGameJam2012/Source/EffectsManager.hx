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
	
	public function new () 
	{
		// Setup timer manager
		effectsTimerManager = new TimerManager();
		isCreatingTimers = false;
		timerCreationCounter = 0;
		timerCreationThreshold = 30;
	}		

	public function showLightningEffect():Void
	{
		FlxG.flash(0xffffff, 0.2, showSecondaryLightningFlash, false); 
	}
	
	private function showSecondaryLightningFlash():Void
	{
		FlxG.flash(0xffffff, 0.3, null, false); 
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
		    rainDropPixel.makeGraphic(1, 1, 0xff0000ff);
		    rainDropPixel.visible = false;
		    rainEmitter.add(rainDropPixel);
		}

		FlxG.state.add(rainEmitter);
		rainEmitter.start(true, 3);
	}
	
	private function onTimer(Timer:FlxTimer):Void
	{
		createRainEmitter();
	}

	public function update():Void
	{
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
