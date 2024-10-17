import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/app_state.dart';
import 'package:note_app/screens/login_screen.dart';
import 'package:note_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD4AEuCXx5glu6Q36-Y31iFeeVZqXp-1zk', 
      appId: '1:38835094563:android:a29bc169f7b3c30e381d96', 
      messagingSenderId: '38835094563', 
      projectId: 'diary-app-11cff',
    )
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'Note App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.light(
                surface: Colors.grey.shade100,
                onSurface: Colors.black,
                primary: const Color(0xFF00B2E7),
                secondary: const Color(0xFFE064F7),
                tertiary: const Color(0xFFFF8D6C),
                outline: Colors.grey,
              )
            ),
            home: appState.loggedIn == true ? const MainScreen() : const LoginScreen(),
          );
        },
      ),
    );
  }
}