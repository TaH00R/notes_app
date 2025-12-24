import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/validators.dart';
import 'package:notes_app/pages/recover_page.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:notes_app/widgets/note_icon_widget.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController registrationController;
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  late final TextEditingController usernameController = TextEditingController();

  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    registrationController = context.read();
  }

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Selector<RegistrationController, bool>(
                selector: (_, controller) => controller.isRegisterMode,
                builder: (context, isRegisterMode, child) => Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        isRegisterMode ? 'Register' : 'Sign In',
                        style: GoogleFonts.pacifico(fontSize: 48, color: primary),
                      ),
                      SizedBox(height: 16),
                      Text(
                        isRegisterMode ? 'In order to sync your notes across devices, please register an account.' : 'Welcome back! Please sign in to continue.',
                      ),
                      SizedBox(height: 40),
                      if (isRegisterMode) ...[
                        NoteFormField(
                          labelText: 'Username',
                          tagController: usernameController,
                          fillColor: white,
                          filled: true,
                          validator: Validators.nameValidator,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          onChanged: (value){
                            registrationController.username = value;
                          },
                        ),
                        SizedBox(height: 8),
                      ],
                      NoteFormField(
                        labelText: 'Email',
                        tagController: emailController,
                        fillColor: white,
                        filled: true,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.emailValidator,
                        onChanged: (value){
                          registrationController.email = value;
                        },
                      ),
                      SizedBox(height: 8),
                      Selector<RegistrationController,bool>(
                        selector: (_, controller) => controller.isPasswordVisible,
                        builder:(_, isPasswordVisible, __) => NoteFormField(
                          tagController: passwordController,
                          labelText: 'Password',
                          obscureText: !isPasswordVisible,
                          fillColor: white,
                          filled: true, 
                          validator: Validators.passValidator,
                          suffixIcon: GestureDetector(
                            onTap: (){
                              registrationController.isPasswordVisible = !isPasswordVisible;
                            },
                            child: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off)),
                          onChanged: (value){
                            registrationController.password = value;
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      if (!isRegisterMode) ...[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecoverPage()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                      ],
                      Selector<RegistrationController,bool>(
                        selector: (_, controller) => controller.isLoading,
                        builder: (_, isLoading, __) => isLoading ? SizedBox(
                          width : 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: white,)) 
                          : NoteButton(
                          onPressed: isLoading? null : () {
                            if(formKey.currentState?.validate() ?? false){
                              registrationController.authenticateWithEmailAndPassword(context: context);
                            }
                          },
                          child: Text(isRegisterMode ? 'Create my account' : 'Log me in'),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(isRegisterMode ? 'Or register with' : 'Or sign in with'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: NotesIconButton(
                              icon: FontAwesomeIcons.google,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: NotesIconButton(
                              icon: Icons.facebook,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      Text.rich(
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = (){
                            context.read<RegistrationController>().isRegisterMode = !isRegisterMode;
                          },
                          text: isRegisterMode ? 'Already have an account? ' : "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: isRegisterMode ? 'Sign In' : 'Register',
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
