class Maps {

    public static function size<K,V>(map:Map<K,V>):Int {
        var count:Int = 0;
        for (key in map.keys()) {
            ++count;
        }
        return count;
    }

    @:generic
    public static function create<K,V>(items:Iterable<V>, keyMapper:V->K):Map<K,V> {
        var map:Map<K,V> = new Map();
        for (item in items) {
            map.set(keyMapper(item), item);
        }
        return map;
    }
}
