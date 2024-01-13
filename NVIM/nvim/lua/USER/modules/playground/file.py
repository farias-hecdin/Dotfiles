def calculadora():
    num1 = float(input("Ingrese el primer número: "))
    num2 = float(input("Ingrese el segundo número: "))
    operacion = input("Ingrese la operación (+, -, *, /): ")

    if operacion == "+":
        resultado = num1 + num2
    elif operacion == "-":
        resultado = num1 - num2
    elif operacion == "*":
        resultado = num1 * num2
    elif operacion == "/":
        if num2 == 0:
            print("Error: Division por cero")
            return
        resultado = num1 / num2
    else:
        print("Error: Operación inválida")
        return

    print(num1, operacion, num2, "=", resultado)

calculadora()
