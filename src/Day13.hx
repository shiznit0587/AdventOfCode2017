class Day13 {

    public function new() {
        neko.Lib.println("Running Day 13 - a");

        var programs:Map<Int, FirewallProgram> = new Map();
        var programsArray:Array<FirewallProgram> = [];

        FileUtil.readInput("13", function (line) {
            var parts:Array<Int> = line.split(" ").map(Strings.trim.bind(_, ":")).map(Std.parseInt);
            programs[parts[0]] = new FirewallProgram(parts[0], parts[1]);
            programsArray.push(programs[parts[0]]);
        });

        var endDepth:Int = Ints.listMax(new Iter<Int>(programs.keys()));

        //neko.Lib.println('programs = $programs');
        //neko.Lib.println('endDepth = $endDepth');

        var catches:Int = 0;
        var severity:Int = 0;

        var player:FirewallProgram = new FirewallProgram(-1, 0);

        while (player.depth <= endDepth) {
            player.advanceUser();
            //neko.Lib.println(player);

            var program:FirewallProgram = programs[player.depth];

            if (program != null && program.layer == player.layer) {
                ++catches;
                severity += program.depth * program.range;
                // neko.Lib.println('Caught by $program :: Catches = $catches, Severity = $severity');
            }

            for (program in programs) {
                program.advanceProgram();
            }
        }

        neko.Lib.println('Caught Times = $catches, Severity = $severity');

        // Redoing part A using new method.

        catches = 0;
        severity = 0;
        for (program in programsArray) {
            var layer:Int = program.getLayer(0);
            // neko.Lib.println('depth = ${program.depth}, layer = $layer');
            if (layer == 0) {
                ++catches;
                severity += program.depth * program.range;
            }
        }

        neko.Lib.println('Caught Times = $catches, Severity = $severity');

        neko.Lib.println("Running Day 13 - b");

        // This is weird, I don't know what to do from here. I don't want to run the simulation for each starting delay, right?

        /*
        var delay:Int = -1;
        var solution:Int = -1;

        while (solution == -1) {

            // increment the delay
            ++delay;

            // reset the player and programs
            player = new FirewallProgram(-1, 0);
            for (program in programs) {
                program.reset();
            }

            // simulate delay
            for (_ in 0...delay) {
                // TODO: There's potentially a mathematical way to advance by delay.
                // Or, I can clone and bump by one each time.
                for (program in programs) {
                    program.advanceProgram();
                }
            }

            // simulate movement until we're caught, or we succeed.
            var caught:Bool = false;

            while (player.depth <= endDepth && !caught) {
                player.advanceUser();
                // neko.Lib.println(player);

                var program:FirewallProgram = programs[player.depth];

                // if (program != null) {
                //     neko.Lib.println('delay = $delay, player = $player, program = $program');
                // }

                if (program != null && program.layer == player.layer) {
                    caught = true;
                    // neko.Lib.println('Delay $delay :: Caught by $program');
                }

                for (program in programs) {
                    program.advanceProgram();
                }
            }

            // check for success
            if (!caught) {
                solution = delay;
            }
        }

        neko.Lib.println('Delay = $solution');
        */

        var solution:Int = -1;
        var delay:Int = -1;

        while (solution == -1) {
            ++delay;

            var caught:Bool = false;
            for (program in programsArray) {
                if (program.getLayer(delay) == 0) {
                    caught = true;
                    break;
                }
            }

            if (!caught) {
                solution = delay;
            }
        }

        neko.Lib.println('Delay = $solution');

        FileUtil.readInput("13", function (line) {
        });
    }
}

class FirewallProgram {
    public var depth(default, null):Int;
    public var range(default, null):Int;
    public var layer(default, null):Int = 0;

    private var _direction:Direction = Direction.DOWN;

    public function new(depth:Int, range:Int) {
        this.depth = depth;
        this.range = range;
    }

    public function getLayer(delay:Int):Int {

        var delta:Int = delay + depth;

        delta = delta % ((range - 1) * 2);

        if (delta < range) {
            return delta;
        }
        return (range - 1) - (delta - (range - 1));
    }

    public function advanceProgram():Void {
        if (_direction == Direction.DOWN) {
            ++layer;
            if (layer == range - 1) {
                _direction = Direction.UP;
            }
        }
        else {
            --layer;
            if (layer == 0) {
                _direction = Direction.DOWN;
            }
        }
    }

    public function advanceUser():Void {
        ++depth;
    }

    public function reset():Void {
        layer = 0;
        _direction = Direction.DOWN;
    }
}
