public class Program {
    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        Machine[] machines = [..text
            .Split('\n')
            .Where(static l => l != "")
            .Select(static l => l.Split(' '))
            .Select(static l => new Machine(l[0], l[1..^1], l[^1]))];
        Console.WriteLine(machines.Sum(static m => m.ShortestConfigurationLength()));
    }
}

public record Machine {
    private readonly bool[] goal;
    private readonly int[][] buttons;
    private readonly int[] requirements;

    public Machine(string goal, string[] buttons, string requirements) {
        this.goal = [..goal[1..^1].Select(static @char => @char == '#')];
        this.buttons = [..buttons.Select(static b => (int[])[..b[1..^1].Split(',').Select(int.Parse)])];
        this.requirements = [..requirements[1..^1].Split(',').Select(int.Parse)];
    }

    public int ShortestConfigurationLength() => ShortestConfiguration().Count(static b => b);
    public bool[] ShortestConfiguration() => CorrectConfigurations().MinBy(static c => c.Count(static b => b)) ?? [];

    public bool[][] CorrectConfigurations() {
        List<bool[]> configurations = [];
        GetAllConfigs(new bool[buttons.Length], configurations, 0);
        return [..configurations];

        List<bool[]> GetAllConfigs(bool[] config, List<bool[]> configurations, int index) {
            bool[] a = [..config];
            a[index] = true;
            if (ConfigIsCorrect(config))
                configurations.Add(config);
            if (ConfigIsCorrect(a))
                configurations.Add(a);
            if (index < config.Length - 1) {
                GetAllConfigs(config, configurations, index + 1);
                GetAllConfigs(a, configurations, index + 1);
            }
            return configurations;
        }
    }

    private bool ConfigIsCorrect(bool[] config) {
        bool[] lights = new bool[goal.Length];
        for (int i = 0; i < config.Length; i++)
            if (config[i])
                foreach (int light in buttons[i])
                    lights[light] = !lights[light];
        return goal.SequenceEqual(lights);
    }
}