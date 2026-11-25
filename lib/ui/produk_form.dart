import 'package:flutter/material.dart';
import 'package:flutter1/bloc/produk_bloc.dart';
import 'package:flutter1/model/produk.dart';
import 'package:flutter1/ui/produk_page.dart';
import 'package:flutter1/widget/success_dialog.dart';
import 'package:flutter1/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  final Produk? produk;

  const ProdukForm({super.key, this.produk});

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUK";
  String tombolSubmit = "SIMPAN";

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  @override
  void didUpdateWidget(covariant ProdukForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.produk != widget.produk) {
      isUpdate();
    }
  }

  @override
  void dispose() {
    _kodeProdukTextboxController.dispose();
    _namaProdukTextboxController.dispose();
    _hargaProdukTextboxController.dispose();
    super.dispose();
  }

  void isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk ?? '';
        _namaProdukTextboxController.text = widget.produk!.namaProduk ?? '';
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk?.toString() ?? '';
      });
    } else {
      judul = "TAMBAH PRODUK";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                const SizedBox(height: 16),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Kode Produk
  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Produk"),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Nama Produk
  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Produk"),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox Harga Produk
  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Harga harus diisi";
        }
        if (int.tryParse(value) == null) {
          return "Harga harus berupa angka";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return _isLoading
        ? const CircularProgressIndicator()
        : OutlinedButton(
            child: Text(tombolSubmit),
            onPressed: () {
              var validate = _formKey.currentState!.validate();
              if (validate) {
                if (!_isLoading) {
                  if (widget.produk != null) {
                    ubah();
                  } else {
                    simpan();
                  }
                }
              }
            },
          );
  }

  void simpan() async {
    setState(() {
      _isLoading = true;
    });

    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text.trim();
    createProduk.namaProduk = _namaProdukTextboxController.text.trim();
    createProduk.hargaProduk =
        int.tryParse(_hargaProdukTextboxController.text.trim());

    try {
      await ProdukBloc.addProduk(produk: createProduk);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => SuccessDialog(
          description: "Data berhasil ditambahkan",
          okClick: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ProdukPage()),
              (route) => false,
            );
          },
        ),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }
  }

  void ubah() async {
    setState(() {
      _isLoading = true;
    });

    Produk updateProdukModel = Produk(id: widget.produk!.id);
    updateProdukModel.kodeProduk = _kodeProdukTextboxController.text.trim();
    updateProdukModel.namaProduk = _namaProdukTextboxController.text.trim();
    updateProdukModel.hargaProduk =
        int.tryParse(_hargaProdukTextboxController.text.trim());

    try {
      await ProdukBloc.updateProduk(produk: updateProdukModel);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => SuccessDialog(
          description: "Data berhasil diubah",
          okClick: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const ProdukPage()),
              (route) => false,
            );
          },
        ),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }
  }
}
