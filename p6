import java.util.*;

public class TranspositionCipher {

    static Integer[] getOrder(String key) {
        Integer[] order = new Integer[key.length()];
        for (int i = 0; i < key.length(); i++) order[i] = i;

        Arrays.sort(order, Comparator.comparingInt(i -> key.charAt(i)));
        return order;
    }

    static String singleEncrypt(String text, String key) {
        int cols = key.length();
        int rows = (int) Math.ceil((double) text.length() / cols);

        char[][] matrix = new char[rows][cols];

        int k = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (k < text.length())
                    matrix[i][j] = text.charAt(k++);
                else
                    matrix[i][j] = 'X';
            }
        }

        Integer[] order = getOrder(key);

        StringBuilder cipher = new StringBuilder();
        for (int i : order) {
            for (int j = 0; j < rows; j++) {
                cipher.append(matrix[j][i]);
            }
        }

        return cipher.toString();
    }

    static String singleDecrypt(String cipher, String key) {
        int cols = key.length();
        int rows = cipher.length() / cols;

        char[][] matrix = new char[rows][cols];
        Integer[] order = getOrder(key);

        int k = 0;

        for (int i : order) {
            for (int j = 0; j < rows; j++) {
                matrix[j][i] = cipher.charAt(k++);
            }
        }


        StringBuilder text = new StringBuilder();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                text.append(matrix[i][j]);
            }
        }

        return text.toString();
    }

    static String doubleEncrypt(String text, String key1, String key2) {
        return singleEncrypt(singleEncrypt(text, key1), key2);
    }

    static String doubleDecrypt(String cipher, String key1, String key2) {
        return singleDecrypt(singleDecrypt(cipher, key2), key1);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("=== Transposition Cipher Program ===");
        System.out.println("1. Single Encryption and Decryption");
        System.out.println("2. Double Encryption and Decryption");
 	System.out.print("Enter your choice: ");
        int choice = sc.nextInt();
        sc.nextLine();

        System.out.print("Enter text: ");
        String text = sc.nextLine().toUpperCase().replaceAll(" ", "");

        switch (choice) {
            case 1:
                System.out.print("Enter key: ");
                String key1 = sc.nextLine().toUpperCase();
                String scp1=singleEncrypt(text, key1);
		System.out.println("Encrypted: " + scp1);
                System.out.println("Decrypted: " + singleDecrypt(scp1, key1));
                break;
            case 2:
                System.out.print("Enter first key: ");
                String k1 = sc.nextLine().toUpperCase();
                System.out.print("Enter second key: ");
                String k2 = sc.nextLine().toUpperCase();
		String cp1=doubleEncrypt(text, k1, k2);
                System.out.println("Encrypted: " +cp1);
                System.out.println("Decrypted: " + doubleDecrypt(cp1, k1, k2));
                break;
	    default:
                System.out.println("Invalid choice!");
        }
	
        sc.close();
	
    }
}
