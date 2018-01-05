class Iter<T> {
    private var _iter:Iterator<T>;

    public function new(iter:Iterator<T>) {
        _iter = iter;
    }

    public function iterator() {
        return _iter;
    }
}
