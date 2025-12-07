public class Program {
    private const char
        Start = 'S',
        Empty = '.',
        Beam = '|',
        Splitter = '^';

    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        char[][] lines = [..text.Split('\n').Where(static l => l != "").Select(static l => l.ToCharArray())];
        int[] beams = [Array.IndexOf(lines[0], Start)];
        int splits = 0;
        for (int i = 1; i < lines.Length; i++) {
            char[] line = lines[i];
            foreach (int b in beams) {
                switch (line[b]) {
                    case Beam:
                        break;
                    case Empty:
                        line[b] = Beam;
                        break;
                    case Splitter:
                        splits++;
                        line[b-1] = Beam;
                        line[b+1] = Beam;
                        break;
                }
            }
            beams = [..Enumerable.Range(0, line.Length - 1).Where(j => line[j] == Beam)];
        }
        Console.WriteLine(string.Join('\n', lines.Select(static l => new string(l))));
        Console.WriteLine(splits);
    }
}