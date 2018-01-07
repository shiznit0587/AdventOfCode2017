class Day16 {

    private static var PROGRAMS:String = "abcdefghijklmnop";

    public function new() {
        neko.Lib.println("Running Day 16 - a");

        var programs:Array<String> = Lambda.array(new CharIterator(PROGRAMS));

        var steps:Array<DanceStep> = [];
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
                        steps.push(Partner(stepParts[0], stepParts[1]));
                }
            }
        });

        programs = performDance(programs, steps);

        neko.Lib.println('Program Order = ${programs.join("")}');

        neko.Lib.println("Running Day 16 - b");

        for (_ in 0...100) {
            programs = performDance(programs, steps);
        }

        neko.Lib.println('Program Order = ${programs.join("")}');
    }

    private function performDance(programs:Array<String>, steps:Array<DanceStep>):Array<String> {
        for (step in steps) {
            switch (step) {
                case Spin(size):
                    var spin:Array<String> = programs.splice(programs.length - size, size);
                    programs = spin.concat(programs);
                case Exchange(a, b):
                    Arrays.swap(programs, a, b);
                case Partner(a, b):
                    Arrays.swap(programs, programs.indexOf(a), programs.indexOf(b));
            }
        }
        return programs;
    }
}

enum DanceStep {
    Spin(size:Int);
    Exchange(positionA:Int, positionB:Int);
    Partner(programA:String, programB:String);
}
