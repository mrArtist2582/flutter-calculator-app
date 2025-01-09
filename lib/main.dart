import 'package:flutter/material.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = '0';
  String _output = '0';
  double? num1;
  double? num2;
  String operand = '';
  String operation = '';

  void buttonPress(String buttonText) {
    try {
      if (buttonText == "C") {
        
        clearCalculator();
      } else if ("+-*/".contains(buttonText)) {
        
        if (_output.isNotEmpty && num1 == null) {
          num1 = double.tryParse(_output) ?? 0.0;
          operand = buttonText;
          _output = '';
          operation = "${formatNumber(num1!)} $operand";
        }
      } else if (buttonText == "=") {
        
        if (_output.isNotEmpty && num1 != null) {
          num2 = double.tryParse(_output) ?? 0.0;
          calculateResult();
        }
      } else {
        
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        operation += buttonText;
      }

     
      setState(() {
        if (_output.isNotEmpty) {
          double value = double.tryParse(_output) ?? 0.0;
          output = formatNumber(value);
        }
      });
    } catch (e) {
    
      setState(() {
        output = "Error";
      });
    }
  }

  void clearCalculator() {
    _output = '0';
    output = '0';
    num1 = null;
    num2 = null;
    operand = '';
    operation = '';
  }

  void calculateResult() {
    double result;
    switch (operand) {
      case '+':
        result = num1! + num2!;
        break;
      case '-':
        result = num1! - num2!;
        break;
      case '*':
        result = num1! * num2!;
        break;
      case '/':
        result = num2 != 0 ? num1! / num2! : double.nan;
        break;
      default:
        result = 0.0;
        break;
    }

    if (result.isNaN || result.isInfinite) {
      output = "Error";
      operation = "Error";
    } else {
      _output = result.toString();
      operation = "${formatNumber(num1!)} $operand ${formatNumber(num2!)}";
      output = formatNumber(result);
    }

    num1 = null;
    num2 = null;
    operand = '';
  }

  String formatNumber(double value) {
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: [
          
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
              operation,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          ),
          
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton("7", Colors.grey[800]!),
                  buildButton("8", Colors.grey[800]!),
                  buildButton("9", Colors.grey[800]!),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey[800]!),
                  buildButton("5", Colors.grey[800]!),
                  buildButton("6", Colors.grey[800]!),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey[800]!),
                  buildButton("2", Colors.grey[800]!),
                  buildButton("3", Colors.grey[800]!),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton(".", Colors.grey[800]!),
                  buildButton("0", Colors.grey[800]!),
                  buildButton("C", Colors.red),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("=", Colors.green),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            buttonPress(buttonText);
          },
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
