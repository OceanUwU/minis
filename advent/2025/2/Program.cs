using System.Text;
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
            if (len < 2) continue;
            List<int> factors = [1];
            int max = (int)Math.Sqrt(len);
            for (int j = 2; j <= max; j++)
                if (len % j == 0) {
                    factors.Add(j);
                    if (j != len / j)
                        factors.Add(len / j);
                }
            foreach (int factor in factors)
                if (str == new StringBuilder(len).Insert(0, str[..factor], len/factor).ToString()) {
                    invalids.Add(i);
                    break;
                }
        }
        return invalids;
    }
}