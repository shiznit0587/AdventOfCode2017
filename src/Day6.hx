class Day6 {

    public function new() {
        neko.Lib.println("Running Day 6 - a");

        var cycles:Int = 0;
        FileUtil.readInput("6", function (line) {
            var buckets:Array<Int> = line.split("	").map(Std.parseInt);
            var seenDistributions:Map<String, Int> = new Map();

            while (true) {
                ++cycles;
                var index:Int = buckets.indexOf(Ints.listMax(buckets));
                var amt:Int = buckets[index];
                buckets[index] = 0;

                for (i in 0...amt) {
                    ++buckets[Ints.wrap(++index, 0, buckets.length)];
                }

                var distribution:String = '$buckets';
                if (seenDistributions.exists(distribution)) {
                    neko.Lib.println('Cycles = $cycles');
                    neko.Lib.println("Running Day 6 - b");
                    neko.Lib.println('Cycles = ${cycles - seenDistributions.get(distribution)}');
                    return;
                }
                seenDistributions.set(distribution, cycles);
            }
        });
    }
}
