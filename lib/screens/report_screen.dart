import 'package:flutter/material.dart';

class ReportDniScreen extends StatefulWidget {
  const ReportDniScreen({super.key});

  @override
  State<ReportDniScreen> createState() => _ReportDniScreenState();
}

class _ReportDniScreenState extends State<ReportDniScreen> {
  String _dniValue = "";
  bool _isAnonymous = true;
  bool _isKeyboardVisible = false; 
  late List<String> _randomKeys;

  @override
  void initState() {
    super.initState();
    _generateRandomKeys();
  }

  void _generateRandomKeys() {
    List<String> numbers = List.generate(10, (index) => index.toString());
    numbers.shuffle();
    setState(() {
      _randomKeys = numbers;
    });
  }

  void _onKeyPressed(String value) {
    if (_dniValue.length < 8) {
      setState(() {
        _dniValue += value;
        
        if (_dniValue.length == 8) {
          _isKeyboardVisible = false;
        }
      });
    }
  }

  void _onBackspace() {
    if (_dniValue.isNotEmpty) {
      setState(() {
        _dniValue = _dniValue.substring(0, _dniValue.length - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // GestureDetector para detectar toques fuera del teclado y cerrarlo
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isKeyboardVisible = false;
          });
        },
        child: Column(
          children: [
            // --- HEADER (Igual que antes) ---
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              color: const Color(0xFF009688),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nuevo Reporte', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Paso 1 de 5', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Text('20%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 0.2,
                      backgroundColor: Colors.black12,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF6D3B)),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),

            // --- CONTENIDO SCROLLEABLE ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                child: Column(
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: const BoxDecoration(color: Color(0xFFE0F2F1), shape: BoxShape.circle),
                      child: const Center(child: Icon(Icons.badge, size: 40, color: Color(0xFF009688))),
                    ),
                    const SizedBox(height: 20),
                    const Text('Ingresa tu DNI', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      'Para garantizar reportes verificados y\nanónimos',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 30),

                    // --- INPUT DNI (DETECTA TAP) ---
                    GestureDetector(
                      onTap: () {
                        // Al tocar aquí, mostramos el teclado y mezclamos las teclas de nuevo si deseas
                        // _generateRandomKeys(); // Descomenta si quieres que cambien cada vez que se abre
                        setState(() {
                          _isKeyboardVisible = true;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            // Borde cambia de color si el teclado está activo
                            color: _isKeyboardVisible ? const Color(0xFF009688) : Colors.grey.shade200,
                            width: _isKeyboardVisible ? 2 : 1
                          ),
                          boxShadow: [
                             BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                          ]
                        ),
                        child: Center(
                          child: Text(
                            _dniValue.isEmpty ? '________' : _dniValue,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: _dniValue.isEmpty ? Colors.grey.shade300 : const Color(0xFF37474F),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isAnonymous,
                            activeColor: const Color(0xFFFF6D3B),
                            onChanged: (v) => setState(() => _isAnonymous = v!),
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text('Reporte anónimo (identidad protegida)', style: TextStyle(fontSize: 13)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity, height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción continuar
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6D3B),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        child: const Text('CONTINUAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- TECLADO ANIMADO (SLIDE UP/DOWN) ---
            AnimatedContainer(
              duration: const Duration(milliseconds: 300), // Velocidad de la animación
              curve: Curves.easeOutCubic, // Efecto suave
              height: _isKeyboardVisible ? 280 : 0, // Altura 0 cuando está oculto
              child: SingleChildScrollView( // Evita overflow de pixeles durante la animación
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  height: 280, // Altura fija del contenido interno
                  color: const Color(0xFFE0E0E0), // Fondo ligeramente más oscuro para el teclado
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Column(
                    children: [
                      _buildKeyRow(0, 3),
                      _buildKeyRow(3, 6),
                      _buildKeyRow(6, 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 90),
                          _buildKeyButton(_randomKeys[9]),
                          _buildBackspaceButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES DEL TECLADO ---

  Widget _buildKeyRow(int start, int end) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(end - start, (i) => _buildKeyButton(_randomKeys[start + i])),
      ),
    );
  }

  Widget _buildKeyButton(String val) {
    return Material(
      color: Colors.white,
      elevation: 2, // Sombra suave
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => _onKeyPressed(val),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5, // Ancho responsivo
          height: 50,
          alignment: Alignment.center,
          child: Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return Material(
      color: const Color(0xFFCFD8DC), // Color diferente para borrar
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: _onBackspace,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width / 3.5,
          height: 50,
          alignment: Alignment.center,
          child: const Icon(Icons.backspace_outlined, color: Colors.black54),
        ),
      ),
    );
  }
}