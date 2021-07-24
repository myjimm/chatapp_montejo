import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import '../models/appUsers.dart';

class UserController {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  createUser(String? uid, String? emailAddress, String? username){
    return users.doc(uid).set({
      'username': username,
      'emailAddress': emailAddress,
      'deleted': false,
    });
  }

  List<AppUser>? _usersList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return AppUser(
          username: (doc.data() as dynamic)['username'],
          emailAddress: (doc.data() as dynamic)['emailAddress'],
          uid: doc.id,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<List<AppUser>?>? get retrieveAllUsers {
    try {
      return users.snapshots().map(_usersList);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<QuerySnapshot?> retrieveUserofChatroom(String emailAddress) async {
    try{
      return users
        .where("emailAddress", isEqualTo: emailAddress)
        .get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool?> doesGoogleUserExist(String emailAddress) async {
    try{
      final result = await users.where("emailAddress", isEqualTo: emailAddress).get();
      if(result.docs.isEmpty){
        print("This user has not existed yet");
        return false;
      }else{
        print("This user is already in the database");
        return true;
      }
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<Stream<QuerySnapshot>?> getUserbyEmail(String emailAddress) async {
    try{
      return users
      .where("emailAddress", isEqualTo: emailAddress)
      .snapshots();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<String?> retrieveUserInformationFromUsername(String username) async {
    try{
      dynamic result = await users
        .where("username", isEqualTo: username)
        .get();
      return result.docs.first['displayPhoto'];
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}