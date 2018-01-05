class Day13 {

    public function new() {
        neko.Lib.println("Running Day 13 - a");

        var programs:Array<Pair<Int>> = [];

        FileUtil.readInput("13", function (line) {
            programs.push(Pair.fromArray(line.split(" ").map(Strings.trim.bind(_, ":")).map(Std.parseInt)));
        });

        var catches:Int = 0;
        var severity:Int = 0;

        for (program in programs) {
            if (isProgramLayerZero(program.left, program.right, 0)) {
                ++catches;
                severity += program.left * program.right;
            }
        }

        neko.Lib.println('Caught Times = $catches, Severity = $severity');

        neko.Lib.println("Running Day 13 - b");

        var delay:Int = -1;
        var caught:Bool = true;

        while (caught) {
            ++delay;

            caught = false;
            for (program in programs) {
                if (isProgramLayerZero(program.left, program.right, delay)) {
                    caught = true;
                    break;
                }
            }
        }

        neko.Lib.println('Delay = $delay');
    }

    private inline function isProgramLayerZero(depth:Int, range:Int, delay:Int):Bool {
        return ((delay + depth) % ((range - 1) * 2)) == 0;
    }
}
