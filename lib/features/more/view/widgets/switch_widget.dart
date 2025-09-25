part of 'widget_imports.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool value) onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .7,
      child: Switch(
        value: _value,
        inactiveTrackColor: AppColors.lightTextFieldFillColor,
        inactiveThumbColor: AppColors.lightTextFieldHintColor,
        trackOutlineColor: WidgetStateProperty.all<Color>(AppColors.lightTextFieldHintColor),
        onChanged: (value) {
          widget.onChanged(value);
          setState(() => _value = value);
        },
      ),
    );
  }
}
