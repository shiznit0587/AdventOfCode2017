class Day7 {

    private var programs:Map<String, ProgramNode> = new Map();

    public function new() {
        neko.Lib.println("Running Day 7 - a");

        FileUtil.readInput("7", function (line) {
            var parts:Array<String> = line.split(" ");

            var program:ProgramNode = new ProgramNode(parts[0], Std.parseInt(Strings.trim(parts[1], "()")));
            programs[program.name] = program;

            if (parts.length > 3) {
                program.next = parts.slice(3).map(Strings.trim.bind(_, ","));
            }
        });

        for (program in programs) {
            for (next in program.next) {
                programs[next].prev = program.name;
            }
        }

        var base:ProgramNode = Lambda.find(programs, function (p) return p.prev == null);
        neko.Lib.println('Bottom Program = ${base.name}');

        neko.Lib.println("Running Day 7 - b");

        getTowerWeight(base);

        var badProgram:ProgramNode = findImbalance(base);
        var correctTowerWeight:Int = Lambda.find(programs[badProgram.prev].nextWeights, function (w) return w != badProgram.totalWeight);
        var correctProgramWeight:Int = correctTowerWeight - Ints.listSum(badProgram.nextWeights);

        neko.Lib.println('Bad Program :: name=${badProgram.name}, weight=${badProgram.weight}, correctWeight=$correctProgramWeight');
    }

    private function getTowerWeight(program:ProgramNode):Int {
        program.nextWeights = [for (next in program.next) getTowerWeight(programs[next])];
        program.totalWeight = Ints.listSum(program.nextWeights) + program.weight;
        return program.totalWeight;
    }

    private function findImbalance(program:ProgramNode):ProgramNode {

        // If we got here and have no next tower, it must be us.
        if (program.next.length == 0) {
            return program;
        }

        // I need to find the only weight that only one next tower has.
        var rightWeight:Int = -1;
        var wrongWeight:Int = -1;

        for (weight in program.nextWeights) {
            if (rightWeight == -1) rightWeight = weight;
            else if (wrongWeight == -1 && weight != rightWeight) wrongWeight = weight;
            else if (weight == wrongWeight) {
                // they're backwards from the first two.
                rightWeight = rightWeight ^ wrongWeight;
                wrongWeight = rightWeight ^ wrongWeight;
                rightWeight = rightWeight ^ wrongWeight;
            }
        }

        var wrongNextIndex:Int = program.nextWeights.indexOf(wrongWeight);

        return (wrongNextIndex == -1) ? program : findImbalance(programs[program.next[wrongNextIndex]]);
    }
}

private class ProgramNode {
    public var prev:String;
    public var next:Array<String> = [];
    public var name:String;
    public var weight:Int;
    public var nextWeights:Array<Int>;
    public var totalWeight:Int;

    public function new(name:String, weight:Int) {
        this.name = name;
        this.weight = weight;
    }
}
