import funkin.game.PlayState;
import funkin.menus.MainMenuState;
import funkin.menus.LoadingState;
import funkin.game.cutscenes.VideoCutscene;
/* To See If The Intro Has Ended */
 var endIntro:Bool = false;

/* Only The Power Of Two Teams Here */
 var thePowerOfTwoTeams:Array<Array<Dynamic>> = [
    ["The Blue Haired Kid", ["Boyfriend", "GirFriend"]],
    ["The S", ["Cloudy", "Clock", "Rocky", "Bottle", "Ice Cube", "Winner", "Yellow Face"]],
    ["Are You Okay", ["Eraser", "Fries", "Golf Ball", "Pen", "Puffball", "Tennis Ball", "TV"]],
    ["Death P.A.C.T Again", ["Black Hole", "Fanny", "Lightning", "Marker", "Pie", "Remote", "Tree"]],
    ["Just Not", ["Bomby", "Book", "Cake", "Naily", "Nickel", "Pillow", "Price Tag"]],
    ["Team8's", ["Barf Bag", "Coiny", "Donut", "Gaty", "Needle", "Pin", "Saw"]],
    ["The Strongest Team On Earth", ["Basketball", "Bell", "Eggy", "Foldy", "Grassy", "Robot Flower", "Snowball"]],
    ["Tear Drop", ["Tear Drop"]]
];

/* Season */
 var season:String = "BFDI";

/* Votes */
    /* Boyfriend And Girlfriend Votes */
     var playerTeamVotes:Array<Int> = [];
    /* Other Teams Votes */
     var otherTeamVotes:Array<Int> = [];
    /* The Votes Being Sorted (Only The Other Teams Votes) */
     var sortedVotes:Array<Int> = [];


/* Polishing Stuff */

    /* Tv Sprite */
     var tv:FlxSprite;

    /* Screen Sprite (To Change Color) */
     var tvScreen:FlxSprite;

    /* To Make Sure That The Animation Is Played Once */
     var playedAnimation:Bool = false;
    
    /* Team's Logo */
     var teamsLogo:FlxSprite;
    
    /* Votes Text (Maybe Temp) */
     var votesTextGrp:FlxTypedGroup<FlxText>;

    /* Color Tv Thing*/
     var tvColor:Array<Array<Dynamic>> = [
        ["The Blue Haired Kid", 0xFF5BB1C7],
        ["The S", 0xFF5C68A0],
        ["Are You Okay", 0xFF7FDB6D],
        ["Death P.A.C.T Again", 0xFF6164FF],
        ["Just Not", 0xFFEFFA53],
        ["Team8's", 0xFFFAAC53],
        ["The Strongest Team On Earth", 0xFFFA5353],
        ["Tear Drop", 0xFF539BFA]
    ];

/* To Decide What Team Is Gonna Do Cake At Stake */
 var randomTeam:Int;

/* To See If The Player Lost Or Won */
 var won:Bool = false;

  function create() {
    // adding tv
    tv = new FlxSprite(25, 50);
    tv.frames = Paths.getSparrowAtlas('CakeAtStake/TV');
    tv.animation.addByPrefix('showing Votes', 'TVShowingVotes', 24, false);
    tv.visible = tv.active = false;
    add(tv);

    tvScreen = new FlxSprite(73, 85);
    tvScreen.frames = Paths.getSparrowAtlas('CakeAtStake/TVWhite');
    tvScreen.visible = tvScreen.active = false;
    add(tvScreen);


    //generating the team
    randomTeam = FlxG.random.int(1, thePowerOfTwoTeams.length - 1);

    //changing the color
    if(thePowerOfTwoTeams[randomTeam][0] == tvColor[randomTeam][0]) {
        tvScreen.color = tvColor[randomTeam][1];
    }
    
    if(FlxG.sound.music != null && PlayState.vocals != null) {
        FlxG.sound.music.pause();
        PlayState.vocals.pause();
    }

    switch(PlayState.dadName) {
        case "four":
            fourCakeAtStake();
            season = "BFB";

        case "two":
            twoCakeAtStake();
            season = "TPOT";

        case "twodep":
            twoCakeAtStake();
            season = "TPOT";
    
        case "announcer":
            season = "BFDI";
    
    }


    //adding the team logo
    teamsLogo = new FlxSprite (
        300, 
        -100
    ).loadGraphic (
    Paths.image (
            'CakeAtStake/' + season + '/'
            + 
            thePowerOfTwoTeams[randomTeam][0] + '/'
            +
            thePowerOfTwoTeams[randomTeam][0]
        )
    );
    teamsLogo.visible = teamsLogo.active = false;
    teamsLogo.scale.x = 0.2;
    teamsLogo.scale.y = 0.2;
    add(teamsLogo);

}



 function update(elapsed:Float) {
    switch(PlayState.dadName) {
        case "four":
            for (k in 0...otherTeamVotes.length) {
                if(playerTeamVotes[0] <= otherTeamVotes[k]) {
                    if(endIntro) {
                        //continueGame();
                        won = true;
                        showVotes();
                    }
                }
                if(playerTeamVotes[0] > otherTeamVotes[k]) {
                    if(endIntro) {
                        won = false;
                        showVotes();
                    }
                }
    
            }
        case "two":
            for (k in 0...otherTeamVotes.length) {
                if(playerTeamVotes[0] >= otherTeamVotes[k]) {
                    if(endIntro) {
                        //continueGame();
                        won = true;
                        showVotes();
                    }
                }
                if(playerTeamVotes[0] < otherTeamVotes[k]) {
                    if(endIntro) {
                        won = false;
                        showVotes();
                    }
                }
    
            }
        case "twodep":
            for (k in 0...otherTeamVotes.length) {
                if(playerTeamVotes[0] >= otherTeamVotes[k]) {
                    if(endIntro) {
                        //continueGame();
                        won = true;
                        showVotes();
                    }
                }
                if(playerTeamVotes[0] < otherTeamVotes[k]) {
                    if(endIntro) {
                        won = false;
                        showVotes();
                    }
                }
    
            }
        
    }    
}

