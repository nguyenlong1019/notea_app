import 'package:flutter/material.dart';
import 'package:note_app/app_state.dart';
import 'package:note_app/screens/main_screen.dart';
import 'package:note_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  @override 
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<ApplicationState>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF0D92F4),
                fontSize: 36,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32,),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: const Color(0xFF0D92F4),
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Image.asset('assets/note.png', width: 50, height: 50, fit: BoxFit.cover,),
              ),
            ),
            const SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.email,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24,),
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 20,),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 11, 94, 153),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () async {
                    String result = await appState.signIn(emailController.text, passwordController.text);
                    if (result != 'Success') {
                      setState(() {
                        errorMessage = result;
                      });
                    } else {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (BuildContext context) => const MainScreen()),
                      );
                    }
                  }, 
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24,),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute<void>(builder: (BuildContext context) => const RegisterScreen())
                );
              }, 
              child: const Text('Don\'t have an account? Register here'),
            ),
          ],
        ),
      ),
    );
  }
}