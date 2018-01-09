using Lambda;

class Day16_3 {

    // private static var PROGRAMS:String = "abcde";
    private static var PROGRAMS:String = "abcdefghijklmnop";
    private static var NUM_PROGRAMS:Int = PROGRAMS.length;

    // I think I need to do the first attempt, but as an array of integers,
    // and I should keep track of an offset to the head node.

    private var programs:Array<Int>;
    private var steps:Array<Array<Int>>;
    private var head:Int = 0;

    private var programToIndexMap:Map<Int, Int> = new Map();

    public function new() {
        neko.Lib.println("Running Day 16 - a");

        steps = [];
        FileUtil.readInput("16", function (line) {
            var rawSteps:Array<String> = line.split(",");
            for (rawStep in rawSteps) {
                var stepParts:Array<String> = rawStep.substr(1).split("/");
                switch (rawStep.charAt(0)) {
                    case "s":
                        steps.push([0, Std.parseInt(stepParts[0])]);
                    case "x":
                        steps.push([1, Std.parseInt(stepParts[0]), Std.parseInt(stepParts[1])]);
                    case "p":
                        steps.push([2, stepParts[0].charCodeAt(0), stepParts[1].charCodeAt(0)]);
                }
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance_2();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance_3();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0) - "a".charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance_3();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;
        for (i in 0...NUM_PROGRAMS) {
            programToIndexMap[programs[i]] = i;
        }

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance_4();
            }
        });

    }

    private function performDance():Void {
        for (step in steps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step[0]) {
                case 0:
                    head = Ints.wrap(head + NUM_PROGRAMS - step[1], 0, NUM_PROGRAMS);

                case 1:
                    var a = (head + step[1]) % NUM_PROGRAMS;
                    var b = (head + step[2]) % NUM_PROGRAMS;

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];

                case 2:
                    var a = programs.indexOf(step[1]);
                    var b = programs.indexOf(step[2]);

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];
            }
            // printLine();
        }
    }

    private function performDance_2():Void {
        for (step in steps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step[0]) {
                case 0:
                    head = Ints.wrap(head + NUM_PROGRAMS - step[1], 0, NUM_PROGRAMS);

                case 1:
                    var a:Int = (head + step[1]) % NUM_PROGRAMS;
                    var b:Int = (head + step[2]) % NUM_PROGRAMS;

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];

                case 2:
                    var a:Int = programs.indexOf(step[1]);
                    var b:Int = programs.indexOf(step[2]);

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];
            }
            // printLine();
        }
    }

    private function performDance_3():Void {
        for (step in steps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step[0]) {
                case 0:
                    head = (head + NUM_PROGRAMS - step[1]) % NUM_PROGRAMS;

                case 1:
                    var a:Int = (head + step[1]) % NUM_PROGRAMS;
                    var b:Int = (head + step[2]) % NUM_PROGRAMS;

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;

                case 2:
                    var a:Int = programs.indexOf(step[1]);
                    var b:Int = programs.indexOf(step[2]);

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;
            }
            // printLine();
        }
    }

    private function performDance_4():Void {
        for (step in steps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step[0]) {
                case 0:
                    head = (head + NUM_PROGRAMS - step[1]) % NUM_PROGRAMS;

                case 1:
                    var a:Int = (head + step[1]) % NUM_PROGRAMS;
                    var b:Int = (head + step[2]) % NUM_PROGRAMS;

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;

                    programToIndexMap[programs[a]] = a;
                    programToIndexMap[programs[b]] = b;

                case 2:
                    var a:Int = programToIndexMap[step[1]];
                    var b:Int = programToIndexMap[step[2]];

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;

                    programToIndexMap[step[1]] = b;
                    programToIndexMap[step[2]] = a;
            }
            // printLine();
        }
    }

    private function printLine():Void {
        var line:String = "";
        for (i in 0...NUM_PROGRAMS) {
            line += getProgramName(programs[Ints.wrap(head + i, 0, NUM_PROGRAMS)]);
        }
        neko.Lib.println('Line = $line');
    }

    private inline function getProgramName(programCode:Int):String {
        return String.fromCharCode(programCode);
    }
}
