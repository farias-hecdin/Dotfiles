import java.util.Scanner;

/** Calculadorax*/
public class File {

  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    double num1, num2;
    char operacion;

    System.out.print("Ingrese el primer número: ");
    num1 = scanner.nextDouble();

    System.out.print("Ingrese el segundo número: ");
    num2 = scanner.nextDouble();

    System.out.print("Ingrese la operación (+, -, *, /): ");
    operacion = scanner.next().charAt(0);

    switch (operacion) {
      case '+':
      System.out.printf("%.2f + %.2f = %.2f", num1, num2, num1 + num2);
      break;
      case '-':
      System.out.printf("%.2f - %.2f = %.2f", num1, num2, num1 - num2);
      break;
      case '*':
      System.out.printf("%.2f * %.2f = %.2f", num1, num2, num1 * num2);
      break;
      case '/':
      if (num2 == 0) {
        System.out.println("Error: Division por cero");
      } else {
        System.out.printf("%.2f / %.2f = %.2f", num1, num2, num1 / num2);
      }
      break;
      default:
      System.out.println("Error: Operación inválida");
    }

    scanner.close();
  }
}

