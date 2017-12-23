class Day7 {

    public function new() {
        neko.Lib.println("Running Day 7 - a");

        var programs:Map<String, ProgramNode> = new Map();

        FileUtil.readInput("7", function (line) {
            var parts:Array<String> = line.split(" ");

            var program:ProgramNode = new ProgramNode(parts[0], Std.parseInt(Strings.trim(parts[1], "()")));
            programs[program.name] = program;

            if (parts.length > 3) {
                program.next = [for (i in 3...parts.length) Strings.trim(parts[i], ",")];
            }
        });

        for (program in programs) {
            for (next in program.next) {
                programs[next].prev = program.name;
            }
        }

        for (program in programs) {
            if (program.prev == null) {
                neko.Lib.println('Bottom Program = ${program.name}');
            }
        }

        neko.Lib.println("Running Day 7 - b");
    }
}

private class ProgramNode {
    public var prev:String;
    public var next:Array<String> = [];
    public var name:String;
    public var weight:Int;

    public function new(name:String, weight:Int) {
        this.name = name;
        this.weight = weight;
    }
}
