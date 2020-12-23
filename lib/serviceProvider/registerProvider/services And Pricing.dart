import 'package:flutter/material.dart';
import 'package:gps_massageapp/utils/customAccordan.dart';

class ServiceAndPricing extends StatefulWidget {
  @override
  _ServiceAndPricingState createState() => _ServiceAndPricingState();
}

class _ServiceAndPricingState extends State<ServiceAndPricing> {
  final esthetickey = new GlobalKey<FormState>();

  Map<String, bool> numbers = {
    'One': false,
    'Two': false,
    'Three': false,
    'Four': false,
    'Five': false,
    'Six': false,
    'Seven': false,
  };
  var holder_1 = [];
  getItems() {
    numbers.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(243, 249, 250, 1),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('提供するサービスを選択し料金を設定してください。'),
              ],
            ),
            Column(
              children: [
                GFAccordion(
                  title: 'エステ',
                  titlePadding:
                      EdgeInsets.only(left: 13, top: 10, bottom: 10, right: 12),
                  customdecoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 229, 250, 1),
                            Color.fromRGBO(0, 187, 255, 1)
                          ]),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.0)),
                  contentChild: Container(
                    color: Colors.white,
                    child: ListView(
                      children: numbers.keys.map((String key) {
                        return new CheckboxListTile(
                          title: new Text(key),
                          value: numbers[key],
                          activeColor: Colors.pink,
                          checkColor: Colors.white,
                          onChanged: (bool value) {
                            setState(() {
                              numbers[key] = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
