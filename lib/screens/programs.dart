import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:vector_math/vector_math_64.dart' as math;

class Exercise1 {
  final String title, time, difficult, image;

  Exercise1({
    @required this.title,
    @required this.time,
    @required this.difficult,
    @required this.image,
  });
}

/*class Exercise2 {
  final String title, time, difficult, image;

  Exercise2({
    @required this.title,
    @required this.time,
    @required this.difficult,
    @required this.image,
  });
}

class Exercise3 {
  final String title, time, difficult, image;

  Exercise3({
    @required this.title,
    @required this.time,
    @required this.difficult,
    @required this.image,
  });
}
*/

class Programs extends StatelessWidget {
  final List<Exercise1> exercises1 = [
    Exercise1(
      image: 'assets/image001.jpg',
      title: 'Easy',
      time: '5 min',
      difficult: 'Low',
    ),
  ];
  /*final List<Exercise2> exercises2 = [
    Exercise2(
      image: 'assets/image002.jpg',
      title: 'Medium',
      time: '10 min',
      difficult: 'Medium',
    ),
  ];
  final List<Exercise3> exercises3 = [
    Exercise3(
      image: 'assets/image003.jpg',
      title: 'Hard',
      time: '25 min',
      difficult: 'High',
    )
  ];*/

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
    exercises1.forEach((exercise) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: ImageCardWithBasicFooter(
            exercise: exercise,
            tag: 'imageHeader$count',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ActivityDetail(
                    exercise1: exercise,
                    //exercise2: exercise,
                    tag: 'imageHeader$count',
                  );
                },
              ),
            );
          },
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Header(
                  'Record Activity',
                  rightSide: UserPhoto(),
                ),
                MainCardPrograms(), // MainCard
                Section(
                  title: 'Weight Loss',
                  horizontalList: this.generateList(context),
                ),
                Section(
                  title: 'Muscle Build',
                  horizontalList: <Widget>[
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                  ],
                ),
                Section(
                  title: 'Endurance',
                  horizontalList: <Widget>[
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum CircularStrokeCap { butt, round, square }

enum ArcType {
  HALF,
  FULL,
}

// ignore: must_be_immutable
class CircularPercentIndicator extends StatefulWidget {
  ///Percent value between 0.0 and 1.0
  final double percent;
  final double radius;

  ///Width of the line of the Circle
  final double lineWidth;

  ///Color of the background of the circle , default = transparent
  final Color fillColor;

  ///First color applied to the complete circle
  final Color backgroundColor;

  Color get progressColor => _progressColor;

  Color _progressColor;

  ///true if you want the circle to have animation
  final bool animation;

  ///duration of the animation in milliseconds, It only applies if animation attribute is true
  final int animationDuration;

  ///widget at the top of the circle
  final Widget header;

  ///widget at the bottom of the circle
  final Widget footer;

  ///widget inside the circle
  final Widget center;

  final LinearGradient linearGradient;

  ///The kind of finish to place on the end of lines drawn, values supported: butt, round, square
  final CircularStrokeCap circularStrokeCap;

  ///the angle which the circle will start the progress (in degrees, eg: 0.0, 45.0, 90.0)
  final double startAngle;

  /// set true if you want to animate the linear from the last percent value you set
  final bool animateFromLastPercent;

  /// set false if you don't want to preserve the state of the widget
  final bool addAutomaticKeepAlive;

  /// set the arc type
  final ArcType arcType;

  /// set a circular background color when use the arcType property
  final Color arcBackgroundColor;

  /// set true when you want to display the progress in reverse mode
  final bool reverse;

  /// Creates a mask filter that takes the progress shape being drawn and blurs it.
  final MaskFilter maskFilter;

  CircularPercentIndicator(
      {Key key,
      this.percent = 0.0,
      this.lineWidth = 5.0,
      this.startAngle = 0.0,
      @required this.radius,
      this.fillColor = Colors.transparent,
      this.backgroundColor = const Color(0xFFB8C7CB),
      Color progressColor,
      this.linearGradient,
      this.animation = false,
      this.animationDuration = 500,
      this.header,
      this.footer,
      this.center,
      this.addAutomaticKeepAlive = true,
      this.circularStrokeCap,
      this.arcBackgroundColor,
      this.arcType,
      this.animateFromLastPercent = false,
      this.reverse = false,
      this.maskFilter})
      : super(key: key) {
    if (linearGradient != null && progressColor != null) {
      throw ArgumentError(
          'Cannot provide both linearGradient and progressColor');
    }
    _progressColor = progressColor ?? Colors.red;

    assert(startAngle >= 0.0);
    if (percent < 0.0 || percent > 1.0) {
      throw Exception("Percent value must be a double between 0.0 and 1.0");
    }

    if (arcType == null && arcBackgroundColor != null) {
      throw ArgumentError('arcType is required when you arcBackgroundColor');
    }
  }

  @override
  _CircularPercentIndicatorState createState() =>
      _CircularPercentIndicatorState();
}

class _CircularPercentIndicatorState extends State<CircularPercentIndicator>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _animationController;
  Animation _animation;
  double _percent = 0.0;

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    if (widget.animation) {
      _animationController = AnimationController(
          vsync: this,
          duration: Duration(milliseconds: widget.animationDuration));
      _animation =
          Tween(begin: 0.0, end: widget.percent).animate(_animationController)
            ..addListener(() {
              setState(() {
                _percent = _animation.value;
              });
            });
      _animationController.forward();
    } else {
      _updateProgress();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(CircularPercentIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent ||
        oldWidget.startAngle != widget.startAngle) {
      if (_animationController != null) {
        _animationController.duration =
            Duration(milliseconds: widget.animationDuration);
        _animation = Tween(
                begin: widget.animateFromLastPercent ? oldWidget.percent : 0.0,
                end: widget.percent)
            .animate(_animationController);
        _animationController.forward(from: 0.0);
      } else {
        _updateProgress();
      }
    }
  }

  _updateProgress() {
    setState(() {
      _percent = widget.percent;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var items = List<Widget>();
    if (widget.header != null) {
      items.add(widget.header);
    }
    items.add(Container(
        height: widget.radius + widget.lineWidth,
        width: widget.radius,
        child: CustomPaint(
          painter: CirclePainter(
              progress: _percent * 360,
              progressColor: widget.progressColor,
              backgroundColor: widget.backgroundColor,
              startAngle: widget.startAngle,
              circularStrokeCap: widget.circularStrokeCap,
              radius: (widget.radius / 2) - widget.lineWidth / 2,
              lineWidth: widget.lineWidth,
              arcBackgroundColor: widget.arcBackgroundColor,
              arcType: widget.arcType,
              reverse: widget.reverse,
              linearGradient: widget.linearGradient,
              maskFilter: widget.maskFilter),
          child: (widget.center != null)
              ? Center(child: widget.center)
              : Container(),
        )));

    if (widget.footer != null) {
      items.add(widget.footer);
    }

    return Material(
      color: widget.fillColor,
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: items,
      )),
    );
  }

  @override
  bool get wantKeepAlive => widget.addAutomaticKeepAlive;
}

class CirclePainter extends CustomPainter {
  final Paint _paintBackground = Paint();
  final Paint _paintLine = Paint();
  final Paint _paintBackgroundStartAngle = Paint();
  final double lineWidth;
  final double progress;
  final double radius;
  final Color progressColor;
  final Color backgroundColor;
  final CircularStrokeCap circularStrokeCap;
  final double startAngle;
  final LinearGradient linearGradient;
  final Color arcBackgroundColor;
  final ArcType arcType;
  final bool reverse;
  final MaskFilter maskFilter;

  CirclePainter(
      {this.lineWidth,
      this.progress,
      @required this.radius,
      this.progressColor,
      this.backgroundColor,
      this.startAngle = 0.0,
      this.circularStrokeCap = CircularStrokeCap.round,
      this.linearGradient,
      this.reverse,
      this.arcBackgroundColor,
      this.arcType,
      this.maskFilter}) {
    _paintBackground.color = backgroundColor;
    _paintBackground.style = PaintingStyle.stroke;
    _paintBackground.strokeWidth = lineWidth;

    if (arcBackgroundColor != null) {
      _paintBackgroundStartAngle.color = arcBackgroundColor;
      _paintBackgroundStartAngle.style = PaintingStyle.stroke;
      _paintBackgroundStartAngle.strokeWidth = lineWidth;
    }

    _paintLine.color = progressColor;
    _paintLine.style = PaintingStyle.stroke;
    _paintLine.strokeWidth = lineWidth;
    if (circularStrokeCap == CircularStrokeCap.round) {
      _paintLine.strokeCap = StrokeCap.round;
    } else if (circularStrokeCap == CircularStrokeCap.butt) {
      _paintLine.strokeCap = StrokeCap.butt;
    } else {
      _paintLine.strokeCap = StrokeCap.square;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, _paintBackground);

    if (maskFilter != null) {
      _paintLine.maskFilter = maskFilter;
    }
    if (linearGradient != null) {
      /*
      _paintLine.shader = SweepGradient(
              center: FractionalOffset.center,
              startAngle: math.radians(-90.0 + startAngle),
              endAngle: math.radians(progress),
              //tileMode: TileMode.mirror,
              colors: linearGradient.colors)
          .createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );*/
      _paintLine.shader = linearGradient.createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
    }

    double fixedStartAngle = startAngle;

    double startAngleFixedMargin = 1.0;
    if (arcType != null) {
      if (arcType == ArcType.FULL) {
        fixedStartAngle = 220;
        startAngleFixedMargin = 172 / fixedStartAngle;
      } else {
        fixedStartAngle = 270;
        startAngleFixedMargin = 135 / fixedStartAngle;
      }
    }

    if (arcBackgroundColor != null) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.radians(-90.0 + fixedStartAngle),
        math.radians(360 * startAngleFixedMargin),
        false,
        _paintBackgroundStartAngle,
      );
    }

    if (reverse) {
      final start =
          math.radians(360 * startAngleFixedMargin - 90.0 + fixedStartAngle);
      final end = math.radians(-progress * startAngleFixedMargin);
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    } else {
      final start = math.radians(-90.0 + fixedStartAngle);
      final end = math.radians(progress * startAngleFixedMargin);
      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        start,
        end,
        false,
        _paintLine,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class UserPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54.0,
      height: 54.0,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/image009.jpg',
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(360),
        ),
        color: Colors.redAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 20.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }
}

