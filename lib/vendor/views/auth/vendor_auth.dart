import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:multiple_vendor/vendor/views/auth/screens/landing_screen.dart';
import 'package:multiple_vendor/vendor/views/auth/vendor_register_screen.dart';

class VendorAuthScreen extends StatelessWidget {
  const VendorAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return VendorRegistrationScreen();
          // SignInScreen(
          //   providers: [
          //     EmailAuthProvider(),
          //   ],
          // );
        }
        return LandingScreen();
      },
    );
  }
}
