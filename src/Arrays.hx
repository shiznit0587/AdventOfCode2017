class Arrays {

    public static function map<A,B>(it:Iterable<A>, f:A->B):Array<B> {
        var a = new Array<B>();
        for (i in it) {
            a.push(f(i));
        }
        return a;
    }

}
