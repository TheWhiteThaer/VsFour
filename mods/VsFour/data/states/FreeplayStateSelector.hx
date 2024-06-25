import funkin.menus.FreeplayState;
import funkin.backend.chart.Chart;
import haxe.io.Path;
import openfl.text.TextField;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import funkin.game.HealthIcon;
import funkin.savedata.FunkinSave;
import haxe.Json;
import funkin.backend.system.Controls;
import flixel.FlxCamera;
import funkin.backend.utils.DiscordUtil;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTweenType;
import funkin.menus.LoadingState;
import funkin.backend.MusicBeatState;


/* The Current Modes */
var freePlayMods:Array<String> = [
      "Main",
      "Bonus"
];

/* Groups */
var freePlayModsGroup:FlxTypedGroup<FlxSprite> = [];

/* Background */
var bg;

/* The Current Index Of The Mode */
public static var curMode:Int = 0;

/* Mouse Checker */
var isUsingMouse:Bool = false;




function create() {
      DiscordUtil.changePresenceSince("Selecting Free Play Mode", null);
      FlxG.mouse.visible = true;
      
      bg = new FlxSprite(0, 0).loadGraphic(Paths.image('menus/menuDesat'));
      bg.color = FlxColor.GRAY;
      bg.antialiasing = true;
      add(bg);


      for (i in 0...freePlayMods.length) {
            var mode:FlxSprite = new FlxSprite(0, -50);

            mode.frames = Paths.getSparrowAtlas('menus/freeplay/FreePlay');
         
            
            mode.animation.addByPrefix('idle', freePlayMods[i] + 'Idle');
            mode.animation.addByPrefix('selected', freePlayMods[i] + "Selected");
            
            mode.scale.x = .6;
            mode.scale.y = .6;
            
            mode.animation.play('idle');
            
            switch(freePlayMods[i]) {
                  case "Main":
                        mode.x = 100;
                  
                  case "Bonus":
                        mode.x = 700;
            }
            freePlayModsGroup.push(mode);
            add(mode);
      }
}

function mouseControl() {
            
      isUsingMouse = FlxG.mouse.justMoved;

      if(isUsingMouse) {
            for(i in 0...freePlayModsGroup.length) {
                  if(FlxG.mouse.overlaps(freePlayModsGroup[i])) {
                        changeMouse(i);
                        if(FlxG.mouse.justPressed) {
                              enter();
                        }
                  } else {

                        var nextMod:Int = curMode + 1;
                        var previousMod:Int = curMode - 1;
                        if(nextMod <= freePlayModsGroup.length - 1) {
                              freePlayModsGroup[nextMod].animation.play('idle');
                        }
                        
                        if(previousMod >= 0) {
                              freePlayModsGroup[previousMod].animation.play('idle');
                        }
                        
                  }

                  
            }
      }
}

function update(elapsed:Float)
{
     mouseControl();

      for(i in 0...freePlayModsGroup.length) 
            if(FlxG.mouse.overlaps(freePlayModsGroup[i])) {
                  if(FlxG.mouse.justPressed) {
                        enter();
                  }
            }

      if(FlxG.mouse.justPressedRight || FlxG.keys.justPressed.ESCAPE) {
            FlxG.switchState(new MainMenuState());
      }
     

      if (controls.LEFT_P) {
            changeItem(1, "default");
      }
      else if (controls.RIGHT_P) {
            changeItem(-1, "default");
      }

      if(controls.ACCEPT) {
            enter();
      }



}


function changeItem(change:Int = 0, mode:String = "default")
{
      freePlayModsGroup[curMode].animation.play('idle');
      
      curMode += change;

      if (curMode < 0)
            curMode = freePlayMods.length - 1;
      if (curMode >= freePlayMods.length)
            curMode = 0;
      
      freePlayModsGroup[curMode].animation.play('selected');
}



function changeMouse(change:Int = 0)
{
      
      curMode = change;

      if (curMode < 0)
            curMode = freePlayMods.length - 1;
      if (curMode >= freePlayMods.length)
            curMode = 0;
      
      freePlayModsGroup[curMode].animation.play('selected');
}



function enter() {
	
      FlxG.switchState(new ModState("FreePlaySongState"));

}

override function destroy():Void
{

      if (!FlxG.sound.music.playing)
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
}
