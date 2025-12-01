class Program {
    const int STARTING_DIAL_POSITION = 50;
    const int NUM_DIAL_POSITIONS = 100;

    static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        IEnumerable<int> rotations = text
            .Split("\n")
            .Where(static l => l != "")
            .Select(static l => int.Parse(l[1..]) * (l[0] == 'L' ? -1 : 1));
        Console.WriteLine(CountRestsAtZero(rotations));
        Console.WriteLine(CountPassesofZero(rotations));
    }

    static int CountRestsAtZero(IEnumerable<int> rotations) {
        int dial = STARTING_DIAL_POSITION;
        int rests = 0;
        foreach (int r in rotations) {
            dial = Mod(dial + r, NUM_DIAL_POSITIONS);
            if (dial == 0)
                rests++;
        }
        return rests;
    }

    static int CountPassesofZero(IEnumerable<int> rotations) {
        int dial = STARTING_DIAL_POSITION;
        int passes = 0;
        foreach (int r in rotations) {
            if (r == 0) continue;
            if (dial == 0 && r < 0)
                passes--;
            dial += r;
            passes += Math.Abs(dial / NUM_DIAL_POSITIONS) + (dial <= 0 ? 1 : 0);
            dial = Mod(dial, NUM_DIAL_POSITIONS);
        }
        return passes;
    }

    static int Mod(int x, int y) => (x % y + y) % y;
}