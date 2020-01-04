import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flowers/model/flower.dart';

class FlowerApi {
  //it will open up the Google site object
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseAuth _auth = FirebaseAuth.instance;

  //to add in a firebase firebase user
  FirebaseUser firebaseUser;

  FlowerApi(FirebaseUser user) {
    //this user is equal to the user that we pass and go
    this.firebaseUser = user;
  }

  //this function that handles these signing with Google
  static Future<FlowerApi> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    //to make sure that I.D. token is definitely not null.
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    //returns a new flower Api with that user account
    return new FlowerApi(user);
  }

  Future<List<Flower>> getAllFlowers() async {
    return (await Firestore.instance.collection('flowers').getDocuments())
        .documents
        .map((snapshot) => _fromDocumentSnapshot(snapshot))
        .toList();
  }

  StreamSubscription watch(Flower flower, void onChange(Flower flower)) {
    return Firestore.instance
        .collection('flowers')
        .document(flower.documentId)
        .snapshots()
        .listen((snapshot) => onChange(_fromDocumentSnapshot(snapshot)));
  }

  Flower _fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data;

    return new Flower(
      documentId: snapshot.documentID,
      externalId: data['id'],
      name: data['name'],
      description: data['description'],
      imageUrl: data['image_url'],
    );
  }
}
