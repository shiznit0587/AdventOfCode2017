using Lambda;

class Day16_2 {

    // private static var PROGRAMS:String = "abcde";
    private static var PROGRAMS:String = "abcdefghijklmnop";
    private static var NUM_PROGRAMS:Int = PROGRAMS.length;

    // I think I need to do the first attempt, but as an array of integers,
    // and I should keep track of an offset to the head node.

    private var programs:Array<Int>;
    private var steps:Array<DanceStep_2>;
    private var head:Int = 0;

    public function new() {
        neko.Lib.println("Running Day 16 - a");

        steps = [];
        FileUtil.readInput("16", function (line) {
            var rawSteps:Array<String> = line.split(",");
            for (rawStep in rawSteps) {
                var stepParts:Array<String> = rawStep.substr(1).split("/");
                switch (rawStep.charAt(0)) {
                    case "s":
                        steps.push(Spin(Std.parseInt(stepParts[0])));
                    case "x":
                        steps.push(Exchange(Std.parseInt(stepParts[0]), Std.parseInt(stepParts[1])));
                    case "p":
                        steps.push(Partners(stepParts[0].charCodeAt(0), stepParts[1].charCodeAt(0)));
                }
            }
        });

        programs = new CharIterator(PROGRAMS).map(function (c) return c.charCodeAt(0)).array();

        haxe.Timer.measure(function () {
            for (_ in 0...10) {
                performDance();
            }
        });

        //
    }

    private function performDance():Void {
        for (step in steps) {
            // neko.Lib.println('Performing Step: $step');
            switch (step) {
                case Spin(size):
                    head = Ints.wrap(head + NUM_PROGRAMS - size, 0, NUM_PROGRAMS);
                case Exchange(a, b):
                    a = Ints.wrap(head + a, 0, NUM_PROGRAMS);
                    b = Ints.wrap(head + b, 0, NUM_PROGRAMS);

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];

                case Partners(a, b):
                    a = programs.indexOf(a);
                    b = programs.indexOf(b);

                    programs[a] = programs[a] ^ programs[b];
                    programs[b] = programs[a] ^ programs[b];
                    programs[a] = programs[a] ^ programs[b];
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

enum DanceStep_2 {
    Spin(size:Int);
    Exchange(positionA:Int, positionB:Int);
    Partners(programA:Int, programB:Int);
}
