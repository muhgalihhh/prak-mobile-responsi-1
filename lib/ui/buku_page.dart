import 'package:aplikasimanajemenbuku/bloc/buku_bloc.dart';
import 'package:aplikasimanajemenbuku/bloc/logout_bloc.dart';
import 'package:aplikasimanajemenbuku/model/buku.dart';
import 'package:aplikasimanajemenbuku/ui/buku_detail.dart';
import 'package:aplikasimanajemenbuku/ui/buku_form.dart';
import 'package:aplikasimanajemenbuku/ui/login_page.dart'; // Import halaman login
import 'package:aplikasimanajemenbuku/widget/success_dialog.dart';
import 'package:flutter/material.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);

  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0D2626), // Warna latar belakang hijau gelap
      appBar: AppBar(
        title: const Text('List Buku',
            style: TextStyle(color: Colors.white)), // Teks putih
        backgroundColor: const Color(0xFF1A3A3A), // Warna hijau gelap
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add,
                  size: 26.0, color: Colors.white), // Ikon putih
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BukuForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor:
            const Color(0xFF0D2626), // Warna hijau lebih gelap untuk Drawer
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color:
                      const Color(0xFF1A3A3A)), // Warna latar belakang header
              accountName: const Text(
                'Aplikasi Manajemen Buku',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              accountEmail: const Text(
                'paket Jumlah_halaman - H1D022052',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: const Icon(Icons.book,
                    color: Color(0xFF1A3A3A)), // Ikon buku
              ),
            ),
            ListTile(
              title: const Text('Logout',
                  style: TextStyle(color: Colors.white)), // Teks putih
              trailing:
                  const Icon(Icons.logout, color: Colors.white), // Ikon putih
              onTap: () async {
                // Menampilkan dialog konfirmasi sebelum logout
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          const Icon(Icons.warning,
                              color: Colors.red), // Ikon peringatan
                          const SizedBox(
                              width: 8), // Spasi antara ikon dan teks
                          const Text('Konfirmasi Logout'),
                        ],
                      ),
                      content: const Text('Apakah Anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Batal'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Menutup dialog
                          },
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () async {
                            // Menutup dialog konfirmasi logout
                            Navigator.of(context).pop();

                            // Melakukan proses logout
                            try {
                              await LogoutBloc.logout();

                              // Pindah ke halaman login setelah logout berhasil
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginPage()), // Ganti dengan halaman login Anda
                                (route) => false,
                              );

                              // Menampilkan dialog sukses jika logout berhasil
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const SuccessDialog(
                                  description: "Logout berhasil",
                                ),
                              );
                            } catch (error) {
                              // Menampilkan dialog peringatan jika logout gagal
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Peringatan'),
                                    content: const Text(
                                        'Logout gagal, silakan coba lagi.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Menutup dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Buku>>(
        future: BukuBloc.getBuku(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBuku(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListBuku extends StatelessWidget {
  final List<Buku>? list;

  const ListBuku({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list == null || list!.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada buku tersedia',
          style: TextStyle(
              color: Colors.white, fontSize: 18), // Teks putih untuk pesan
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Menampilkan dua kolom
        childAspectRatio:
            1.3, // Rasio lebar dan tinggi (lebih kecil dari 1 untuk persegi panjang)
      ),
      itemCount: list!.length,
      itemBuilder: (context, i) {
        return ItemBuku(buku: list![i]);
      },
    );
  }
}

class ItemBuku extends StatelessWidget {
  final Buku buku;

  const ItemBuku({Key? key, required this.buku}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BukuDetail(buku: buku)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8), // Margin antara item
        child: Card(
          color: const Color(0xFF1A3A3A), // Warna latar belakang kartu
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.book,
                  size: 40, color: Colors.white), // Ikon buku
              const SizedBox(height: 10),
              Text(
                buku.totalPages.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18), // Teks putih dan ukuran lebih besar
              ),
              const SizedBox(height: 5),
              Text(
                buku.paperType ?? 'Unknown',
                style:
                    const TextStyle(color: Colors.white70), // Teks putih pudar
              ),
            ],
          ),
        ),
      ),
    );
  }
}
