import funkin.game.PlayState;
import funkin.backend.assets.ModsFolder;
import funkin.game.cutscenes.VideoCutscene;
import sys.io.FileSystem;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;


      
function onEvent(_:EventGameEvent) {
      if (_.event.name == 'Zoom') { 
            FlxTween.tween(FlxG.camera, {"zoom": _.event.params[1]}, _.event.params[0], {
                  ease: FlxEase.circIn
            });
      }
}