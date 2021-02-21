import 'package:flutter/material.dart';
import 'package:kilo/bloc/bloc.dart';
import 'package:kilo/navigate.dart';
import 'package:kilo/screens/workout_screen.dart';
import 'package:kilo/widgets/progress_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

workout(BuildContext context, Stream stream, String title, List images){
  Size size = MediaQuery.of(context).size;
  List duration = [0,0,0];
  List difficulty = ['Easy', 'Medium', 'Hard'];
  return StreamBuilder(
    stream: stream,
    builder: (context, workouts) {
      if(!workouts.hasData){
        bloc.loadingStatusIn.add(true);
        return progressIndicator(context);
      }
      else{
        bloc.loadingStatusIn.add(false);
        workouts.data.forEach((val){
          duration[0] = duration[0] + val['Easy'];
          duration[1] = duration[1] + val['Medium'];
          duration[2] = duration[2] + val['Hard'];
        });
        duration[0] = Duration(seconds: duration[0]).inMinutes;
        duration[1] = Duration(seconds: duration[1]).inMinutes;
        duration[2] = Duration(seconds: duration[2]).inMinutes;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () => navigate(
                    context, 
                    WorkoutScreen(workouts: workouts.data, image: images[index], duration: duration[index], difficulty: difficulty[index], title: title,), 
                    PageTransitionAnimation.fade, false
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '$title: ${difficulty[index]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        width: size.width * 0.85,
                        height: size.width * 0.55,
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width*0.75,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '${duration[index]} mins    |    ${difficulty[index]}',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        );
      }
    },
  );
}