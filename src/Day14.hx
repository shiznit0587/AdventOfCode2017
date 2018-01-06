using Lambda;
using Ints;

class Day14 {

    public function new() {
        neko.Lib.println("Running Day 14 - a");

        FileUtil.readInput("14", function (line) {
            var totalSum:Int = ([for (i in 0...128) '$line-$i'])
                .map(KnotHash.generate)
                .flatMap(Strings.charArray)
                .map(function (c) return BITS[HEX_CHARS.indexOf(c)])
                .listSum();

            neko.Lib.println('Used Squares = $totalSum');
        });

        neko.Lib.println("Running Day 14 - b");

        FileUtil.readInput("14", function (line) {
        });
    }

    private static var HEX_CHARS:String = "0123456789abcdef";
    private static var BITS:Array<Int> = [0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4];
}
