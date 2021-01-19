import 'package:flutter/material.dart';

class WeeklySchedule extends StatefulWidget {
  @override
  _WeeklyScheduleState createState() => _WeeklyScheduleState();
}

class _WeeklyScheduleState extends State<WeeklySchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Center(
            child: Text(
          '一週間のスケジュール',
          style: TextStyle(color: Colors.black),
        )),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Row(children: <Widget>[
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Divider(
                      // height: 50,
                      color: Colors.grey,
                    )),
              ),
              Text(
                "2021-01-13",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: new Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Divider(
                      color: Colors.grey,
                      // height: 50,
                    )),
              ),
            ]),
            Text('09: 00~10: 00'),
            weeklyScheduleCard(),
          ],
        ),
      ),
    );
  }
}

class weeklyScheduleCard extends StatefulWidget {
  @override
  _weeklyScheduleCardState createState() => _weeklyScheduleCardState();
}

class _weeklyScheduleCardState extends State<weeklyScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('AK さん'),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(4),
                            child: Text('オフィス')),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: EdgeInsets.all(4),
                              child: Text('足つぼ')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text('リンバ')),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Text('オイル')),
                        ],
                      ),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              // height: 50,
                              color: Colors.grey,
                            )),
                      ),
                      Container(
                        child: IconButton(
                            icon: Icon(Icons.cancel_rounded), onPressed: () {}),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.black38),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'オフィス',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),

                          // width: 85,
                          // height: 30,
                          child: Center(
                            child: Text(
                              'オフィス',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('オフィス')
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
