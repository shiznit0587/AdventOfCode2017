class Day8 {

    public function new() {
        neko.Lib.println("Running Day 8 - a");

        var lines:Array<Line> = [];

        FileUtil.readInput("8", function (line) {
            var parts:Array<String> = line.split(" ");
            lines.push(new Line(new Instruction(parts[0], parts[1], parts[2]), new Condition(parts[4], parts[5], parts[6])));
        });

        var variables:Map<String, Int> = new Map();

        var max:Int = Ints.MIN;

        for (line in lines) {
            line.eval(variables);
            max = Ints.max(max, Ints.listMax(variables));
        }

        neko.Lib.println('Max Register Value = ${Ints.listMax(variables)}');
        neko.Lib.println("Running Day 8 - b");
        neko.Lib.println('Max Register Value = $max');
    }
}

private class Line {
    private var instruction:Instruction;
    private var condition:Condition;

    public function new(instruction:Instruction, condition:Condition) {
        this.instruction = instruction;
        this.condition = condition;
    }

    public function eval(variables:Map<String, Int>):Void {
        if (condition.eval(variables)) {
            instruction.eval(variables);
        }
    }
}

private class Instruction {
    private var variable:String;
    private var instruction:InstructionType;
    private var value:Int;

    public function new(variable:String, instruction:String, value:String) {
        this.variable = variable;
        this.instruction = cast instruction;
        this.value = Std.parseInt(value);
    }

    public function eval(variables:Map<String, Int>):Void {
        if (!variables.exists(variable)) {
            variables[variable] = 0;
        }

        switch (instruction) {
            case INC: variables[variable] += value;
            case DEC: variables[variable] -= value;
        }
    }
}

private class Condition {
    private var variable:String;
    private var comparator:Comparator;
    private var value:Int;

    public function new(variable:String, comparator:String, value:String) {
        this.variable = variable;
        this.comparator = cast comparator;
        this.value = Std.parseInt(value);
    }

    public function eval(variables:Map<String, Int>):Bool {
        var val:Int = 0;
        if (variables.exists(variable)) {
            val = variables[variable];
        }

        switch (comparator) {
            case LT: return val < value;
            case LTE: return val <= value;
            case EQ: return val == value;
            case NEQ: return val != value;
            case GT: return val > value;
            case GTE: return val >= value;
        }
    }
}

@:enum
abstract InstructionType(String) from String {
    var INC = "inc";
    var DEC = "dec";
}

@:enum
abstract Comparator(String) from String {
    var LT = "<";
    var LTE = "<=";
    var EQ = "==";
    var NEQ = "!=";
    var GT = ">";
    var GTE = ">=";
}
