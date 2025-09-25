import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/bar_chart_data_model.dart';

class VerticalBarChartWidget extends StatelessWidget {
  const VerticalBarChartWidget({
    super.key,
    required this.data,
    required this.mileage,
    required this.subtitle,
    required this.year,
    this.chartHeight,
  });
  final List<BarChartDataModel> data;
  final String mileage;
  final String subtitle;
  final String year;
  final double? chartHeight;

  double get maxY {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return (maxValue * 1).ceilToDouble(); // Add 10% padding to max value
  }

  double get horizontalInterval {
    return (maxY / 5).ceilToDouble(); // Divide by 5 for nice spacing
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      contentPadding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: '$mileage ',
                      style: const TextStyle(
                          color: AppColors.lightTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      children: const [
                        TextSpan(
                            text: 'M',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            )),
                      ],
                    ),
                  ),
                  ExtraSmallText(
                    text: subtitle,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightSecondaryTextColor,
                  )
                ],
              )),
              Expanded(
                  child: CarInfoTile(
                titleKey: 'This year',
                titleValue: year,
                textAlign: TextAlign.end,
              ))
            ],
          ).paddingOnly(bottom: 20),

          // Chart
          SizedBox(
            height: chartHeight ?? 150,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: const EdgeInsets.all(8),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${data[group.x.toInt()].month}\n',
                        const TextStyle(
                          color: AppColors.buttonTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: rod.toY.toString(),
                            style: const TextStyle(
                              color: AppColors.buttonTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: AppColors.lightTextFieldHintColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        );
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Text(data[value.toInt()].month.substring(0, 1),
                              style: style);
                        } else {
                          return const Text('');
                        }
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: horizontalInterval,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          '${value.toInt()}',
                          style: const TextStyle(
                            color: AppColors.lightTextFieldHintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: horizontalInterval,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: AppColors.lightTextFieldHintColor,
                      strokeWidth: 0.5,
                    );
                  },
                ),
                borderData: FlBorderData(
                    show: true,
                    border: const Border(
                        bottom: BorderSide(
                            color: AppColors.lightTextFieldHintColor,
                            width: 0.5))),
                barGroups: _buildBarGroups(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: value,
              width: 10,
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ))
        ],
      );
    }).toList();
  }
}
