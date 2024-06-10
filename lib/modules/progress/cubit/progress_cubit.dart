import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ninen/modules/progress/pages/before_and_after_page.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(this.picker) : super(const ProgressState());

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
