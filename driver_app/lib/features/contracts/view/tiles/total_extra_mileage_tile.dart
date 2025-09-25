import 'package:flutter/material.dart';

import '../../../my_vehicles/model/bar_chart_data_model.dart';
import '../../../my_vehicles/view/widgets/vertical_bar_chart_widget.dart';

class TotalExtraMileageTile extends StatelessWidget {
  const TotalExtraMileageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalBarChartWidget(
      chartHeight: 180,
      data: [
        BarChartDataModel(month: 'January', value: 50),
        BarChartDataModel(month: 'February', value: 167),
        BarChartDataModel(month: 'March', value: 200),
        BarChartDataModel(month: 'April', value: 123),
        BarChartDataModel(month: 'May', value: 45),
        BarChartDataModel(month: 'June', value: 150),
        BarChartDataModel(month: 'July', value: 56),
        BarChartDataModel(month: 'August', value: 47),
        BarChartDataModel(month: 'September', value: 200),
        BarChartDataModel(month: 'October', value: 0),
        BarChartDataModel(month: 'November', value: 0),
        BarChartDataModel(month: 'December', value: 0),
      ],
      mileage: '1032',
      subtitle: 'Total extra mileage',
      year: '2024',
    );
  }
}