function startVideo(name:String) {
    new VideoCutscene("CakeAtStake/" + name, () -> {
        endIntro = true;
    });
}

function twoCakeAtStake() {
    startVideo('CakeAtStakeTwo');
    votes("Two");
    
}


function fourCakeAtStake() {

    startVideo('CakeAtStakeFour');
    votes("Original");
    
}



function votes(mode:String = "Original") {

    switch(mode) {
        case "Original":
            calculateVotes("/");

        case "Two":
            calculateVotes("*");
            
    }
        
    //Look it is like 3 am in the morning I AM TIRED AS FUCK
    var yPos = 130;
    var yPos2 = 130;
    for(i in 0...otherTeamVotes.length) {
        var voteTxt:FlxText = null;
        yPos += 100;
        if(i < 5) {
            voteTxt = new FlxText(220.2, yPos, FlxG.width, "", 20);
        }
        if(i > 5) {
            yPos2 += 100;
            voteTxt = new FlxText(630, yPos2, FlxG.width, "", 20);
        }
        add(voteTxt);
        votesTextGrp.push(voteTxt);
    }

}

/* To Make It More Orgianized */
function calculateVotes(mode:String) {
    if(mode == "divide" || mode == "/" || mode == "lessEliminated") {
        for(i in 0...thePowerOfTwoTeams.length - (thePowerOfTwoTeams.length - 1)) {
            var vote = Math.floor(FlxG.random.int(Math.floor(10000 / accuracy), 15000 - Math.floor((10000 / (accuracy / 30)))));
            playerTeamVotes.push(vote);
        }
    }
    else if (mode == "multiply" || mode == "*" || mode == "moreEliminated") {
        for(i in 0...thePowerOfTwoTeams.length - (thePowerOfTwoTeams.length - 1)) {
            var vote = Math.floor(FlxG.random.int(Math.floor(10000 * accuracy), 15000 - Math.floor((10000 * (accuracy * 30)))));
            playerTeamVotes.push(vote);
        }
        
    }

    for(j in 0...thePowerOfTwoTeams[randomTeam][1].length) {
        var vote = FlxG.random.int(0, 15000);
        otherTeamVotes.push(vote);
    }

    otherTeamVotes.sort((a, b) -> a + b);
    trace(otherTeamVotes);
}



function showVotes() {
    tv.visible = tv.active = true;
    if(!playedAnimation) {
        tv.animation.play('showing Votes');
        tv.animation.finishCallback = (name:String) -> {
            tvScreen.visible = tvScreen.active = true;
            teamsLogo.visible = teamsLogo.active = true;
            //FlxG.sound.play(Paths.sound('pop'));
            for (i in 0...votesTextGrp.length) {
                var timer2:FlxTimer = new FlxTimer().start(1 * i, function (tmr:FlxTimer) {
                    CoolUtil.oscillateNumber(votesTextGrp.members[i], otherTeamVotes[i], 3, 100);
                });
            }
            
        
            /*if(won) {
                continueGame();
            } else {
                MusicBeatState.switchState(new MainMenuState());
            }*/
        };
        playedAnimation = true;
    }
}


function continueGame() {
    if (PlayState.isStoryMode)
    {
        if (PlayState.storyPlaylist.length <= 0)
        {
            Mods.loadTopMod();
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            #if DISCORD_ALLOWED DiscordClient.resetClientID(); #end


            MusicBeatState.switchState(new StoryMenuState());

            // if ()
            if(!ClientPrefs.getGameplaySetting('practice') && !ClientPrefs.getGameplaySetting('botplay')) {
                StoryMenuState.weekCompleted.set(WeekData.weeksList[PlayState.storyWeek], true);
                Highscore.saveWeekScore(WeekData.getWeekFileName(), PlayState.campaignScore, PlayState.storyDifficulty);

                FlxG.save.data.weekCompleted = StoryMenuState.weekCompleted;
                FlxG.save.flush();
            }
            PlayState.changedDifficulty = false;
        }
        else
        {
            var difficulty:String = Difficulty.getFilePath();

            trace('LOADING NEXT SONG');
            trace(Paths.formatToSongPath(PlayState.PlayState.storyPlaylist[0]) + difficulty);

            FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;

            PlayState.PlayState.SONG = Song.loadFromJson(PlayState.PlayState.storyPlaylist[0] + difficulty, PlayState.PlayState.storyPlaylist[0]);
            FlxG.sound.music.stop();

            LoadingState.loadAndSwitchState(new PlayState());
        }
    } else {
        
        trace('WENT BACK TO FREEPLAY??');
        Mods.loadTopMod();
        #if DISCORD_ALLOWED DiscordClient.resetClientID(); #end
        MusicBeatState.switchState(new FreeplayState());
        FlxG.sound.playMusic(Paths.music('freakyMenu'));
        PlayState.changedDifficulty = false;
    }
}

