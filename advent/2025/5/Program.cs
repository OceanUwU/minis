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
        Console.WriteLine(CountRanges(fresh));
        //Console.WriteLine(string.Join('\n', MergeRanges(fresh).OrderBy(r => r.Min).Select(r => $"{r.Min}-{r.Max}")));
    }

    private static Range[] MergeRanges(Range[] ranges) {
        List<Range> newRanges = [];
        foreach (Range range in ranges) {
            Range r = range;
            while (newRanges.FirstOrDefault(r2 => RangesOverlapOrAreAdjacent(r, r2), (-1,-1)) is Range overlap && overlap != (-1, -1)) {
                r = (Math.Min(r.Min, overlap.Min), Math.Max(r.Max, overlap.Max));
                newRanges.Remove(overlap);
            }
            newRanges.Add(r);
        }
        return [..newRanges];
    }

    private static long CountRanges(Range[] ranges)
        => MergeRanges(ranges)
            .Sum(static r => r.Max - r.Min + 1);

    private static int CountFresh(Range[] fresh, long[] ids)
        => ids.Count(i => IsFresh(fresh, i));

    private static bool IsFresh(Range[] fresh, long id)
        => fresh.Any(r => WithinRange(r, id));

    private static bool WithinRange(Range range, long n) => n >= range.Min && n <= range.Max;
    private static bool WithinOrAdjacentToRange(Range range, long n) => n + 1 >= range.Min && n - 1 <= range.Max;
    private static bool RangesOverlapOrAreAdjacent(Range a, Range b)
        => WithinRange(a, b.Min) || WithinRange(a, b.Max)
        || WithinRange(b, a.Min) || WithinOrAdjacentToRange(b, a.Max);
}