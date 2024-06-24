import flixel.text.FlxTextBorderStyle;
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
import flixel.text.FlxTextAlign;
import funkin.backend.system.Logs;
import funkin.game.PlayState;
import funkin.backend.MusicBeatState;
import funkin.menus.LoadingState;


var songs:Array<SongMetadata> = [];

var curSelected:Int = 0;
var curDifficulty:Int = -1;

var scoreBG:FlxSprite;
var scoreText:FlxText;
var diffText:FlxText;

var grpSongsSpr:FlxTypedGroup<FlxSprite> = [];


var bg:FlxSprite;
var colorTween:FlxTween;

var missingTextBG:FlxSprite;
var missingText:FlxText;

var bottomString:String;
var bottomBG:FlxSprite;

var holdTime:Float = 0;
var songText:FlxText;
var leftArrow:FlxSprite;
var rightArrow:FlxSprite;

var leftSpikyThing:FlxSprite;
var rightSpikyThing:FlxSprite;
var elapsedTime:Float = 0;
var leftStartY:Float;
var rightStartY:Float;
// was gonna use this but not working for some reason
var songsNames:Array<String> = [
      "four",
      "freefall",
      "eliminated",
      "rushed",
      "projection",
      "cheese-cake",
      "quality",
      "tie-breaker",
      "budget-cuts"
];

function create()
{
      PlayState.isStoryMode = false;
      songs = [];
      // cur mode is in the FreeplayStateSelector script
      if(curMode == 0) {
            songs.push(Chart.loadChartMeta("four", "hard", true));
            songs.push(Chart.loadChartMeta("freefall", "hard", true));
            songs.push(Chart.loadChartMeta("eliminated", "hard", true));
            songs.push(Chart.loadChartMeta("rushed", "hard", true));
            songs.push(Chart.loadChartMeta("projection", "hard", true));
            songs.push(Chart.loadChartMeta("cheese-cake", "hard", true));
            songs.push(Chart.loadChartMeta("quality", "hard", true));
            songs.push(Chart.loadChartMeta("tie-breaker", "hard", true));
            songs.push(Chart.loadChartMeta("budget-cuts", "hard", true));
      }
      if(curMode == 1) {
            songs.push(Chart.loadChartMeta("gay", "hard", true));
            songs.push(Chart.loadChartMeta("hightail", "hard", true));
            songs.push(Chart.loadChartMeta("bewilderment", "hard", true));
      }
      

      
      
      FlxG.mouse.visible = true;
      
      bg = new FlxSprite().loadGraphic(Paths.image('menus/menuDesat'));
      add(bg);
      bg.screenCenter();
      
      scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
      scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE);
      scoreBG = new FlxSprite(scoreText.x - 6, 0).makeGraphic(1, 66, 0xFF000000);
      scoreBG.alpha = 0.6;
      
      
      add(scoreBG);
      add(scoreText);

      
      diffText = new FlxText(scoreText.x, scoreText.y + 36, 0, "", 24);
      diffText.font = scoreText.font;
      add(diffText);



      missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
      missingTextBG.alpha = 0.6;
      missingTextBG.visible = false;
      add(missingTextBG);
      
      missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
      missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
      missingText.scrollFactor.set();
      missingText.visible = false;
      add(missingText);


      bottomBG = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
      bottomBG.alpha = 0.6;
      add(bottomBG);


      
      songText = new FlxText(0, 500, FlxG.width, "", 32);
      songText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
      songText.borderSize = 1.50;
      add(songText);


      PlayState.isStoryMode = false;
      



      #if DISCORD_ALLOWED
            DiscordUtil.changePresence("Free Playing", null);
      #end



      var XPos:Int = 400;



      

      for(i in 0...songs.length) {
            XPos += 1000;
            
            var songSpr:FlxSprite;
            songSpr = new FlxSprite(XPos, 50).loadGraphic(Paths.image('menus/freeplay/iconshit/PLACEHOLDER'));
            grpSongsSpr.push(songSpr);
            add(songSpr);
      }

      leftArrow = new FlxSprite(300, 300);
      leftArrow.frames = Paths.getSparrowAtlas('menus/campaign_menu_UI_assets');
      leftArrow.animation.addByPrefix('idle', 'arrow left');
      leftArrow.animation.addByPrefix('pressed', 'arrow push left');
      add(leftArrow);
      leftArrow.animation.play('idle');

      rightArrow = new FlxSprite(900, 300);
      rightArrow.frames = Paths.getSparrowAtlas('menus/campaign_menu_UI_assets');
      rightArrow.animation.addByPrefix('idle', 'arrow right');
      rightArrow.animation.addByPrefix('pressed', 'arrow push right');
      add(rightArrow);
      rightArrow.animation.play('idle');

      leftSpikyThing = new FlxSprite(-100, -240);
      leftSpikyThing.loadGraphic(Paths.image('menus/freeplay/spikething'));
      leftSpikyThing.scale.x = .7;
      leftSpikyThing.scale.y = .7;
      add(leftSpikyThing);

      rightSpikyThing = new FlxSprite(1000, -240);
      rightSpikyThing.loadGraphic(Paths.image('menus/freeplay/spikething'));
      rightSpikyThing.scale.x = .7;
      rightSpikyThing.scale.y = .7;
      rightSpikyThing.angle = 180;
      add(rightSpikyThing);

      rightStartY = rightSpikyThing.y;
      leftStartY = leftSpikyThing.y;

      if(curSelected >= songs.length) curSelected = 0;
      changeSelection(0);
}

 function update(elapsed:Float) {

      songText.text = songs[curSelected].displayName;
      elapsedTime += elapsed;
      mouseControls();
      // Move spikeThing up and down using sine wave
      leftSpikyThing.y = leftStartY + Math.sin(elapsedTime * Math.PI * 2 * 0.5) * 50;
      rightSpikyThing.y = rightStartY + Math.sin(elapsedTime * Math.PI * 2 * 0.5) * -50;


      if (controls.LEFT_P) {
            changeSelection(-1);
      }
      if (controls.RIGHT_P) {
            changeSelection(1);
      }

      
      if(FlxG.keys.justPressed.ESCAPE || FlxG.mouse.justPressedRight) {
            FlxG.switchState(new ModState("FreeplayStateSelector"));

      }

      if (controls.DOWN_P)
      {
            //changeDiff(-1);
            //_updateSongLastDifficulty();
      }
      else if (controls.UP_P)
      {
            //changeDiff(1);
            //_updateSongLastDifficulty();
      }

      //songText.text = songs[curSelected].songName;

      if (controls.ACCEPT)
      {
           enter();
      }


}

