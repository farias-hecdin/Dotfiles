package main
import "fmt"

/* Suma tres numeros
 * @param {int} a, b, c - Ingresa un numero
 */
func sumarTresNumeros(a, b, c int) int {
    return a + b + c
}

func main() {
    num1 = 5
    num2 = 10
    num3 := 15

    resultado := sumarTresNumeros(num1, num2, num3)

    fmt.Printf("La suma de %d, %d y %d es: %d\n", num1, num2, num3, resultado)
}