class ImageCardWithInternal extends StatelessWidget {
  final String image, title, duration;

  const ImageCardWithInternal({
    Key key,
    @required this.image,
    @required this.title,
    @required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              this.duration,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Colors.black.withAlpha(900),
            ),
          ),
          Text(
            this.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
      width: size.width * 0.85,
      height: size.width * 0.60,
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final List<Widget> horizontalList;
  final String title;

  Section({this.title, this.horizontalList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      child: Column(
        children: <Widget>[
          SectionTitle((this.title != null) ? this.title : ''),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            child: Row(
                children:
                    (this.horizontalList != null) ? this.horizontalList : []),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String _text;

  SectionTitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          this._text,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class MainCardPrograms extends StatelessWidget {
  final Map<String, String> cardInfo = {
    'title': 'For You',
    'time': '8 min',
    'image': 'assets/image008.jpg',
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.cardInfo['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                this.cardInfo['time'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              )
            ],
          ),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[400].withOpacity(0.95),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
        ),
      ),
      width: size.width - 40,
      height: (size.width - 40) / 2,
      margin: EdgeInsets.only(
        top: 40.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(this.cardInfo['image']),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 25.0,
            offset: Offset(8.0, 8.0),
          ),
        ],
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[
            Programs(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.explicit, size: 26.0),
            ),
            Tab(
              icon: Icon(Icons.restaurant_menu, size: 26.0),
            ),
            Tab(
              icon: Icon(Icons.insert_chart, size: 26.0),
            ),
          ],
          labelPadding: EdgeInsets.all(5.0),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black12,
          indicatorWeight: 0.01,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final Widget rightSide;

  Header(this.title, {this.rightSide});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 28,
              color: Colors.grey[600],
              fontWeight: FontWeight.w700,
            ),
          ),
          margin: EdgeInsets.only(left: 20.0),
          height: 54.0,
        ),
        (this.rightSide != null) ? this.rightSide : Container()
      ],
    );
  }
}

