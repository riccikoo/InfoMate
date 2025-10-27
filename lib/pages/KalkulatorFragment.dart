import 'package:flutter/material.dart';

class KalkulatorFragment extends StatefulWidget {
  const KalkulatorFragment({super.key});

  @override
  State<KalkulatorFragment> createState() => _KalkulatorFragmentState();
}

class _KalkulatorFragmentState extends State<KalkulatorFragment> {
  String _display = '0';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = '';
  bool _isOperationPressed = false;
  bool _shouldResetDisplay = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_display == '0' || _isOperationPressed || _shouldResetDisplay) {
        _display = number;
        _isOperationPressed = false;
        _shouldResetDisplay = false;
      } else {
        _display += number;
      }
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _firstNumber = double.parse(_display);
      _operation = operation;
      _isOperationPressed = true;
    });
  }

  void _onEqualPressed() {
    setState(() {
      _secondNumber = double.parse(_display);
      
      switch (_operation) {
        case '+':
          _display = (_firstNumber + _secondNumber).toString();
          break;
        case '-':
          _display = (_firstNumber - _secondNumber).toString();
          break;
        case '×':
          _display = (_firstNumber * _secondNumber).toString();
          break;
        case '÷':
          _display = _secondNumber != 0
              ? (_firstNumber / _secondNumber).toString()
              : 'Error';
          break;
        case 'x²':
          _display = (_firstNumber * _firstNumber).toString();
          break;
        case '√':
          _display = _firstNumber >= 0
              ? (sqrt(_firstNumber)).toString()
              : 'Error';
          break;
      }
      
      // Hapus .0 jika hasilnya integer
      if (_display.endsWith('.0')) {
        _display = _display.substring(0, _display.length - 2);
      }
      
      _operation = '';
      _isOperationPressed = true;
      _shouldResetDisplay = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstNumber = 0;
      _secondNumber = 0;
      _operation = '';
      _isOperationPressed = false;
      _shouldResetDisplay = false;
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (_display.length > 1) {
        _display = _display.substring(0, _display.length - 1);
      } else {
        _display = '0';
      }
    });
  }

  void _onDecimalPressed() {
    setState(() {
      if (!_display.contains('.')) {
        _display += '.';
      }
    });
  }

  void _onSquarePressed() {
    setState(() {
      _firstNumber = double.parse(_display);
      _operation = 'x²';
      _onEqualPressed();
    });
  }

  void _onSquareRootPressed() {
    setState(() {
      _firstNumber = double.parse(_display);
      _operation = '√';
      _onEqualPressed();
    });
  }

  void _onPercentagePressed() {
    setState(() {
      double number = double.parse(_display);
      _display = (number / 100).toString();
      _shouldResetDisplay = true;
    });
  }

  // Fungsi akar kuadrat manual
  double sqrt(double number) {
    if (number < 0) return double.nan;
    if (number == 0) return 0;
    
    double guess = number / 2;
    for (int i = 0; i < 20; i++) {
      guess = (guess + number / guess) / 2;
    }
    return guess;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3DAD9),
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$_firstNumber $_operation',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _display,
                        style: const TextStyle(
                          color: Color(0xFF37353E),
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Calculator Buttons
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    // Row 1
                    _buildCalculatorButton('C', const Color(0xFFA5A5A5), Colors.black, _onClearPressed),
                    _buildCalculatorButton('⌫', const Color(0xFFA5A5A5), Colors.black, _onDeletePressed),
                    _buildCalculatorButton('%', const Color(0xFFA5A5A5), Colors.black, _onPercentagePressed),
                    _buildCalculatorButton('÷', const Color(0xFF715A5A), Colors.white, () => _onOperationPressed('÷')),
                    
                    // Row 2
                    _buildCalculatorButton('7', const Color(0xFF333333), Colors.white, () => _onNumberPressed('7')),
                    _buildCalculatorButton('8', const Color(0xFF333333), Colors.white, () => _onNumberPressed('8')),
                    _buildCalculatorButton('9', const Color(0xFF333333), Colors.white, () => _onNumberPressed('9')),
                    _buildCalculatorButton('×', const Color(0xFF715A5A), Colors.white, () => _onOperationPressed('×')),
                    
                    // Row 3
                    _buildCalculatorButton('4', const Color(0xFF333333), Colors.white, () => _onNumberPressed('4')),
                    _buildCalculatorButton('5', const Color(0xFF333333), Colors.white, () => _onNumberPressed('5')),
                    _buildCalculatorButton('6', const Color(0xFF333333), Colors.white, () => _onNumberPressed('6')),
                    _buildCalculatorButton('-', const Color(0xFF715A5A), Colors.white, () => _onOperationPressed('-')),
                    
                    // Row 4
                    _buildCalculatorButton('1', const Color(0xFF333333), Colors.white, () => _onNumberPressed('1')),
                    _buildCalculatorButton('2', const Color(0xFF333333), Colors.white, () => _onNumberPressed('2')),
                    _buildCalculatorButton('3', const Color(0xFF333333), Colors.white, () => _onNumberPressed('3')),
                    _buildCalculatorButton('+', const Color(0xFF715A5A), Colors.white, () => _onOperationPressed('+')),
                    
                    // Row 5
                    _buildCalculatorButton('x²', const Color(0xFF333333), Colors.white, _onSquarePressed),
                    _buildCalculatorButton('0', const Color(0xFF333333), Colors.white, () => _onNumberPressed('0')),
                    _buildCalculatorButton('√', const Color(0xFF333333), Colors.white, _onSquareRootPressed),
                    _buildCalculatorButton('=', const Color(0xFF715A5A), Colors.white, _onEqualPressed),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorButton(String text, Color backgroundColor, Color textColor, VoidCallback onPressed) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}