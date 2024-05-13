import 'package:freezed_annotation/freezed_annotation.dart';
part 'vo_problem.g.dart';

@JsonSerializable()
class Problem {
  final String question;
  final String answer;

  Problem({
    required this.question,
    required this.answer,
  });
  factory Problem.fromJson(Map<String, dynamic> json) =>
      _$ProblemFromJson(json);
  Map<String, dynamic> toJson() => _$ProblemToJson(this);
}
