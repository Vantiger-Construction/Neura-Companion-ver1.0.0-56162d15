import 'package:your_app/utils/neura_funny_error.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _emailSent = false;
  bool _isVerified = false;

  @override
  void initState() {
  super.initState();
  _checkVerified();
  }

  // 🛡️ Error-handled
try {
  Future<void> _checkVerified() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  final verified = await AuthService().isEmailVerified();
  setState(() => _isVerified = verified);
  if (verified) {
    Navigator.pushReplacementNamed(context, '/'); // main nav
  }
  }

  // 🛡️ Error-handled
try {
  Future<void> _resend() async {
  try {
    // Your code here
  } catch (e, stack) {
    handleNeuraError(e, stack);
  }
    // original logic here
  } catch (e) {
    print('💥 Neura says: Oops! \$e');
  }
  await AuthService().sendEmailVerification();
  setState(() => _emailSent = true);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Verify Email')),
    body: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
      Text('A verification email has been sent to your address.'),
      if (_emailSent)
        Text('Email resent! Check your inbox.', style: TextStyle(color: Colors.green)),
      SizedBox(height: 16),
      ElevatedButton(onPressed: _resend, child: Text('Resend Email')),
      SizedBox(height: 16),
      ElevatedButton(onPressed: _checkVerified, child: Text('I have verified')),
      ],
    ),
    ),
  );
  }
}
