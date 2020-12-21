import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/services%20And%20Pricing.dart';
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
                              "display": "運転免許証",
                              "value": "運転免許証",
                            },
                            {
                              "display": "運転経歴証明書",
                              "value": "運転経歴証明書",
                            },
                            {
                              "display": "パスポート",
                              "value": "パスポート",
                            },
                            {
                              "display": "個人番号カー",
                              "value": "個人番号カー",
                            },
                            {
                              "display": "住民基本台帳カード",
                              "value": "住民基本台帳カード",
                            },
                            {
                              "display": "マイナンバーカード",
                              "value": "マイナンバーカード",
                            },
                            {
                              "display": "運転経歴証明書",
                              "value": "運転経歴証明書",
                            },
                            {
                              "display": "学生証",
                              "value": "学生証",
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
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
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
                              "display": "はり師",
                              "value": "はり師",
                            },
                            {
                              "display": "きゅう師",
                              "value": "きゅう師",
                            },
                            {
                              "display": "鍼灸師",
                              "value": "鍼灸師",
                            },
                            {
                              "display": "あん摩マッサージ指圧師",
                              "value": "あん摩マッサージ指圧師",
                            },
                            {
                              "display": "柔道整復師",
                              "value": "柔道整復師",
                            },
                            {
                              "display": "理学療法士",
                              "value": "理学療法士",
                            },
                            {
                              "display": "国家資格取得予定（学生）",
                              "value": "国家資格取得予定（学生）",
                            },
                            {
                              "display": "民間資格",
                              "value": "民間資格",
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
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('asdghsd'),
                      Text('aschbxsxcbc'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.file_upload),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ファイルをアップロードする',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: RaisedButton(
                    child: Text(
                      '提供サービスと料金設定',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ServiceAndPricing()));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                /*  InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Text(
                        'hello',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),*/
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
                    hintText: "掲載写真のアップロード",
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
                              hintText: readonly ? bankname : '銀行名*',
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
                          hintText: "支店コード",
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          hintText: "支店番号",
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
                          hintText: "口座番号",
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
                            hintText: readonly ? accountnumber : '口座種類*',
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
                                "display": "普通",
                                "value": "普通",
                              },
                              {
                                "display": "当座",
                                "value": "当座",
                              },
                              {
                                "display": "貯蓄",
                                "value": "貯蓄",
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
                      '登録完了',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.lime,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'すでにアカウントをお持ちの方',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
