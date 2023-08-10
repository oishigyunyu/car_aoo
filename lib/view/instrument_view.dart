import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Instrument extends StatefulWidget {
  const Instrument({Key? key}) : super(key: key);

  @override
  State<Instrument> createState() => _InstrumentState();
}

class _InstrumentState extends State<Instrument> {
  int _deg = 0;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTimer);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: MeterIndicator(
              deg: _deg,
            ),
          ),
        ),
      ),
    );
  }

  void _onTimer(Timer timer) {
    var random = Random();
    var value = random.nextInt(800);
    setState(() {
      _deg = value;
    });
  }
}

class _MeterIndicatorPainter extends CustomPainter {
  final double textCircleRadius; // 内側に表示される白丸の半径
  final int deg;

  _MeterIndicatorPainter({required this.textCircleRadius, required this.deg});

  @override
  void paint(Canvas canvas, Size size) {
    const color = Colors.yellow;
    const spaceLen = 16; // 円とゲージ間の長さ
    const baseLineLen = 30; // ゲージの長さ
    final offset0 = Offset(size.width * 0.5, size.height * 0.5);
    final blackPaint = Paint()
      ..isAntiAlias = true
      ..color = Colors.black;
    canvas.drawCircle(offset0, 160, blackPaint);
    for (int i = 0; i <= 120; i += 30) {
      final per = i / 360.0;
      // 割合（0~1.0）からグラデーション色に変換
      var paintBase = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..isAntiAlias = true;
      if (i == 0 || i == 60 || i == 120) {
        paintBase.strokeWidth = 6;
      } else {
        paintBase.strokeWidth = 4;
      }

      var paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..isAntiAlias = true;

      final angle = (2 * pi * per) - (5 * pi / 6); // 0時方向から開始するため-90度ずらす

      // 円の中心座標

      // 線の内側部分の座標
      final offset1 = offset0.translate(
        (textCircleRadius + spaceLen) * cos(angle),
        (textCircleRadius + spaceLen) * sin(angle),
      );
      // 線の外側部分の座標
      final offset2 = offset1.translate(
        baseLineLen * cos(angle),
        baseLineLen * sin(angle),
      );
      canvas.drawLine(offset1, offset2, paintBase);
      final lineAngle =
          (deg.toDouble() / 800.0) * (2.0 * pi / 3.0) - (5.0 * pi / 6.0);
      final lineOffset = offset0.translate(
        (textCircleRadius + spaceLen + baseLineLen) * cos(lineAngle),
        (textCircleRadius + spaceLen + baseLineLen) * sin(lineAngle),
      );
      canvas.drawLine(offset0, lineOffset, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MeterIndicator extends StatelessWidget {
  final percentage = 0.7;
  final size = 164.0;
  final int deg;

  const MeterIndicator({super.key, required this.deg});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MeterIndicatorPainter(
        textCircleRadius: size * 0.5,
        deg: deg,
      ),
    );
  }
}
