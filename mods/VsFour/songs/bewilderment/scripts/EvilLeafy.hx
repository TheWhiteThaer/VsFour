import flixel.effects.FlxFlicker;
import flixel.text.FlxTextBorderStyle;
import flixel.tween.FlxTween;
import flixel.ui.FlxBar;
var positionX;
var positionY;
var doneTping:Bool = false;
var isDoneFlickering:Bool = false;
var darkness:FlxSprite;
var batteryBar:FlxBar;
var guide:FlxText;
var flashLight:FlxSprite;
var isDead:Bool = false;
public static var batteries:Int = 3;
public static var batteryType:String;
var batteryTxt:FlxText;

function create() {
    batteries = 3;
    /** Characters Adjustment **/
    boyfriend.visible = false;
    gf.visible = false;
    dad.visible = false;

    /** To Make The Camera Still **/
    camFollow.x = 100;
    camFollow.y = 300;
    
    /** Darkness Around The Flashlight **/
    darkness = new FlxSprite().makeGraphic(2000, 2000, FlxColor.BLACK);
    darkness.alpha = 0.5;
    darkness.cameras = [camHUD];
    add(darkness);

    /** Your Stamina **/
    batteryBar = new FlxBar(585, 530);
    batteryBar.min = 0;
    batteryBar.max = 100;
    batteryBar.scale.x = 5;
    batteryBar.createFilledBar(FlxColor.TRANSPARENT, FlxColor.YELLOW);
    batteryBar.percent = 100;
    batteryBar.cameras = [camHUD];
    add(batteryBar);

    /** The Guide Text (Will Change) **/
    guide = new FlxText(450, 300, FlxG.width, "YOU NEED TO LIGHT THE PLACE DON'T MAKE IT DARK!! \n BEWARE OF YOUR BATTERY!!!! \n Press Space To Light \n Press E to change the battery!", 32);
    guide.cameras = [camHUD];
    guide.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    guide.screenCenter();
    add(guide);
    new FlxTimer().start(8, function(tmr:FlxTimer) {
        FlxTween.tween(guide, {alpha: 0}, 1);
    });

    /** To Show How Many Batteries You Have **/
    batteryTxt = new FlxText(-450, 150, FlxG.width, "x" + batteries + " Batteries", 32);
    batteryTxt.cameras = [camHUD];
    batteryTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    add(batteryTxt);

    /** The Flashlight **/
    flashLight = new FlxSprite(-550,-50).loadGraphic(Paths.image("game/EvilLeafy/Flash"));
    flashLight.alpha = 0.375;
    flashLight.blend = "Add";
    add(flashLight);
    

}


function update(elapsed) {

    /** For More Spookyness **/
    new FlxTimer().start(2, function(tmr:FlxTimer) {
        if(!isDoneFlickering) {
            FlxFlicker.flicker(flashLight, 1, 0.1, true);
            isDoneFlickering = true;
        }
        new FlxTimer().start(4, function(tmr:FlxTimer) {mechanics();});
    
    });
    
}


function disableMechanics() {
    darkness.alpha = 0;
    batteryBar.percent = 100;
    flashLight.alpha = 0.375;
}


function evilLeafyShows() {
    dad.visible = true;
    if(curBeat % 2 == 0) {
        if(!doneTping) {
            positionX = FlxG.random.int(-500, 1000 * darkness.alpha);
            positionY = Math.abs(positionX) / 2000;
            doneTping = true;
        }
        if(darkness.alpha < 1) {
            dad.x = positionX;
            dad.y = positionY;
            dad.scale.set(Math.abs(positionX) / 200, Math.abs(positionX) / 200);
        } else {
            if(!isDead) {
                gameOver();
                isDead = true;
            }
        }
       
    }

    if(curBeat % 2 == 0 + 1) {
        doneTping = false;
    }
}

function flashLightMechanics() {
    if(FlxG.keys.pressed.SPACE && batteryBar.percent > 1) {
        flashLight.alpha += 0.001;
        darkness.alpha -= 0.001;
        batteryBar.percent -= 0.05;
    } else {
        darkness.alpha += 0.001;
        flashLight.alpha -= 0.001;
    }

    if(flashLight.alpha >= 0.5) {
        flashLight.alpha = 0.5;
    }

    if(flashLight.alpha >= 0.15) {
        FlxFlicker.flicker(flashLight, 1, 0.1, true);
    }
    
}

function batteryMechanics() {
    if(FlxG.keys.justPressed.E && batteries > 0) {
        batteries -= 1;
        switch(batteryType) {
            case "Fully Charged":
                batteryBar.percent = 100;
            case "Half Charged":
                batteryBar.percent += 50;
            case "Broken":
                batteryBar.percent += 25;
            case "Super Charged":
                batteryBar.max = 200;
                batteryBar.percent = 200;
        }

        if(batteryType != "Super Charged") {
            batteryBar.max = 100;
        }
    }

    batteryType = "Fully Charged";
    batteryTxt.text = "x" + batteries + " Batteries";
}

function mechanics() {
    //MY code sucks yeb my code is lazy yeb but guess what IDGAF
    dad.visible = true;
    
    /** If Four Is Helping Will Disable The Mechanics **/
    if(isFourHelping) {
        disableMechanics();
    }

    flashLightMechanics();
    batteryMechanics();

    if(darkness.alpha <= 0.3) {
        positionX = 1500;
        dad.visible = false;
    } else {
        evilLeafyShows();
    }  
      
}

function onPlayerHit(e) {
    moveFlashLight(e.direction);
}


function onDadHit(e) {
    moveFlashLight(e.direction);
}


function moveFlashLight(dir) {
    switch(dir) {
        case 0:
            FlxTween.tween(flashLight, {x: -750, y: -50}, 0.1, {ease: FlxEase.cubeInOut});
        case 1:
            FlxTween.tween(flashLight, {x: -550, y: 150}, 0.1, {ease: FlxEase.cubeInOut});
        case 2:
            FlxTween.tween(flashLight, {x: -550, y: -250}, 0.1, {ease: FlxEase.cubeInOut});
        case 3:
            FlxTween.tween(flashLight, {x: -350, y: -50}, 0.1, {ease: FlxEase.cubeInOut});

    }
}