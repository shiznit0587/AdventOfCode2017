class Arrays {

    public static function map<A,B>(it:Iterable<A>, f:A->B):Array<B> {
        var a = new Array<B>();
        for (i in it) {
            a.push(f(i));
        }
        return a;
    }

    public static function has<T>(arr:Array<T>, el:T):Bool {
        return arr.indexOf(el) >= 0;
    }

    public static function add<T>(arr:Array<T>, el:T):Bool {
        if (has(arr, el)) return false;
        arr.push(el);
        return true;
    }
}
