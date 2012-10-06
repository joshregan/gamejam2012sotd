package;

import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxG;

/**
 * @author Josh Regan
 */
class TestState extends FlxState
{
	var effectsManager:EffectsManager;

	override public function create():Void
	{
		#if neko
		FlxG.camera.bgColor = { rgb: 0x000000, a: 0xff };
		#end
		
		effectsManager = new EffectsManager(true);
	}
	
	override public function update():Void
	{	
		if(FlxG.mouse.justPressed())
			FlxG.mouse.hide();
		
		if (FlxG.keys.SPACE)
		{
			effectsManager.showLightningEffect();
		}
		
		if (FlxG.keys.R)
		{
			effectsManager.showRainEffect(20);
		}
		
		effectsManager.update();
		
		super.update();
	}
}
