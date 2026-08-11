import 'package:flutter/material.dart';

/// A button that plays a subtle bounce animation on tap.
class BouncyButton extends StatefulWidget {
  const BouncyButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.scale = 0.93,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final double scale;

  @override
  State<BouncyButton> createState() => _BouncyButtonState();
}

class _BouncyButtonState extends State<BouncyButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: widget.scale).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _handleTapDown(TapDownDetails _) async {
    await _ctrl.forward();
  }

  Future<void> _handleTapUp(TapUpDetails _) async {
    await _ctrl.reverse();
    widget.onPressed?.call();
  }

  Future<void> _handleTapCancel() async {
    await _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null ? _handleTapDown : null,
      onTapUp: widget.onPressed != null ? _handleTapUp : null,
      onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: widget.child,
      ),
    );
  }
}
