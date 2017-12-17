class Day1 {

    public function new() {

        neko.Lib.println("Running Day 1 - a");

        var sumA:Int = 0;
        var sumB:Int = 0;

        FileUtil.readInput("1", function(line) {

            for (i in 0...line.length) {
                var jA:Int = (i + 1) % line.length;
                var jB:Int = (i + Std.int(line.length / 2)) % line.length;
                if (line.charAt(i) == line.charAt(jA)) {
                    sumA += Std.parseInt(line.charAt(i));
                }
                if (line.charAt(i) == line.charAt(jB)) {
                    sumB += Std.parseInt(line.charAt(i));
                }
            }
        });

        neko.Lib.println("Sum = " + sumA);
        neko.Lib.println("Running Day 1 - b");
        neko.Lib.println("Sum = " + sumB);
    }
}
