part of 'widget_imports.dart';

class HeightBox extends StatelessWidget {
  const HeightBox({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
