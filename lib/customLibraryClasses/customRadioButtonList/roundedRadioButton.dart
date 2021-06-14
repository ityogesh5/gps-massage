import 'package:flutter/material.dart';

import 'baseSelect.dart';

class CustomRadioButton extends StatelessWidget {
  final double size;
  final bool selected;
  final Color color;
  final ValueChanged<bool> onChange;

  const CustomRadioButton({
    Key key,
    this.size = 10.0,
    this.selected = false,
    this.color = Colors.grey,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseSelect(
      selected: selected,
      onChange: onChange,
      builder: (BuildContext context, Animation animation) {
        return Container(
          width: 10,
          height: 10,
          child: CustomPaint(
            painter: CustomRadioButtonPainter(
                animation: animation, checked: true, color: Colors.black),
          ),
        );
      },
    );
  }
}

class CustomRadioButtonPainter extends CustomPainter {
  final Animation animation;
  final Color color;
  final bool checked;

  CustomRadioButtonPainter({this.animation, this.checked, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 1, size.height / 1);
    final Paint borderPaint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final Paint innerCirclePaint = Paint()
      ..color = color.withOpacity(animation.value);
    canvas.drawCircle(center, size.width / 1, borderPaint);
    canvas.drawCircle(center, size.width / 1 - 3.0, innerCirclePaint);
  }

  @override
  bool shouldRepaint(CustomRadioButtonPainter oldDelegate) {
    return oldDelegate.checked != checked;
  }
}
