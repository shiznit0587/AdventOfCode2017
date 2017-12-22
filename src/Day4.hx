class Day4 {
    public function new() {
        neko.Lib.println("Running Day 4 - a");

        var valid:Int = 0;

        FileUtil.readInput("4", function (line) {
            var words:Array<String> = line.split(" ");
            var wordMap:Map<String, String> = new Map();

            for (word in words) {
                if (wordMap.exists(word)) {
                    return;
                }
                wordMap.set(word, word);
            }

            ++valid;
        });

        neko.Lib.println('Valid Passphrases = $valid');

        neko.Lib.println("Running Day 4 - b");

        valid = 0;

        FileUtil.readInput("4", function (line) {
            var words:Array<String> = line.split(" ");
            var wordMap:Map<String, String> = new Map();

            // for each word, sort the characters.
            for (word in words) {
                var chars:Array<String> = Lambda.array(new CharIterator(word));
                chars.sort(function (a, b) return a.charCodeAt(0) - b.charCodeAt(0));
                word = chars.join("");

                if (wordMap.exists(word)) {
                    return;
                }
                wordMap.set(word, word);
            }

            ++valid;
        });

        neko.Lib.println('Valid Passphrases = $valid');
    }
}
