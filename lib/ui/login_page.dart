import 'package:aplikasimanajemenbuku/bloc/login_bloc.dart';
import 'package:aplikasimanajemenbuku/helpers/user_info.dart';
import 'package:aplikasimanajemenbuku/ui/buku_page.dart';
import 'package:aplikasimanajemenbuku/ui/registrasi_page.dart';
import 'package:aplikasimanajemenbuku/widget/success_dialog.dart'; // Import dialog sukses
import 'package:aplikasimanajemenbuku/widget/warning_dialog.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
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
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2626), // Dark green background
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1A3A3A), // Slightly lighter dark green
        elevation: 0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: child,
              );
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      _emailTextField(),
                      const SizedBox(height: 16),
                      _passwordTextField(),
                      const SizedBox(height: 40),
                      _buttonLogin(),
                      const SizedBox(height: 16),
                      _menuRegistrasi(),
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Red border for error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Format email tidak valid';
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Red border for error
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(color: Colors.white), // White text color
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password harus diisi";
        } else if (value.length < 6) {
          return "Password minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Times New Roman',
            color: Colors.white, // White text for button
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[600], // Darker green for button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5, // Add some elevation for a better look
      ),
      onPressed: () {
        if (_formKey.currentState!.validate() && !_isLoading) {
          _submit();
        } else {
          // Jika form tidak valid, tampilkan SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Periksa kembali input Anda'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        await UserInfo().setToken(value.token.toString());
        await UserInfo().setUserID(int.parse(value.userID.toString()));

        // Menampilkan dialog sukses
        _showSuccessDialog('Login berhasil!').then((_) {
          // Pindah ke halaman BukuPage setelah dialog ditutup
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BukuPage()),
          );
        });
      } else {
        _showWarningDialog("Login gagal, silahkan coba lagi");
      }
    }, onError: (error) {
      print(error);
      _showWarningDialog("Login gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WarningDialog(
        description: message,
      ),
    );
  }

  Future<void> _showSuccessDialog(String description) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SuccessDialog(
          description: description,
          okClick: () {},
        );
      },
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: Text(
          "Registrasi",
          style: TextStyle(
            color: Colors.green[300], // Lighter green for registration text
            fontSize: 16,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
