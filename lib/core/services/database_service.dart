import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  DatabaseService() {
    _firebaseDatabase.setPersistenceEnabled(true);
  }

  Future<void> create(String path, Map<String, dynamic> data) async {
    final ref = _firebaseDatabase.ref(path);
    await ref.set(data);
  }


  //Future<DataSnapshot?> read(String path) async {
  Future<Map<String, dynamic>?> read(String path) async {
    final ref = _firebaseDatabase.ref(path).child(path);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      return snapshot.value as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    final ref = _firebaseDatabase.ref(path);
    await ref.update(data);
  }

  Future<void> deleteData(String path) async {
    final ref = _firebaseDatabase.ref(path).child(path);
    await ref.remove();
  }
}