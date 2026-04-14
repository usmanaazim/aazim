import java.util.*;

public class PlayfairCipher {

    private static char[][] matrix = new char[5][5];
    private static Map<Character, int[]> map = new HashMap<>();

    public static void generateMatrix(String key) {
        key = key.toUpperCase().replaceAll("[^A-Z]", "").replace("J", "I");
        Set<Character> used = new LinkedHashSet<>();

        for (char c : key.toCharArray()) {
            used.add(c);
        }

        for (char c = 'A'; c <= 'Z'; c++) {
            if (c != 'J') {
                used.add(c);
            }
        }

        Iterator<Character> it = used.iterator();
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                matrix[i][j] = it.next();
                map.put(matrix[i][j], new int[]{i, j});
            }
        }
    }

    public static String prepareText(String text) {
        text = text.toUpperCase().replaceAll("[^A-Z]", "").replace("J", "I");
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < text.length(); i++) {
            sb.append(text.charAt(i));
            if (i + 1 < text.length() && text.charAt(i) == text.charAt(i + 1)) {
                sb.append('X');
            }
        }

        if (sb.length() % 2 != 0) {
            sb.append('X');
        }

        return sb.toString();
    }

    public static String encrypt(String text) {
        StringBuilder cipher = new StringBuilder();

        for (int i = 0; i < text.length(); i += 2) {
            char a = text.charAt(i);
            char b = text.charAt(i + 1);

            int[] posA = map.get(a);
            int[] posB = map.get(b);

            if (posA[0] == posB[0]) { // Same row
                cipher.append(matrix[posA[0]][(posA[1] + 1) % 5]);
                cipher.append(matrix[posB[0]][(posB[1] + 1) % 5]);
            } else if (posA[1] == posB[1]) { // Same column
                cipher.append(matrix[(posA[0] + 1) % 5][posA[1]]);
                cipher.append(matrix[(posB[0] + 1) % 5][posB[1]]);
            } else { // Rectangle
                cipher.append(matrix[posA[0]][posB[1]]);
                cipher.append(matrix[posB[0]][posA[1]]);
            }
        }
        return cipher.toString();
    }

    public static String decrypt(String text) {
        StringBuilder plain = new StringBuilder();

        for (int i = 0; i < text.length(); i += 2) {
            char a = text.charAt(i);
            char b = text.charAt(i + 1);

            int[] posA = map.get(a);
            int[] posB = map.get(b);

            if (posA[0] == posB[0]) { // Same row
                plain.append(matrix[posA[0]][(posA[1] + 4) % 5]);
                plain.append(matrix[posB[0]][(posB[1] + 4) % 5]);
            } else if (posA[1] == posB[1]) { // Same column
                plain.append(matrix[(posA[0] + 4) % 5][posA[1]]);
                plain.append(matrix[(posB[0] + 4) % 5][posB[1]]);
            } else { // Rectangle
                plain.append(matrix[posA[0]][posB[1]]);
                plain.append(matrix[posB[0]][posA[1]]);
            }
        }
        return plain.toString();
    }

    public static void printMatrix() {
        System.out.println("\nPlayfair Matrix:");
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter Key: ");
        String key = sc.nextLine();

        generateMatrix(key);
        printMatrix();

        System.out.print("\nEnter Plain Text: ");
        String text = sc.nextLine();

        String preparedText = prepareText(text);
        String encrypted = encrypt(preparedText);

        System.out.println("Encrypted Text: " + encrypted);

        String decrypted = decrypt(encrypted);
        System.out.println("Decrypted Text: " + decrypted);

        sc.close();
    }
}
