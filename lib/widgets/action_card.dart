import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimens.dart';
import '../core/constants/app_text_styles.dart';

/// Large tappable card used for the two primary Home actions:
/// "Send" and "Receive". Includes a gentle scale-in press animation.
class ActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback? onTap;

  const ActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    this.onTap,
  });

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  double _scale = 1.0;

  void _setScale(double value) => setState(() => _scale = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setScale(0.96),
      onTapUp: (_) => _setScale(1.0),
      onTapCancel: () => _setScale(1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          padding: const EdgeInsets.all(AppDimens.space20),
          height: 150,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSmall),
                ),
                child: Icon(widget.icon, color: Colors.white, size: 22),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.h3.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppDimens.space4),
                  Text(
                    widget.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
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
