
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wseen/models/models.dart';

  Future<Stream> expirationDateStream() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final Timestamp expTimestamp = await FirebaseFirestore.instance.collection('webusers').doc(user!.uid).get().then((value) => value.get('subscription_expiration_date'));
    return Stream.periodic(const Duration(seconds: 1), (_) {
      final Duration diff = DateTime.parse(formattedDate(expTimestamp)).difference(DateTime.now());
      //if(diff.isNegative) AuthService.deleteUser();
      return diff;
    });
  }