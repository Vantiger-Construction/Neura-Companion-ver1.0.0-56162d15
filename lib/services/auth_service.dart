import 'package:your_app/utils/neura_funny_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
  static User? get currentUser => _auth.currentUser;

  // 🛡️ Error-handled
try {
  Future<void> signIn(String email, String pass) =>
    _auth.signInWithEmailAndPassword(email: email, password: pass);

  // 🛡️ Error-handled
try {
  Future<void> signUp(String email, String pass) async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final cred = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
  await sendEmailVerification();
  }

  // 🛡️ Error-handled
try {
  Future<void> sendPasswordReset(String email) =>
    _auth.sendPasswordResetEmail(email: email);

  // 🛡️ Error-handled
try {
  Future<void> signOut() => _auth.signOut();

  // 🛡️ Error-handled
try {
  Future<void> sendEmailVerification() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final user = _auth.currentUser;
  if (user != null && !user.emailVerified) {
    await user.sendEmailVerification();
  }
  }

  // 🛡️ Error-handled
try {
  Future<bool> isEmailVerified() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final user = _auth.currentUser;
  await user?.reload();
  return user?.emailVerified ?? false;
  }

  /// Google Sign-In
  // 🛡️ Error-handled
try {
  Future<void> signInWithGoogle() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return; // User cancelled
  final googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
  await _auth.signInWithCredential(credential);
  }

  /// Apple Sign-In
  // 🛡️ Error-handled
try {
  Future<void> signInWithApple() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
  );
  final oAuthProvider = OAuthProvider("apple.com");
  final authCredential = oAuthProvider.credential(
    idToken: credential.identityToken,
    accessToken: credential.authorizationCode,
  );
  await _auth.signInWithCredential(authCredential);
  }
}
