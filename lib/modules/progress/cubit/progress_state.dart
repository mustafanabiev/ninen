part of 'progress_cubit.dart';

class ProgressState {
  const ProgressState({
    this.beforeImage,
    this.afterImage,
    this.beforeAfterModel,
    this.weightList,
    this.waistList,
    this.bicepsList,
  });

  final File? beforeImage;
  final File? afterImage;
  final BeforeAfterModel? beforeAfterModel;
  final List<int>? weightList;
  final List<int>? waistList;
  final List<int>? bicepsList;

  ProgressState copyWith({
    File? beforeImage,
    File? afterImage,
    BeforeAfterModel? beforeAfterModel,
    List<int>? weightList,
    List<int>? waistList,
    List<int>? bicepsList,
  }) {
    return ProgressState(
      beforeImage: beforeImage ?? this.beforeImage,
      afterImage: afterImage ?? this.afterImage,
      beforeAfterModel: beforeAfterModel ?? this.beforeAfterModel,
      weightList: weightList ?? this.weightList,
      waistList: waistList ?? this.waistList,
      bicepsList: bicepsList ?? this.bicepsList,
    );
  }
}
