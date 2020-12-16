library dropdown_formfield;

import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final EdgeInsets contentPadding;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
        FormFieldValidator<dynamic> validator,
        bool autovalidate = false,
        this.titleText = 'Title',
        this.hintText = 'Select one option',
        this.required = false,
        this.errorText = 'Please select one option',
        this.value,
        this.dataSource,
        this.textField,
        this.valueField,
        this.onChanged,
        this.filled = true,
        this.contentPadding = const EdgeInsets.fromLTRB(10, 10, 5, 0)})
      : super(
    onSaved: onSaved,
    validator: validator,
    autovalidate: autovalidate,
    initialValue: value == '' ? null : value,
    builder: (FormFieldState<dynamic> state) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InputDecorator(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.red,
                    contentPadding: contentPadding,
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<dynamic>(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(200, 200, 200, 1),
                    ),
                    hint: Text(
                      hintText,
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontFamily: 'Open Sans'),
                    ),
                    value: value == '' ? null : value,
                    onChanged: (dynamic newValue) {
                      state.didChange(newValue);
                      onChanged(newValue);
                    },
                    items: dataSource.map((item) {
                      return DropdownMenuItem<dynamic>(
                        value: item[valueField],
                        child: Text(
                          item[textField],
                          style: TextStyle(fontFamily: 'Open Sans',color: Colors.grey.shade500),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: state.hasError ? 5.0 : 0.0),
              Text(
                state.hasError ? state.errorText : '',
                style: TextStyle(
                    color: Colors.redAccent.shade700,
                    fontSize: state.hasError ? 12.0 : 0.0,
                    fontFamily: 'Open Sans'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
