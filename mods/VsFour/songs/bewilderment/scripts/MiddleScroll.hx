function create() {
    strumLines.members[0].visible = false;
    for(i=>strumLine in SONG.strumLines) { 
        strumLine.strumPos = [415, 150];
    }
}