import 'package:flutter/material.dart';
import 'package:Kobold/core/color.dart';

import '../core/data_model.dart';

class HistoricPage extends StatelessWidget {
  final Future<List<DataModel>> values;

  HistoricPage({Key key, this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: background,
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: primary,
      ),
      body: Center(
        child: FutureBuilder<List<DataModel>>(
          future: values,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? dataList(snapshot.data)
                : Center(child: CircularProgressIndicator(color: primary));
          },
        ),
      ));
}
Widget dataList(List<DataModel> dataList) {
  return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        return Card(
            elevation: 5,
            child: Container(
              color: background,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   dataList[index].value.toString() + " cm",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25, color: secondary),
                  ),
                  Container(
                    child: Text(
                      '\n- ' + dataList[index].date + "     " + dataList[index].weekday,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '- ' + dataList[index].time,
                      style: TextStyle(
                    color: Colors.grey,
                      ),
                    ),

                  )
                ],
              ),
            ));
      });
}

