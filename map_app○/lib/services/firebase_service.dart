import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ピンの保存
  Future<void> addPin(
      String userId, String title, double lat, double lng) async {
    await _firestore.collection('users').doc(userId).collection('pins').add({
      'title': title,
      'latitude': lat,
      'longitude': lng,
      'timestamp': Timestamp.now(),
    });
  }

  // ピンの取得
  Stream<QuerySnapshot> getPins(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('pins')
        .snapshots();
  }
}
