class Day9 {

    public function new() {
        neko.Lib.println("Running Day 9 - a");

        var input:String = null;
        FileUtil.readInput("9", function (line) {
            input = line;
        });

        var iter:CharIterator = new CharIterator(input);
        var skipGarbage:Bool = false;
        var totalScore:Int = 0;
        var groupCount:Int = 0;
        var garbageCount:Int = 0;

        while (iter.hasNext()) {

            if (skipGarbage) {
                switch (iter.next()) {
                    case "!":
                        if (iter.hasNext()) {
                            iter.next();
                        }
                    case ">":
                        skipGarbage = false;
                    default:
                        ++garbageCount;
                }
                continue;
            }

            switch (iter.next()) {
                case "{":
                    ++groupCount;
                case "}":
                    totalScore += groupCount;
                    --groupCount;
                case "!":
                    if (iter.hasNext()) {
                        iter.next();
                    }
                case "<":
                    skipGarbage = true;
            }
        }

        neko.Lib.println('Total Score = $totalScore');
        neko.Lib.println("Running Day 9 - b");
        neko.Lib.println('Garbage Count = $garbageCount');
    }
}
