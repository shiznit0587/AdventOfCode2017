import haxe.ds.GenericStack;

using Lambda;
using Ints;

class Day14 {

    private var disk:Array<Array<Bool>>;
    private var mark:Array<Array<Int>>;

    public function new() {
        neko.Lib.println("Running Day 14 - a");

        var input:String;
        FileUtil.readInput("14", function (line) {
            //partA_attempt1(line);
            input = line;
        });

        disk = ([for (i in 0...128) '$input-$i'])
                .map(KnotHash.generate)
                .map(Strings.charArray)
                .map(function (arr) return arr.flatMap(function (c) return BIT_ARRAYS[HEX_CHARS.indexOf(c)]).array())
                .array();

        var used:Int = disk.flatten().count(function (bit) return bit);

        neko.Lib.println('Used Squares = $used');

        neko.Lib.println("Running Day 14 - b");

        var regions:Int = 0;

        mark = [for (_ in 0...128) [for (_ in 0...128) -1]];

        for (i in 0...128) {
            for (j in 0...128) {
                if (disk[i][j] && mark[i][j] == -1) {
                    markRegion(new Location(i, j), regions);
                    ++regions;
                }
            }
        }

        neko.Lib.println('Regions = $regions');
    }

    private function markRegion(start:Location, region:Int):Void {
        var stack:GenericStack<Location> = new GenericStack<Location>();
        stack.add(start);

        while (!stack.isEmpty()) {
            var location:Location = stack.pop();
            mark[location.x][location.y] = region;

            for (adjacent in location.adjacent) {
                if (Ints.inRange(adjacent.x, 0, 127) &&
                    Ints.inRange(adjacent.y, 0, 127) &&
                    disk[adjacent.x][adjacent.y] &&
                    mark[adjacent.x][adjacent.y] == -1)
                {
                    stack.add(adjacent);
                }
            }
        }
    }

    private static var HEX_CHARS:String = "0123456789abcdef";
    private static var BITS:Array<Int> = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4];
    private static var BIT_ARRAYS:Array<Array<Bool>> = [[false, false, false, false],
                                                        [false, false, false, true ],
                                                        [false, false, true,  false],
                                                        [false, false, true,  true ],
                                                        [false, true,  false, false],
                                                        [false, true,  false, true ],
                                                        [false, true,  true,  false],
                                                        [false, true,  true,  true ],
                                                        [true,  false, false, false],
                                                        [true,  false, false, true ],
                                                        [true,  false, true,  false],
                                                        [true,  false, true,  true ],
                                                        [true,  true,  false, false],
                                                        [true,  true,  false, true ],
                                                        [true,  true,  true,  false],
                                                        [true,  true,  true,  true ]];

    // Siloed off my first attempt to a method that isn't called, because knot hashes are expensive.
    private function partA_attempt1(line:String):Void {
        var totalSum:Int = ([for (i in 0...128) '$line-$i'])
                .map(KnotHash.generate)
                .flatMap(Strings.charArray)
                .map(function (c) return BITS[HEX_CHARS.indexOf(c)])
                .listSum();

        neko.Lib.println('Used Squares = $totalSum');
    }
}
