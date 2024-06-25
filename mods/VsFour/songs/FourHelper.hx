import funkin.game.HealthIcon;
import funkin.game.PlayState;
import funkin.game.StrumLine; 
/**
      Will Determind if you need help or not
**/
public static var deaths = 0;
public static var isFourHelping:Bool = false;
public static var isInGameOverMenu:Bool = false;
/**
      Shows That Four Is Playing
**/

function create() {
      /** Dont Touch ... **/
      isFourHelping = false;
      isInGameOverMenu = false;
      
}


var bot:Bool = false;
function update(elapsed) {
      // No Need to explain it
      if(deaths >= 1 && !isInGameOverMenu) {
            fourHelp();
      }

      if(bot) {
            var currentTime = Conductor.songPosition;
            for (s in playerStrums) {
                  if (s.lastHit + (Conductor.crochet / 2) < currentTime && s.getAnim() == "confirm") {
                      s.playAnim("static");
                  }
            }
              
              // Handle notes separately
            for (no in playerStrums.notes) {
                  if (!no.wasGoodHit && !no.avoid && no.strumTime < currentTime) {
                        goodNoteHit(playerStrums, no); // Assuming `goodNoteHit` can handle this correctly
                  }
            }
      }

}

function fourHelp() {
      //Pause the notes, music, and vocals
      for (strumLine in strumLines.members) strumLine.vocals.pause();
      FlxG.sound.music.pause();
      vocals.pause();
      //can't open pause menu
      canPause = false;
      //Play The Sound
      FlxG.sound.play(Paths.sound("FourTakesOver"));
      //Reset The Deaths
      deaths = 0;
      //Wait Until The Sound Is Finished
      new FlxTimer().start(8.5, function (tmr:FlxTimer) {
            //Four Notes Visuals
            isFourHelping = true;
            //TO DO : MAKE THE NOTES FOUR'S NOTES!!!
                  
      });
      //Four Notes Logic
      new FlxTimer().start(10, function (tmr:FlxTimer) {
            //Can Open Pause Mneu
            canPause = true;
            //Bot Takes Over
            bot = true;
            // Plays The Music
            FlxG.sound.music.play();
            //Plays The Vocals
            vocals.play();
      }); 
}

function onPlayerHit(event) {
      if(bot) {
            boyfriend.playSingAnim(event.direction, event.animSuffix, SING, event.forceAnim);
      }

}

function onInputUpdate(e) {
      if(bot) {
            e.cancel();
      }
}

function onGameOver() {
      deaths ++;
      isInGameOverMenu = true;
}