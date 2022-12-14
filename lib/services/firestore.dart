import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {

  updateUserToken(String uid, dynamic token){
    FirebaseFirestore.instance.collection('webusers').doc(uid).update({
      'notification_token': token
    });
  }

  static getContacts(String uid) async {
    List contactList = [];
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('webusers').doc(uid).get();
    final Map contactsMap = userSnapshot.get('contacts');
    for(var contact in contactsMap.values){
      contactList.add(contact);
    }
    return contactList;
  }

  Future<List<String>> getUserInfo(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('webusers').doc(uid).get();
    final String userName = snapshot.get('username');
    final String email = snapshot.get('email');
    final String password = snapshot.get('password');
    List<String> userInfo = [userName, email, password];
    return userInfo;
  }

  Future addContactToDatabase(String uid, String number, String name) async {

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('webusers').doc(uid).get();
    if(userSnapshot.get('contact_count') >= 1) return Future.error('You can only follow one person at the same time.');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('webcontacts').get();

    var doc = querySnapshot.docs.where((element) => element.id == number);
    final Map newMap = {
      uid: {'created_at': DateTime.now(), 'name': name, 'uid': uid}
    };

    if(doc.isEmpty){
      await FirebaseFirestore.instance.collection('webcontacts').doc(number).set({
        'is_first': true,
        'is_online': null,
        'last_seen': null,
        'sent_message': false,
        'document_id': number,
        'users': newMap
      });
    }else{
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('webcontacts').doc(number).get();
      final Map oldMap = documentSnapshot.get('users');
      final Map totalMap = {};
      totalMap.addAll(oldMap);
      totalMap.addAll(newMap);
      await FirebaseFirestore.instance.collection('webcontacts').doc(number).update({
        'users': totalMap
      });
    }
    
    final Map contactMap = userSnapshot.get('contacts');
    final Map newContactMap = {name: number};
    final Map finalContactMap = {};

    finalContactMap.addAll(contactMap);
    finalContactMap.addAll(newContactMap);

    FirebaseFirestore.instance.collection('webusers').doc(uid).update({
      'contact_count': FieldValue.increment(1),
      'contacts': finalContactMap,
    });
  }

  Future<void> deleteContactFromDatabase(String uid, String number) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('webcontacts').doc(number).get();
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('webusers').doc(uid).get();

    final Map oldMap = documentSnapshot.get('users');
    oldMap.removeWhere((key, value) => key == uid);

    if (oldMap.isEmpty) {
      await FirebaseFirestore.instance.collection('webcontacts').doc(number).delete();
    } else {
      await FirebaseFirestore.instance.collection('webcontacts').doc(number).update({'users': oldMap});
    }

    final Map contactMap = userSnapshot.get('contacts');
    contactMap.removeWhere((key, value) => value == number);
    FirebaseFirestore.instance.collection('webusers').doc(uid).update({
      'contact_count': FieldValue.increment(-1),
      'contacts': contactMap,
    });
  }
}
