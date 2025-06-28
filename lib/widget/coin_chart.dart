import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:job_review/constant/color_const.dart';

class CoinLineChart extends StatelessWidget {
  const CoinLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final coinValues = [5.0, 10.0, 6.0, 8.0, 12.0];

    final mainBarData = LineChartBarData(
      spots: List.generate(
        coinValues.length,
        (i) => FlSpot(i.toDouble(), coinValues[i]),
      ),
      isCurved: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 4,
            color: whiteColor,
            strokeColor: appColor,
            strokeWidth: 2,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [appColor.withOpacity(0.3), whiteColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      color: appColor,
      barWidth: 3,
    );

    return AspectRatio(
      aspectRatio: 2.5,
      child: LineChart(
        LineChartData(
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            enabled: false,
            touchTooltipData: LineTouchTooltipData(
              // tooltipBgColor: Colors.transparent,
              getTooltipColor: (touchedSpot) {
                return whiteColor;
              },
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 14,
              getTooltipItems: (spots) => spots.map((spot) {
                return LineTooltipItem(
                  '🌕₹${spot.y.toInt()}',
                  const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                  ),
                );
              }).toList(),
            ),
            handleBuiltInTouches: false,
          ),
          showingTooltipIndicators: List.generate(coinValues.length, (index) {
            return ShowingTooltipIndicators([
              LineBarSpot(
                mainBarData,
                0,
                FlSpot(index.toDouble(), coinValues[index]),
              )
            ]);
          }),
          lineBarsData: [
            mainBarData,
            // Optional dashed line (future data)
            LineChartBarData(
              spots: const [
                FlSpot(4, 12),
                FlSpot(5, 9),
                FlSpot(6, 12),
              ],
              isCurved: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              color: greyColor.withOpacity(0.4),
              barWidth: 3,
              dashArray: [5, 0],
            ),
          ],
          extraLinesData: const ExtraLinesData(),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 15,
        ),
      ),
    );
  }
}
