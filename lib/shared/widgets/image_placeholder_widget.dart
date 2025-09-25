part of 'widget_imports.dart';

class ImagePlaceholderWidget extends StatefulWidget {
  const ImagePlaceholderWidget({super.key, this.width, this.iconSize, this.height, this.showShimmer = true});
  final double? height;
  final double? width;
  final double? iconSize;
  final bool showShimmer;

  @override
  State<ImagePlaceholderWidget> createState() => _ImagePlaceholderWidgetState();
}

class _ImagePlaceholderWidgetState extends State<ImagePlaceholderWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    if (widget.showShimmer) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 100,
      height: widget.height ?? 100,
      decoration: BoxDecoration(
        color: AppColors.lightTextFieldHintColor.withAlpha(102),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: widget.showShimmer
          ? AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ShimmerPainter(
                    animation: _animation.value,
                    baseColor: AppColors.lightTextFieldHintColor.withAlpha(100),
                    shimmerColor: AppColors.lightTextFieldHintColor.withAlpha(200),
                  ),
                );
              },
            )
          : null,
    );
  }
}

class ShimmerPainter extends CustomPainter {
  final double animation;
  final Color baseColor;
  final Color shimmerColor;

  ShimmerPainter({required this.animation, required this.baseColor, required this.shimmerColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(animation - 1, 0),
        end: Alignment(animation, 0),
        colors: [baseColor, shimmerColor, baseColor],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(ShimmerPainter oldDelegate) {
    return oldDelegate.animation != animation ||
        oldDelegate.baseColor != baseColor ||
        oldDelegate.shimmerColor != shimmerColor;
  }
}
