import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Access the authenticated user
        final User? user = userCredential.user;
        print('Logged in with Facebook. User ID: ${user?.uid}');
      } else {
        print('Facebook login failed. Status: ${result.status}');
      }
    } catch (e) {
      print('Error during Facebook login: $e');
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically handles verification if the SMS code is detected
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        // User is now signed in, proceed with necessary actions
        print(
            'User signed in with phone number: ${userCredential.user?.phoneNumber}');
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
        print('Phone verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID to use later
        // Show UI to enter the verification code
        print('Verification code sent. Verification ID: $verificationId');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle code auto-retrieval timeout
        print('Code auto-retrieval timeout. Verification ID: $verificationId');
      },
      timeout: const Duration(seconds: 60), // Timeout for code entry
    );
  }

  Future<void> signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // User is now signed in, proceed with necessary actions
      print(
          'User signed in with phone number: ${userCredential.user?.phoneNumber}');
    } catch (e) {
      // Handle sign-in failure
      print('Sign in with phone number failed: $e');
    }
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      // Anonymous user is signed in
      User? user = userCredential.user;
      if (user != null) {
        print('Signed in anonymously: ${user.uid}');
        updateUI(user);
      } else {
        print('Failed to sign in anonymously.');
        updateUI(null);
      }
    } catch (e, stackTrace) {
      // Error occurred during anonymous sign-in
      print('Failed to sign in anonymously: $e\n$stackTrace');
      updateUI(null);
    }
  }

  void updateUI(User? user) {
    // Update the user interface based on the signed-in user
    if (user != null) {
      // User is signed in
      // Perform actions for a signed-in user
    } else {
      // User is signed out
      // Perform actions for a signed-out user
    }
  }
}
