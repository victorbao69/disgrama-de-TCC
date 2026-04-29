import 'package:flutter/material.dart';
import 'tela2.dart';

// ── Modelo ───────────────────────────────────────────────────────────
class Produto {
  final String nome;
  final String descricao;
  final String descricaoLonga;
  final double preco;


  const Produto({
    required this.nome,
    required this.descricao,
    required this.descricaoLonga,
    required this.preco,

  });
}

// ── Produtos ─────────────────────────────────────────────────────────
const List<Produto> _produtos = [
  Produto(
    nome: 'Sofá 3 lugares',
    descricao: 'Tecido linho, confortável',
    descricaoLonga: 'Sofá de 3 lugares com revestimento em linho, estrutura reforçada e almofadas macias.',
    preco: 1899.90,

  ),
  Produto(
    nome: 'Mesa de jantar',
    descricao: 'Madeira maciça, 6 lugares',
    descricaoLonga: 'Mesa de jantar em madeira maciça com acabamento premium. Suporta até 6 pessoas.',
    preco: 1299.00,
  ),
  Produto(
    nome: 'Cadeira estofada',
    descricao: 'Base de madeira, tecido suede',
    descricaoLonga: 'Cadeira confortável com assento estofado em suede e base de madeira resistente.',
    preco: 249.90,
  ),
  Produto(
    nome: 'Guarda-roupa',
    descricao: '6 portas, espelho incluso',
    descricaoLonga: 'Guarda-roupa espaçoso com 6 portas, divisões internas e espelho frontal.',
    preco: 2199.00,

  ),
  Produto(
    nome: 'Rack para TV',
    descricao: 'Até 65", design moderno',
    descricaoLonga: 'Rack para TV com design moderno, suporta televisores de até 65 polegadas.',
    preco: 599.90,
  ),
];

// ── Cores ─────────────────────────────────────────────────────────────
const _marrom = Color(0xFF5F3A1A);
const _bege = Color(0xFFF7F4EE);
const _begeClaro = Color(0xFFF5EFE6);
const _cinzaBorda = Color(0xFFE8E4DC);
const _cinzaTexto = Color(0xFF888780);
const _textoEscuro = Color(0xFF2C2C2A);

// ── Tela 1 ────────────────────────────────────────────────────────────
class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  final List<Produto> _carrinho = [];

  void _adicionar(Produto p) {
    setState(() => _carrinho.add(p));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${p.nome} adicionado!'),
      duration: const Duration(seconds: 1),
      backgroundColor: _textoEscuro,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ));
  }

  void _verDetalhes(Produto p) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _Modal(
        produto: p,
        onAdicionar: () {
          Navigator.pop(context);
          _adicionar(p);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bege,
      appBar: AppBar(
        backgroundColor: _marrom,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFF7E9D4), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Catálogo',
            style: TextStyle(color: Color(0xFFF7E9D4), fontSize: 15,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Lista de produtos
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _produtos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 260,
              ),
              itemBuilder: (_, i) => _Card(
                produto: _produtos[i],
                onDetalhes: () => _verDetalhes(_produtos[i]),
                onAdicionar: () => _adicionar(_produtos[i]),
              ),
            ),
          ),

          // Botão carrinho
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const Tela2())),
            child: Container(
              color: _marrom,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const Center(
                child: Text('Ver carrinho',
                    style: TextStyle(color: Color(0xFFF7E9D4),
                        fontSize: 14, fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card ──────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final Produto produto;
  final VoidCallback onDetalhes;
  final VoidCallback onAdicionar;

  const _Card({
    required this.produto,
    required this.onDetalhes,
    required this.onAdicionar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _cinzaBorda),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(produto.nome,
                    style: const TextStyle(fontSize: 13,
                        fontWeight: FontWeight.w500, color: _textoEscuro),
                    maxLines: 1, overflow: TextOverflow.ellipsis),

                const SizedBox(height: 2),
                Text(produto.descricao,
                    style: const TextStyle(fontSize: 11, color: _cinzaTexto),
                    maxLines: 1, overflow: TextOverflow.ellipsis),

                const SizedBox(height: 6),
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w600, color: _marrom),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onDetalhes,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          side: const BorderSide(color: _cinzaBorda),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Detalhes',
                            style: TextStyle(fontSize: 11,
                                color: Color(0xFF5F5E5A))),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAdicionar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _marrom,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('+ Add',
                            style: TextStyle(fontSize: 11,
                                color: Color(0xFFF7E9D4))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Modal detalhes ────────────────────────────────────────────────────
class _Modal extends StatelessWidget {
  final Produto produto;
  final VoidCallback onAdicionar;

  const _Modal({required this.produto, required this.onAdicionar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _bege,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Text(produto.nome,
              style: const TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w600, color: _textoEscuro)),
          const SizedBox(height: 4),
          Text(produto.descricaoLonga,
              style: const TextStyle(fontSize: 13,
                  color: _cinzaTexto, height: 1.5)),
          const SizedBox(height: 12),
          Text(
            'R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
            style: const TextStyle(fontSize: 22,
                fontWeight: FontWeight.w600, color: _marrom),
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAdicionar,
              style: ElevatedButton.styleFrom(
                backgroundColor: _marrom,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Adicionar ao carrinho',
                  style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w500, color: Color(0xFFF7E9D4))),
            ),
          ),
        ],
      ),
    );
  }
}