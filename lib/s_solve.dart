import 'package:auto_size_text/auto_size_text.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:dart_website/common/common.dart';
import 'package:dart_website/model/dummies.dart';
import 'package:dart_website/model/vo_problem.dart';
import 'package:dart_website/s_result.dart';
import 'package:dart_website/widget/w_tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nav/nav.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

class SolveScreen extends StatefulWidget {
  const SolveScreen({super.key, required this.countList});
  final List countList;

  @override
  State<SolveScreen> createState() => _SolveScreenState();
}

class _SolveScreenState extends State<SolveScreen> {
  Artboard? riveArtboard;
  SMIBool? isHover;
  SMITrigger? isSuccess;
  SMITrigger? isFail;
  FocusNode focusNode = FocusNode();
  CodeController? _codeController;
  String source = problem1.answer;

  @override
  void initState() {
    rootBundle.load('assets/riv/oxCharacter.riv').then((data) async {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          isHover = controller.findSMI('hands_up');
          isSuccess = controller.findSMI('success');
          isFail = controller.findSMI('fail');
        }
        setState(() => riveArtboard = artboard);
      } catch (e) {
        ErrorWidget(e);
      }
    });

    _codeController = CodeController(
      text: source,
      language: dart,
    );
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hoverCode(true);
      } else {
        hoverCode(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.countList;
    _codeController?.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void hoverCode(bool newValue) {
    setState(() => isHover!.value = newValue);
  }

  void correctCode(bool newValue) async {
    newValue
        ? setState(() => isSuccess!.value = true)
        : setState(() => isFail!.value = true);
  }

  void flutterCorrectToast() {
    // 진동
    HapticFeedback.heavyImpact();
    HapticFeedback.heavyImpact();
    // 토스트
    Fluttertoast.showToast(
        msg: "맞았습니다.", // 메시지 내용
        toastLength: Toast.LENGTH_SHORT, // 메시지 시간 - 안드로이드
        gravity: ToastGravity.BOTTOM, // 메시지 위치
        timeInSecForIosWeb: 1, // 메시지 시간 - iOS 및 웹
        backgroundColor: Colors.lightBlue, // 배경
        textColor: Colors.white, // 글자
        fontSize: 16.0); // 글자 크기
  }

  void flutterDiscorrectToast() {
    // 진동
    HapticFeedback.heavyImpact();
    HapticFeedback.heavyImpact();
    // 토스트
    Fluttertoast.showToast(
        msg: "틀렸습니다.", // 메시지 내용
        toastLength: Toast.LENGTH_SHORT, // 메시지 시간 - 안드로이드
        gravity: ToastGravity.BOTTOM, // 메시지 위치
        timeInSecForIosWeb: 1, // 메시지 시간 - iOS 및 웹
        backgroundColor: Colors.red, // 배경
        textColor: Colors.white, // 글자
        fontSize: 16.0); // 글자 크기
  }

  @override
  Widget build(BuildContext context) {
    int pageNum = widget.countList[0] + 1;
    Problem problem = problemList[pageNum - 1];
    debugPrint(widget.countList[0].toString());
    return Tap(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
          title: "$pageNum/${widget.countList[1]}".text.semiBold.make(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.5,
                child: riveArtboard == null
                    ? const SizedBox()
                    : Rive(artboard: riveArtboard!),
              ),
              height30,
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 211, 211, 211),
                    borderRadius: BorderRadius.circular(15)),
                child: AutoSizeText.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 18),
                    text: problem.question,
                  ),
                ).p(10),
              ),
              height20,
              CodeTheme(
                data: const CodeThemeData(styles: monokaiSublimeTheme),
                child: CodeField(
                  focusNode: focusNode,
                  controller: _codeController!,
                  textStyle: const TextStyle(fontFamily: 'SourceCode'),
                ),
              ),
              height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnswerButton(
                    iconType: CupertinoIcons.arrow_clockwise,
                    onTap: () => _codeController!.text = source,
                  ),
                  const WidthBox(80),
                  AnswerButton(
                      iconType: CupertinoIcons.arrow_right,
                      onTap: () async {
                        if (pageNum == 5) {
                          if (_codeController!.text == problem.answer) {
                            flutterCorrectToast();
                          } else {
                            flutterDiscorrectToast();
                          }
                          Nav.clearAllAndPush(ResultScreen(
                            resultData: widget.countList,
                          ));
                        } else if (_codeController!.text == problem.answer) {
                          flutterCorrectToast();
                          widget.countList[0]++;
                          correctCode(true);
                        } else {
                          flutterDiscorrectToast();
                          widget.countList[0]++;
                          widget.countList[2]++;
                          correctCode(false);
                        }
                      })
                ],
              ),
              height30,
            ],
          ).pSymmetric(h: MediaQuery.of(context).size.width / 13),
        ),
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final IconData iconType;
  final VoidCallback onTap;
  const AnswerButton({
    super.key,
    required this.iconType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: MediaQuery.of(context).size.width / 5,
      onPressed: onTap,
      icon: Icon(iconType),
    );
  }
}
