using Lambda;

class Day16_3 {

    // private static var PROGRAMS:String = "abcde";
    private static var PROGRAMS:String = "abcdefghijklmnop";
    private static var NUM_PROGRAMS:Int = PROGRAMS.length;

    // I think I need to do the first attempt, but as an array of integers,
    // and I should keep track of an offset to the head node.

    private var programs:Array<Int>;
    private var enumSteps:Array<DanceStep_3>;
    private var steps:Array<Array<Int>>;
    private var head:Int = 0;

    private var programToIndexMap:Map<Int, Int> = new Map();

    public function new() {
        neko.Lib.println("Running Day 16 - a");

        enumSteps = [];
        steps = [];
        FileUtil.readInput("16", function (line) {
            var rawSteps:Array<String> = line.split(",");
            for (rawStep in rawSteps) {
                var stepParts:Array<String> = rawStep.substr(1).split("/");
                switch (rawStep.charAt(0)) {
                    case "s":
                        enumSteps.push(Spin(Std.parseInt(stepParts[0])));
                        steps.push([0, Std.parseInt(stepParts[0])]);
                    case "x":
                        enumSteps.push(Exchange(Std.parseInt(stepParts[0]), Std.parseInt(stepParts[1])));
                        steps.push([1, Std.parseInt(stepParts[0]), Std.parseInt(stepParts[1])]);
                    case "p":
                        enumSteps.push(Partners(stepParts[0].charCodeAt(0), stepParts[1].charCodeAt(0)));
                        steps.push([2, stepParts[0].charCodeAt(0), stepParts[1].charCodeAt(0)]);
                }
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();

        var iterations:Int = 10;
        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_1();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_2();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_3();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_4();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0) - "a".charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_5();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();
        head = 0;
        for (i in 0...NUM_PROGRAMS) {
            programToIndexMap[programs[i]] = i;
        }

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_6();
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0) - "a".charCodeAt(0)).array();
        head = 0;

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performDance_7();
            }
        });

    }

    private function performDance_1():Void {
        for (step in enumSteps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step) {
                case Spin(size):
                    head = Ints.wrap(head + NUM_PROGRAMS - size, 0, NUM_PROGRAMS);

                case Exchange(a, b):
                    var a = (head + a) % NUM_PROGRAMS;
                    var b = (head + b) % NUM_PROGRAMS;

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];

                case Partners(a, b):
                    var a = programs.indexOf(a);
                    var b = programs.indexOf(b);

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

    private function performDance_3():Void {
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

    private function performDance_4():Void {
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

    private function performDance_5():Void {
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

    private function performDance_6():Void {
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

    private function performDance_7():Void {
        for (step in enumSteps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step) {
                case Spin(size):
                    head = (head + NUM_PROGRAMS - size) % NUM_PROGRAMS;

                case Exchange(a, b):
                    var a = (head + a) % NUM_PROGRAMS;
                    var b = (head + b) % NUM_PROGRAMS;

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;

                case Partners(a, b):
                    var a = programs.indexOf(a);
                    var b = programs.indexOf(b);

                    var tmp:Int = programs[a];
                    programs[a] = programs[b];
                    programs[b] = tmp;
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

enum DanceStep_3 {
    Spin(size:Int);
    Exchange(positionA:Int, positionB:Int);
    Partners(programA:Int, programB:Int);
}
