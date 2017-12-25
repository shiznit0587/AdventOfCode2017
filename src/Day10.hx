class Day10 {

    private var hash:Array<Int>;
    private var lengths:Array<Int>;

    public function new() {
        neko.Lib.println("Running Day 10 - a");

        FileUtil.readInput("10", function (line) {
            lengths = line.split(",").map(Std.parseInt);
        });

        hash = [for (i in 0...256) i];

        processLengths(1);

        neko.Lib.println('Hash Check = ${hash[0] * hash[1]}');

        neko.Lib.println("Running Day 10 - b");

        lengths = [];
        FileUtil.readInput("10", function (line) {
            lengths = Lambda.array(Lambda.map(new CharIterator(line), function (c) return c.charCodeAt(0)));
        });
        lengths = lengths.concat([17,31,73,47,23]);

        hash = [for (i in 0...256) i];

        processLengths(64);
        hash = calculateSparseHash();
        var knotHash:String = Lambda.map(hash, getHex).join("");

        neko.Lib.println('hash = $knotHash');
    }

    private function processLengths(iterations:Int):Void {
        iterations *= lengths.length;
        var lengthCursor:Int = 0;
        var hashCursor:Int = 0;
        var skipSize:Int = 0;

        while (iterations > 0) {
            var length:Int = lengths[lengthCursor];

            swap(hashCursor, length);
            hashCursor = Ints.wrap(hashCursor + length + skipSize, 0, hash.length);
            lengthCursor = Ints.wrap(lengthCursor + 1, 0, lengths.length);
            ++skipSize;
            --iterations;
        }
    }

    private function swap(cursor:Int, length:Int):Void {
        var start:Int = cursor;
        var end:Int = Ints.wrap(start + length - 1, 0, hash.length);

        while (length > 1) {
            var temp:Int = hash[start];
            hash[start] = hash[end];
            hash[end] = temp;

            start = Ints.wrap(start + 1, 0, hash.length);
            end = Ints.wrap(end - 1, 0, hash.length);
            length -= 2;
        }
    }

    private function calculateSparseHash():Array<Int> {
        var sparseHash:Array<Int> = [for (_ in 0...16) 0];
        for (i in 0...16) {
            for (j in 0...16) {
                sparseHash[i] = sparseHash[i] ^ hash[i*16+j];
            }
        }
        return sparseHash;
    }

    private function getHex(value:Int):String {
        return HEX_CHARS.charAt(Std.int(value / 16)) + HEX_CHARS.charAt(value % 16);
    }

    private static var HEX_CHARS:String = "0123456789abcdef";
}
