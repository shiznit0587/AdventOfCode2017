class Day3 {

    public function new() {

        neko.Lib.println("Running Day 3 - a");

        var input:Int;

        FileUtil.readInput("3", function (line) {
            input = Std.parseInt(line);
        });

        var result:Int = partA(input);

        neko.Lib.println('input = $input, distance = $result');

        neko.Lib.println("Running Day 3 - b");

        result = partB(input);

        neko.Lib.println('input = $input, result = $result');
    }

    private function partA(input:Int):Int {

        var root:Int = 3;

        while (true) {

            var ringMin:Int = (root-2)*(root-2) + 1;
            var ringMax:Int = root*root;

            if (ringMin <= input && input <= ringMax) {

                var edgeSize:Int = root - 1;
                var corners:Array<Int> = [ringMax - edgeSize * 4, ringMax - edgeSize * 3, ringMax - edgeSize * 2, ringMax - edgeSize, ringMax];

                for (i in 0...corners.length - 1) {
                    if (corners[i] <= input && input <= corners[i+1]) {

                        var distanceFromFirstCorner:Int = input - corners[i];
                        var distanceFromSecondCorner:Int = corners[i+1] - input;

                        if (distanceFromFirstCorner < distanceFromSecondCorner) {
                            return root - 1 - distanceFromFirstCorner;
                        }
                        else {
                            return root - 1 - distanceFromSecondCorner;
                        }
                    }
                }
            }

            root += 2;
        }
    }

    private function partB(input:Int):Int {

        var spiral:Map<String, Int> = new Map();

        spiral.set(Location.ORIGIN.toString(), 1);

        var root:Int = 1;
        var ringSize:Int = 1;
        var cursor:Location = Location.ORIGIN;
        var direction:Direction = Direction.RIGHT;

        while (true) {

            root += 2;
            ringSize = root * root - ringSize;
            var edgeSize:Int = root - 1;

            cursor = cursor.move(direction);

            // Move to the location below, so that the loops work correctly.
            cursor = cursor.move(Direction.DOWN);

            for (_ in 0...Direction.COUNT) {

                direction = direction.turnLeft();

                for (_ in 0...edgeSize) {
                    cursor = cursor.move(direction);

                    // var result:Int = Lambda.fold(cursor.surrounding, function(loc, sum) return sum + spiral.getOrDefault(loc, 0), 0);
                    var result:Int = 0;
                    for (neighbor in cursor.surrounding) {
                        if (spiral.exists(neighbor.toString())) {
                            result += spiral.get(neighbor.toString());
                        }
                    }

                    if (result > input) {
                        return result;
                    }

                    spiral.set(cursor.toString(), result);
                }
            }
        }
    }
}
