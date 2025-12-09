using Rect = (Point a, Point b, long area);

public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Point[] points = [..text.Split('\n').Where(static l => l != "").Select(static l => new Point([..l.Split(',').Select(int.Parse)]))];
        List<Rect> rects = [];
        for (int i = 0; i < points.Length - 1; i++) {
            for (int j = i + 1; j < points.Length; j++) {
                rects.Add(points[i].Rect(points[j]));
            }
        }
        Console.WriteLine(rects.OrderByDescending(static r => r.area).First());
    }
}

public record Point(int X, int Y) {
    public Point(int[] coords) : this(coords[0], coords[1]) {}

    public Rect Rect(Point b) => (this, b, (long)(Math.Abs(b.X - X) + 1) * (Math.Abs(b.Y - Y) + 1));
}