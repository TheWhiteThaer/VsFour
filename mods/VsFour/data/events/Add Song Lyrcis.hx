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

var text:FlxText;
var timerC = 0.4;

function create() {
    text = new FlxText(0, 500, FlxG.width, "", 20);
    text.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    text.cameras = [camHUD];


    add(text);
}



function onEvent(e:EventGameEvent){
    if (e.event.name == "Add Song Lyrcis"){
        lyrcis = e.event.params[0];
        duration = e.event.params[1];
        text.text = lyrcis;
        text.visible = text.active = true;
        text.alpha = 1;
        text.font = Paths.font(e.event.params[2]);
        
        writeLyrics(text, lyrcis, duration, function() {
            new FlxTimer().start(timerC, function(tmr:FlxTimer) {
                text.visible = text.active = false;
                text.alpha = 0;
            });
        });
    }
}

function writeLyrics(text:FlxText, lyrics:String, duration:Float, callBack:Void -> Void):Void {
    text.text = "";
    var words = lyrics.split(" ");
    for (i in 0...words.length) {
        var word = words[i];
        new FlxTimer().start(duration * i, function(_:FlxTimer) {
            var currentWord = word; // Capture the current word
            text.text += (text.text == "" ? "" : " ") + currentWord;
            timerC = 2;
            if (i == words.length - 1) { // Check if it's the last word
                callBack();
            }
        });
    }
}

