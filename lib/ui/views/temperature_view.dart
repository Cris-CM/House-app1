import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:house_app/colors/palette.dart';

class TemperatureDialView extends StatefulWidget {
  const TemperatureDialView({super.key});

  @override
  State<TemperatureDialView> createState() => _TemperatureDialViewState();
}

class _TemperatureDialViewState extends State<TemperatureDialView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FA),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Habitación',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 40),
              const TemperatureDial(temp: 22),

              SizedBox(height: 20),
              Container(
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Palette.grey,
                ),
                child: Text(
                  'Sala',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Palette.grey2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Palette.purpleAccent,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Pronto',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Palette.grey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Palette.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Palette.cream,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Temperatura',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Palette.grey2,
                          ),
                        ),
                        Text(
                          '10º',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Palette.grey2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DeviceOption(
                    title: "Ventilador",
                    icon: Icons.whatshot,
                    selected: selectedIndex == 0,
                    onTap: () => setState(() => selectedIndex = 0),
                  ),
                  DeviceOption(
                    title: "Sonido",
                    icon: Icons.music_note,
                    selected: selectedIndex == 1,
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  DeviceOption(
                    title: "Iluminación",
                    icon: Icons.lightbulb_outline,
                    selected: selectedIndex == 2,
                    onTap: () => setState(() => selectedIndex = 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemperatureDial extends StatelessWidget {
  final double temp;
  const TemperatureDial({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(size: const Size(240, 240), painter: _TickMarksPainter()),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFFDFDFE), Color(0xFFEAEAEA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 15,
                offset: const Offset(-5, -5),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(8, 8),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _ArcPainter(temp: temp),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Aire',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    temp.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double temp;
  _ArcPainter({required this.temp});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final startTemp = 10;
    final endTemp = 30;
    final sweepAngle =
        ((temp - startTemp) / (endTemp - startTemp)) * math.pi * 1.2;

    // Fondo gris del arco
    final basePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    // Arco de progreso con degradado
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.redAccent, Colors.purpleAccent],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Dibuja el arco base
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.9,
      math.pi * 1.2,
      false,
      basePaint,
    );

    // Dibuja el arco de progreso
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.9,
      sweepAngle,
      false,
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _TickMarksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final tickPaint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.2;

    const startAngle = math.pi * 0.9;
    const endAngle = math.pi * 2.1;
    const tickCount = 21;

    for (int i = 0; i < tickCount; i++) {
      final angle =
          startAngle + (endAngle - startAngle) * (i / (tickCount - 1));
      final x1 = center.dx + math.cos(angle) * (radius - 6);
      final y1 = center.dy + math.sin(angle) * (radius - 6);
      final x2 = center.dx + math.cos(angle) * radius;
      final y2 = center.dy + math.sin(angle) * radius;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), tickPaint);
    }

    // Texto 10°, 20°, 30°
    _drawText(canvas, '10°', center, radius, startAngle);
    _drawText(canvas, '20°', center, radius, (startAngle + endAngle) / 2);
    _drawText(canvas, '30°', center, radius, endAngle);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    double radius,
    double angle,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final offset = Offset(
      center.dx + math.cos(angle) * (radius + 15) - textPainter.width / 2,
      center.dy + math.sin(angle) * (radius + 15) - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DeviceOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  const DeviceOption({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {},
      onTap: onTap,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 150),
        opacity: selected ? 1.0 : 0.6,
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 150),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.black.withValues(alpha: 0.08),
                  width: 2,
                ),
                gradient: selected
                    ? LinearGradient(
                        colors: [Palette.purpleAccent, Palette.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: selected ? null : Palette.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 9),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 32,
                color: selected ? Palette.white : Palette.grey2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Palette.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
