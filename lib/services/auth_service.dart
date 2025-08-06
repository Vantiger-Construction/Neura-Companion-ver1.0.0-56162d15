import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
  static User? get currentUser => _auth.currentUser;

  Future<void> signIn(String email, String pass) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } catch (e) {
      debugPrint('💥 Neura says: Sign in error: $e');
      rethrow;
    }
  }

  Future<void> signUp(String email, String pass) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      await sendEmailVerification();
    } catch (e) {
      debugPrint('💥 Neura says: Sign up error: $e');
      rethrow;
    }
  }

  Future<void> sendPasswordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('💥 Neura says: Password reset error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint('💥 Neura says: Sign out error: $e');
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      debugPrint('💥 Neura says: Email verification error: $e');
      rethrow;
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      final user = _auth.currentUser;
      await user?.reload();
      return user?.emailVerified ?? false;
    } catch (e) {
      debugPrint('💥 Neura says: Email verification check error: $e');
      return false;
    }
  }

  /// Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, 
        accessToken: googleAuth.accessToken
      );
      await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint('💥 Neura says: Google sign in error: $e');
      rethrow;
    }
  }

  /// Apple Sign-In
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );
      final oAuthProvider = OAuthProvider("apple.com");
      final authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      await _auth.signInWithCredential(authCredential);
    } catch (e) {
      debugPrint('💥 Neura says: Apple sign in error: $e');
      rethrow;
    }
  }
}
