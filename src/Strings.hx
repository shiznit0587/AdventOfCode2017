class Strings {
    public static function trim(v:String, chars:String):String {
        if (v.length == 0) return v;

        var modified:Bool = false;
        var leftIndex:Int = 0;

        while (chars.indexOf(v.charAt(leftIndex)) != -1) {
            ++leftIndex;
            modified = true;
        }

        var rightIndex:Int = v.length;
        while (chars.indexOf(v.charAt(rightIndex - 1)) != -1) {
            --rightIndex;
            modified = true;
        }

        return modified ? v.substring(leftIndex, rightIndex) : v;
    }
}
