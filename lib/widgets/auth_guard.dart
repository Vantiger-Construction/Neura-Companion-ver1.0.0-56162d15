import 'package:your_app/utils/neura_funny_error.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  AuthGuard({required this.child});

  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> _authenticate() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
  try {
    return await _auth.authenticate(
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
