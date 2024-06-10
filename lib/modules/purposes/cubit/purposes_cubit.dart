import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninen/constants/app_cache.dart';
import 'package:ninen/modules/setting/pages/premium_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ninen/models/purpose_model.dart';

part 'purposes_state.dart';

class PurposesCubit extends Cubit<PurposesState> {
  PurposesCubit() : super(const PurposesState(purposes: [])) {
    _loadFromCache();
  }

  void addPurpose(
    BuildContext context,
    PurposeModel newPurpose,
  ) async {
    final updatedPurposes = List<PurposeModel>.from(state.purposes);

    final premium = await isUserPremium();

    if (updatedPurposes.length >= 10 && premium == false) {
      _showUpgradeDialog(context);
      return;
    }

    updatedPurposes.add(newPurpose);
    emit(state.copyWith(purposes: updatedPurposes));
    _saveToCache(updatedPurposes);
  }

  void saveDate(TypeDateTime type, String data) {
    if (TypeDateTime.date == type) {
      emit(state.copyWith(date: data));
    } else {
      emit(state.copyWith(time: data));
    }
  }

  void toggleIsCheck(int index) {
    final updatedPurposes = List<PurposeModel>.from(state.purposes);
    final updatedPurpose = updatedPurposes[index];
    updatedPurposes[index] = PurposeModel(
      deadline: updatedPurpose.deadline,
      purpose: updatedPurpose.purpose,
      description: updatedPurpose.description,
      isCheck: !updatedPurpose.isCheck,
    );
    emit(state.copyWith(purposes: updatedPurposes));
    _saveToCache(updatedPurposes);
  }

  Future<void> _saveToCache(List<PurposeModel> purposes) async {
    final prefs = await SharedPreferences.getInstance();
    final purposesJsonList =
        purposes.map((purpose) => jsonEncode(purpose.toJson())).toList();
    await prefs.setStringList(AppCache.purposes, purposesJsonList);
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final purposesJsonList = prefs.getStringList(AppCache.purposes);
    if (purposesJsonList != null) {
      final purposes = purposesJsonList
          .map((purposeJson) => PurposeModel.fromJson(jsonDecode(purposeJson)))
          .toList();
      emit(state.copyWith(purposes: purposes));
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
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PremiumPage(),
                  ),
                  (route) => false,
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

enum TypeDateTime { date, time }
