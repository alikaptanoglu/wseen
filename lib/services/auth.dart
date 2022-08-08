import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  Future<User?> signUp(String name, String email, String password, dynamic notificationToken, String subscriptionType) async {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await _firestore.collection('webusers').doc(user.user!.uid).set({
      'username': name,
      'email': email,
      'password': password,
      'contact_count': 0,
      'contacts': {},
      'uid': user.user!.uid,
      'notification_token': notificationToken,
      'subscription_type': subscriptionType,
      'subscription_expiration_date': DateTime.now().add(const Duration(hours: 8))
    });
    return user.user;
  }

  static deleteUser(){
    FirebaseAuth.instance.currentUser!.delete();
  }

  signOut() async {
    return await _auth.signOut();
  }
}
