import 'package:flutter/material.dart';

class GrowingTree extends StatefulWidget {
  final double growthFactor; // This represents the growth level of the tree

  const GrowingTree({Key? key, required this.growthFactor}) : super(key: key);

  @override
  _GrowingTreeState createState() => _GrowingTreeState();
}

class _GrowingTreeState extends State<GrowingTree> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: widget.growthFactor).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(GrowingTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.growthFactor != widget.growthFactor) {
      _animation = Tween<double>(begin: _animation.value, end: widget.growthFactor).animate(_controller);
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TreePainter(growthFactor: _animation.value),
      child: Container(),
    );
  }
}

class TreePainter extends CustomPainter {
  final double growthFactor;

  TreePainter({required this.growthFactor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    final trunkHeight = size.height * 0.2 * growthFactor;
    final trunkWidth = size.width * 0.1;

    final trunk = Rect.fromCenter(
      center: Offset(size.width / 2, size.height - trunkHeight / 2),
      width: trunkWidth,
      height: trunkHeight,
    );

    final leavesHeight = size.height * 0.8 * growthFactor;
    final leavesWidth = size.width * 0.8;

    final leaves = Rect.fromCenter(
      center: Offset(size.width / 2, size.height - trunkHeight - leavesHeight / 2),
      width: leavesWidth,
      height: leavesHeight,
    );

    canvas.drawRect(trunk, paint);

    paint.color = Colors.green.withOpacity(0.7);
    canvas.drawOval(leaves, paint);
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) {
    return oldDelegate.growthFactor != growthFactor;
  }
}
