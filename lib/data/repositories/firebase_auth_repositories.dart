import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/domain/entities/user_entity.dart';

class FirebaseAuthRepositories {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //sign in
  Future<UserEntity> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    if (user == null) throw Exception("user is null");
    return UserEntity(
      uid: user.uid,
      email: user.email ?? "",
      displayName: user.displayName ?? "",
    );
  }

  //sign up
  Future<UserEntity> signUp(
      String displayName, String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User? user = userCredential.user;
    await user?.updateDisplayName(displayName);
    user?.reload();
    user = _firebaseAuth.currentUser!;
    await _firebaseFirestore.collection("user").doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName
    });
    return UserEntity(uid: user.uid, email: email, displayName: displayName);
  }

  //sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
