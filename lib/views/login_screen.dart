import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tahu_nih/services/auth_service.dart';
import 'package:tahu_nih/views/register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'news@itg.ac.id');
  final _passwordController = TextEditingController(text: 'ITG#news');
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _login() async {
    print('--- Tombol Login Ditekan! Proses _login() dimulai. ---');

    setState(() {
      _isLoading = true;
    });

    print('Mencoba memanggil Provider.of<AuthService>...');

    try {
      await Provider.of<AuthService>(
        context,
        listen: false,
      ).login(_emailController.text, _passwordController.text);
      print('Pemanggilan AuthService.login() selesai tanpa error langsung.');
    } catch (error, stackTrace) {
      // BLOK INI AKAN JALAN JIKA ADA ERROR
      print('--- TERJADI ERROR SAAT MENCOBA LOGIN! ---');
      print('TIPE ERROR: ${error.runtimeType}');
      print('PESAN ERROR: $error');
      print('STACK TRACE:');
      print(stackTrace);
      print('-------------------------------------------');

      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Login Gagal'),
              content: Text(error.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      await Provider.of<AuthService>(
        context,
        listen: false,
      ).login(email, password);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF3EDED),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 32.0),
                child: const Center(
                  child: Text(
                    'Selamat Datang !',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: const Center(
                  child: Text(
                    'Selamat datang Di aplikasi',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Username
              TextField(
                controller: _emailController,
                decoration: inputDecoration.copyWith(
                  hintText: 'Masukan Username',
                ),
              ),
              const SizedBox(height: 24),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: inputDecoration.copyWith(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Tambahkan navigasi ke halaman reset password jika ada
                  },
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 139, 172, 243),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 64),

              // Regis Now
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Regist Now',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
