import funkin.game.PlayState;
import funkin.backend.assets.ModsFolder;
import funkin.game.cutscenes.VideoCutscene;
import sys.io.FileSystem;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;

var videoData:Array<{folder:String, video:String, videoPath:String}> = [];

function postCreate() {
      for (event in events) {
            if (event.name == 'Play Video') { 
                   
                  var data = {
                        folder: event.params[1],
                        video: event.params[0],
                        videoPath: ''
                  };
                  data.videoPath = Paths.video(data.folder + "/" + data.video);
                  if(Assets.exists(data.videoPath))
                        videoData.push(data);
                  
                  trace(data.videoPath);
            } 
      }
} 
      
function onEvent(_) {
      if (_.event.name == 'Play Video') { 
            openSubState(new VideoCutscene(videoData.videoPath, function() {
                  trace("Done");
            }));
      }
}