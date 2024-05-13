import 'package:dart_website/common/common.dart';
import 'package:dart_website/f_home.dart';
import 'package:dart_website/widget/w_tap.dart';
import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:velocity_x/velocity_x.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.resultData});
  final List resultData;

  @override
  Widget build(BuildContext context) {
    double score = (resultData[0] - resultData[2] + 1) / resultData[1] * 100;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
        // 마지막에 false로 변경하기
        automaticallyImplyLeading: true,
        title: "결과화면".text.semiBold.make(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "맞춘 개수 : ${resultData[0] - resultData[2] + 1}/${resultData[1]}"
                .text
                .semiBold
                .size(20)
                .make(),
            height5,
            "${score.toInt()}점".text.semiBold.size(70).make(),
            height30,
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(20)),
              height: 50,
              width: 100,
              child: Tap(
                  onTap: () => Nav.clearAllAndPush(const HomeFragment()),
                  child: "다시 풀기".text.size(18).semiBold.make()),
            )
          ],
        ),
      ),
    );
  }
}
