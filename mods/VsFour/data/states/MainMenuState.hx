import funkin.menus.MainMenuState;
import funkin.menus.LoadingState;
import funkin.backend.MusicBeatState;
function update(elasped:Float) {
      if(controls.ACCEPT) {
            if(optionShit[curSelected] == "freeplay") {
                  FlxG.switchState(new ModState("FreeplayStateSelector"));
                  trace("Selecting Free Play Mode");
            }
      }
}