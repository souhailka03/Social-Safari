import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0.5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Accueil',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 14,
                height: 15,
                child: CustomPaint(
                  painter: NotificationIconPainter(),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 19,
                height: 19,
                decoration: const BoxDecoration(
                  color: Color(0xFFCED0F8),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/216133e8eea83f5382dba7c712a5a691d784f9b3',
                    width: 19,
                    height: 19,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFCED0F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.moveTo(9.65, 6.27418);
    path.lineTo(9.65, 4.96966);
    path.cubicTo(9.65, 3.28857, 8.2397, 1.92578, 6.5, 1.92578);
    path.cubicTo(4.7603, 1.92578, 3.35, 3.28857, 3.35, 4.96966);
    path.lineTo(3.35, 6.27418);
    path.cubicTo(3.35, 7.70915, 2, 8.05702, 2, 8.88321);
    path.cubicTo(2, 9.62244, 3.755, 10.1877, 6.5, 10.1877);
    path.cubicTo(9.245, 10.1877, 11, 9.62244, 11, 8.88321);
    path.cubicTo(11, 8.05702, 9.65, 7.70915, 9.65, 6.27418);
    canvas.drawPath(path, paint);

    // Draw the bottom part of the notification bell
    Paint fillPaint = Paint()
      ..color = const Color(0xCCC5C7CC)
      ..style = PaintingStyle.fill;

    Path fillPath = Path();
    fillPath.moveTo(6.50008, 11.231);
    fillPath.cubicTo(6.04513, 11.231, 5.61763, 11.2162, 5.21533, 11.1875);
    fillPath.cubicTo(5.39136, 11.7301, 5.91163, 12.0994, 6.50008, 12.0994);
    fillPath.cubicTo(7.08853, 12.0994, 7.60881, 11.7301, 7.78483, 11.1875);
    fillPath.cubicTo(7.38253, 11.2162, 6.95503, 11.231, 6.50008, 11.231);
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
