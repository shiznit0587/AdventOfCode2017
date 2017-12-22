class Day5 {
    public function new() {
        neko.Lib.println("Running Day 5 - a");

        var jumps:Array<Int> = [];
        FileUtil.readInput("5", function (line) {
            jumps.push(Std.parseInt(line));
        });

        var cursor:Int = 0;
        var steps:Int = 0;
        while (0 <= cursor && cursor < jumps.length) {
            ++jumps[cursor];
            cursor += jumps[cursor] - 1;
            ++steps;
        }

        neko.Lib.println('Steps = $steps');

        neko.Lib.println("Running Day 5 - b");

        jumps = [];
        FileUtil.readInput("5", function (line) {
            jumps.push(Std.parseInt(line));
        });

        cursor = 0;
        steps = 0;
        while (0 <= cursor && cursor < jumps.length) {
            var temp:Int = jumps[cursor];
            jumps[cursor] = (temp >= 3) ? temp - 1 : temp + 1;
            cursor += temp;
            ++steps;
        }

        neko.Lib.println('Steps = $steps');
    }
}
