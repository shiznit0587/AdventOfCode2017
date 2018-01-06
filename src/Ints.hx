class Ints {

    public static inline var MIN:Int = 0xFFFFFFFF;
    public static inline var MAX:Int = 0x7FFFFFFF;

    public static function listMin(list:Iterable<Int>):Int {
        return Lambda.fold(list, min, MAX);
    }

    public static function listMax(list:Iterable<Int>):Int {
        return Lambda.fold(list, max, MIN);
    }

    public static function listSum(list:Iterable<Int>) {
        return Lambda.fold(list, function (a,b) return a+b, 0);
    }

    public static inline function min(a:Int, b:Int):Int {
        return (a < b) ? a : b;
    }

    public static inline function max(a:Int, b:Int):Int {
        return (a > b) ? a : b;
    }

    public static function clamp(v:Int, min:Int, max:Int):Int {
        if (min == max) return min;

        if (min > max) {
            min = min ^ max;
            max = min ^ max;
            min = min ^ max;
        }

        if (v < min) return min;
        if (v > max) return max;
        return v;
    }

    public static inline function inRange(v:Int, min:Int, max:Int):Bool {
        return min <= v && v <= max;
    }

    public static function wrap(v:Int, min:Int, max:Int):Int {
        if (min == max) return min;

        if (min > max) {
            min = min ^ max;
            max = min ^ max;
            min = min ^ max;
        }

        var range:Int = max - min;
        var wrapped:Int = ((v - min) % range) + min;

        if (wrapped < min) return wrapped += range;
        return wrapped;
    }

    public static function map(sourceValue:Int, sourceMin:Int, sourceMax:Int, targetMin:Int, targetMax:Int):Int {
        if (sourceMin == sourceMax) return targetMin;
        if (sourceValue == sourceMin) return targetMin;
        if (sourceValue == sourceMax) return targetMax;

        return Std.int((((sourceValue - sourceMin) / (sourceMax - sourceMin)) * (targetMax - targetMin)) + targetMin);
    }
}
