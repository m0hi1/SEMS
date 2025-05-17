import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinancialChartWidget extends StatelessWidget {
  const FinancialChartWidget({
    super.key,
    required this.line1Data,
    required this.line2Data,
    this.line1Color = Colors.green,
    this.line2Color = Colors.red,
    this.betweenColor,
    this.aspectRatio = 2.0,
    this.currencySymbol = '₹',
    this.onDataPointTap,
  });

  final List<FlSpot> line1Data;
  final List<FlSpot> line2Data;
  final Color line1Color;
  final Color line2Color;
  final Color? betweenColor;
  final double aspectRatio;
  final String currencySymbol;
  final Function(FlSpot spot, int lineIndex)? onDataPointTap;

  Widget _buildBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    );

    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (value.toInt() < 0 || value.toInt() >= months.length) {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(months[value.toInt()], style: style),
    );
  }

  Widget _buildLeftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        
        '$currencySymbol ${(value * 100).toStringAsFixed(0)}',
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black54,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (line1Data.isEmpty && line2Data.isEmpty) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: const Center(
          child: Text(
            'No data available',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 18,
          top: 10,
          bottom: 4,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.barIndex == 0 ? 'Line 1' : 'Line 2'}\n$currencySymbol ${spot.y.toStringAsFixed(2)}',
                      const TextStyle(color: Colors.white),
                    );
                  }).toList();
                },
              ),
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (event is FlTapUpEvent && response?.lineBarSpots != null) {
                  for (var spot in response!.lineBarSpots!) {
                    // It Uses spot directly since LineBarSpot already contains the spot information
                    onDataPointTap?.call(FlSpot(spot.x, spot.y), spot.barIndex);
                  }
                }
              },
            ),
            lineBarsData: [
              if (line1Data.isNotEmpty)
                LineChartBarData(
                  spots: line1Data,
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              if (line2Data.isNotEmpty)
                LineChartBarData(
                  spots: line2Data,
                isCurved: false,
                barWidth: 2,
                color: line2Color,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
              ),
            ],
            betweenBarsData: line1Data.isNotEmpty && line2Data.isNotEmpty
                ? [
                    BetweenBarsData(
                      fromIndex: 0,
                      toIndex: 1,
                      color: betweenColor ?? line2Color.withOpacity(0.3),
                    )
                  ]
                : [],
            minY: 0,
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: _buildBottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: _buildLeftTitleWidgets,
                  interval: 1,
                  reservedSize: 36,
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
              horizontalInterval: 1,
            ),
          ),
        ),
      ),
    );
  }
}
