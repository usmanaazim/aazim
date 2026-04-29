Import java.util.*;
Public class LCG {
Public static void main(String[] args) {
Scanner sc = new Scanner(System.in);
System.out.print(“Enter seed (X0): “);
Int seed = sc.nextInt();
System.out.print(“Enter multiplier (a): “);
Int a = sc.nextInt();
System.out.print(“Enter increment ©: “);
Int c = sc.nextInt();
System.out.print(“Enter modulus (m): “);
Int m = sc.nextInt();
System.out.print(“Enter number of random numbers to generate: “);
Int n = sc.nextInt();
Int X = seed;
System.out.println(“\nGenerated Pseudo Random Numbers:”);
For (int I = 0; I < n; i++) {
X = (a * X + c) % m;
System.out.println(“X” + (I + 1) + “ = “ + X); }
Sc.close(); } }
