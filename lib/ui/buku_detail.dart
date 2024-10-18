import 'package:flutter/material.dart';

import '/ui/buku_form.dart';
import '../model/buku.dart';

// ignore: must_be_immutable
class BukuDetail extends StatefulWidget {
  Buku? buku;
  BukuDetail({Key? key, this.buku}) : super(key: key);
  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2626), // Warna latar belakang
      appBar: AppBar(
        title: const Text('Detail Buku', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A3A3A), // Warna AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color(0xFF1A3A3A), // Warna card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Sudut melengkung
            ),
            elevation: 4, // Efek bayangan
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailContainer(
                      Icons.book, "ID Buku: ${widget.buku!.id}"),
                  _buildDetailContainer(Icons.pages,
                      "Jumlah Halaman: ${widget.buku!.totalPages}"),
                  _buildDetailContainer(Icons.description,
                      "Tipe Kertas: ${widget.buku!.paperType}"),
                  _buildDetailContainer(
                      Icons.crop_square, "Dimensi: ${widget.buku!.dimensions}"),
                  _buildDetailContainer(Icons.access_time,
                      "Dibuat Pada: ${widget.buku!.createdAt}"),
                  _buildDetailContainer(Icons.update,
                      "Diperbarui Pada: ${widget.buku!.updatedAt}"),
                  const SizedBox(height: 20),
                  _tombolHapusEdit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat bungkus detail dengan ikon
  Widget _buildDetailContainer(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0), // Margin lebih banyak
      padding: const EdgeInsets.all(12.0), // Padding dalam kontainer
      decoration: BoxDecoration(
        color: const Color(0xFF2A4B4B), // Warna latar belakang kontainer
        borderRadius: BorderRadius.circular(8.0), // Sudut melengkung
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white), // Ikon untuk detail
          const SizedBox(width: 8.0), // Jarak antara ikon dan teks
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 18.0, color: Colors.white), // Warna teks putih
            ),
          ),
        ],
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Rata tengah
      children: [
        // Tombol Edit
        OutlinedButton.icon(
          icon: const Icon(Icons.edit, color: Colors.white), // Ikon Edit
          label: const Text("EDIT", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BukuForm(
                  buku: widget.buku!,
                ),
              ),
            );
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3A3A), // Warna tombol
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Padding tombol
          ),
        ),

        // Tombol Hapus
        OutlinedButton.icon(
          icon: const Icon(Icons.delete, color: Colors.white), // Ikon Delete
          label: const Text("DELETE", style: TextStyle(color: Colors.white)),
          onPressed: () => confirmHapus(),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3A3A), // Warna tombol
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Padding tombol
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: Row(
        children: const [
          Icon(Icons.warning, color: Colors.red, size: 24), // Ikon peringatan
          SizedBox(width: 8), // Jarak antara ikon dan teks
          Text("Konfirmasi Hapus",
              style: TextStyle(color: Colors.black)), // Judul dialog
        ],
      ),
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya", style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Logika penghapusan
            Navigator.pop(context); // Close the dialog after deletion
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3A3A), // Warna tombol
          ),
        ),

        // Tombol batal
        OutlinedButton(
          child: const Text("Batal", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3A3A), // Warna tombol
          ),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
