import 'package:Kobold/core/color.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/data_model.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Kobold',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: ChartWidget(values: fetchData()));
  }
}

class ChartWidget extends StatelessWidget {
  final Future<List<DataModel>> values;

  ChartWidget({this.values, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            child: FutureBuilder<List<DataModel>>(
              future: values,
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? chartData(snapshot.data)
                    : Center(child: CircularProgressIndicator(color: primary));
              },
            ),
          ),
        ),
      );
}

Widget chartData(List<DataModel> dataList) {
  List<FlSpot> data = List.generate(dataList.length, (index) {
    return FlSpot(index.toDouble(), dataList[index].value);
  });

  return LineChart(
    LineChartData(
      borderData: FlBorderData(show: true),
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: false,
          barWidth: 3,
          color: primary,
        ), // The orange line
      ],
    ),
  );
}
