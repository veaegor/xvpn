import 'package:flutter/material.dart';

class PulsatingButton extends StatefulWidget {
  const PulsatingButton(
      {Key? key,
      this.onPressed,
      required this.selectedColor,
      required this.counter})
      : super(key: key);
  final Color selectedColor;
  final VoidCallback? onPressed;
  final int counter;
  @override
  State<PulsatingButton> createState() => _PulsatingButtonState();
}

class _PulsatingButtonState extends State<PulsatingButton>
    with SingleTickerProviderStateMixin {
  bool isFin = false;
  late AnimationController _animationController;
  late Animation _animation;
  String text = 'Disconnected';

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 30.0).animate(_animationController)
      ..addListener(() {});
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationController.reset();
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFin = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            textSwitch();
            _animationController.forward();
            widget.onPressed?.call();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 15,
                    color: widget.selectedColor,
                  ),
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      spreadRadius: _animation.value,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/button.png',
                      height: 80,
                      color: widget.selectedColor,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: widget.selectedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '139.99.69.219',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void textSwitch() {
    switch (widget.counter) {
      case 0:
        setState(() {
          text = "Connecting";
        });
        break;
      case 1:
        setState(() {
          text = "Connected";
        });
        break;
      case 2:
        setState(() {
          text = "Connection Failed";
        });
        break;
    }
  }
}
