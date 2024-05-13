import 'package:dart_website/s_solve.dart';
import 'package:dart_website/widget/w_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nav/nav.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  Artboard? riveArtboard;
  SMIBool? isHover;
  List countList = [
    [0, 5, 0],
    [0, 10, 0],
    [0, 15, 0],
    [0, 20, 0]
  ];
  @override
  void initState() {
    rootBundle.load('assets/riv/birb.riv').then((data) async {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'birb');
        if (controller != null) {
          artboard.addController(controller);
          isHover = controller.findSMI('dance');
        }
        setState(() {
          riveArtboard = artboard;
          isHover!.value = true;
        });
      } catch (e) {
        ErrorWidget(e);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(216, 226, 233, 1),
        title: "Dart Test".text.semiBold.make(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width / 1.5,
              child: riveArtboard == null
                  ? const SizedBox()
                  : Rive(artboard: riveArtboard!),
            ),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              children: [
                for (List data in countList)
                  NumButtonWidget(
                    countList: data,
                  )
              ],
            ),
          ],
        ).pSymmetric(h: 20),
      ),
    );
  }
}

class NumButtonWidget extends StatelessWidget {
  const NumButtonWidget({
    super.key,
    required this.countList,
  });
  final List countList;

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () => Nav.push(SolveScreen(
        countList: countList,
      )),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.blue.shade200,
        ),
        child: Center(child: "${countList[1]}문제".text.size(28).semiBold.make()),
      ).p(10),
    );
  }
}
