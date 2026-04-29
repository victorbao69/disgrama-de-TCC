import 'package:flutter/material.dart';
import 'tela1.dart';
import 'Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFF7F4EE),
      ),
      home: SplashScreen(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  static const Color _marromEscuro = Color(0xFF5F3A1A);
  static const Color _marromMedio = Color(0xFF8B5E3C);
  static const Color _bege = Color(0xFFF7F4EE);
  static const Color _begeClaro = Color(0xFFF7E9D4);
  static const Color _cinzaMedio = Color(0xFFB4B2A9);
  static const Color _cinzaBorda = Color(0xFFD3D1C7);

  void _tentarLogar() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Tela1()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bege,
      body: Column(
        children: [
          // ── Hero ──────────────────────────────────────────────
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_marromEscuro, _marromMedio],
              ),
            ),
            padding: const EdgeInsets.fromLTRB(28, 60, 28, 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _begeClaro,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _marromEscuro, width: 3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bem-vindo\nde volta.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF7E9D4),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Acesse sua conta para continuar',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFD4B896),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),

          // ── Formulário ────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('E-MAIL'),
                  const SizedBox(height: 6),
                  _buildField(
                    hint: 'seu@email.com',
                    icon: Icons.mail_outline_rounded,
                    obscure: false,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('SENHA'),
                  const SizedBox(height: 6),
                  _buildField(
                    hint: '••••••••',
                    icon: Icons.lock_outline_rounded,
                    obscure: true,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _tentarLogar,
                      icon: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Color(0xFFF7E9D4),
                      ),
                      label: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF7E9D4),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _marromEscuro,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Color(0xFF888780),
        letterSpacing: 0.8,
      ),
    );
  }

  Widget _buildField({
    required String hint,
    required IconData icon,
    required bool obscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFD3D1C7)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFFB4B2A9)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscure,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C2C2A),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFFB4B2A9),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}