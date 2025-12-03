public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Bank[] banks = [..text.Split('\n').Where(static s => s != "").Select(static s => new Bank(s))];
        Console.WriteLine(TotalJoltage(banks));
    }

    private static int TotalJoltage(Bank[] banks) => banks.Sum(static b => b.MaxJoltage());
}

public class Bank(string batteries) {
    private const int NUM_BATTERIES_ON = 2;
    private readonly string batteries = batteries;

    public int MaxJoltage() {
        int[] best = new int[NUM_BATTERIES_ON];
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
        return int.Parse(new string([..best.Order().Select(index => batteries[index])]));
    }
}