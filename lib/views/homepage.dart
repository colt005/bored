import 'package:bored/bloc/boredBloc.dart';
import 'package:bored/globals.dart';
import 'package:bored/model/activityModel.dart';
import 'package:bored/views/chipList.dart';
import 'package:bored/views/default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rubber/rubber.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool op = true;
  RubberAnimationController _controller;
  bool coll = false;
  String getDollars(dynamic d) {
    if (d >= 0.0 && d <= 0.2) {
      return '\$';
    } else if (d >= 0.3 && d <= 0.4) {
      return '\$ \$';
    } else if (d >= 0.5 && d <= 0.6) {
      return '\$ \$ \$';
    } else if (d >= 0.7 && d <= 0.8) {
      return '\$ \$ \$ \$';
    } else if (d >= 0.9 && d <= 0.10) {
      return '\$ \$ \$ \$ \$';
    }
  }

  void initState() {
    _controller = RubberAnimationController(
      vsync: this,
      //halfBoundValue: AnimationControllerValue(pixel: 140),
      lowerBoundValue: AnimationControllerValue(pixel: 50),

      upperBoundValue: AnimationControllerValue(pixel: 250),
      duration: Duration(milliseconds: 150),
      dismissable: true,
    );
    _controller.animationState.addListener(_stateListener);
    super.initState();
  }

  void _stateListener() {
    if (_controller.animationState.value == AnimationState.expanded) {
      setState(() {});
    } else if (_controller.animationState.value == AnimationState.collapsed) {
      setState(() {
        coll = false;
      });
    } else if (_controller.animationState.value == AnimationState.animating) {
      setState(() {});
    }
    // print("state changed ${_controller.animationState.value}");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BoredBloc>.reactive(
        viewModelBuilder: () => BoredBloc(),
        staticChild: Container(),
        onModelReady: (model) {
          model.getActivity(randomListItem(categories));
        },
        builder: (context, model, child) {
          if (model.activityString == null) {
            return CupertinoActivityIndicator();
          } else {
            var activity = activityFromJson(model.activityString);
            return Scaffold(
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(right: 20.0, bottom: 15),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.forward,
                      color: Color.fromRGBO(4, 4, 4, 1),
                    ),
                    onPressed: () async {
                      setState(() {
                        op = false;
                      });
                      if (categories.isEmpty) {
                        await model
                            .getActivity(randomListItem(dummyCategories));
                      } else {
                        await model.getActivity(randomListItem(categories));
                      }
                      /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DefaultPage()),
                ); */
                      setState(() {
                        op = true;
                      });
                    },
                  ),
                ),
                backgroundColor: Color.fromRGBO(4, 4, 4, 1),
                body: RubberBottomSheet(
                  lowerLayer: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 80, 0, 60),
                            child: AnimatedCrossFade(
                              firstCurve: Curves.easeIn,
                              secondCurve: Curves.easeOut,
                              firstChild: SvgPicture.asset(
                                'assets/sqbored.svg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fitHeight,
                                color: Color.fromRGBO(255, 221, 142, 1),
                              ),
                              secondChild: SvgPicture.asset(
                                'assets/sqgiggle.svg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fitHeight,
                                color: Color.fromRGBO(255, 221, 142, 1),
                              ),
                              crossFadeState: op
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 450),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                          opacity: op ? 1 : 0,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text("${activity.activity}",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                      color: Colors.white)),
                              SizedBox(
                                height: 15,
                              ),
                              Text("${capitalize(activity.type)}",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                      color: Colors.white)),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Participants : ${activity.participants}",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                      color: Colors.white)),
                              SizedBox(
                                height: 15,
                              ),
                              Text("${getDollars(activity.price)}",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 24,
                                      color: Colors.white)),
                              SizedBox(
                                height: 10,
                              ),
                              (activity.link == null || activity.link.isEmpty)
                                  ? Container()
                                  : Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await launch(activity.link);
                                        },
                                        child: Text("Explore here",
                                            style: GoogleFonts.raleway(
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  upperLayer: _getUpperLayer(),
                  animationController: _controller,
                  headerHeight: 60,
                ));
          }
        });
  }

  Widget _getUpperLayer() {
    return Container(
      color: Colors.white.withOpacity(0.2),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                if (_controller.animationState.value ==
                    AnimationState.expanded) {
                  setState(() {
                    coll = true;
                  });
                  _controller.collapse();
                } else if (_controller.animationState.value ==
                    AnimationState.collapsed) {
                  _controller.expand();
                }
              },
              child: Container(
                width: 75,
                height: 20,
                child: Center(
                    child: Icon(
                  _controller.animationState.value == AnimationState.expanded
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up,
                  color: Colors.black,
                  size: 28,
                )),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          (_controller.animationState.value == AnimationState.collapsed ||
                  coll == true ||
                  _controller.animationState.value == AnimationState.animating)
              ? Container()
              : Container(
                  child: ChipList(),
                ),
        ],
      ),
    );
  }
}

//  child: Center(child: Icon(_controller.animationState.value == AnimationState.expanded ?Icons.arrow_drop_down : Icons.arrow_drop_up,color: Colors.black,size: 28,)),
