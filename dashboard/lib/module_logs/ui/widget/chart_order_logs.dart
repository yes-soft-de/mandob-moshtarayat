import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/generated/l10n.dart';
import 'package:mandob_moshtarayat_dashboad/module_logs/ui/widget/indector.dart';

class PieChartSample2 extends StatefulWidget {
  final int countProducts;
  final int countPrivate;
  final int countDeliver;

  PieChartSample2(
      {required this.countProducts,
      required this.countPrivate,
      required this.countDeliver});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: showingSections()),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Text(
              ' ${widget.countProducts + widget.countDeliver + widget.countPrivate} ' +
                  S.current.order,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Indicator(
                  color: Theme.of(context).primaryColor,
                  text: S.current.products,
                  isSquare: false,
                ),
                Indicator(
                  color: Colors.amber,
                  text: S.current.privateOrder,
                  isSquare: false,
                ),
                Indicator(
                  color: Colors.grey[800]!,
                  text: S.current.deliverForMe,
                  isSquare: false,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    int total =
        widget.countProducts + widget.countDeliver + widget.countPrivate;
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          double value = (100 * widget.countProducts) / total;
          return PieChartSectionData(
            color: Theme.of(context).primaryColor,
            value: value.floorToDouble(),
            title: isTouched
                ? '${widget.countProducts}'
                : '${value.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          double value = (100 * widget.countPrivate) / total;
          return PieChartSectionData(
            color: Colors.amber,
            value: value.floorToDouble(),
            title: isTouched
                ? '${widget.countPrivate}'
                : '${value.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          double value = (100 * widget.countDeliver) / total;

          return PieChartSectionData(
            color: Colors.grey[800],
            value: value.floorToDouble(),
            title: isTouched
                ? '${widget.countDeliver}'
                : '${value.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
