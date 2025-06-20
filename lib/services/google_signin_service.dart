import 'package:codemap/utils/util.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInService {
  // FirebaseAuth instance to handle authentication.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // GoogleSignIn instance to handle Google Sign-In.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await _googleSignIn.signIn();

    // User canceled the sign-in.
    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential.
    final userCredential = await _auth.signInWithCredential(credential);

    // Return the authenticated user.
    printDebug("SIGNIN", "User: ${userCredential.user}");
    return userCredential.user;
  }

  /// Signs out the user from both Google and Firebase.
  Future<void> signOut() async {
    // Sign out from Google.
    await _googleSignIn.signOut();

    // Sign out from Firebase.
    await _auth.signOut();
  }
}
