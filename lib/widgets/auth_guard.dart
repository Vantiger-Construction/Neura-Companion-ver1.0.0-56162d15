import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  Future<bool> _authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      // Your code here
    } catch (e, stack) {
      // TODO: Implement proper error handling
      debugPrint('Authentication error: $e');
    }
    try {
      return await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        biometricOnly: true,
      );
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
  return FutureBuilder<bool>(
    future: _authenticate(),
    builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (snapshot.data == true) {
      return child;
    } else {
      return Scaffold(body: Center(child: Text('Authentication failed')));
    }
    },
  );
  }
}
