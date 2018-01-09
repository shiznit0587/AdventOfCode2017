using Lambda;

class Day16 {

    // private static var PROGRAMS:String = "abcde";
    private static var PROGRAMS:String = "abcdefghijklmnop";
    private static var NUM_PROGRAMS:Int = PROGRAMS.length;

    public function new() {
        neko.Lib.println("Running Day 16 - a");

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
                        steps.push(PartnerNames(stepParts[0], stepParts[1]));
                        steps.push(PartnerCodes(stepParts[0].charCodeAt(0), stepParts[1].charCodeAt(0)));
                }
            }
        });

        // neko.Lib.println('steps = $steps');

        var programs:List<DanceProgram> = new CharIterator(PROGRAMS).map(DanceProgram.new);
        var programMap:Map<Int, DanceProgram> = Maps.create(programs, function (p) return p.val);

        var line:DanceLine = new DanceLine(programs);

        neko.Lib.println('Program Order = $line');

        var programNames:Array<String> = programs.map(function (p) return p.name).array();

        var iterations:Int = 10;
        haxe.Timer.measure(function() {
            for (_ in 0...iterations) {
                programNames = performDance(programNames, steps);
            }
        });
        neko.Lib.println('Program Order = ${programNames.join("")}');

        haxe.Timer.measure(function () {
            for (_ in 0...iterations) {
                performLinkedDance(programMap, line, steps);
            }
        });
        neko.Lib.println('times: spin=$spinTime, exchange=$exchangeTime, partner=$partnerTime');
        neko.Lib.println('Program Order = $line');

        neko.Lib.println("Running Day 16 - b");

        // neko.Lib.println('Program Order = ${programs.join("")}');
    }

    private function performDance(programs:Array<String>, steps:Array<DanceStep>):Array<String> {
        for (step in steps) {
            switch (step) {
                case Spin(size):
                    var spin:Array<String> = programs.splice(programs.length - size, size);
                    programs = spin.concat(programs);
                case Exchange(a, b):
                    Arrays.swap(programs, a, b);
                case PartnerNames(a, b):
                    Arrays.swap(programs, programs.indexOf(a), programs.indexOf(b));
                case PartnerCodes(_,_):
            }
        }
        return programs;
    }

    var spinTime = 0.;
    var exchangeTime = 0.;
    var partnerTime = 0.;

    private function performLinkedDance(programs:Map<Int, DanceProgram>, line:DanceLine, steps:Array<DanceStep>):Void {
        // neko.Lib.println('Perform Linked Dance');

        for (step in steps) {
            // var start = haxe.Timer.stamp();
            // neko.Lib.println('Performing Step : $step : on $line');
            switch (step) {
                case Spin(size):
                    line.rotate(line.get(NUM_PROGRAMS - size));
                    // spinTime += (haxe.Timer.stamp() - start);

                case Exchange(a, b):
                    line.swap(line.get(a), line.get(b));
                    // exchangeTime += (haxe.Timer.stamp() - start);

                case PartnerCodes(a, b):
                    var pa = programs.get(a), pb = programs.get(b);
                    // neko.Lib.println('a=$pa, b=$pb');
                    line.swap(pa, pb);
                    // partnerTime += (haxe.Timer.stamp() - start);

                case PartnerNames(_,_):
            }

            // var line:String = line.map(function (h) return h.name).join("");
            // neko.Lib.println('Program Order = $line');
        }
    }
}

enum DanceStep {
    Spin(size:Int);
    Exchange(positionA:Int, positionB:Int);
    PartnerNames(programA:String, programB:String);
    PartnerCodes(programA:Int, programB:Int);
}

class DanceProgram {
    public var val(default, null):Int;
    public var name(default, null):String;

    public function new(name:String) {
        this.name = name;
        this.val = name.charCodeAt(0);
    }

    public function toString() {
        return name;
    }
}

class DanceLine extends LinkedList<DanceProgram> {
    public function toString():String {
        return map(function (h) return h.name).join("");
    }
}
