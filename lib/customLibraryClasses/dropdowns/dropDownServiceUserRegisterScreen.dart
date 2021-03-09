library dropdown_formfield;

import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

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
  final bool enabled;
  final dynamic items;
  final bool isList;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Select one option',
      this.required = false,
      this.errorText = 'Please select one option',
      this.value,
      this.items,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged,
      this.filled = true,
      this.enabled = true,
      this.isList = false,
      this.contentPadding = const EdgeInsets.fromLTRB(10, 10, 5, 0)})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: ColorConstants.formFieldFillColor,
                    border:
                        Border.all(color: ColorConstants.formFieldBorderColor)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /*   InputDecorator(
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          focusColor: Colors.red,
                          contentPadding: contentPadding,
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: */
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                      child: DropdownButtonHideUnderline(
                          child: enabled
                              ? DropdownButton<dynamic>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30.0,
                                    color: Colors
                                        .black, //Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  isExpanded: true,
                                  hint: Text(
                                    hintText,
                                    style:
                                        HealingMatchConstants.formHintTextStyle,
                                  ),
                                  value: value == '' ? null : value,
                                  onChanged: (dynamic newValue) {
                                    state.didChange(newValue);
                                    onChanged(newValue);
                                  },
                                  items: isList
                                      ? dataSource.map((item) {
                                          return DropdownMenuItem<dynamic>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: HealingMatchConstants
                                                  .formTextStyle,
                                            ),
                                          );
                                        }).toList()
                                      : dataSource.map((item) {
                                          return DropdownMenuItem<dynamic>(
                                            value: item[valueField],
                                            child: Text(
                                              item[textField],
                                              style: HealingMatchConstants
                                                  .formTextStyle,
                                            ),
                                          );
                                        }).toList(),
                                )
                              : DropdownButton<dynamic>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30.0,
                                    color: Colors
                                        .black, // Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                  hint: Text(
                                    value,
                                    style: HealingMatchConstants.formTextStyle,
                                  ),
                                  value: value == '' ? null : value,
                                  style: HealingMatchConstants.formTextStyle,
                                  onChanged: (dynamic newValue) {
                                    state.didChange(newValue);
                                    onChanged(newValue);
                                  },
                                  items: [],
                                )),
                    ),
                    //  ),
                    SizedBox(height: state.hasError ? 5.0 : 0.0),
                    Text(
                      state.hasError ? state.errorText : '',
                      style: TextStyle(
                          color: Colors.redAccent.shade700,
                          fontFamily: 'NotoSansJP',
                          fontSize: state.hasError ? 12.0 : 0.0),
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
