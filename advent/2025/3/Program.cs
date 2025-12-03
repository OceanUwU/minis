public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Bank[] banks = [..text.Split('\n').Where(static s => s != "").Select(static s => new Bank(s))];
        Console.WriteLine(TotalJoltage(banks, 12));
    }

    private static long TotalJoltage(Bank[] banks, int numBatteries) => banks.Sum(b => b.MaxJoltage(numBatteries));
}

public class Bank(string batteries) {
    private readonly string batteries = batteries;

    public long MaxJoltage(int numBatteries) {
        int[] best = new int[numBatteries];
        for (int i = 0; i < best.Length; i++)
            best[i] = -1;
        for (int i = 0; i < batteries.Length; i++) {
            if (best[^1] != -1 && batteries[best[^1]] > batteries[i]) continue;
            best[^1] = i;
            for (int j = best.Length - 1; j >= Math.Max(1, i - batteries.Length + 1 + best.Length); j--) {
                if (best[j - 1] != -1 && batteries[best[j]] <= batteries[best[j - 1]]) break;
                best[j - 1] = best[j];
                best[j] = -1;
            }
        }
        return long.Parse(new string([..best.Order().Select(index => batteries[index])]));
    }
}