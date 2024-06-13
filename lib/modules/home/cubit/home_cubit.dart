import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninen/constants/app_cache.dart';
import 'package:ninen/modules/home/service/home_service.dart';
import 'package:ninen/modules/setting/pages/premium_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ninen/models/new_training_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.service)
      : super(HomeState(
          newTraining: [],
          auth: service.getBool(AppCache.auth) ?? false,
          premium: service.getBool(AppCache.premium) ?? false,
        )) {
    _loadFromCache();
  }

  final HomeService service;

  Future<void> saveAuth(bool auth) async {
    await service.save(AppCache.auth, auth);
    emit(state.copyWith(auth: auth));
  }

  Future<void> savePremium(bool premium) async {
    await service.save(AppCache.premium, premium);
    emit(state.copyWith(premium: premium));
  }

  void createNewTraining(
    BuildContext context,
    NewTrainingModel newTraining,
  ) async {
    final updatedTraining = List<NewTrainingModel>.from(state.newTraining);
    final premium = await isUserPremium();

    if (updatedTraining.length >= 10 && premium == false) {
      _showUpgradeDialog(context);
      return;
    }

    updatedTraining.add(newTraining);
    emit(state.copyWith(newTraining: updatedTraining));
    _saveToCache(updatedTraining);
    Navigator.pop(context);
    clear();
  }

  void saveDuration(String duration) {
    emit(state.copyWith(durationNewTraining: duration));
  }

  Future<void> takePhoto(BuildContext context) async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(state.copyWith(image: File(pickedFile.path)));
      }
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        // ignore: use_build_context_synchronously
        showAlertDialog(context);
      } else {
        return;
      }
    }
  }

  void showAlertDialog(BuildContext context) => showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Permission Denied'),
            content: const Text('Allow access to gallery and photos'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => openAppSettings(),
                child: const Text('Settings'),
              ),
            ],
          );
        },
      );

  void clear() {
    final updatedTraining = List<NewTrainingModel>.from(state.newTraining);
    emit(
      HomeState(
        newTraining: updatedTraining,
        durationNewTraining: null,
        image: null,
      ),
    );
  }

  Future<void> _saveToCache(List<NewTrainingModel> trainings) async {
    final prefs = await SharedPreferences.getInstance();
    final trainingJsonList =
        trainings.map((training) => jsonEncode(training.toJson())).toList();
    await prefs.setStringList(AppCache.training, trainingJsonList);
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final trainingJsonList = prefs.getStringList(AppCache.training);
    if (trainingJsonList != null) {
      final trainings = trainingJsonList
          .map((trainingJson) =>
              NewTrainingModel.fromJson(jsonDecode(trainingJson)))
          .toList();
      emit(state.copyWith(newTraining: trainings));
    }
  }

  Future<bool> isUserPremium() async {
    final prefs = await SharedPreferences.getInstance();
    final premium = prefs.getBool(AppCache.premium);
    if (premium != null && premium == true) {
      return true;
    } else {
      return false;
    }
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upgrade to Premium'),
          content: const Text(
              'You have reached the limit of 10 purposes. Upgrade to premium to add more.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PremiumPage(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
