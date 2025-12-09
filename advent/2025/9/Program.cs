using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;

using Rect = (Point a, Point b, long area);

public class Program : Game {
#pragma warning disable IDE0052
    private readonly GraphicsDeviceManager _graphics;
#pragma warning restore IDE0052
    private SpriteBatch _spriteBatch;

    private readonly Point[] points;
    private readonly Line[] lines;
    private readonly List<Rect> rects = [];
    private readonly Rect displayedRect;
    private Texture2D? t;

    private static void Main(string[] args) {
        new Program(args).Run();
    }

#pragma warning disable CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.
    public Program(string[] args) {
        _graphics = new(this) {
            PreferredBackBufferHeight = 1000,
            PreferredBackBufferWidth = 1000
        };
        //Content.RootDirectory = "Content";
        IsMouseVisible = true;
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        points = [..text.Split('\n').Where(static l => l != "").Select(static l => new Point([..l.Split(',').Select(int.Parse)]))];
        lines = [..Enumerable.Range(0, points.Length - 1).Select(i => new Line(points[i], points[i+1])), new Line(points[^1], points[0])];
        for (int i = 0; i < points.Length - 1; i++)
            for (int j = i + 1; j < points.Length; j++)
                rects.Add(points[i].Rect(points[j]));

        //displayedRect = rects.OrderByDescending(static r => r.area).First(); // part 1
        displayedRect = rects.OrderByDescending(static r => r.area).First(r => lines.All(l => !l.Intersects(r)));
        Console.WriteLine(displayedRect);
    }
#pragma warning restore CS8618 // Non-nullable field must contain a non-null value when exiting constructor. Consider adding the 'required' modifier or declaring as nullable.

    protected override void LoadContent() {
        _spriteBatch = new(GraphicsDevice);
        t = new Texture2D(GraphicsDevice, 1, 1);
        t.SetData([Color.White]);// fill the texture with white
    }

    protected override void Draw(GameTime gameTime) {
        GraphicsDevice.Clear(Color.CornflowerBlue);

        _spriteBatch.Begin();
        foreach (Line l in lines)
            DrawLine(_spriteBatch, l.A, l.B, Color.White);
        DrawLine(_spriteBatch, displayedRect.a, new Point(displayedRect.a.X, displayedRect.b.Y), Color.Red);
        DrawLine(_spriteBatch, new Point(displayedRect.a.X, displayedRect.b.Y), displayedRect.b, Color.Red);
        DrawLine(_spriteBatch, displayedRect.b, new Point(displayedRect.b.X, displayedRect.a.Y), Color.Red);
        DrawLine(_spriteBatch, new Point(displayedRect.b.X, displayedRect.a.Y), displayedRect.a, Color.Red);
        _spriteBatch.End();

        base.Draw(gameTime);
    }

    // https://gamedev.stackexchange.com/a/44016
    void DrawLine(SpriteBatch sb, Vector2 start, Vector2 end, Color colour) {
        Vector2 edge = end - start;
        sb.Draw(t, new((int)start.X, (int)start.Y, (int)edge.Length(), 1), null, colour, (float)Math.Atan2(edge.Y , edge.X), new(0, 0), SpriteEffects.None, 0);
    }
}

public record Point(int X, int Y) {
    public Point(int[] coords) : this(coords[0], coords[1]) {}

    public Rect Rect(Point b) => (
        new Point(Math.Min(X, b.X), Math.Min(Y, b.Y)),
        new Point(Math.Max(X, b.X), Math.Max(Y, b.Y)),
        (long)(Math.Abs(b.X - X) + 1) * (Math.Abs(b.Y - Y) + 1)
    );

    public static implicit operator Vector2(Point p) => new Vector2(p.X, p.Y) * 0.01f;
}

public record Line(Point A, Point B) {
    public bool Horizontal = A.Y == B.Y; 

    public bool Intersects(Rect rect) => Horizontal ? (
        A.Y > rect.a.Y && A.Y < rect.b.Y
        && (
            (A.X > rect.a.X && A.X < rect.b.X)
            || (B.X > rect.a.X && B.X < rect.b.X)
            || (A.X <= rect.a.X && B.X >= rect.b.X)
        )
    ) : (
        A.X > rect.a.X && A.X < rect.b.X
        && (
            (A.Y > rect.a.Y && A.Y < rect.b.Y)
            || (B.Y > rect.a.Y && B.Y < rect.b.Y)
            || (A.Y <= rect.a.Y && B.Y >= rect.b.Y)
        )
    );
}