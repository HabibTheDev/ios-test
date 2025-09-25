// ignore_for_file: use_build_context_synchronously
part of 'widget_imports.dart';

class HomeCalenderWidget extends StatefulWidget {
  const HomeCalenderWidget({super.key, required this.onTimeSelected});
  final Function(DateTime selectedDate) onTimeSelected;

  @override
  State<HomeCalenderWidget> createState() => _HomeCalenderWidgetState();
}

class _HomeCalenderWidgetState extends State<HomeCalenderWidget> {
  final EasyInfiniteDateTimelineController _controller = EasyInfiniteDateTimelineController();

  DateTime? _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.only(top: 290),
      decoration: BoxDecoration(
          color: AppColors.lightCardColor, boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)]),
      child: Column(
        children: [
          EasyInfiniteDateTimeLine(
            selectionMode: const SelectionMode.autoCenter(),
            controller: _controller,
            firstDate: DateTime(1970),
            focusDate: _focusDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            headerBuilder: (context, date) {
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
                ).paddingOnly(bottom: 16),
              );
            },
            dayProps: EasyDayProps(
              height: 68,
              width: 56,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: const DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border(
                      left: BorderSide.none, top: BorderSide.none, right: BorderSide.none, bottom: BorderSide.none),
                ),
                dayNumStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.lightSecondaryTextColor),
                dayStrStyle: TextStyle(fontSize: 10.0),
              ),
              todayStyle: DayStyle(
                  decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: .7),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              )),
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: const Color(0xffEFF5FD),
                  border: Border.all(color: AppColors.primaryColor, width: .7),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                dayStrStyle: const TextStyle(fontSize: 14.0, color: AppColors.primaryColor),
                dayNumStyle:
                    const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
            ),
            onDateChange: (selectedDate) {
              setState(() => _focusDate = selectedDate);
              widget.onTimeSelected(selectedDate);
            },
          ),
          const HeightBox(height: 16)
        ],
      ),
    );
  }
}
