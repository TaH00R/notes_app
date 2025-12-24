import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/constants.dart';
import 'package:notes_app/core/dialogs.dart';
import 'package:notes_app/services/auth_service.dart';

class RegistrationController extends ChangeNotifier{
  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value){
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;
  set isPasswordVisible(bool value){
    _isPasswordVisible = value;
    notifyListeners();
  }

  String _userName = '';
  set username(String value){
    _userName = value;
    notifyListeners();
  }
  String get userName => _userName.trim();

  String _email = '';
  set email(String value){
    _email = value;
    notifyListeners();
  }
  String get email => _email.trim();

  String _password = '';
  set password(String value){
    _password = value;
    notifyListeners();
  }
  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword({required BuildContext context}) async {
    isLoading = true;
  try {
    if (isRegisterMode) {
      await AuthService.register(
        username: userName,
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      showMessageDialog(context: context, message: 'Registration successful! Please verify your email before logging in.');

    if(!context.mounted) return;
    while(!AuthService.isEmailVerified){
    await Future.delayed(const Duration(seconds: 5),()=> AuthService.user?.reload());
    }} 
    else {
      await AuthService.login(
        email: email,
        password: password,
      );
    }
  } on FirebaseAuthException catch (e) {
    if(!context.mounted) return;
    showMessageDialog(context: context, message: authExceptionMapper[e.code] ?? 'Authentication error');
  } catch (e) {
    if(!context.mounted) return;
    throw 'Something went wrong';
  }
  finally {
    isLoading = false;
  }
}
Future<void> resetPassword({required BuildContext context, required String email}) async {
  isLoading = true;
  try {
    await AuthService.resetPassword(email: email);
    if(!context.mounted) return;
    showMessageDialog(context: context, message: 'Password reset email sent. Please check your inbox.');
  } on FirebaseAuthException catch (e) {
    if(!context.mounted) return;
    showMessageDialog(context: context, message: authExceptionMapper[e.code] ?? 'Error sending password reset email');
  } catch (e) {
    if(!context.mounted) return;
    showMessageDialog(context: context, message: 'Something went wrong');
  } finally {
    isLoading = false;
  }
}
}