import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/BottomBarUser.dart';

class SizeAnimation extends StatelessWidget {
  static const routeName = 'Size_Animation';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Size Animation"),
      ),
      body: ListView.builder(
          itemCount: HealingMatchConstants.curveList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${HealingMatchConstants.curveList[index]}"),
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                  backgroundColor: Colors.white,
                ),
                onTap: () {
                  print(HealingMatchConstants.curveList.length);
                  Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, anotherAnimation) {
                        return BottomBarUser(0);
                      },
                      transitionDuration: Duration(milliseconds: 2000),
                      transitionsBuilder:
                          (context, animation, anotherAnimation, child) {
                        animation = CurvedAnimation(
                            curve: HealingMatchConstants.curveList[index],
                            parent: animation);
                        return Align(
                          child: SizeTransition(
                            sizeFactor: animation,
                            child: child,
                            axisAlignment: 0.0,
                          ),
                        );
                      }));
                },
              ),
            );
          }),
    );
  }
}
