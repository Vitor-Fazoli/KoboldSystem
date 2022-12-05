import 'dart:async';
import 'package:Kobold/pages/chart.dart';
import 'package:flutter/material.dart';
import 'package:Kobold/core/data_model.dart';
import 'package:Kobold/pages/historic.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'core/color.dart';

class MyHomePage extends StatelessWidget {
  final Future<List<DataModel>> values;

  const MyHomePage({Key key, this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          "Kobold",
          style: TextStyle(
              fontFamily: 'KenyanCoffee',
              color: primary,
              fontWeight: FontWeight.bold,
              fontSize: 28),
        ),
        backgroundColor: background,
      ),
      drawer: const NavigationDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              width: 300,
              height: 300,
              child: FutureBuilder<List<DataModel>>(
                future: values,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? buildCircular(snapshot.data)
                      : Center(
                          child: CircularProgressIndicator(
                          color: primary,
                        ));
                },
              ),
            ),
            Center(
                child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyHomePage(values: fetchData())));
              },
              child: Icon(
                Icons.change_circle_outlined,
                color: secondary,
                size: 60,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(8),
                backgroundColor: background, // <-- Button color
              ),
            )),
            Center(
                child: Container(
              height: 60,
              margin: EdgeInsets.only(top: 20),
              color: primary,
              child: Center(
                child: DigitalClock(
                  areaDecoration: BoxDecoration(color: Colors.transparent),
                  areaAligment: AlignmentDirectional.center,
                  hourMinuteDigitDecoration:
                      BoxDecoration(color: Colors.transparent),
                  hourMinuteDigitTextStyle: TextStyle(fontSize: 30),
                  showSecondsDigit: false,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget buildCircular(List<DataModel> dataList)  =>
      LiquidCircularProgressIndicator(
        value: DataModel.currentValue / 100,
        // Defaults to 0.5.
        valueColor: AlwaysStoppedAnimation(primary),
        // Defaults to the current Theme's accentColor.
        backgroundColor: backgroundDark,
        // Defaults to the current Theme's backgroundColor.
        direction: Axis.vertical,
        // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
        center: Text(
          DataModel.currentValue.toString() + ' cm',
          style: TextStyle(color: secondary, fontSize: 70),
        ),
      );
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: backgroundDark,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[buildHeader(context), buildMenuItems(context)],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        color: backgroundDark,
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(
                Icons.history_outlined,
                color: Colors.grey,
              ),
              title: const Text(
                'Histórico',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HistoricPage(values: fetchData())));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.auto_graph_outlined,
                color: Colors.grey,
              ),
              title: const Text(
                'Gráfico',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChartPage()));
              },
            ),
          ],
        ),
      );
}
