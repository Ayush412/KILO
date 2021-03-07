import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

lineChart(Stream stream, String type){
  return  StreamBuilder<List>(
    stream: stream,
    builder: (context, snapshot) {
      if(snapshot.data==null)
        return Center(child: CircularProgressIndicator(),);
      else{
        List labels = snapshot.data[0];
        List series = snapshot.data[1];
        return Container(
          height: 280,
          width: 340,
          child: charts.BarChart(
            series,
            animate: true,
            primaryMeasureAxis: new charts.NumericAxisSpec(
              renderSpec: new charts.GridlineRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  fontSize: 15,
                  color: charts.MaterialPalette.white
                ),
                lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white
                )
              )
            ),
            domainAxis: new charts.OrdinalAxisSpec(
              renderSpec: charts.SmallTickRendererSpec(
                labelStyle: new charts.TextStyleSpec(
                  fontSize: 15,
                  color: charts.MaterialPalette.white
                ),
                lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.white
                )
              ),
              viewport: new charts.OrdinalViewport(labels[labels.length -1], 3),
            ),
            behaviors: [
              charts.SlidingViewport(),
              charts.PanAndZoomBehavior(),
              charts.SeriesLegend(
                entryTextStyle: charts.TextStyleSpec(
                  color: charts.Color(r: 255,g: 255,b: 255)
                )
              ),
              charts.ChartTitle(
                type,
                innerPadding: 20,
                titleStyleSpec: charts.TextStyleSpec(
                  color: charts.Color( r: 121,g: 121, b:121)
                ),
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea
              ),
            ],
            defaultRenderer: charts.BarRendererConfig(customRendererId: 'customLine')
          )
        );
      }
    }
  );
}