class PurposeModel {
  PurposeModel({
    required this.deadline,
    required this.purpose,
    required this.description,
    required this.isCheck,
  });

  final String deadline;
  final String purpose;
  final String description;
  bool isCheck;

  Map<String, dynamic> toJson() => {
        'deadline': deadline,
        'purpose': purpose,
        'description': description,
        'isCheck': isCheck,
      };

  factory PurposeModel.fromJson(Map<String, dynamic> json) => PurposeModel(
        deadline: json['deadline'],
        purpose: json['purpose'],
        description: json['description'],
        isCheck: json['isCheck'],
      );
}
