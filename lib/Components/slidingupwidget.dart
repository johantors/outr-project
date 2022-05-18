import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../ScreenPages/mapviewpage.dart';

class SlidingUpWidget extends StatefulWidget {
  final PanelController panelController;
  final ButtonChoiceCallback chooseButton;

  const SlidingUpWidget({
    Key? key,
    required this.panelController,
    required this.chooseButton,
  }) : super(key: key);

  @override
  State<SlidingUpWidget> createState() => _SlidingUpWidgetState();
}

class _SlidingUpWidgetState extends State<SlidingUpWidget> {
  bool _isActive = false;
  bool _isPaused = false;
  String _playPause = 'Pause';
  String _sliderHeader = 'Start';

  Stopwatch _watch = Stopwatch();
  late Timer _timer;
  bool _startStop = true;
  bool _click = false;

  String _elapsedTime = '';

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 15),
          openUpPanelDragHandle(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                togglePanelUpDown();
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(390, 30)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              child: Text(
                _sliderHeader,
                style: TextStyle(
                  fontSize: 60.0,
                  letterSpacing: 1.5,
                  color: Colors.blueGrey,
                  fontFamily: 'Dongle',
                ),
              ),
            ),
          ),
          Visibility(
            visible: !_isActive,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
                  child: Container(
                    width: 400,
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          icon: Image.asset('assets/plainDude.png'),
                          label: Text('Beginner',
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(1);
                            changeState();
                          },
                        ),

                        ElevatedButton.icon(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          icon: Image.asset('assets/cardioDude.png'),
                          label: Text('Cardio',
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(1);
                            changeState();
                          },
                        ),



                        ElevatedButton.icon(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          icon: Image.asset('assets/strengthDude.png'),
                          label: Text('Strength',
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(1);
                            changeState();
                          },
                        ),


                        ElevatedButton.icon(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          icon: Image.asset('assets/mixDude.png'),
                          label: Text('Mix',
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            togglePanelUpDown();
                            // widget.chooseButton(1);
                            changeState();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _isActive,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
                  child: Container(
                    width: 400,
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "0,60",
                                    style: TextStyle(
                                      fontSize: 60.0,
                                      letterSpacing: 1.5,
                                      color: Colors.black,
                                      fontFamily: 'Dongle',
                                    ),
                                  ),
                                  Text("12,47",
                                      style: TextStyle(
                                        fontSize: 60.0,
                                        letterSpacing: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Dongle',
                                      )),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("KM left",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        letterSpacing: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Dongle',
                                      )),
                                  Text("Min/KM",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                        letterSpacing: 1.5,
                                        color: Colors.black,
                                        fontFamily: 'Dongle',
                                      ))
                                ]),
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          icon: Icon(
                              (_isPaused == false)
                                  ? Icons.pause_circle
                                  : Icons.play_arrow,
                              size: 40),
                          label: Text(_playPause,
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            togglePanelUpDown();
                            setState(() {
                              if (_playPause == 'Pause') {
                                _playPause = 'Play';
                              } else {
                                _playPause = "Pause";
                              }
                              _isPaused = !_isPaused;
                            });
                          },
                        ),


                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.white,
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              )),
                          child: Text('End',
                              style: TextStyle(
                                  fontFamily: 'Dongle', fontSize: 50)),
                          onPressed: () {
                            changeState();
                            togglePanelUpDown();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget openUpPanelDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onTap: togglePanelUpDown,
      );

  void changeState() {
    setState(() {
      if (!_isActive) {
        _isActive = true;
        _sliderHeader = '31:00' + '   ' + '2,02' + '    ' + '7:00';
      } else {
        _isActive = false;
        _sliderHeader = 'Start';
      }
    });
  }

  //Den här skiten funkar ju bara när den är nere
  void togglePanelUpDown() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();

  startOrStop() {
    if (_startStop) {
      _click = true;
      startWatch();
    } else {
      stopWatch();
    }
  }

  resetTimer() {
    _watch.reset();
    _elapsedTime = "";
  }

  startWatch() {
    setState(() {
      _startStop = false;
      _watch.start();
      _timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      _click = false;
      _startStop = true;
      _watch.stop();
      setTime();
    });
  }

  setTime() {
    var timeSoFar = _watch.elapsedMilliseconds;
    setState(() {
      _elapsedTime = transformMilliSeconds(timeSoFar);
    });
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  updateTime(Timer timer) {
    if (_watch.isRunning) {
      setState(() {
        _elapsedTime = transformMilliSeconds(_watch.elapsedMilliseconds);
      });
    }
  }
}

typedef ButtonChoiceCallback = void Function(int buttonNumber);
