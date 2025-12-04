public class Program {
    private const int MaxAdjacentRolls = 3;
    private static readonly int[][] ToCheck = [
        [-1, -1],
        [0, -1],
        [1, -1],
        [1, 0],
        [1, 1],
        [0, 1],
        [-1, 1],
        [-1, 0],
    ];

    private static void Main(string[] args) {
        StreamReader reader = new(args[0]);
        string text = reader.ReadToEnd();
        bool[][] rolls = [..text
            .Split('\n')
            .Where(static line => line != "")
            .Select(static line => line.Select(static c => c == '@').ToArray())];
        Console.WriteLine(CountAccessible(rolls));
    }

    private static int CountAccessible(bool[][] rolls) {
        int accessible = 0;
        for (int x = 0; x < rolls.Length; x++)
            for (int y = 0; y < rolls[0].Length; y++)
                if (IsAccessible(rolls, x, y))
                    accessible++;
        return accessible;
    }


    private static bool IsAccessible(bool[][] rolls, int x, int y) {
        if (!rolls[x][y])
            return false;
        int adjacent = 0;
        foreach (int[] dir in ToCheck) {
            int checkX = x + dir[0], checkY = y + dir[1];
            if (checkX < 0 || checkY < 0 || checkX >= rolls[0].Length || checkY >= rolls.Length)
                continue;
            if (rolls[checkX][checkY] && ++adjacent > MaxAdjacentRolls)
                return false;
        }
        return true;
    }
}