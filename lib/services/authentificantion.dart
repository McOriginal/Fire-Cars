import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // Connexion avec Google
Future<UserCredential> signInWithGoogle() async {
  //Déclanche le flux de d'authentification
   final  googleUser = await  _googleSignIn.signIn();

   //obtenir les détails d'autorisation de la demande
  final googlaAuth  = await googleUser!.authentication;

  // créer un nouvel identifiant
  final credential = GoogleAuthProvider.credential(
    accessToken: googlaAuth.accessToken,
    idToken: googlaAuth.idToken,
  );

// une fois connecté, renvoyez l'identifiant de l'utilisateur
return await _auth.signInWithCredential(credential);
}
// l'etat de l'utilisateur en temps réel

Stream<User?> get user => _auth.authStateChanges();

//deconnection
Future<void> signOut() async{
  await _googleSignIn.signOut();
  await _auth.signOut();
}

}