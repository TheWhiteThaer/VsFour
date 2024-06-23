public var curMode:Int = 1;
function update(elapsed:Float) {
	if (FlxG.keys.justPressed.F5) FlxG.resetState();
}

public function setMode(number) {
	return number;
}
