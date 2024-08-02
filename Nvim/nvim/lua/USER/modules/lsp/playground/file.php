<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $num1 = floatval($_POST["num1"]);
    $num2 = floatval($_POST["num2"]);
    $operacion = $_POST["operacion"];

    switch ($operacion) {
        case '+':
            $resultado = $num1 + $num2;
            break;
        case '-':
            $resultado = $num1 - $num2;
            break;
        case '*':
            $resultado = $num1 * $num2;
            break;
        case '/':
            if ($num2 == 0) {
                echo "Error: Division por cero";
                return;
            }
            $resultado = $num1 / $num2;
            break;
        default:
        echo "Error: Operación inválida";
        return;
    }

    echo $num1, " ", $operacion, " ", $num2, " = ", $resultado;
}
?>
