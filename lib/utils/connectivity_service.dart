import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'constants.dart';
import 'app_colors.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isOnline = true.obs;
  StreamSubscription<ConnectivityResult>? _sub;

  Future<ConnectivityService> init() async {
    final initial = await _connectivity.checkConnectivity();
    isOnline.value = _mapResult(initial);
    _sub = _connectivity.onConnectivityChanged.listen((result) {
      isOnline.value = _mapResult(result);
      if (!isOnline.value) {
        if (Get.isSnackbarOpen == false) {
          Get.snackbar(
            AppConstants.noInternetTitle,
            AppConstants.noInternetMessage,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.error,
            colorText: AppColors.textOnPrimary,
            margin: const EdgeInsets.all(12),
            borderRadius: 8,
          );
        }
      }
    });
    return this;
  }

  bool _mapResult(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  Future<bool> ensureOnline() async {
    final result = await _connectivity.checkConnectivity();
    final online = _mapResult(result);
    if (!online) {
      Get.snackbar(
        AppConstants.noInternetTitle,
        AppConstants.noInternetMessage,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.error,
        colorText: AppColors.textOnPrimary,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
      );
    }
    return online;
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