class NextStep extends StatelessWidget {
  final String image, title;
  final int seconds;

  NextStep({
    @required this.image,
    @required this.title,
    @required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 60.0,
          width: 60.0,
          margin: EdgeInsets.only(
            right: 20.0,
            bottom: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                this.image,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        Container(
          height: 65.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                this.title,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${this.seconds} sec',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blueGrey[200],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ActivityDetail extends StatelessWidget {
  final String tag;
  final Exercise1 exercise1;
  // final Exercise2 exercise2;
  // final Exercise3 exercise3;

  ActivityDetail({
    @required this.exercise1,
    // @required this.exercise2,
    // @required this.exercise3,
    @required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: this.tag,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 270,
                    child: Image.asset(
                      this.exercise1.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(0, 0, 0, 0.7),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.exercise1.title,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(231, 241, 255, 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 55.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Time',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.blueGrey[300]),
                                  ),
                                  Text(
                                    '${this.exercise1.time}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 45.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Intensity',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.blueGrey[300],
                                    ),
                                  ),
                                  Text(
                                    this.exercise1.difficult,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: <Widget>[
                            NextStep(
                              image: 'assets/sit_ups.gif',
                              title: 'Sit-Ups',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/crunches.gif',
                              title: 'Crunches',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/lunges.gif',
                              title: 'Lunges',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/jumping_jacks.gif',
                              title: 'Jumping Jacks',
                              seconds: 45,
                            ),
                            NextStep(
                              image: 'assets/skipping.gif',
                              title: 'Skipping',
                              seconds: 45,
                            ),
                            NextStep(
                              image: 'assets/running_on_the_spot.gif',
                              title: 'Running on the Spot',
                              seconds: 45,
                            ),
                            NextStep(
                              image: 'assets/superman.gif',
                              title: 'Supermans',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/squat.gif',
                              title: 'Squats',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/knee_elbow_kicks.gif',
                              title: 'Knee to Elbow Kicks',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/wall_sit.jpg',
                              title: 'Wall Sit',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/spider_walk.gif',
                              title: 'Spider Walk',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/duck_walk.gif',
                              title: 'Duck Walk',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/plank.gif',
                              title: 'Plank',
                              seconds: 30,
                            ),
                            NextStep(
                              image: 'assets/side_plank.gif',
                              title: 'Side Plank',
                              seconds: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(100, 140, 255, 1.0),
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(100, 140, 255, 0.5),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0),
                ),
              ]),
          child: Text(
            'Start',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) {
              return ActivityTimer();
            }),
          );
        },
      ),
    );
  }
}

