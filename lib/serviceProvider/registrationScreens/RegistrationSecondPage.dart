import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/utils/dropdown.dart';

class RegistrationSecondPage extends StatefulWidget {
  @override
  _RegistrationSecondPageState createState() => _RegistrationSecondPageState();
}

class _RegistrationSecondPageState extends State<RegistrationSecondPage> {
  final identityverification = new GlobalKey<FormState>();
  final qualificationupload = new GlobalKey<FormState>();
  final bankkey = new GlobalKey<FormState>();
  final accountnumberkey = new GlobalKey<FormState>();
  bool readonly = false;
  String identificationverify, qualification, bankname, accountnumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'セラピスト情報の入力',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('*は必項目です'),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Form(
                  key: identityverification,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(0.0),
                        color: Colors.transparent,
                        child: DropDownFormField(
                          titleText: null,
                          hintText: readonly
                              ? identificationverify
                              : '登録する本人確認証の種類を選択して\nください。*',
                          onSaved: (value) {
                            setState(() {
                              identificationverify = value;
                            });
                          },
                          value: identificationverify,
                          onChanged: (value) {
                            setState(() {
                              identificationverify = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "賃貸",
                              "value": "賃貸",
                            },
                            {
                              "display": "販売（売買）",
                              "value": "販売（売買）",
                            },
                            {
                              "display": "企画開発",
                              "value": "企画開発",
                            },
                            {
                              "display": "資産運用",
                              "value": "資産運用",
                            },
                            {
                              "display": "賃貸管理",
                              "value": "賃貸管理",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.0,
                        ),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.file_upload)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      hintText: "本人確認書のアップロード",
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '保有資格の種類を選択し、\n証明書をアップロードしてください。',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: qualificationupload,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(0.0),
                        color: Colors.transparent,
                        child: DropDownFormField(
                          titleText: null,
                          hintText: readonly
                              ? identificationverify
                              : '保有資格を選択してください。*',
                          onSaved: (value) {
                            setState(() {
                              identificationverify = value;
                            });
                          },
                          value: identificationverify,
                          onChanged: (value) {
                            setState(() {
                              identificationverify = value;
                            });
                          },
                          dataSource: [
                            {
                              "display": "賃貸",
                              "value": "賃貸",
                            },
                            {
                              "display": "販売（売買）",
                              "value": "販売（売買）",
                            },
                            {
                              "display": "企画開発",
                              "value": "企画開発",
                            },
                            {
                              "display": "資産運用",
                              "value": "資産運用",
                            },
                            {
                              "display": "賃貸管理",
                              "value": "賃貸管理",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 75,
                  width: 75,
                  color: Colors.red,
                  child: Card(),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.0,
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                      hintText: "電話番号",
                      fillColor: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.0,
                      ),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.file_upload)),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.black, fontSize: 13),
                    hintText: "本人確認書のアップロード",
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '売上振込先銀行口座',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: bankkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.38,
                            color: Colors.transparent,
                            child: DropDownFormField(
                              titleText: null,
                              hintText: readonly ? bankname : '保有資*',
                              onSaved: (value) {
                                setState(() {
                                  bankname = value;
                                });
                              },
                              value: bankname,
                              onChanged: (value) {
                                setState(() {
                                  bankname = value;
                                });
                              },
                              dataSource: [
                                {
                                  "display": "賃貸",
                                  "value": "賃貸",
                                },
                                {
                                  "display": "販売（売買）",
                                  "value": "販売（売買）",
                                },
                                {
                                  "display": "企画開発",
                                  "value": "企画開発",
                                },
                                {
                                  "display": "資産運用",
                                  "value": "資産運用",
                                },
                                {
                                  "display": "賃貸管理",
                                  "value": "賃貸管理",
                                },
                              ],
                              textField: 'display',
                              valueField: 'value',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "本人確認書のアップロード",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "本人確認書のアップロード",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          filled: true,
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 13),
                          hintText: "本人確認書のアップロード",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Form(
                    key: accountnumberkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          color: Colors.transparent,
                          child: DropDownFormField(
                            titleText: null,
                            hintText: readonly ? accountnumber : '口座番号*',
                            onSaved: (value) {
                              setState(() {
                                accountnumber = value;
                              });
                            },
                            value: accountnumber,
                            onChanged: (value) {
                              setState(() {
                                accountnumber = value;
                              });
                            },
                            dataSource: [
                              {
                                "display": "賃貸",
                                "value": "賃貸",
                              },
                              {
                                "display": "販売（売買）",
                                "value": "販売（売買）",
                              },
                              {
                                "display": "企画開発",
                                "value": "企画開発",
                              },
                              {
                                "display": "資産運用",
                                "value": "資産運用",
                              },
                              {
                                "display": "賃貸管理",
                                "value": "賃貸管理",
                              },
                            ],
                            textField: 'display',
                            valueField: 'value',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    child: Text(
                      'パスワード',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.lime,
                    onPressed: () {
                      /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyHomePage()));*/
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
