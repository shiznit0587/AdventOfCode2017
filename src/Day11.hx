class Day11 {

    var directions:Array<HexDirection>;
    var directionCounts:Map<HexDirection, Int>;

    public function new() {
        FileUtil.readInput("11", function (line) {

            var furthest:Int = Ints.MIN;
            directions = line.split(",").map(HexDirection.fromString);
            directionCounts = [for (direction in HexDirection) direction => 0];

            for (direction in directions) {
                directionCounts[direction]++;
                searchForReductions(direction);
                furthest = Ints.max(furthest, Ints.listSum(directionCounts));
            }

            neko.Lib.println("Running Day 11 - a");
            neko.Lib.println('Steps = ${Ints.listSum(directionCounts)}');
            neko.Lib.println("Running Day 11 - b");
            neko.Lib.println('Furthest = $furthest');
        });
    }

    private function searchForReductions(direction:HexDirection):Void {
        // Check if direction can be countered.
        if (have(direction.opposite)) {
            counter(direction, direction.opposite);
            return;
        }

        // Prioritize choosing a reduction that can be countered.
        var reduction:Null<HexDirection> = findReduction(direction, true);
        if (reduction != null) {
            searchForReductions(reduction);
            return;
        }

        // Just do the first reduction that works.
        reduction = findReduction(direction, false);
        if (reduction != null) {
            searchForReductions(reduction);
        }
    }

    private function findReduction(direction:HexDirection, checkForCounter:Bool):Null<HexDirection> {
        for (reduction in direction.reductions) {
            if (have(reduction.left) && (!checkForCounter || have(reduction.right.opposite))) {
                reduce(direction, reduction);
                return reduction.right;
            }
        }

        return null;
    }

    private inline function have(direction:HexDirection):Bool {
        return directionCounts[direction] > 0;
    }

    private inline function reduce(direction:HexDirection, reduction:Pair<HexDirection>):Void {
        directionCounts[direction]--;
        directionCounts[reduction.left]--;
        directionCounts[reduction.right]++;
    }

    private inline function counter(a:HexDirection, b:HexDirection):Void {
        directionCounts[a]--;
        directionCounts[b]--;
    }
}

@:enum
abstract HexDirection(Int) to Int {
    var N  = 0;
    var NE = 1;
    var SE = 2;
    var S  = 3;
    var SW = 4;
    var NW = 5;

    public static function fromString(string:String):HexDirection {
        switch (string) {
            case "n" : return N;
            case "ne": return NE;
            case "se": return SE;
            case "s" : return S;
            case "sw": return SW;
            case "nw": return NW;
            default  : return null;
        }
    }

    @:to
    public function toString():String {
        switch (this) {
            case N : return "n";
            case NE: return "ne";
            case SE: return "se";
            case S : return "s";
            case SW: return "sw";
            case NW: return "nw";
            default: return null;
        }
    }

    public static function iterator():Iterator<HexDirection> {
        return [N,NE,SE,S,SW,NW].iterator();
    }

    public var opposite(get, never):HexDirection;
    private inline function get_opposite() return wrap(this + 3);

    public var reductions(get, never):Array<Pair<HexDirection>>;
    private function get_reductions():Array<Pair<HexDirection>> {
        // If you combine the complementary directions with this one, the output is the neighbor between them.
        return [new Pair(wrap(this - 2), wrap(this - 1)), new Pair(wrap(this + 2), wrap(this + 1))];
    }

    private inline function wrap(val:Int):HexDirection {
        return cast Ints.wrap(val, 0, 6);
    }
}
