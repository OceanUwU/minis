using Connection = (Point a, Point b, double distance);

public class Program {
    private const int NumPairs = 1000;
    private const int NumCircuits = 3;

    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Point[] points = [..text.Split('\n').Where(static l => l != "").Select(static l => new Point([..l.Split(',').Select(int.Parse)]))];
        List<Connection> connections = [];
        for (int i = 0; i < points.Length - 1; i++)
            connections.AddRange(points[i].Connections(points[(i+1)..]));
        connections = [..connections.OrderBy(static c => c.distance)];
        Console.WriteLine(Connect(points, [..connections.Take(NumPairs)]).circuits.Select(static c => c.Count).OrderDescending().Take(NumCircuits).Aggregate(1, (a, b) => a * b));
        var final = Connect(points, connections).final;
        Console.WriteLine((long)final.a.X * final.b.X);
    }

    private static (List<List<Point>> circuits, Connection final) Connect(Point[] points, List<Connection> connections) {
        List<List<Point>> circuits = [..points.Select(static p => new List<Point>([p]))];
        Connection final = connections[0];
        foreach (Connection connection in connections) {
            var circuitA = circuits.First(c => c.Any(p => p == connection.a));
            var circuitB = circuits.First(c => c.Any(p => p == connection.b));
            if (circuitA == circuitB) continue;
            final = connection;
            circuits.Remove(circuitB);
            circuitA.AddRange(circuitB);
            if (circuits.Count == 1)
                break;
        }
        return (circuits, final);
    }
}

public record Point(int X, int Y, int Z) {
    public Point(int[] coords) : this(coords[0], coords[1], coords[2]) {}

    public double DistanceSquaredTo(Point p) => Math.Pow(p.X - X, 2) + Math.Pow(p.Y - Y, 2) + Math.Pow(p.Z - Z, 2);
    //public double DistanceTo(Point p) => Math.Sqrt(DistanceSquaredTo(p));
    //public Point Closest(IEnumerable<Point> others) => others.MinBy(DistanceSquaredTo) ?? new(0,0,0);
    public Connection[] Connections(IEnumerable<Point> others) => [..others.Select(p => (this, p, DistanceSquaredTo(p)))];

    public override string ToString() => $"X:{X} Y:{Y} Z:{Z}";
}