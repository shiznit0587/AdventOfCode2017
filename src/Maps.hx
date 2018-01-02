class Maps {

    public static function size<K,V>(map:Map<K,V>):Int {
        var count:Int = 0;
        for (key in map.keys()) {
            ++count;
        }
        return count;
    }
}
