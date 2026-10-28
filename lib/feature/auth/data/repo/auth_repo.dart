import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static const String _webClientId =
      '568441967080-ciaam99cs88083qgkl70tnamsvgua48a.apps.googleusercontent.com';
  static Future<void>? _googleInit;

  Future<void> _initGoogle() {
    return _googleInit ??= GoogleSignIn.instance.initialize(
      serverClientId: _webClientId,
    );
  }

  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = UserModel(
      uid: credential.user!.uid,
      username: name,
      email: email,
    );

    await credential.user!.updateDisplayName(name);
    await firestore.collection('users').doc(user.uid).set(user.toMap());

    return credential;
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> googleSignIn() async {
    await _initGoogle();

    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;

    if (idToken == null) {
      throw FirebaseAuthException(
        code: 'missing-id-token',
        message: 'No ID Token found.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);

    final result = await auth.signInWithCredential(credential);

    if (result.additionalUserInfo?.isNewUser ?? false) {
      final firebaseUser = result.user!;
      final user = UserModel(
        uid: firebaseUser.uid,
        username: firebaseUser.displayName ?? '',
        email: firebaseUser.email ?? '',
      );
      await firestore.collection('users').doc(user.uid).set(user.toMap());
    }

    return result;
  }

  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await auth.signOut();
  }

  Future<UserModel?> getProfile() async {
    final userId = auth.currentUser!.uid;

    final snapshot = await firestore.collection('profiles').doc(userId).get();
    final data = snapshot.data();

    if (data == null) return null;
    return UserModel.fromMap(data);
  }
}
