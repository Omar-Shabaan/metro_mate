import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit(this._repo) : super(AuthInitial());

  final AuthRepo _repo;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _repo.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'حدث خطأ، حاول مرة أخرى'));
    } catch (e) {
      emit(AuthError('حدث خطأ، حاول مرة أخرى'));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _repo.signIn(email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'حدث خطأ، حاول مرة أخرى'));
    } catch (e) {
      emit(AuthError('حدث خطأ، حاول مرة أخرى'));
    }
  }

  Future<void> googleSignIn() async {
    emit(AuthLoading());
    try {
      await _repo.googleSignIn();
      emit(AuthSuccess());
    } on GoogleSignInException catch (e) {
      debugPrint('Google error------------------------------------: ${e.code} ${e.description}');
      emit(AuthError('تعذر الدخول بواسطة Google، راجع إعدادات التطبيق'));
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase error--------------------------------: ${e.message}');
      emit(AuthError(e.message ?? 'تعذر الدخول بواسطة Google'));
    } catch (e) {
      debugPrint('Unknown error---------------------------------: $e');
      emit(AuthError('تعذر الدخول بواسطة Google'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _repo.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('حدث خطأ، حاول مرة أخرى'));
    }
  }
}
