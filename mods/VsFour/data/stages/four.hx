var gelatin:FlxSprite;
function create() {
    gelatin = new FlxSprite(1500, 400);
    gelatin.frames = Paths.getFrames("stages/four/Players/Gelati");
    gelatin.animation.addByPrefix("Gelatin Vibing", "Gelatin Vibing", 20, true);
    gelatin.animation.addByPrefix("Gelatin YAY", "Gelatin YAY", 24);
    gelatin.animation.play("Gelatin Vibing");
    replace(dad, gelatin, "normal");
}

function beatHit(curBeat:Int) {
    if(curBeat == 126) {
        gelatin.animation.play("Gelatin YAY");
    }

    if(curBeat == 128) {
        gelatin.animation.play("Gelatin Vibing");
    }
}


function replace(replaceObject, replacing, mode = "normal") {
    if(mode == "normal") {
        remove(replaceObject);
        add(replacing);
        add(replaceObject);
    } else if (mode == "rev") {
        add(replacing);
    }
}