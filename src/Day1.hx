class Day1 {

    public function new() {

        neko.Lib.println("Running Day 1 - a");

        var sumA:Int = 0;
        var sumB:Int = 0;

        FileUtil.readInput("1", function(line) {

            var digits:Array<Int> = Arrays.map(new CharIterator(line), Std.parseInt);

            for (i in 0...digits.length) {

                var jA:Int = (i + 1) % digits.length;
                var jB:Int = (i + Std.int(digits.length / 2)) % digits.length;

                if (digits[i] == digits[jA]) {
                    sumA += digits[i];
                }

                if (digits[i] == digits[jB]) {
                    sumB += digits[i];
                }
            }
        });

        neko.Lib.println("Sum = " + sumA);
        neko.Lib.println("Running Day 1 - b");
        neko.Lib.println("Sum = " + sumB);
    }
}
