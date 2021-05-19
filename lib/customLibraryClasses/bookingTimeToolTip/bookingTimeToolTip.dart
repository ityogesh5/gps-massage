import 'dart:core';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/customLibraryClasses/flutterTimePickerSpinner/flutter_time_picker_spinner.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';

class ShowToolTip {
  double _popupWidth = 200.0;
  double _popupHeight = 200.0;
  double arrowHeight = 10.0;
  OverlayEntry _entry;
  String _text;
  TextStyle _textStyle;
  Offset _offset;
  Rect _showRect;
  bool _isDownArrow = true;
  int _index;
  VoidCallback dismissCallback;
  bool _isStart;
  final _callBack;
  Size _screenSize;
  BuildContext context;
  Color _backgroundColor;
  TherapistList therapistListItem;
  void Function(void Function()) _refreshState;
  bool _isVisible = false;
  DateTime _time;

  BorderRadius _borderRadius;
  EdgeInsetsGeometry _padding;
  Map<int, int> _timePrice = Map<int, int>();

  ShowToolTip(this.context,
      this._callBack, //Function(int index, DateTime newTime, bool isStart) refreshPage,
      {double height,
      double width,
      TherapistList therapistListItem,
      VoidCallback onDismiss,
      Color backgroundColor,
      String text,
      int index,
      bool isStart,
      DateTime time,
      TextStyle textStyle,
      Map<int, int> timePrice,
      BorderRadius borderRadius,
      EdgeInsetsGeometry padding}) {
    this.therapistListItem = therapistListItem;
    this.dismissCallback = onDismiss;
    this._popupHeight = height;
    this._popupWidth = width;
    this._timePrice = timePrice != null ? timePrice : Map<int, int>();
    this._text = text;
    this._index = index;
    this._isStart = isStart;
    this._time = time;
    this._index = index;
    this._textStyle = textStyle ??
        TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF000000));
    this._backgroundColor = backgroundColor ?? Color(0xFFFFA500);
    this._borderRadius = borderRadius ?? BorderRadius.circular(10.0);
    this._padding = padding ?? EdgeInsets.all(4.0);
  }

  /// Shows a popup near a widget with key [widgetKey] or [rect].
  void show({Rect rect, GlobalKey widgetKey}) {
    if (rect == null && widgetKey == null) {
      print("both 'rect' and 'key' can't be null");
      return;
    }

    this._text = _text ?? this._text;
    this._showRect = rect ?? _getWidgetGlobalRect(widgetKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    this.dismissCallback = dismissCallback;

    _calculatePosition(context);

    _entry = OverlayEntry(builder: (context) {
      return buildPopupLayout(_offset);
    });

    Overlay.of(context).insert(_entry);
    _isVisible = true;
  }

  void _calculatePosition(BuildContext context) {
    _offset = _calculateOffset(context);
  }

  /// Returns globalRect of widget with key [key]
  Rect _getWidgetGlobalRect(GlobalKey key) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  /// Returns calculated widget offset using [context]
  Offset _calculateOffset(BuildContext context) {
    double dx = _showRect.left + _showRect.width / 2.0 - _popupWidth / 2.0;
    if (dx < 10.0) {
      dx = 10.0;
    }

    if (dx + _popupWidth > _screenSize.width && dx > 10.0) {
      double tempDx = _screenSize.width - _popupWidth - 10;
      if (tempDx > 10) dx = tempDx;
    }

    double dy = _showRect.top - _popupHeight;
    //if (dy <= MediaQuery.of(context).padding.top + 10) {
    // not enough space above, show popup under the widget.
    dy = arrowHeight + _showRect.height + _showRect.top;
    _isDownArrow = false;
    /* } else {
      dy -= arrowHeight;
      _isDownArrow = true;
    }
 */
    return Offset(dx, dy);
  }

  /// Builds Layout of popup for specific [offset]
  LayoutBuilder buildPopupLayout(Offset offset) {
    return LayoutBuilder(builder: (context, constraints) {
      return StatefulBuilder(builder: (context, setState) {
        _refreshState = setState;
        return GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () {
            dismiss();
          },
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                // popup content
                Positioned(
                  left: 7.0, //offset.dx,
                  top: offset.dy,
                  child: Container(
                    padding: _padding,
                    width: _popupWidth,
                    height: _popupHeight,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      borderRadius: _borderRadius,
                      border: Border.all(color: Colors.grey[300]),
                      /* boxShadow: [
                        BoxShadow(
                          color: Color(0xFF808080),
                          // blurRadius: 1.0,
                        ),
                      ] */
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            buildShiftPriceCard(60, therapistListItem.sixtyMin),
                            SizedBox(width: 8.0),
                            buildShiftPriceCard(90, therapistListItem.nintyMin),
                            SizedBox(width: 8.0),
                            buildShiftPriceCard(
                                120, therapistListItem.oneTwentyMin),
                            SizedBox(width: 8.0),
                            buildShiftPriceCard(
                                150, therapistListItem.oneFifityMin),
                            SizedBox(width: 8.0),
                            buildShiftPriceCard(
                                180, therapistListItem.oneEightyMin),
                            SizedBox(width: 8.0),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                // triangle arrow
                Positioned(
                  left: _showRect.left + _showRect.width / 2.0 - 7.5,
                  top: _isDownArrow
                      ? offset.dy + _popupHeight
                      : offset.dy - arrowHeight + 1,
                  child: CustomPaint(
                    size: Size(15.0, arrowHeight),
                    painter: TrianglePainter(
                      isDownArrow: _isDownArrow,
                      color: _backgroundColor,
                    ),
                    foregroundPainter: TrianglePainterShadow(
                      isDownArrow: _isDownArrow,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  /// Dismisses the popup
  void dismiss() {
    if (!_isVisible) {
      return;
    }
    _entry.remove();
    _isVisible = false;
    _callBack(
      _index,
      _timePrice,
    );
    if (dismissCallback != null) {
      dismissCallback();
    }
  }

  InkWell buildShiftPriceCard(
    int min,
    int price,
  ) {
    return InkWell(
      onTap: () {
        if (_timePrice.length != 0 && _timePrice[min] != null) {
          _refreshState(() {
            _timePrice.clear();
          });
        } else {
          _timePrice.clear();
          _refreshState(() {
            if (_timePrice[min] != null) {
              _timePrice.remove(min);
            } else {
              _timePrice[min] = price;
            }
          });
        }
      },
      child: Container(
          height: 60,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _timePrice[min] != null
                ? Color.fromRGBO(242, 242, 242, 1)
                : Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images_gps/processing.svg',
                        height: 20, width: 20, color: Colors.black),
                    SizedBox(width: 5),
                    new Text(
                      '$min分',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'NotoSansJP',
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              new Text(
                price == 0 ? "利用できません" : '\t¥$price',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: price == 0 ? Colors.grey : Colors.black,
                    fontSize: price == 0 ? 10 : 13,
                    fontFamily: 'NotoSansJP',
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}

class TrianglePainter extends CustomPainter {
  bool isDownArrow;
  Color color;

  TrianglePainter({this.isDownArrow = true, this.color});

  /// Draws the triangle of specific [size] on [canvas]
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    Paint paint = new Paint();
    paint.strokeWidth = 2.0;
    paint.color = color;
    paint.style = PaintingStyle.fill;
    //     .fill;
    // paint.maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3));

    if (isDownArrow) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      /* path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1); */
    }

    canvas.drawPath(path, paint);
    // canvas.drawShadow(path, Colors.red, 8.0, true);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  /// Specifies to redraw for [customPainter]
  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
  }
}

class TrianglePainterShadow extends CustomPainter {
  bool isDownArrow;
  Color color;

  TrianglePainterShadow({this.isDownArrow = true, this.color});

  /// Draws the triangle of specific [size] on [canvas]
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    Paint paint = new Paint();
    paint.strokeWidth = 1.0;
    paint.color = color;
    paint.style = PaintingStyle.stroke;
    /*  paint.maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3)); */

    if (isDownArrow) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, 0);
      path.lineTo(size.width, size.height);
      // path.lineTo(0, size.height);
      /*  path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1); */
    }

    canvas.drawPath(path, paint);
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  /// Specifies to redraw for [customPainter]
  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
  }
}
