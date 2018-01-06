class KnotHash {

    private static var LENGTHS_SUFFIX:Array<Int> = [17,31,73,47,23];
    private static var HEX_CHARS:String = "0123456789abcdef";

    /**
     *  Generates a knot hash from a given input string.
     *  @param input - String used as directions for performing the the knot hash.
     *  @return String 32-character hexadecimal string, representing 128 bits.
     */
    public static function generate(input:String):String {
        var lengths:Array<Int> = Lambda.array(Lambda.map(new CharIterator(input), function (c) return c.charCodeAt(0)));

        lengths = lengths.concat(LENGTHS_SUFFIX);

        var hash:Array<Int> = [for (i in 0...256) i];

        processLengths(lengths, hash, 64);
        hash = calculateSparseHash(hash);
        return Lambda.map(hash, getHex).join("");
    }

    private static function processLengths(lengths:Array<Int>, hash:Array<Int>, iterations:Int):Void {
        iterations *= lengths.length;
        var lengthCursor:Int = 0;
        var hashCursor:Int = 0;
        var skipSize:Int = 0;

        while (iterations > 0) {
            var length:Int = lengths[lengthCursor];

            swap(lengths, hash, hashCursor, length);
            hashCursor = Ints.wrap(hashCursor + length + skipSize, 0, hash.length);
            lengthCursor = Ints.wrap(lengthCursor + 1, 0, lengths.length);
            ++skipSize;
            --iterations;
        }
    }

    private static function swap(lengths:Array<Int>, hash:Array<Int>, cursor:Int, length:Int):Void {
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

    private static function calculateSparseHash(hash:Array<Int>):Array<Int> {
        var sparseHash:Array<Int> = [for (_ in 0...16) 0];
        for (i in 0...16) {
            for (j in 0...16) {
                sparseHash[i] = sparseHash[i] ^ hash[i*16+j];
            }
        }
        return sparseHash;
    }

    private static function getHex(value:Int):String {
        return HEX_CHARS.charAt(Std.int(value / 16)) + HEX_CHARS.charAt(value % 16);
    }
}
