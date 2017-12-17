import sys.io.File;
import sys.io.FileInput;

class FileUtil {
    public static function readInput(input:String, lineReader:String->Void):Void {
        var fileInput:FileInput = File.read('inputs/Day$input.txt', false);

        while (!fileInput.eof()) {
            lineReader(fileInput.readLine());
        }

        fileInput.close();
    }
}
