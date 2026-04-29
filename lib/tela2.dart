import 'package:flutter/material.dart';
import 'tela1.dart';

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  static const Color _marromEscuro = Color(0xFF5F3A1A);
  static const Color _bege = Color(0xFFF7F4EE);
  static const Color _cinzaTexto = Color(0xFF888780);
  static const Color _cinzaBorda = Color(0xFFE8E4DC);
  static const Color _textoEscuro = Color(0xFF2C2C2A);

  // Itens estáticos de exemplo — substitua por dados reais quando integrar
  static const List<Map<String, dynamic>> _itens = [
    {'nome': 'Sofá 3 lugares', 'descricao': 'Tecido linho', 'preco': 1899.90},
    {'nome': 'Cadeira estofada', 'descricao': 'Base de madeira', 'preco': 249.90},
  ];

  @override
  Widget build(BuildContext context) {
    final double total = _itens.fold(0, (s, i) => s + (i['preco'] as double));

    return Scaffold(
      backgroundColor: _bege,
      appBar: AppBar(
        backgroundColor: _marromEscuro,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFF7E9D4), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Carrinho',
          style: TextStyle(
            color: Color(0xFFF7E9D4),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Lista de itens ─────────────────────────────────────
          Expanded(
            child: _itens.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 48, color: Color(0xFFD3D1C7)),
                  const SizedBox(height: 12),
                  const Text(
                    'Seu carrinho está vazio',
                    style: TextStyle(
                        fontSize: 14, color: Color(0xFF888780)),
                  ),
                ],
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _itens.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => _ItemCarrinho(
                nome: _itens[i]['nome'],
                descricao: _itens[i]['descricao'],
                preco: _itens[i]['preco'],
                marromEscuro: _marromEscuro,
                cinzaTexto: _cinzaTexto,
                cinzaBorda: _cinzaBorda,
              ),
            ),
          ),

          // ── Rodapé ────────────────────────────────────────────
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              children: [
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF888780),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: _marromEscuro,
                          fontFamily: 'Georgia'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Botão finalizar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null, // não funciona por enquanto
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _marromEscuro,
                      disabledBackgroundColor: const Color(0xFFB4967A),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Finalizar compra',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF7E9D4)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Botão continuar comprando
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFD3D1C7)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Continuar comprando',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF5F5E5A)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Item do carrinho ─────────────────────────────────────────────────
class _ItemCarrinho extends StatelessWidget {
  final String nome;
  final String descricao;
  final double preco;
  final Color marromEscuro;
  final Color cinzaTexto;
  final Color cinzaBorda;

  const _ItemCarrinho({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.marromEscuro,
    required this.cinzaTexto,
    required this.cinzaBorda,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cinzaBorda),
      ),
      child: Row(
        children: [
          // Placeholder de imagem
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF5EFE6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.inventory_2_outlined,
                size: 24, color: marromEscuro.withOpacity(0.5)),
          ),
          const SizedBox(width: 12),

          // Nome e descrição
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2C2C2A)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  descricao,
                  style: TextStyle(fontSize: 11, color: cinzaTexto),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Preço
          Text(
            'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: marromEscuro,
                fontFamily: 'Georgia'),
          ),
        ],
      ),
    );
  }
}