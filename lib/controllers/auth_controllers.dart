import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseService _firebaseService = Get.find();
  final Rx<User?> _user = Rx<User?>(null);
  User? get user => _user.value;
  Rx<User?> get userStream => _user;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    _user.bindStream(_firebaseService.authStateChanges());
    super.onInit();
  }

  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    try {
      User? user = await _firebaseService.signUpWithEmail(email, password);
      if (user != null) {
        await _createUserDocument(user);
        _user.value = user;
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createUserDocument(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'email': user.email,
    });
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    try {
      User? user = await _firebaseService.signInWithEmail(email, password);
      if (user != null) {
        _user.value = user;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _firebaseService.signOut();
  }
}
