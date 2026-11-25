import 'package:flutter/material.dart';
import 'package:flutter1/bloc/produk_bloc.dart';
import 'package:flutter1/model/produk.dart';
import 'package:flutter1/ui/produk_form.dart';
import 'package:flutter1/ui/produk_page.dart';
import 'package:flutter1/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  const ProdukDetail({super.key, this.produk});

  @override
  State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "Kode : ${widget.produk?.kodeProduk ?? '-'}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk?.namaProduk ?? '-'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk?.hargaProduk?.toString() ?? '0'}",
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () async {
            Navigator.pop(context); // menutup dialog konfirmasi
            try {
              await ProdukBloc.deleteProduk(id: widget.produk?.id);
              if (!mounted) return;
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ProdukPage()),
                (route) => false,
              );
            } catch (error) {
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) => const WarningDialog(
                  description: "Hapus data gagal, silahkan coba lagi",
                ),
              );
            }
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
