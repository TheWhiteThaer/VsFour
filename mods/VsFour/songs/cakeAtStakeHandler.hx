import funkin.game.PlayState;
import funkin.menus.LoadingState;
import funkin.backend.MusicBeatState;

function onSongEnd() {
      if(accuracy * 100 < 80) {
            trace("Cake At Stake");
            FlxG.switchState(new ModState("CakeAtStake"));
      }
      
      FlxG.switchState(new ModState("FreePlaySongState"));
}