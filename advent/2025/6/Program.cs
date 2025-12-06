public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        string[] lines = [..text.Split('\n').Where(static l => l != "")];
        string operators = lines.Last();
        lines = [..lines.SkipLast(1)];
        List<Problem> problems = [];
        int problemStart = 0;
        void AddProblem(int end) => problems.Add(new(
            operators[problemStart],
            [..lines.Select(l => long.Parse(l[problemStart..end].Trim()))]
        ));
        for (int i = 1; i < operators.Length; i++) {
            if (operators[i] == ' ') continue;
            AddProblem(i - 1);
            problemStart = i;
        }
        AddProblem(operators.Length);
        Console.WriteLine(problems.Sum(static p => p.Result()));
    }
}

public class Problem(char @operator, long[] numbers) {
    private readonly char @operator = @operator;
    private readonly long[] numbers = numbers;

    public long Result() => @operator switch {
        '+' => numbers.Sum(),
        '*' => numbers.Aggregate(1, new Func<long, long, long>((a, b) => a * b)),
        _ => 0
    };
}