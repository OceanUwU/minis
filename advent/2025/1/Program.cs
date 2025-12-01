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
        int dial = STARTING_DIAL_POSITION;
        int timesStoppedAtZero = 0;
        foreach (int r in rotations) {
            dial = ((dial + r) % NUM_DIAL_POSITIONS + NUM_DIAL_POSITIONS) % NUM_DIAL_POSITIONS;
            if (dial == 0)
                timesStoppedAtZero++;
        }
        Console.WriteLine(timesStoppedAtZero);
    }
}