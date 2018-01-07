import haxe.Int64;

using Arrays;

class Day15 {

    private static var FACTOR_A:Int = 16807;
    private static var FACTOR_B:Int = 48271;
    private static var MASK:Int = 0xFFFF;

    public function new() {
        neko.Lib.println("Running Day 15 - a");

        var a:Int64 = 0;
        var b:Int64 = 0;

        FileUtil.readInput("15-test", function (line) {
            if (a == 0) {
                a = Std.parseInt(line.split(" ").last());
            }
            else {
                b = Std.parseInt(line.split(" ").last());
            }
        });

        var total:Int = 0;

        for (_ in 0...40000000) {
            a = (a * FACTOR_A) % Ints.MAX;
            b = (b * FACTOR_B) % Ints.MAX;

            if ((a & MASK) == (b & MASK)) {
                ++total;
            }
        }

        neko.Lib.println('Judge Total = $total');

        neko.Lib.println("Running Day 15 - b");

        FileUtil.readInput("15", function (line) {
        });
    }
}
