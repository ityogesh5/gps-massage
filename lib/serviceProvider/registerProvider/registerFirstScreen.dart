import 'package:flutter/material.dart';
import 'package:gps_massageapp/customLibraryClasses/multiSelectDropdown/multiselectDropDownField.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

void main() => runApp(RegisterFirstScreen());

class RegisterFirstScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Checked Listview',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: MyHomePage(title: 'Flutter Checked Listview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _myActivities;
  String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectDropDownField(
                  autovalidate: false,
                  chipBackGroundColor: Colors.lime,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.lime,
                  checkBoxCheckColor: Colors.lime,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  title: Text(
                    "Aesthetic",
                    style: TextStyle(fontSize: 16),
                  ),
                  /*validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },*/
                  dataSource: [
                    {
                      "display": "Running #120/120分",
                      "value": "Running #120/120分",
                    },
                    {
                      "display": "Running ell #120/120分",
                      "value": "Running ell #120/120分",
                    },
                    {
                      "display": "Running half #120/120分",
                      "value": "Running half #120/120分",
                    },
                    {
                      "display": "Running full #120/120分",
                      "value": "Running full #120/120分",
                    },
                    {
                      "display": "Soccer Practice #120/120分",
                      "value": "Soccer Practice #120/120分",
                    },
                    {
                      "display": "Baseball Practice #120/120分",
                      "value": "Baseball Practice #120/120分",
                    },
                    {
                      "display": "Football Practice #120/120分",
                      "value": "Football Practice #120/120分",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: _saveForm,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_myActivitiesResult),
              )
            ],
          ),
        ),
      ),
    );
  }
}
