part of 'widget_imports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color = AppColors.primaryColor, this.size = 24});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ThreeBounceIndicator(color: color);
  }
}

class CenterLoadingWidget extends StatelessWidget {
  const CenterLoadingWidget({super.key, this.color = AppColors.primaryColor, this.size = 24});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ThreeBounceIndicator(color: color),
    );
  }
}

class ThreeBounceIndicator extends StatefulWidget {
  const ThreeBounceIndicator({
    super.key,
    this.color,
    this.size = 24.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.controller,
  }) : assert(
          !(itemBuilder is IndexedWidgetBuilder && color is Color) && !(itemBuilder == null && color == null),
          'You should specify either a itemBuilder or a color',
        );

  final Color? color;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;

  @override
  State<ThreeBounceIndicator> createState() => _SpinKitThreeBounceState();
}

class _SpinKitThreeBounceState extends State<ThreeBounceIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ?? AnimationController(vsync: this, duration: widget.duration))..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(widget.size * 2, widget.size),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          return ScaleTransition(
            scale: DelayTween(begin: 0.0, end: 1.0, delay: i * .2).animate(_controller),
            child: SizedBox.fromSize(size: Size.square(widget.size * 0.5), child: _itemBuilder(i)),
          );
        }),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

class DelayTween extends Tween<double> {
  DelayTween({super.begin, super.end, required this.delay});
  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
