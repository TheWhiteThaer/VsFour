import funkin.game.HealthIcon;

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


function update(elapsed) {
      // No Need to explain it
      if(deaths >= 1 && !isInGameOverMenu) {
            fourHelp();
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
            playerStrums.cpu = true;
            //Accuracy equals to one so it won't take you to cake at stake
            accuracy = 1;
            // Plays The Music
            FlxG.sound.music.play();
            //Making The Rating S++
            for(e in comboRatings)      
                  curRating = e;
            //Plays The Vocals
            vocals.play();
      }); 
}


function onGameOver() {
      deaths ++;
      isInGameOverMenu = true;
}