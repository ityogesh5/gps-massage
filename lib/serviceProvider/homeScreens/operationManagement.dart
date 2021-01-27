import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

class OperationManagement extends StatefulWidget {
  @override
  _OperationManagementState createState() => _OperationManagementState();
}

class _OperationManagementState extends State<OperationManagement> {
  List<String> shiftValues = [
    "キッズスペースの完備",
    "保育士の常駐",
    "子供同伴OK",
    "ースの完備",
    "キッズスペ",
  ];

  int _selectedIndex;
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);//the listener for up and down.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            NavigationRouter.switchToServiceProviderBottomBar(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'マイアカウント',
          style: TextStyle(
              fontFamily: 'Oxygen',
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.0),
                    //BuildShiftValueLists(),
                    //_buildChips(),

                    /*Container(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: shiftValues
                            .map((e) {
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            height: 40.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "$e",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0),
                                ),
                              ],
                            ),
                          );
                        })
                            .toList()
                            .cast<Widget>(),
                      ),
                    ),
                    */

                    ListView.builder(
                      controller: _controller, //new line
                      itemCount: shiftValues.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(shiftValues[index]),
                      ),
                    ),

                    /*ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: shiftValues.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = shiftValues[index];
                          return buildShiftValues(key, index);
                          //return buildQualificationImage(key, index);
                        }),*/
                    SizedBox(height: 10),
                  ],
                )),
          ],
        ),
      ),
      /*Center(
        child: Text('Welcome to OperationManagement'),
      ),*/
    );
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < shiftValues.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(shiftValues[i], style: TextStyle(color: Colors.white)),
        elevation: 3,
        pressElevation: 5,
        backgroundColor: Colors.grey[400],
        selectedColor: Colors.lightGreen,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(choiceChip);
    }
    print('_selectedIndex is : ${shiftValues[_selectedIndex]}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: chips,
    );
  }

  Widget buildShiftValues(String key, int index) {
    return Container(
      padding: EdgeInsets.only(left: 16.0),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return new Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Text(
                shiftValues[index],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            );
          }),
    );
  }
}
