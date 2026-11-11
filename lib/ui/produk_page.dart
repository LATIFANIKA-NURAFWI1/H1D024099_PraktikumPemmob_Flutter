import 'package:flutter/material.dart';
import 'package:flutter1/ui/produk_detail.dart';
import 'package:flutter1/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              child: const Icon(Icons.add),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProdukForm(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: const [
          ItemProduk(
            kodeProduk: 'KBL01',
            namaProduk: 'Kulkas',
            harga: 30000,
          ),
          ItemProduk(
            kodeProduk: 'PS01',
            namaProduk: 'Playstation',
            harga: 30000,
          ),
          ItemProduk(
            kodeProduk: 'RD01',
            namaProduk: 'Radio',
            harga: 30000,
          ),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final String? kodeProduk;
  final String? namaProduk;
  final int? harga;

  const ItemProduk({super.key, this.kodeProduk, this.namaProduk, this.harga});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              kodeProduk: kodeProduk ?? '',
              namaProduk: namaProduk ?? '',
              hargaProduk: harga ?? 0,
            ),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(namaProduk ?? ''),
          subtitle: Text(harga.toString()),
        ),
      ),
    );
  }
}