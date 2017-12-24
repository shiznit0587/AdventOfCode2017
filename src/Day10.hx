class Day10 {

    public function new() {
        neko.Lib.println("Running Day 10 - a");

        var lengths:Array<Int> = null;
        FileUtil.readInput("10", function (line) {
            lengths = line.split(",").map(Std.parseInt);
        });

        var hash:Array<Int> = [for (i in 0...256) i];
        var cursor:Int = 0;
        var skipSize:Int = 0;
        //neko.Lib.println('hash = $hash, cursor = $cursor, skipSize = $skipSize');

        for (length in lengths) {
            //neko.Lib.println('cursor = $cursor, length = $length');
            swap(hash, cursor, length);
            cursor = Ints.wrap(cursor + length + skipSize, 0, hash.length);
            ++skipSize;
            //neko.Lib.println('hash = $hash, cursor = $cursor, skipSize = $skipSize');
        }

        neko.Lib.println('Hash Check = ${hash[0] * hash[1]}');

        neko.Lib.println("Running Day 10 - b");

        FileUtil.readInput("10", function (line) {
        });
    }

    private function swap(hash:Array<Int>, cursor:Int, length:Int):Void {
        var start:Int = cursor;
        var end:Int = Ints.wrap(start + length - 1, 0, hash.length);

        while (length > 1) {
            //neko.Lib.println('swapping $start and $end (${hash[start]} and ${hash[end]})');
            var temp:Int = hash[start];
            hash[start] = hash[end];
            hash[end] = temp;

            start = Ints.wrap(start + 1, 0, hash.length);
            end = Ints.wrap(end - 1, 0, hash.length);
            length -= 2;
        }
    }
}
