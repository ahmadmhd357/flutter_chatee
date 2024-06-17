import 'package:chatee/methods/methods.dart';
import 'package:chatee/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _id;
  String? _phoneNumber;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get id => _id;
  String? get phoneNumber => _phoneNumber;
  UserModel? get userModel => _userModel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then(
          (value) {
            _id = value.user!.uid;
            _phoneNumber = value.user!.phoneNumber;
            _isSuccess = true;
            _isLoading = false;
            notifyListeners();
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        _isSuccess = false;
        _isLoading = false;
        notifyListeners();
        showSnackBar(context, e.message!);
      },
      codeSent: (String verificationId, int? resendToken) {
        _isLoading = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code sent'),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String code){},
    );
  }
}