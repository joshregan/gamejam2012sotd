package ;

import org.flixel.FlxG;
import org.flixel.FlxParticle;
import org.flixel.FlxEmitter;
import org.flixel.FlxTimer;
import org.flixel.FlxSound;
import org.flixel.FlxObject;
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
	
	public var allowLightning:Bool;
	
	public function new (lightning:Bool) 
	{
		// Setup timer manager
		effectsTimerManager = new TimerManager();
		isCreatingTimers = false;
		timerCreationCounter = 0;
		timerCreationThreshold = 30;
		
		counter = 0;
		weatherPhaseTimer = Std.random(900) % 1 + 800;
		
		isShowingLightningFlash = false;
		
		allowLightning = lightning;
	}		

	public function showLightningEffect():Void
	{
		isShowingLightningFlash = true;
		FlxG.flash(0xffffff, 0.4, showSecondaryLightningFlash, false); 
	}
	
	private function showSecondaryLightningFlash():Void
	{
		FlxG.flash(0xffffff, 0.5, stopShowingLightningFlash, false); 
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

	public function startRain() : Void
	{
		this.createRainEmitter();
	}
	
	private function createRainEmitter():Void
	{
		
		var rainEmitter : FlxEmitter = new FlxEmitter(0,0,250);
		rainEmitter.width = FlxG.width*1.5;
		rainEmitter.setXSpeed(-110,-120);
		rainEmitter.setYSpeed(260,280);
		rainEmitter.minRotation = 0;
		rainEmitter.maxRotation = 0;
		rainEmitter.bounce = 0.2;

		var rainDropPixel : FlxParticle;
		for (i in 0...250) 
		{
		    rainDropPixel = new FlxParticle();
		    rainDropPixel.makeGraphic(2, 12, 0xff304b6f);
			rainDropPixel.angle = 25;
		    rainEmitter.add(rainDropPixel);
		}

		FlxG.state.add(rainEmitter);
		rainEmitter.start(false, 15.0, 0.010);
	}
	
	public function showCritterCollectEffect(critter:FlxObject):Void
	{
		var critterCollectEmitter : FlxEmitter = new FlxEmitter(0,0,10);
		critterCollectEmitter.setXSpeed(-30,30);
		critterCollectEmitter.setYSpeed(-30,30);
		critterCollectEmitter.setRotation(0, 0);
		critterCollectEmitter.gravity = 180;
		critterCollectEmitter.bounce = 0.2;

		var critterCollectPixel : FlxParticle;
		for (i in 0...critterCollectEmitter.maxSize) 
		{
		    critterCollectPixel = new FlxParticle();
		    critterCollectPixel.makeGraphic(1, 1, 0xff00ff00);
		    critterCollectPixel.visible = false;
		    critterCollectEmitter.add(critterCollectPixel);
		}


		FlxG.state.add(critterCollectEmitter);
		critterCollectEmitter.at(critter);
		critterCollectEmitter.start(true, 5);
	}
	
	private function onTimer(Timer:FlxTimer):Void
	{
		createRainEmitter();
	}

	public function update():Void
	{
		if (allowLightning)
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
