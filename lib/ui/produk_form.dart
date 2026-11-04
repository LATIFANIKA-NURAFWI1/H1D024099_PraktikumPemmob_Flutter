import 'package:flutter/material.dart';
import 'package:flutter1/ui/produk_detail.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({super.key});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _kodeProdukController = TextEditingController();
  final _namaProdukController = TextEditingController();
  final _hargaProdukController = TextEditingController();

  @override
  void dispose() {
    _kodeProdukController.dispose();
    _namaProdukController.dispose();
    _hargaProdukController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Produk'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            _textboxKodeProduk(),
            _textboxNamaProduk(),
            _textboxHarga(),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  Widget _textboxKodeProduk() {
    return TextField(
      controller: _kodeProdukController,
      decoration: const InputDecoration(labelText: 'Kode Produk'),
    );
  }

  Widget _textboxNamaProduk() {
    return TextField(
      controller: _namaProdukController,
      decoration: const InputDecoration(labelText: 'Nama Produk'),
    );
  }

  Widget _textboxHarga() {
    return TextField(
      controller: _hargaProdukController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(labelText: 'Harga'),
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        // Navigasi ke halaman detail membawa data inputan
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              kodeProduk: _kodeProdukController.text,
              namaProduk: _namaProdukController.text,
              hargaProduk: int.tryParse(_hargaProdukController.text) ?? 0,
            ),
          ),
        );
      },
      child: const Text('Simpan'),
    );
  }
}