class ActivityTimer extends StatelessWidget {
  final String image =
      'https://i0.wp.com/fitnessrunning.net/wp-content/uploads/2016/10/woman-doing-plank.jpg';
  final String tag = 'imageHeader';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: OrientationBuilder(builder: (context, orientation) {
          return (MediaQuery.of(context).orientation ==
                  prefix0.Orientation.portrait)
              ? Portrait(image: this.image, tag: this.tag)
              : Landscape(image: this.image, tag: this.tag);
        }),
      ),
    );
  }
}

class Portrait extends StatelessWidget {
  final String image, tag;

  Portrait({@required this.image, @required this.tag});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Hero(
              tag: this.tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: Image.network(
                  this.image,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          height: size.height - 270.0,
          width: size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Plank',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CircularPercentIndicator(
                      radius: size.width * 0.60,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 16.0,
                      percent: 0.86,
                      center: new Text(
                        '43',
                        style: TextStyle(
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[400],
                        ),
                      ),
                      backgroundColor: Colors.grey[300],
                      circularStrokeCap: CircularStrokeCap.round,
                      linearGradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(190, 130, 255, 1.0),
                          Color.fromRGBO(105, 139, 255, 1.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 55.0,
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(232, 242, 248, 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      Icons.pause,
                      color: Color.fromRGBO(82, 126, 255, 1.0),
                      size: 35.0,
                    ),
                  ),
                  Container(
                    width: size.width - 130.0,
                    height: 55.0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(232, 242, 248, 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Color.fromRGBO(82, 126, 255, 1.0),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Landscape extends StatelessWidget {
  final String image, tag;

  Landscape({@required this.image, @required this.tag});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          child: Image.network(
            this.image,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 40.0,
          left: 40.0,
          child: Text(
            'Plank',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
              color: Colors.grey[500],
            ),
          ),
        ),
        Positioned(
          top: 80.0,
          left: 40.0,
          child: Text(
            'Next: Push-ups',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
              color: Colors.grey[800],
            ),
          ),
        ),
        Positioned(
            top: 30.0,
            left: size.width - 60.0,
            child: GestureDetector(
                child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 29.0,
                      color: Colors.grey[600],
                    )),
                onTap: () {
                  Navigator.pop(context);
                })),
        Positioned(
            left: 40.0,
            top: size.height - 60.0,
            child: Text(
              '43',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w900,
                color: Colors.grey[500],
              ),
            )),
        Positioned(
            top: size.height - 80.0,
            left: size.width / 2 - 30.0,
            child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.pause,
                  size: 38.0,
                ))),
        Positioned(
          top: size.height - 80.0,
          left: size.width - 170.0,
          child: Container(
            height: 60.0,
            width: 145.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(360.0),
            ),
            child: Center(
              child: Text(
                'Next',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImageCardWithBasicFooter extends StatelessWidget {
  final Exercise1 exercise;
  final String tag;
  final double imageWidth;

  ImageCardWithBasicFooter({
    @required this.exercise,
    @required this.tag,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double localWidth = size.width * 0.75;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: this.tag,
          child: Container(
            width: this.imageWidth != null ? this.imageWidth : localWidth,
            height: 160.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              image: DecorationImage(
                image: AssetImage(this.exercise.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          width: this.imageWidth != null ? this.imageWidth : localWidth,
          margin: EdgeInsets.only(top: 10.0),
          child: Text(
            this.exercise.title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        Container(
          width: this.imageWidth != null ? this.imageWidth : localWidth,
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            '${this.exercise.time}    |    ${this.exercise.difficult}',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
