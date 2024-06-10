part of 'progress_cubit.dart';

class ProgressState {
  const ProgressState({
    this.beforeImage,
    this.afterImage,
    this.beforeAfterModel,
  });

  final File? beforeImage;
  final File? afterImage;
  final BeforeAfterModel? beforeAfterModel;

  ProgressState copyWith({
    File? beforeImage,
    File? afterImage,
    BeforeAfterModel? beforeAfterModel,
  }) {
    return ProgressState(
      beforeImage: beforeImage ?? this.beforeImage,
      afterImage: afterImage ?? this.afterImage,
      beforeAfterModel: beforeAfterModel ?? this.beforeAfterModel,
    );
  }
}
