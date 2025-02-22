import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  VoidCallback dismissCallback;

  Size _screenSize;

  BuildContext context;
  Color _backgroundColor;

  bool _isVisible = false;

  BorderRadius _borderRadius;
  EdgeInsetsGeometry _padding;

  ShowToolTip(this.context,
      {double height,
      double width,
      VoidCallback onDismiss,
      Color backgroundColor,
      String text,
      TextStyle textStyle,
      BorderRadius borderRadius,
      EdgeInsetsGeometry padding}) {
    this.dismissCallback = onDismiss;
    this._popupHeight = height;
    this._popupWidth = width;
    this._text = text;
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
    if (dy <= MediaQuery.of(context).padding.top + 10) {
      // not enough space above, show popup under the widget.
      dy = arrowHeight + _showRect.height + _showRect.top;
      _isDownArrow = false;
    } else {
      dy -= arrowHeight;
      _isDownArrow = true;
    }

    return Offset(dx, dy);
  }

  /// Builds Layout of popup for specific [offset]
  LayoutBuilder buildPopupLayout(Offset offset) {
    var split = _text.split(',');
    //var storeType = {for (int i = 0; i < split.length; i++) i: split[i]};
    final jsonList = split.map((item) => jsonEncode(item)).toList();
    final uniqueJsonList = jsonList.toSet().toList();
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          dismiss();
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              // popup content
              Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Container(
                    padding: _padding,
                    width: _popupWidth,
                    height: _popupHeight,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        color: _backgroundColor,
                        borderRadius: _borderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF808080),
                            blurRadius: 1.0,
                          ),
                        ]),
                    child: ListView.builder(
                        itemCount: result.length,
                        padding: EdgeInsets.all(0.0),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: result[index].contains("エステ")
                                          ? SvgPicture.asset(
                                              "assets/images_gps/serviceTypeOne.svg",
                                              height: 15.0,
                                              width: 15.0,
                                              color: Colors.black,
                                            )
                                          : result[index].contains("接骨・整体")
                                              ? SvgPicture.asset(
                                                  "assets/images_gps/serviceTypeTwo.svg",
                                                  height: 15.0,
                                                  width: 15.0,
                                                  color: Colors.black,
                                                )
                                              : result[index]
                                                      .contains("リラクゼーション")
                                                  ? SvgPicture.asset(
                                                      "assets/images_gps/serviceTypeThree.svg",
                                                      height: 15.0,
                                                      width: 15.0,
                                                      color: Colors.black,
                                                    )
                                                  : /*  storeType[index] == "フィットネス" ? */
                                                  SvgPicture.asset(
                                                      "assets/images_gps/serviceTypeFour.svg",
                                                      height: 15.0,
                                                      width: 15.0,
                                                      color: Colors.black,
                                                    )),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  result[index],
                                  style: _textStyle,
                                ),
                              ],
                            ),
                          );
                        })
                    /*  SingleChildScrollView(
                    child: Text(
                      _text,
                      style: _textStyle,
                    ),
                  ), */
                    ),
              ),
              // triangle arrow
              Positioned(
                left: _showRect.left + _showRect.width / 2.0 - 7.5,
                top: _isDownArrow
                    ? offset.dy + _popupHeight
                    : offset.dy - arrowHeight,
                child: CustomPaint(
                  size: Size(15.0, arrowHeight),
                  painter: TrianglePainter(
                      isDownArrow: _isDownArrow, color: _backgroundColor),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Dismisses the popup
  void dismiss() {
    if (!_isVisible) {
      return;
    }
    _entry.remove();
    _isVisible = false;
    if (dismissCallback != null) {
      dismissCallback();
    }
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
    /*  paint.maskFilter = MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(3)); */

    if (isDownArrow) {
      path.moveTo(0.0, -1.0);
      path.lineTo(size.width, -1.0);
      path.lineTo(size.width / 2.0, size.height);
    } else {
      path.moveTo(size.width / 2.0, 0.0);
      path.lineTo(0.0, size.height + 1);
      path.lineTo(size.width, size.height + 1);
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
