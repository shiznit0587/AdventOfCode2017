class Pair<T> {

    public var left(default, null):T;
    public var right(default, null):T;

    public function new(l:T, r:T) {
        left = l;
        right = r;
    }

    public static function fromArray<T>(arr:Array<T>):Pair<T> {
        return new Pair<T>(arr[0], arr[1]);
    }
}
