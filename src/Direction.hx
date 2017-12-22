@:enum
abstract Direction(Int) {

    var LEFT = 0;
    var DOWN = 1;
    var RIGHT = 2;
    var UP = 3;

    public static var COUNT(get, never):Int;
    private static inline function get_COUNT() return 4;

    public function turnLeft():Direction {
        return cast Ints.wrap(this + 1, 0, COUNT);
    }

    public function turnRight():Direction {
        return cast Ints.wrap(this - 1, 0, COUNT);
    }
}
