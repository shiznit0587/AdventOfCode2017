class Day11 {

    var directions:Array<HexDirection>;
    var directionCounts:Map<HexDirection, Int> = [for (direction in HexDirection) direction => 0];

    public function new() {
        neko.Lib.println("Running Day 11 - a");

        FileUtil.readInput("11", function (line) {
            directions = line.split(",").map(HexDirection.fromString);
            directionCounts = [for (direction in HexDirection) direction => 0];

            // neko.Lib.println('Steps = $line');

            for (direction in directions) {
                directionCounts[direction]++;
                searchForReductions(direction);
            }

            neko.Lib.println('Steps = ${Ints.listSum(directionCounts)}');
        });

        neko.Lib.println("Running Day 11 - b");

        FileUtil.readInput("11", function (line) {
        });
    }

    private function searchForReductions(direction:HexDirection):Void {
        // neko.Lib.println('Searching for reductions to $direction');

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
        // neko.Lib.println('Have $direction = ${directionCounts[direction] > 0}');
        return directionCounts[direction] > 0;
    }

    private inline function reduce(direction:HexDirection, reduction:Pair<HexDirection>):Void {
        // neko.Lib.println('Reducing $direction and ${reduction.left} to ${reduction.right}');
        directionCounts[direction]--;
        directionCounts[reduction.left]--;
        directionCounts[reduction.right]++;
    }

    private inline function counter(a:HexDirection, b:HexDirection):Void {
        //neko.Lib.println('Counter $a and $b');
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

    //public var adjacent(get, never):Pair<HexDirection>;
    //private function get_adjacent() return new Pair(cast Ints.wrap(cast this - 1, 0, 6), cast Ints.wrap(cast this + 1, 0, 6));

    public var reductions(get, never):Array<Pair<HexDirection>>;
    private function get_reductions():Array<Pair<HexDirection>> {
        // Each pair is this *with* 'left' = 'right'
        /*switch (this) {
            case N:
                // N + SE = NE
                // N + SW = NW
                return [new Pair(SE, NE), new Pair(SW, NW)];
            case NE:
                // NE + S = SE
                // NE + NW = N
                return [new Pair(S, SE), new Pair(NW, N)];
            case SE:
                // SE + N = NE
                // SE + SW = S
                return [new Pair(N, NE), new Pair(SW, S)];
            case S:
                // S + NE = SE
                // S + NW = SW
                return [new Pair(NE, SE), new Pair(NW, SW)];
            case SW:
                // SW + N = NW
                // SW + SE = S
                return [new Pair(N, NW), new Pair(SE, S)];
            case NW:
                // NW + NE = N
                // NW + S = SW
                return [new Pair(NE, N), new Pair(S, SW)];
            default:

        }*/

        // If you combine the complementary directions with this one, the output is the neighbor between them.
        return [new Pair(wrap(this - 2), wrap(this - 1)), new Pair(wrap(this + 2), wrap(this + 1))];
    }

    private inline function wrap(val:Int):HexDirection {
        return cast Ints.wrap(val, 0, 6);
    }
}
