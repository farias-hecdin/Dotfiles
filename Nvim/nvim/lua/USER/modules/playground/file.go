package main

import (
    "fmt"
)

func main() {
    var num1, num2 float64
    var operacion string

    fmt.Print("Ingrese el primer número: ")
    fmt.Scan(&num1)

    fmt.Print("Ingrese el segundo número: ")
    fmt.Scan(&num2)

    fmt.Print("Ingrese la operación (+, -, *, /): ")
    fmt.Scan(&operacion)

    switch operacion {
    case "+":
        fmt.Printf("%.2f + %.2f = %.2f\n", num1, num2, num1+num2)
    case "-":
        fmt.Printf("%.2f - %.2f = %.2f\n", num1, num2, num1-num2)
    case "*":
        fmt.Printf("%.2f * %.2f = %.2f\n", num1, num2, num1*num2)
    case "/":
        if num2 == 0 {
            fmt.Println("Error: Division por cero")
        } else {
            fmt.Printf("%.2f / %.2f = %.2f\n", num1, num2, num1/num2)
        }
    default:
        fmt.Println("Error: Operación inválida")
    }
}

