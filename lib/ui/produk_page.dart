import 'package:flutter/material.dart';
import 'package:flutter1/bloc/logout_bloc.dart';
import 'package:flutter1/bloc/produk_bloc.dart';
import 'package:flutter1/model/produk.dart';
import 'package:flutter1/ui/login_page.dart';
import 'package:flutter1/ui/produk_detail.dart';
import 'package:flutter1/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late Future<List<Produk>> _futureProduk;

  @override
  void initState() {
    super.initState();
    _refreshProduk();
  }

  void _refreshProduk() {
    setState(() {
      _futureProduk = ProdukBloc.getProduks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProdukForm()),
                );
                _refreshProduk();
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List<Produk>>(
        future: _futureProduk,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Terjadi kesalahan: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _refreshProduk,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada data produk'),
            );
          }
          return ListProduk(
            list: snapshot.data,
            onRefresh: _refreshProduk,
          );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List<Produk>? list;
  final VoidCallback? onRefresh;

  const ListProduk({super.key, this.list, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemProduk(
          produk: list![i],
          onRefresh: onRefresh,
        );
      },
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  final VoidCallback? onRefresh;

  const ItemProduk({super.key, required this.produk, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
        if (onRefresh != null) {
          onRefresh!();
        }
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk ?? ''),
          subtitle: Text("Rp. ${produk.hargaProduk ?? 0}"),
        ),
      ),
    );
  }
}
