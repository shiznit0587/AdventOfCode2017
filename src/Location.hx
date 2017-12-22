class Location {

    public static var ORIGIN(default, never):Location = new Location(0, 0);

    public var x(default, null):Int;
    public var y(default, null):Int;

    public var adjacent(get, null):Array<Location>;
    private function get_adjacent() {
        if (adjacent == null) {
            adjacent = [
                new Location(x + 1, y + 0),
                new Location(x + 0, y + 1),
                new Location(x - 1, y + 0),
                new Location(x + 0, y - 1)
            ];
        }
        return adjacent;
    }

    public var surrounding(get, null):Array<Location>;
    private function get_surrounding() {
        if (surrounding == null) {
            surrounding = [
                new Location(x + 1, y + 0),
                new Location(x + 1, y + 1),
                new Location(x + 0, y + 1),
                new Location(x - 1, y + 1),
                new Location(x - 1, y + 0),
                new Location(x - 1, y - 1),
                new Location(x + 0, y - 1),
                new Location(x + 1, y - 1)
            ];
        }
        return surrounding;
    }

    public function new(x:Int, y:Int) {
        this.x = x;
        this.y = y;
    }

    public function getManhattanDistance(to:Location):Int {
        return Std.int(Math.abs(x - to.x) + Math.abs(y - to.y));
    }

    public function move(direction:Direction):Location {
        switch (direction) {
            case LEFT: return new Location(x-1,y);
            case DOWN: return new Location(x, y+1);
            case RIGHT: return new Location(x+1, y);
            case UP: return new Location(x, y-1);
        }
    }

    public function equals(o:Location):Bool {
        return x == o.x && y == o.y;
    }

    public function toString():String {
        return '$x,$y';
    }
}
