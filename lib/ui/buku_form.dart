import 'package:aplikasimanajemenbuku/bloc/buku_bloc.dart';
import 'package:aplikasimanajemenbuku/model/buku.dart';
import 'package:aplikasimanajemenbuku/ui/buku_page.dart';
import 'package:aplikasimanajemenbuku/widget/success_dialog.dart';
import 'package:aplikasimanajemenbuku/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BukuForm extends StatefulWidget {
  Buku? buku;
  BukuForm({Key? key, this.buku}) : super(key: key);

  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Buku";
  String tombolSubmit = "Simpan";

  // Controllers for form fields
  final _totalPagesController = TextEditingController();
  final _paperTypeController = TextEditingController();
  final _dimensionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.buku != null) {
      setState(() {
        judul = "Ubah Buku";
        tombolSubmit = "Ubah";
        _totalPagesController.text = widget.buku!.totalPages.toString();
        _paperTypeController.text = widget.buku!.paperType!;
        _dimensionsController.text = widget.buku!.dimensions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2626), // Dark green background
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A3A3A), // Dark green for AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _totalPagesTextField(),
                const SizedBox(height: 16),
                _paperTypeTextField(),
                const SizedBox(height: 16),
                _dimensionsTextField(),
                const SizedBox(height: 40),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox untuk Jumlah Halaman
  Widget _totalPagesTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Jumlah Halaman",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[400]!), // More visible border
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[500]!), // Brighter when focused
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Red border for error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red), // Red border when focused on error
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.book, color: Colors.white), // Add icon
      ),
      keyboardType: TextInputType.number,
      controller: _totalPagesController,
      style: const TextStyle(color: Colors.white), // White text color
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah Halaman harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Tipe Kertas
  Widget _paperTypeTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tipe Kertas",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[400]!), // More visible border
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[500]!), // Brighter when focused
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Red border for error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red), // Red border when focused on error
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon:
            const Icon(Icons.description, color: Colors.white), // Add icon
      ),
      keyboardType: TextInputType.text,
      controller: _paperTypeController,
      style: const TextStyle(color: Colors.white), // White text color
      validator: (value) {
        if (value!.isEmpty) {
          return "Tipe Kertas harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Textbox untuk Dimensi Buku
  Widget _dimensionsTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Dimensi",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[400]!), // More visible border
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.green[500]!), // Brighter when focused
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Red border for error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.red), // Red border when focused on error
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon:
            const Icon(Icons.crop_square, color: Colors.white), // Add icon
      ),
      keyboardType: TextInputType.text,
      controller: _dimensionsController,
      style: const TextStyle(color: Colors.white), // White text color
      validator: (value) {
        if (value!.isEmpty) {
          return "Dimensi harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.buku != null) {
              // Kondisi update buku
              ubah();
            } else {
              // Kondisi tambah buku
              simpan();
            }
          }
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:
            const Color(0xFF1A3A3A), // Warna yang sama dengan BukuPage
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // Fungsi untuk menyimpan buku baru
  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Buku newBuku = Buku(
      id: null,
      totalPages: int.parse(_totalPagesController.text),
      paperType: _paperTypeController.text,
      dimensions: _dimensionsController.text,
    );

    BukuBloc.addBuku(buku: newBuku).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const SuccessDialog(
          description: "Data berhasil disimpan",
        ),
      ).then((_) {
        // Navigasi setelah dialog ditutup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => const BukuPage()),
        );
      });
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Fungsi untuk mengubah data buku
  void ubah() {
    setState(() {
      _isLoading = true;
    });

    Buku updatedBuku = Buku(
      id: widget.buku!.id,
      totalPages: int.parse(_totalPagesController.text),
      paperType: _paperTypeController.text,
      dimensions: _dimensionsController.text,
    );

    BukuBloc.updateBuku(buku: updatedBuku).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const SuccessDialog(
          description: "Data berhasil diubah",
        ),
      ).then((_) {
        // Navigasi setelah dialog ditutup
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) => const BukuPage()),
        );
      });
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
