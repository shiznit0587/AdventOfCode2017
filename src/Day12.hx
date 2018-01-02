import haxe.ds.GenericStack;

class Day12 {

    private var graph:Map<Int, Array<Int>> = new Map();
    private var masterVisited:Map<Int, Bool> = new Map();

    public function new() {
        neko.Lib.println("Running Day 12 - a");

        FileUtil.readInput("12", function (line) {
            var list:Array<String> = line.split(" ").map(Strings.trim.bind(_, ","));
            graph[Std.parseInt(list[0])] = list.slice(2).map(Std.parseInt);
        });

        var visited:Map<Int, Bool> = visitGroup(0);

        neko.Lib.println('Num Programs = ${Maps.size(visited)}');
        neko.Lib.println("Running Day 12 - b");

        var groupHead:Null<Int> = findUnvisitedNode();
        var groupCount:Int = 0;

        while (groupHead != null) {
            visited = visitGroup(groupHead);
            groupHead = findUnvisitedNode();
            ++groupCount;

            for (a in visited.keys()) {
                masterVisited[a] = true;
            }
        }

        neko.Lib.println('Num Groups = $groupCount');
    }

    private function findUnvisitedNode():Null<Int> {
        for (a in graph.keys()) {
            if (!masterVisited.exists(a)) {
                return a;
            }
        }
        return null;
    }

    private function visitGroup(start:Int):Map<Int, Bool> {
        var stack:GenericStack<Int> = new GenericStack<Int>();
        stack.add(start);

        var visited:Map<Int, Bool> = new Map();

        while (!stack.isEmpty()) {
            var a:Int = stack.pop();
            visited[a] = true;

            for (b in graph[a]) {
                if (!visited.exists(b) && !Lambda.has(stack, b)) {
                    stack.add(b);
                }
            }
        }

        return visited;
    }
}
