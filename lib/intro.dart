import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'home.dart';

class DivineIntroApp extends StatelessWidget {
  const DivineIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DivineIntroScreen(),
    );
  }
}

class DivineIntroScreen extends StatefulWidget {
  const DivineIntroScreen({super.key});

  @override
  State<DivineIntroScreen> createState() => _DivineIntroScreenState();
}

class _DivineIntroScreenState extends State<DivineIntroScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();

    _t = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubicEmphasized,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fluteIvory = Color(0xFFFDFDFD);
    const shyamDeepBlue = Color(0xFF003366);
    const peacockTeal = Color(0xFF008080);

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _t,
        builder: (context, _) {
          return CustomPaint(
            painter: _CornerFlowAnimPainter(
              base: fluteIvory,
              topLeftColor: shyamDeepBlue,
              bottomRightColor: peacockTeal,
              t: _t.value,
            ),
            child: const Center(
              child: Text(
                'श्री हरि',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD4AF37), // soft gold
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CornerFlowAnimPainter extends CustomPainter {
  final Color base;
  final Color topLeftColor;
  final Color bottomRightColor;
  final double t;

  _CornerFlowAnimPainter({
    required this.base,
    required this.topLeftColor,
    required this.bottomRightColor,
    required this.t,
  });

  double _ease(double x) => Curves.easeInOutCubic.transform(x.clamp(0.0, 1.0));

  Path _cornerWedgeTL(double w, double h, double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..quadraticBezierTo(x * 0.45, y * 0.45, 0, y)
      ..close();
  }

  Path _cornerWedgeBR(double w, double h, double x, double y) {
    return Path()
      ..moveTo(w, h)
      ..lineTo(w, h - y)
      ..quadraticBezierTo(w - x * 0.45, h - y * 0.45, w - x, h)
      ..close();
  }

  Paint _wedgePaint(Color solid, Rect bounds, Alignment begin, Alignment end) {
    final shader = LinearGradient(
      begin: begin,
      end: end,
      colors: [
        solid,
        Color.alphaBlend(Colors.white.withOpacity(0.08), solid),
      ],
    ).createShader(bounds);
    return Paint()..shader = shader;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final w = size.width;
    final h = size.height;
    canvas.drawRect(rect, Paint()..color = base);

    final p = _ease(t);
    final tlX = lerpDouble(0, w * 0.55, p)!;
    final tlY = lerpDouble(0, h * 0.55, p)!;
    final brX = lerpDouble(0, w * 0.55, p)!;
    final brY = lerpDouble(0, h * 0.55, p)!;

    final tlPath = _cornerWedgeTL(w, h, tlX, tlY);
    canvas.drawPath(
      tlPath,
      _wedgePaint(
        topLeftColor,
        Rect.fromLTWH(0, 0, max(1.0, tlX), max(1.0, tlY)),
        Alignment.topLeft,
        const Alignment(0.3, 0.3),
      ),
    );

    final brPath = _cornerWedgeBR(w, h, brX, brY);
    canvas.drawPath(
      brPath,
      _wedgePaint(
        bottomRightColor,
        Rect.fromLTWH(w - max(1.0, brX), h - max(1.0, brY), max(1.0, brX), max(1.0, brY)),
        Alignment.bottomRight,
        const Alignment(0.8, 0.8),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _CornerFlowAnimPainter oldDelegate) =>
      oldDelegate.t != t;
}
