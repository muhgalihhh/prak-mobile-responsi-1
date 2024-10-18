import 'package:aplikasimanajemenbuku/bloc/registrasi_bloc.dart';
import 'package:aplikasimanajemenbuku/widget/success_dialog.dart';
import 'package:aplikasimanajemenbuku/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _namaTextboxController.dispose();
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2626), // Dark green background
      appBar: AppBar(
        title: const Text("Registrasi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1A3A3A), // Slightly lighter dark green
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      _namaTextField(),
                      const SizedBox(height: 24),
                      _emailTextField(),
                      const SizedBox(height: 24),
                      _passwordTextField(),
                      const SizedBox(height: 24),
                      _passwordKonfirmasiTextField(),
                      const SizedBox(height: 40),
                      _buttonRegistrasi(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[500]!),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[500]!),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[500]!),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Konfirmasi Password",
        labelStyle:
            TextStyle(color: Colors.green[300]), // Lighter green for label
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[400]!),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[500]!),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const Text(
          "Registrasi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for button
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600], // Darker green for button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate && !_isLoading) _submit();
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    RegistrasiBloc.registrasi(
      nama: _namaTextboxController.text,
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => SuccessDialog(
          description: "Registrasi berhasil, silahkan login",
          okClick: () {
            Navigator.pop(context);
          },
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Registrasi gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
