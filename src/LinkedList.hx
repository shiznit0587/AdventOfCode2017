import haxe.ds.ObjectMap;

class LinkedList<T:{}> {

    private var _h:LinkedListNode<T>;
    private var _q:LinkedListNode<T>;
    private var _map:ObjectMap<T, LinkedListNode<T>>;

    public function new(?source:Iterable<T>) {
        _map = new Map<T, LinkedListNode<T>>();
        if (source != null) {
            Lambda.iter(source, add);
        }
    }

    public function get(i:Int):T {
        if (_h == null) return null;

        var j = -1;
        var node = _h;
        while (++j < i) node = node.next;
        return node.data;
    }

    public function indexOf(item:T):Int {
        if (_h == null) return -1;

        // Special case for 1 item.
        if (_h == _q) return (_h.data == item) ? 0 : -1;

        var j = 0;
        var node = null;

        while (node != _h) {
            if (node == null) node = _h;
            if (node.data == item) return j;
            node = node.next;
            ++j;
        }
        return -1;
    }

    public function add(item:T):Void {
        if (_map.exists(item)) return;

        var node:LinkedListNode<T> = new LinkedListNode<T>(item);
        _map.set(item, node);
        if (_h == null) {
            node.prev = node;
            node.next = node;
            _h = node;
            _q = node;
        }
        else {
            _q.next = node;
            _h.prev = node;
            node.prev = _q;
            node.next = _h;
            _q = node;
        }
    }

    public function isEmpty() {
        return _h == null;
    }

    /**
     *  Rotate the LinkedList, resulting in `item` being the first item.
     *  @param item - New list head.
     */
    public function rotate(item:T):Void {
        var node = _getNode(item);
        if (node != null) {
            _h = node;
            _q = _h.prev;
        }
    }

    public function swap(itemA:T, itemB:T):Void {
        if (itemA == itemB) return;

        var a = _getNode(itemA);
        var b = _getNode(itemB);

        if (a == null || b == null) return;

        a.data = itemB;
        b.data = itemA;
        _map.set(itemA, a);
        _map.set(itemB, b);

        /*
        // Fixup to handle switching neighbors.
        if (a.prev == b) a.prev = a;
        if (a.next == b) a.next = a;
        if (b.prev == a) b.prev = b;
        if (b.next == a) b.next = b;

        // Cache links to be swapped.
        var ah = (a == _h), aq = (a == _q);
        var bh = (b == _h), bq = (b == _q);
        var ap = a.prev, an = a.next;
        var bp = b.prev, bn = b.next;

        // Swap links.
        ap.next = an.prev = b;
        bp.next = bn.prev = a;
        a.prev = bp;
        a.next = bn;
        b.prev = ap;
        b.next = an;

        // Fixup list if head or tail were swapped.
        if (ah) _h = b;
        else if (aq) _q = b;
        if (bh) _h = a;
        else if (bq) _q = a;
        */
    }

    public function iterator() {
        return new LinkedListIterator<T>(_h);
    }

    private function _getNode(item:T):LinkedListNode<T> {
        return _map.get(item);
        /*
        // neko.Lib.println('_getNode :: Getting node for item: $item');
        if (_h == null) return null;

        // Special case for 1 item.
        if (_h == _q) return (_h.data == item) ? _h : null;

        var node = null;

        while (node != _h) {
            if (node == null) node = _h;
            // neko.Lib.println('_getNode :: Searching node with item: ${node.data}');
            if (node.data == item) {
                // neko.Lib.println('_getNode :: Found node with item: ${node.data}');
                return node;
            }
            node = node.next;
            // neko.Lib.println('_getNode :: Not Found - Next Node is: ${node.data}');
        }
        return null;
        */
    }
}

class LinkedListNode<T> {
    public var prev:LinkedListNode<T>;
    public var next:LinkedListNode<T>;

    public var data:T;

    public function new(data:T) {
        this.data = data;
        prev = null;
        next = null;
    }
}

class LinkedListIterator<T> {
    private var _h:LinkedListNode<T>;
    private var _i:LinkedListNode<T>;

    public function new(h:LinkedListNode<T>) {
        _h = h;
        _i = null;
    }

    public function hasNext():Bool {
        return _h != null && (_i == null || _i.next != _h);
    }

    public function next():T {
        if (_i == null) _i = _h;
        else _i = _i.next;
        return _i.data;
    }
}
