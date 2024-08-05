import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waterdropdash/provider/SaveScores.dart';


// Tree Screen
class TreeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magical Growing Tree'),
        backgroundColor: Colors.green[700],
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue[200]!, Colors.green[200]!],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GrowingTreeWidget(growthFactor: gameState.treeGrowth),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Tree Growth: ${(gameState.treeGrowth * 100).toStringAsFixed(1)}%',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Score: ${gameState.score}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (gameState.score >= 10) {
                            gameState.increaseScore(-10);
                            gameState.growTree(0.05);
                            gameState.saveToPrefs();
                          }
                        },
                        child: Text('Nurture Tree (10 points)'),
                        style: ElevatedButton.styleFrom(
                          
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Growing Tree Widget
class GrowingTreeWidget extends StatefulWidget {
  final double growthFactor;

  const GrowingTreeWidget({Key? key, required this.growthFactor}) : super(key: key);

  @override
  _GrowingTreeWidgetState createState() => _GrowingTreeWidgetState();
}

class _GrowingTreeWidgetState extends State<GrowingTreeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: widget.growthFactor).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(GrowingTreeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.growthFactor != widget.growthFactor) {
      _animation = Tween<double>(begin: _animation.value, end: widget.growthFactor).animate(_controller);
      _controller
        ..reset()
        ..forward();
      
      // Add particles for growth effect
      addParticles();
    }
  }

  void addParticles() {
    final random = Random();
    for (int i = 0; i < 20; i++) {
      particles.add(Particle(
        position: Offset(
          random.nextDouble() * MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        color: Colors.green[300]!.withOpacity(0.6),
        size: random.nextDouble() * 10 + 5,
        velocity: Offset(random.nextDouble() * 2 - 1, -random.nextDouble() * 5 - 2),
      ));
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
      painter: TreePainter(growthFactor: _animation.value, particles: particles),
      child: Container(),
    );
  }
}

class TreePainter extends CustomPainter {
  final double growthFactor;
  final List<Particle> particles;

  TreePainter({required this.growthFactor, required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    // Draw trunk
    final trunkPath = Path();
    final trunkWidth = size.width * 0.1;
    final trunkHeight = size.height * 0.4 * growthFactor;
    trunkPath.moveTo(size.width / 2 - trunkWidth / 2, size.height);
    trunkPath.lineTo(size.width / 2 - trunkWidth / 4, size.height - trunkHeight);
    trunkPath.lineTo(size.width / 2 + trunkWidth / 4, size.height - trunkHeight);
    trunkPath.lineTo(size.width / 2 + trunkWidth / 2, size.height);
    canvas.drawPath(trunkPath, paint);

    // Draw branches
    paint.color = Colors.brown[600]!;
    drawBranch(canvas, paint, Offset(size.width / 2, size.height - trunkHeight), 
               pi / 4, size.width * 0.2 * growthFactor, 3);
    drawBranch(canvas, paint, Offset(size.width / 2, size.height - trunkHeight), 
               -pi / 4, size.width * 0.2 * growthFactor, 3);

    // Draw leaves
    paint.color = Colors.green[400]!;
    drawLeaves(canvas, paint, Offset(size.width / 2, size.height - trunkHeight), 
               size.width * 0.4 * growthFactor, 5);

    // Draw particles
    for (var particle in particles) {
      particle.update();
      canvas.drawCircle(particle.position, particle.size, Paint()..color = particle.color);
    }
    particles.removeWhere((particle) => particle.position.dy < 0);
  }

  void drawBranch(Canvas canvas, Paint paint, Offset start, double angle, double length, int depth) {
    if (depth <= 0) return;

    final end = Offset(start.dx + cos(angle) * length, start.dy - sin(angle) * length);
    canvas.drawLine(start, end, paint);

    drawBranch(canvas, paint, end, angle + pi / 5, length * 0.8, depth - 1);
    drawBranch(canvas, paint, end, angle - pi / 5, length * 0.8, depth - 1);
  }

  void drawLeaves(Canvas canvas, Paint paint, Offset center, double radius, int depth) {
    if (depth <= 0) return;

    canvas.drawCircle(center, radius, paint);

    final childRadius = radius * 0.7;
    final childCount = 5;
    for (int i = 0; i < childCount; i++) {
      final angle = 2 * pi * i / childCount;
      final childCenter = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      drawLeaves(canvas, paint, childCenter, childRadius, depth - 1);
    }
  }

  @override
  bool shouldRepaint(TreePainter oldDelegate) {
    return oldDelegate.growthFactor != growthFactor || oldDelegate.particles != particles;
  }
}

class Particle {
  Offset position;
  Color color;
  double size;
  Offset velocity;

  Particle({required this.position, required this.color, required this.size, required this.velocity});

  void update() {
    position += velocity;
    size *= 0.99;
  }
}