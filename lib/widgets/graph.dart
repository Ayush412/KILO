import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/widgets/progress_indicator.dart';

lineChart(BuildContext context, Stream stream, String type){
  return  StreamBuilder<List>(
    stream: stream,
    builder: (context, snapshot) {
      if(snapshot.data==null){
        bloc.loadingStatusIn.add(true);
        return progressIndicator(context);
      }
      else{
         bloc.loadingStatusIn.add(false);
        List labels = snapshot.data[0];
        List series = snapshot.data[1];
        return Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color(0xFFD79609),
                Color(0xFFC74318),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
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
                  color: charts.Color(r: 0,g: 0,b: 0)
                )
              ),
              charts.ChartTitle(
                type,
                innerPadding: 20,
                titleStyleSpec: charts.TextStyleSpec(
                  color: charts.Color( r: 255,g: 255, b:255)
                ),
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification: charts.OutsideJustification.middleDrawArea
              ),
            ],
            defaultRenderer: charts.BarRendererConfig(
              cornerStrategy: const charts.ConstCornerStrategy(15)
            )
          )
        );
      }
    }
  );
}