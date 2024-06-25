import funkin.game.PlayState;

var canBoyfriendCameraMove:Bool = false;
var canDadCameraMove:Bool = false;

var rate = 50;

var boyfriendPosition = [0, 0];
var dadPosition = [0, 0];

function create() {
      boyfriendPosition[0] = boyfriend.getCameraPosition().x;
      boyfriendPosition[1] = boyfriend.getCameraPosition().y;

      dadPosition[0] = dad.getCameraPosition().x;
      dadPosition[1] = dad.getCameraPosition().y;
      for(c in strumLines.members[curCameraTarget].characters) {
            if (c == null || !c.visible) continue;
            var cpos = c.getCameraPosition();
            camFollow.setPosition(cpos.x, cpos.y);
      }
}


function update(elapsed) {
     if(boyfriend.getAnimName() == "idle") {
            canBoyfriendCameraMove = false;
            canDadCameraMove = true;
      } else {
            canBoyfriendCameraMove = true;
            canDadCameraMove = false;
      }

      
      //goBack = !canBoyfriendCameraMove;
}

function onPlayerHit(e) {
      if(canBoyfriendCameraMove) {
            moveCameraOnNotes(boyfriend, e.direction, boyfriendPosition, rate);
            canBoyfriendCameraMove = false;
      }
}

function onDadHit(e) {
      if(canDadCameraMove) {
            moveCameraOnNotes(dad, e.direction, dadPosition, rate);
            canDadCameraMove = false;
      }
}



function moveCameraOnNotes(character, noteDirection, createdPosition, rates) {
      switch (noteDirection) {
            case 0:
                  camFollow.setPosition(character.getCameraPosition().x - rates, createdPosition[1]);
            case 1:
                  camFollow.setPosition(createdPosition[0], character.getCameraPosition().y + rates);
            case 2:
                 camFollow.setPosition(createdPosition[0], character.getCameraPosition().y - rates);
            case 3:
                  camFollow.setPosition(character.getCameraPosition().x + rates, createdPosition[1]);

      }
}


function onCameraMove(e) {
      e.cancel();
}