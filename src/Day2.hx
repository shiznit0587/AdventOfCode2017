class Day2 {

    public function new() {

        neko.Lib.println("Running Day 2 - a");

        var checksum:Int = 0;

        FileUtil.readInput("2", function (line) {

            var values:Array<Int> = line.split("	").map(Std.parseInt);

            var min:Int = Ints.listMin(values);
            var max:Int = Ints.listMax(values);

            checksum += (max - min);
        });

        neko.Lib.println("Checksum = " + checksum);

        neko.Lib.println("Running Day 2 - b");

        checksum = 0;

        FileUtil.readInput("2", function (line) {

            var values:Array<Int> = line.split("	").map(Std.parseInt);

            for (i in 0...values.length) {
                for (j in 0...values.length) {
                    if (i != j && values[i] % values[j] == 0) {
                        checksum += Std.int(values[i] / values[j]);
                        return;
                    }
                }
            }
        });

        neko.Lib.println("Checksum = " + checksum);
    }
}
