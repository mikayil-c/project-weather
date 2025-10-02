import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_weather/shared/helpers/parse_helper.dart';
import 'package:project_weather/l10n/app_localizations.dart';

class Compass extends StatefulWidget {
  final int? degree;

  const Compass({super.key, required this.degree});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _swayAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _swayAnimation = Tween<double>(
      begin: -0.04,
      end: 0.04,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      key: ValueKey(widget.degree),
      tween: Tween(begin: 0, end: ParseHelper.parseDouble(widget.degree)),
      duration: const Duration(seconds: 2),
      curve: Curves.easeOutBack,
      builder: (context, currentAngle, child) {
        return AnimatedBuilder(
          animation: _swayAnimation,
          builder: (context, _) {
            final mainRotationRad = (currentAngle - 90) * pi / 180;
            final finalRotationRad = mainRotationRad + _swayAnimation.value;

            final localizations = AppLocalizations.of(context)!;

            return Transform.rotate(
              angle: finalRotationRad,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.25),
                          Color.fromRGBO(255, 255, 255, 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(255, 255, 255, 0.5),
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.navigation_outlined,
                    size: 70,
                    color: Colors.redAccent,
                  ),

                  Transform.rotate(
                    angle: -finalRotationRad,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 8,
                          child: Text(
                            localizations.northLetter,
                            style: _dirStyle,
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          child: Text(
                            localizations.southLetter,
                            style: _dirStyle,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          child: Text(
                            localizations.eastLetter,
                            style: _dirStyle,
                          ),
                        ),
                        Positioned(
                          left: 8,
                          child: Text(
                            localizations.westLetter,
                            style: _dirStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

const _dirStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  shadows: [Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(1, 1))],
);
