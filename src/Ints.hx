class Ints {

    public static inline var MIN:Int = 0xFFFFFFFF;
    public static inline var MAX:Int = 0x7FFFFFFF;

    public static function listMin(list:Iterable<Int>):Int {
        return Lambda.fold(list, minInt, MAX);
    }

    public static function listMax(list:Iterable<Int>):Int {
        return Lambda.fold(list, maxInt, MIN);
    }

    public static inline function minInt(a:Int, b:Int):Int {
        return (a < b) ? a : b;
    }

    public static inline function maxInt(a:Int, b:Int):Int {
        return (a > b) ? a : b;
    }

}
