import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinder/resources/storage_methods.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFriend(String uid, String friendId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(friendId).get();

      List friendsReq = (snap.data()! as dynamic)['friendsReq'];
      if (!friendsReq.contains(uid)) {
        await _firestore.collection('users').doc(friendId).update({
          'friendsReq': FieldValue.arrayUnion([uid])
        });
      } else {
        // user already requested
      }
      // when the friend accept the reqest then add
      // await _firestore.collection('users').doc(uid).update({
      //   'friends': FieldValue.arrayUnion([])
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteFriend(String uid, String friendId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List friends = (snap.data()! as dynamic)['friends'];
      if (friends.contains(friendId)) {
        await _firestore.collection('users').doc(friendId).update({
          'friends': FieldValue.arrayRemove([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'friends': FieldValue.arrayRemove([friendId])
        });
      } else {
        // friend is not registered
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> acceptFriend(String uid, String friendId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List friendsReq = (snap.data()! as dynamic)['friendsReq'];
      if (friendsReq.contains(friendId)) {
        await _firestore.collection('users').doc(friendId).update({
          'friends': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'friends': FieldValue.arrayUnion([friendId])
        });
      } else {
        // request doesn't exist
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeUser(String uid, String likeUserId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List likeTo = (snap.data()! as dynamic)['likeTo'];
      if (likeTo.contains(likeUserId)) {
        await _firestore.collection('users').doc(likeUserId).update({
          'likeFrom': FieldValue.arrayUnion([uid])
        });
        await _firestore.collection('users').doc(uid).update({
          'likeTo': FieldValue.arrayUnion([likeUserId])
        });
      } else {
        // request doesn't exist
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
