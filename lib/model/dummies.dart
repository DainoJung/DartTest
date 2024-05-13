import 'package:dart_website/model/vo_problem.dart';

final problemList = [problem1, problem2, problem3, problem4, problem5];

final problem1 = Problem(
  question: "'Hello, world!'를 출력해보세요",
  answer: "void main() {\n    print(\"Hello, world!\");\n}",
);

final problem2 = Problem(
  question: "'Hello, star!'를 출력해보세요",
  answer: "void main() {\n    print(\"Hello, star!\");\n}",
);

final problem3 = Problem(
  question: "'Hello, moon!'를 출력해보세요",
  answer: "void main() {\n    print(\"Hello, moon!\");\n}",
);

final problem4 = Problem(
  question: "'Hello, Dart!'를 출력해보세요",
  answer: "void main() {\n    print(\"Hello, Dart!\");\n}",
);

final problem5 = Problem(
  question: "'Hello Flutter!'를 출력해보세요",
  answer: "void main() {\n    print(\"Hello, Flutter!\");\n}",
);
