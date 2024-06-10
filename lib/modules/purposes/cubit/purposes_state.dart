part of 'purposes_cubit.dart';

class PurposesState {
  const PurposesState({
    required this.purposes,
    this.date,
    this.time,
  });

  final List<PurposeModel> purposes;
  final String? date;
  final String? time;

  PurposesState copyWith({
    List<PurposeModel>? purposes,
    String? date,
    String? time,
  }) {
    return PurposesState(
      purposes: purposes ?? this.purposes,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }
}
