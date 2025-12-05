using Range = (long Min, long Max);

public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Range[] fresh = [..text
            .Split("\n\n")[0]
            .Split('\n')
            .Select(static l => {
                long[] nums = [..l.Split('-').Select(static n => long.Parse(n))];
                return (nums[0], nums[1]);
            })];
        long[] ids = [..text
            .Split("\n\n")[1]
            .Split('\n')
            .Where(l => l != "")
            .Select(static l => long.Parse(l))];
        Console.WriteLine(CountFresh(fresh, ids));
    }

    private static int CountFresh(Range[] fresh, long[] ids)
        => ids.Count(i => IsFresh(fresh, i));

    private static bool IsFresh(Range[] fresh, long id)
        => fresh.Any(r => id >= r.Min && id <= r.Max);
}