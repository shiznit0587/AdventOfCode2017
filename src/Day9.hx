class Day9 {

    public function new() {
        neko.Lib.println("Running Day 9 - a");

        FileUtil.readInput("9", function (line) {

            //neko.Lib.println('input = $line');

            var iter:CharIterator = new CharIterator(line);
            var skipGarbage:Bool = false;
            var totalScore:Int = 0;
            var groupCount:Int = 0;

            while (iter.hasNext()) {

                var char:String = iter.next();

                if (skipGarbage) {
                    switch (char) {
                        case "!":
                            if (iter.hasNext()) {
                                //neko.Lib.println('$char : Skipping next character of ${iter.next()}');
                                iter.next();
                            }
                        case ">":
                            //neko.Lib.println('$char : Ending garbage');
                            skipGarbage = false;
                        default:
                            //neko.Lib.println('$char : Skipping garbage');
                    }
                    continue;
                }

                switch (char) {
                    case "{":
                        ++groupCount;
                        //neko.Lib.println('$char : Starting group - groupCount = $groupCount');
                    case "}":
                        totalScore += groupCount;
                        --groupCount;
                        //neko.Lib.println('$char : Ending group - score = ${groupCount+1}, totalScore = $totalScore, groupCount = $groupCount');
                    case "!":
                        if (iter.hasNext()) {
                            //neko.Lib.println('$char : Skipping next character of ${iter.next()}');
                            iter.next();
                        }
                    case "<":
                        skipGarbage = true;
                        //neko.Lib.println('$char : Starting garbage');
                    default:
                        //neko.Lib.println('$char : Unhandled character');
                }
            }

            neko.Lib.println('Total Score = $totalScore');
        });

        neko.Lib.println("Running Day 9 - b");

        FileUtil.readInput("9", function (line) {
        });
    }
}
