using Range = (long Min, long Max);

class Program {
    static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Range[] ranges = [..text
            .Split(',')
            .Select(static l => {
                long[] nums = [..l.Split('-').Select(static n => long.Parse(n))];
                return (nums[0], nums[1]);
            })];
        Console.WriteLine(GetInvalidIDsInRanges(ranges).Sum());
    }

    static List<long> GetInvalidIDsInRanges(Range[] ranges) {
        List<long> invalids = [];
        foreach (Range r in ranges)
            invalids.AddRange(GetInvalidIDsInRange(r));
        return invalids;
    }

    static List<long> GetInvalidIDsInRange(Range range) {
        List<long> invalids = [];
        for (long i = range.Min; i <= range.Max; i++) {
            string str = i.ToString();
            int len = str.Length;
            if (len % 2 == 1) continue;
            if (str[..(len/2)] == str[(len/2)..]) {
                invalids.Add(i);
                Console.WriteLine(i);
            }
        }
        return invalids;
    }
}