import funkin.menus.PauseSubState;
import funkin.menus.LoadingState;
import funkin.backend.MusicBeatState;
function create() {
	menuItems[4] = "Exit";
}


function update(elasped:Float) {
      if(menuItems[curSelected] == "Exit") {
		if(controls.ACCEPT) {
			FlxG.switchState(new ModState("FreePlaySongState"));
            }
      } 
}