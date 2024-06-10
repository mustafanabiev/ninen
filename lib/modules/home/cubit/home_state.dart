part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    required this.newTraining,
    this.image,
    this.durationNewTraining,
    this.auth,
    this.premium,
  });

  final List<NewTrainingModel> newTraining;
  final File? image;
  final String? durationNewTraining;
  final bool? auth;
  final bool? premium;

  HomeState copyWith({
    List<NewTrainingModel>? newTraining,
    File? image,
    String? durationNewTraining,
    bool? auth,
    bool? premium,
  }) {
    return HomeState(
      newTraining: newTraining ?? this.newTraining,
      image: image ?? this.image,
      durationNewTraining: durationNewTraining ?? this.durationNewTraining,
      auth: auth ?? this.auth,
      premium: premium ?? this.premium,
    );
  }
}
