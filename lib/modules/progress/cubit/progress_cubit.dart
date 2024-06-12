import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninen/modules/home/cubit/home_cubit.dart';
import 'package:ninen/modules/setting/pages/premium_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ninen/modules/progress/pages/before_and_after_page.dart';
import 'package:flutter/material.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(this.picker)
      : super(const ProgressState(
          weightList: [],
          bicepsList: [],
          waistList: [],
        )) {
    _loadFromCache();
  }

  final ImagePicker picker;

  void takePhoto(PhotoType type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (type == PhotoType.before) {
        emit(state.copyWith(beforeImage: File(pickedFile.path)));
      } else {
        emit(state.copyWith(afterImage: File(pickedFile.path)));
      }
    }
  }

  Future<void> saveProgress(
    BuildContext context,
    int weight,
    int waist,
    int biceps,
  ) async {
    final weightList = List<int>.from(state.weightList ?? []);
    final waistList = List<int>.from(state.waistList ?? []);
    final bicepsList = List<int>.from(state.bicepsList ?? []);

    if (weightList.length >= 10) {
      final isPremium = context.read<HomeCubit>().state.premium ?? false;
      if (!isPremium) {
        _showUpgradeDialog(context);
        return;
      }
    }

    weightList.add(weight);
    waistList.add(waist);
    bicepsList.add(biceps);
    emit(state.copyWith(
      weightList: weightList,
      waistList: waistList,
      bicepsList: bicepsList,
    ));
    _saveProgressToCache(weightList, waistList, bicepsList);
  }

  Future<void> _showUpgradeDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upgrade to Premium'),
          content: const Text(
            'You have reached the limit of 10 purposes. Upgrade to premium to add more.',
          ),
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

  Future<void> _saveProgressToCache(
    List<int> weightList,
    List<int> waistList,
    List<int> bicepsList,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weightList', jsonEncode(weightList));
    await prefs.setString('waistList', jsonEncode(waistList));
    await prefs.setString('bicepsList', jsonEncode(bicepsList));
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final weightListJson = prefs.getString('weightList');
    final waistListJson = prefs.getString('waistList');
    final bicepsListJson = prefs.getString('bicepsList');

    if (weightListJson != null &&
        waistListJson != null &&
        bicepsListJson != null) {
      final weightList = List<int>.from(jsonDecode(weightListJson));
      final waistList = List<int>.from(jsonDecode(waistListJson));
      final bicepsList = List<int>.from(jsonDecode(bicepsListJson));

      emit(state.copyWith(
        weightList: weightList,
        waistList: waistList,
        bicepsList: bicepsList,
      ));
    }
  }

  void compare(BeforeAfterModel beforeAfterModel) =>
      emit(state.copyWith(beforeAfterModel: beforeAfterModel));

  void clear() {
    emit(
      const ProgressState(
        afterImage: null,
        beforeAfterModel: null,
        beforeImage: null,
      ),
    );
  }
}

enum PhotoType { before, after }
