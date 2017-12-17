class CharIterator {

    var index:Int;
    var string:String;

    public inline function new(string:String) {
        this.string = string;
        index = 0;
    }

    public inline function hasNext() {
        return index < string.length;
    }

    public inline function next() {
        return string.charAt(++index);
    }

    public inline function iterator() return this;

}
