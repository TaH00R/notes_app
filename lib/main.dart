import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/change_notifiers/notes_provider.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/pages/homepage.dart';
import 'package:notes_app/pages/registration_page.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => NotesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RegistrationController(),
    )], 
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primary),
          fontFamily: GoogleFonts.poppins().toString(),
          scaffoldBackgroundColor: background,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: GoogleFonts.fredoka().toString(),
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: [
          FlutterQuillLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      
        supportedLocales: const [
          Locale('en'), // English (required)
        ],
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, asyncSnapshot) {
            return asyncSnapshot.hasData && AuthService.isEmailVerified ? const Homepage() : const RegistrationPage();
          }
        ),
      ),
    );
  }
}
