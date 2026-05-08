import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../models/user_model.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}

class AuthService {
  AuthService._();

  static final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static bool get isSignedIn => _auth.currentUser != null;

  static Future<UserModel?> loadCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      return null;
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      final data = snapshot.data();
      if (data != null) {
        return UserModel.fromJson(data);
      }
    } catch (_) {
      // Firebase Auth still has the signed-in user, so keep the profile usable.
    }

    return UserModel(
      name: firebaseUser.displayName ?? 'PetGuardian User',
      email: firebaseUser.email ?? '',
    );
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = name.trim();

    if (normalizedName.isEmpty) {
      throw const AuthException('Please enter your name.');
    }
    _validateEmailAndPassword(normalizedEmail, password);

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      await credential.user?.updateDisplayName(normalizedName);

      final user = UserModel(name: normalizedName, email: normalizedEmail);
      await _firestore.collection('users').doc(credential.user!.uid).set({
        ...user.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return user;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(_messageForFirebaseError(error));
    } catch (_) {
      throw const AuthException('Unable to create account right now.');
    }
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    _validateEmailAndPassword(normalizedEmail, password);

    try {
      await _auth.signInWithEmailAndPassword(
        email: normalizedEmail,
        password: password,
      );
      final user = await loadCurrentUser();
      if (user == null) {
        throw const AuthException('Unable to load user profile.');
      }
      return user;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(_messageForFirebaseError(error));
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static void _validateEmailAndPassword(String email, String password) {
    if (!email.contains('@') || !email.contains('.')) {
      throw const AuthException('Please enter a valid email.');
    }
    if (password.length < 6) {
      throw const AuthException('Password must be at least 6 characters.');
    }
  }

  static String _messageForFirebaseError(
    firebase_auth.FirebaseAuthException error,
  ) {
    return switch (error.code) {
      'email-already-in-use' => 'This email is already registered.',
      'invalid-email' => 'Please enter a valid email.',
      'weak-password' => 'Password must be at least 6 characters.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'Email or password is incorrect.',
      'network-request-failed' => 'Check your internet connection.',
      _ => error.message ?? 'Authentication failed. Please try again.',
    };
  }
}
