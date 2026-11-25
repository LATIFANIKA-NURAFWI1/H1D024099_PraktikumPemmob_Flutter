import 'package:flutter/material.dart';
import 'package:flutter1/bloc/login_bloc.dart';
import 'package:flutter1/helpers/user_info.dart';
import 'package:flutter1/ui/produk_page.dart';
import 'package:flutter1/ui/registrasi_page.dart';
import 'package:flutter1/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  void dispose() {
    _emailTextboxController.dispose();
    _passwordTextboxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                _passwordTextField(),
                const SizedBox(height: 16),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  // Membuat Textbox Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Login
  Widget _buttonLogin() {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () {
              var validate = _formKey.currentState!.validate();
              if (validate) {
                if (!_isLoading) _submit();
              }
            },
            child: const Text("Login"),
          );
  }

  void _submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final value = await LoginBloc.login(
        email: _emailTextboxController.text.trim(),
        password: _passwordTextboxController.text,
      );

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      if (value.code == 200 && value.token != null) {
        await UserInfo().setToken(value.token!);
        if (value.userID != null) {
          await UserInfo().setUserID(value.userID!);
        }
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProdukPage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    }
  }

  // Membuat menu untuk membuka halaman registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Colors.blue),
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
