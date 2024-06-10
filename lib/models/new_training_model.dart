import 'dart:io';

class NewTrainingModel {
  const NewTrainingModel({
    required this.date,
    required this.time,
    required this.typeOfTraining,
    required this.duration,
    required this.newTrainingExerciseModel,
    required this.comment,
    required this.image,
  });

  final String date;
  final String time;
  final String typeOfTraining;
  final String duration;
  final List<NewTrainingExerciseModel> newTrainingExerciseModel;
  final String comment;
  final File image;

  Map<String, dynamic> toJson() => {
        'date': date,
        'time': time,
        'typeOfTraining': typeOfTraining,
        'duration': duration,
        'newTrainingExerciseModel':
            newTrainingExerciseModel.map((e) => e.toJson()).toList(),
        'comment': comment,
        'image': image.path,
      };

  factory NewTrainingModel.fromJson(Map<String, dynamic> json) =>
      NewTrainingModel(
        date: json['date'],
        time: json['time'],
        typeOfTraining: json['typeOfTraining'],
        duration: json['duration'],
        newTrainingExerciseModel: List<NewTrainingExerciseModel>.from(
          json['newTrainingExerciseModel']
              .map((e) => NewTrainingExerciseModel.fromJson(e)),
        ),
        comment: json['comment'],
        image: File(json['image']),
      );
}

class NewTrainingExerciseModel {
  const NewTrainingExerciseModel({
    required this.name,
    required this.approach,
    required this.repetition,
    required this.comment,
  });

  final String name;
  final String approach;
  final String repetition;
  final String comment;

  Map<String, dynamic> toJson() => {
        'name': name,
        'approach': approach,
        'repetition': repetition,
        'comment': comment,
      };

  factory NewTrainingExerciseModel.fromJson(Map<String, dynamic> json) =>
      NewTrainingExerciseModel(
        name: json['name'],
        approach: json['approach'],
        repetition: json['repetition'],
        comment: json['comment'],
      );
}
