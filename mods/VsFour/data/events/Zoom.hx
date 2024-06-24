import funkin.game.PlayState;
import funkin.backend.assets.ModsFolder;
import funkin.game.cutscenes.VideoCutscene;
import sys.io.FileSystem;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;

var triggered:Bool = false;
var time:Double = 0;
var zoom:Double = 0;
function onEvent(_:EventGameEvent) {
      if (_.event.name == 'Zoom') { 
            triggered = true;
            zoom = _.event.params[1];
            time = _.event.params[0];
      }
}


function update(elapsed) {
      if(triggered) {
            FlxTween.tween(FlxG.camera, {"zoom": zoom}, time, {
                  ease: FlxEase.circIn
            });
      }
}