function enter() {
      Logs.traceColored([Logs.logText("\n     Song Found !", 10),
                        Logs.logText("\n\t - Song : ", 9),
                        Logs.logText(songs[curSelected].displayName, 14),
                        Logs.logText("\n\t - Difficulty : ", 9),
                        Logs.logText('Hard', 12)
      ]);
      PlayState.loadSong(songs[curSelected].name, songs[curSelected].name + "-hard", false, false);
      FlxG.switchState(new LoadingState());
	MusicBeatState.wantedState = "Play State";
}

function mouseControls() {
      
      for (i in 0...grpSongsSpr.length) {
            var hovering:Bool = FlxG.mouse.overlaps(grpSongsSpr[i]);
            if(FlxG.mouse.justPressed && hovering) {
                  enter();
            }
      }

      if(FlxG.mouse.overlaps(rightArrow)) {
            if(FlxG.mouse.justPressed) {
                  FlxTween.tween(rightArrow,
                  {"scale.x": 0.6, "scale.y": .6}, 0.2, {
                        type: FlxTweenType.ONESHOT,
                        ease: FlxEase.cubeOut,
                        onComplete: function(twn:FlxTween)
                        {
                              FlxTween.tween(rightArrow,
                              {"scale.x": 1, "scale.y": 1}, 0.2, {
                                    type: FlxTweenType.ONESHOT,
                                    ease: FlxEase.cubeOut
      
                              });
                        }
                  });
                  changeSelection(1);
            }

      }
      else if (FlxG.mouse.overlaps(leftArrow)) {
            if(FlxG.mouse.justPressed) {
                  FlxTween.tween(leftArrow,
                  {"scale.x": 0.6, "scale.y": .6}, 0.2, {
                        type: FlxTweenType.ONESHOT,
                        ease: FlxEase.cubeOut,
                        onComplete: function(twn:FlxTween)
                        {
                              FlxTween.tween(leftArrow,
                              {"scale.x": 1, "scale.y": 1}, 0.2, {
                                    type: FlxTweenType.ONESHOT,
                                    ease: FlxEase.cubeOut
      
                              });
                        }

                  });
                  changeSelection(-1);
            }
      }
      
}


function changeSelection(change:Int = 0) {
      //_updateSongLastDifficulty();
      
      FlxTween.tween(grpSongsSpr[curSelected],
      {"scale.x": 1, "scale.y": 1}, 0.2, {
            type: FlxTweenType.ONESHOT,
            ease: FlxEase.cubeOut
      });
      grpSongsSpr[curSelected].x = 1300;


      curSelected += change;


     // var lastList:Array<String> = Difficulty.list;

      if (curSelected < 0)
            curSelected = songs.length - 1;
      if (curSelected >= songs.length)
            curSelected = 0;
      



      grpSongsSpr[curSelected].screenCenter();
      grpSongsSpr[curSelected].y = 0;


      FlxTween.tween(grpSongsSpr[curSelected],
      {"scale.x": .7, "scale.y": .7}, 0.2,  {
            type: FlxTweenType.ONESHOT,
            ease: FlxEase.cubeOut
      });

}