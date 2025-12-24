import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/change_notifiers/registration_controller.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/validators.dart';
import 'package:notes_app/widgets/back_button.dart';
import 'package:notes_app/widgets/note_button.dart';
import 'package:notes_app/widgets/note_form_field.dart';
import 'package:provider/provider.dart';

class RecoverPage extends StatefulWidget {
  const RecoverPage({super.key});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const NoteBackButton(),
        title: Text('Recover Password', style: GoogleFonts.wellfleet()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: emailKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Don't worry! It happens.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                Selector<RegistrationController, bool>(
                  selector: (_, controller) => controller.isLoading,
                  builder: (context, isLoading, _) {
                    return isLoading
                        ? const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : NoteFormField(
                            tagController: emailController,
                            fillColor: white,
                            filled: true,
                            labelText: 'Email Address',
                            validator: Validators.emailValidator,
                          );
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 48,
                  child: NoteButton(
                    child: const Text('Send me the recovery link!'),
                    onPressed: () {
                      if (emailKey.currentState?.validate() ?? false) {
                        context.read<RegistrationController>().resetPassword(
                          context: context,
                          email: emailController.text.trim(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
