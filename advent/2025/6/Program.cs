public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        string[] lines = [..text.Split('\n').Where(static l => l != "")];
        string operators = lines.Last();
        lines = [..lines.SkipLast(1)];
        List<Problem> horizontalProblems = [], verticalProblems = [];
        int problemStart = 0;
        void AddHorizontalProblem(int end) => horizontalProblems.Add(new(
            operators[problemStart],
            [..lines.Select(l => long.Parse(l[problemStart..end].Trim()))]
        ));
        void AddVerticalProblem(int end) => verticalProblems.Add(new(
            operators[problemStart],
            [..Enumerable.Range(problemStart, end - problemStart)
                .Reverse()
                .Select(i => new string([..lines.Select(l => l[i])]).Trim())
                .Where(n => !string.IsNullOrWhiteSpace(n))
                .Select(long.Parse)]
        ));
        for (int i = 1; i < operators.Length; i++) {
            if (operators[i] == ' ') continue;
            AddHorizontalProblem(i - 1);
            AddVerticalProblem(i - 1);
            problemStart = i;
        }
        AddHorizontalProblem(operators.Length);
        AddVerticalProblem(operators.Length);
        Console.WriteLine(horizontalProblems.Sum(static p => p.Result()));
        Console.WriteLine(verticalProblems.Sum(static p => p.Result()));
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