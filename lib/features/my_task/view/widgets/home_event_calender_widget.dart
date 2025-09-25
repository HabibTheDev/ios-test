// ignore_for_file: use_build_context_synchronously
part of 'widget_imports.dart';

class HomeEventCalenderWidget extends StatefulWidget {
  const HomeEventCalenderWidget({super.key, required this.onTimeSelected, required this.eventList});
  final Function(DateTime selectedDate) onTimeSelected;
  final List<DateTime> eventList;

  @override
  State<HomeEventCalenderWidget> createState() => _HomeEventCalenderWidgetState();
}

class _HomeEventCalenderWidgetState extends State<HomeEventCalenderWidget> {
  final EasyDatePickerController _controller = EasyDatePickerController();
  DateTime _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 428,
      padding: const EdgeInsets.only(top: 290),
      decoration: BoxDecoration(
        color: AppColors.lightCardColor,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
      ),
      child: Column(
        children: [
          EasyDateTimeLinePicker.itemBuilder(
            selectionMode: const SelectionMode.autoCenter(),
            daySeparatorPadding: 8.0,
            controller: _controller,
            currentDate: DateTime.now(),
            firstDate: DateTime(1970),
            focusedDate: _focusDate,
            itemExtent: 52,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            headerOptions: HeaderOptions(
              headerBuilder: (context, date, onTapAction) {
                return InkWell(
                  onTap: () async {
                    DateTime? selectedDate = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(
                      context,
                      initialDate: date,
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      _controller.animateToDate(selectedDate);
                      setState(() => _focusDate = selectedDate);
                      widget.onTimeSelected(selectedDate);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_month, color: AppColors.primaryColor, size: 18),
                      const WidthBox(width: 8),
                      BodyText(
                        text: readableDate(date, pattern: AppString.calendarDateFormat),
                        textSize: 18,
                        textColor: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                );
              },
            ),
            itemBuilder: (context, date, isSelected, isDisabled, isToday, onTap) {
              final bool hasEvent = widget.eventList.any((eventDate) =>
                  eventDate.year == date.year && eventDate.month == date.month && eventDate.day == date.day);
              return InkWell(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 22),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor.withAlpha(27) : null,
                    border: isSelected ? Border.all(color: AppColors.primaryColor, width: .7) : null,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BodyText(
                            text: date.day.toString().padLeft(2, '0'),
                            textColor: isSelected ? AppColors.primaryColor : null,
                            textSize: isSelected ? 24 : null,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                          SmallText(
                            text: readableDate(date, pattern: AppString.dayOfWeek),
                            textSize: isSelected ? 14 : null,
                            textColor: isSelected ? AppColors.primaryColor : AppColors.lightSecondaryTextColor,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      if (!isSelected && hasEvent)
                        const Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(backgroundColor: AppColors.primaryColor, radius: 3),
                        )
                    ],
                  ),
                ),
              );
            },
            onDateChange: (date) {
              setState(() => _focusDate = date);
              _controller.animateToDate(_focusDate);
              widget.onTimeSelected(_focusDate);
            },
          ),
          // const HeightBox(height: 16)
        ],
      ),
    );
  }
}
