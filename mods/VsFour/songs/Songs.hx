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

/** The Song Display Name **/
var song:String = PlayState.SONG.meta.displayName;
/** Text For The Songs **/
 var songLabel:FlxText;
/** The Songs Credit **/
 var songsCredits:Array<Array<String>> = [
    /** Song                    Composer                 Charter   **/
    [
        [
            "Four",
            "Free Fall", 
            "Rushed"
        ],     
        [
            "NotCoddz"
        ],            
        [
            "Spy"
        ]
    ],
    [
        [
            "Projection"
        ],            
        [
            "Hunbun999"
        ],            
        [
            "UNKNOW"
        ]
    ],
    [
        [
            "Cheese Cake"
        ],           
        [
            "Fountain"
        ],
        [
            "Fountain | d0ni"
        ]
    ],
    [
        [
            "Tie Breaker"
        ],          
        [
            "FlakeyFlugelHorn"
        ], 
        [
            "Spy"
        ]
    ],
    [
        [
            "Budget Cuts"
        ],
        [
            "Fountain"
        ],
        [
            "JacobLmao"
        ]
    ],
    [
        [
            "Take The Plunge"
        ],       
        [
            "Hunbun999 | MrMaestro | Fountain | TheGabiM"
        ],
        [
            "Not Done"
        ]
    ],
    [
        [
            "Gay"
        ],
        [
            "Cycslik"
        ],
        [
            "TheWhiteThaer"
        ]
    ],
    [
        [
            "HighTail"
        ],
        [
            "Candy"
        ],
        [
            "JacobLmao"
        ]
    ]
];

function create() {
    //trace(song);
    songLabel = new FlxText(500, 300, FlxG.width, "", 32);
    songLabel.cameras = [camHUD];
    songLabel.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songLabel.screenCenter();
    add(songLabel);
    for(i in 0...songsCredits.length) {
        //trace(songsCredits[i]);
        for(j in 0...songsCredits[i][0].length) {
           // trace(songsCredits[i][1][j]);
            if(songsCredits[i][0][j] == song) {
                var songInfo = song + " \n Composer : " + songsCredits[i][1][0] + " \n Charter : " + songsCredits[i][2][0];
                trace(songInfo);
                songLabel.text = songInfo;
                songLabel.alpha = 1;
                FlxTween.tween(songLabel, {"scale.x": 2, "scale.y": 2}, 0.3, {
                    type: FlxTweenType.ONESHOT,
                    ease: FlxEase.circInOut,
                    onComplete: function(twn:FlxTween) {
                        new FlxTimer().start(2, function(tmr:FlxTimer) {
                            FlxTween.tween(songLabel, {alpha : 0}, 0.3);
                        });
                    }
                });
                
            }
        }
    }

}