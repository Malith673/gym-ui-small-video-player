import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gym_ui_and_video_player_app/home_page.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List VideoInfo = [];
  bool _playArea = false;
  bool _isPlay = false;

  VideoPlayerController? _controller;
  // _initState() {
  //   DefaultAssetBundle.of(context)
  //       .loadString("json/info.json")
  //       .then((value) => {info = json.decode(value)});
  // }
  Future<void> _readJson() async {
    final String response = await rootBundle.loadString('json/videoinfo.json');
    setState(() {
      VideoInfo = json.decode(response);
    });
  }

  @override
  void initState() {
    _readJson();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.AppColor.gradientFirst.withOpacity(0.9),
                    color.AppColor.gradientSecond,
                  ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : BoxDecoration(
                color: color.AppColor.gradientSecond,
              ),
        child: Column(
          children: [
            _playArea == false
                ? Container(
                    padding:
                        const EdgeInsets.only(top: 70, left: 30, right: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => const HomePage());
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Legs Toning",
                              style: TextStyle(
                                fontSize: 25,
                                color: color.AppColor.secondPageTitleColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "and Glutes Workout",
                              style: TextStyle(
                                fontSize: 25,
                                color: color.AppColor.secondPageTitleColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 18,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '68 min',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: color.AppColor.secondPageIconColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 240,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.handyman_outlined,
                                    size: 18,
                                    color: color.AppColor.secondPageIconColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Ressistan band, kettebell',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: color.AppColor.secondPageIconColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(
                              top: 50, left: 30, right: 30),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => const HomePage());
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: color.AppColor.secondPageTopIconColor,
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: color.AppColor.secondPageTopIconColor,
                              ),
                            ],
                          ),
                        ),
                        _playView(context),
                        _controlPlayView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      70,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          'Circuit 1: Legs Toning',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Icon(
                              Icons.loop,
                              size: 30,
                              color: color.AppColor.loopColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '3 sets',
                              style: TextStyle(
                                fontSize: 15,
                                color: color.AppColor.setsColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _listView() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      itemCount: VideoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(index);
            debugPrint(index.toString());
            setState(() {
              if (_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: _buildCard(index),
        );
      },
    );
  }

  _buildCard(int index) {
    return Container(
      height: 135,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(
                      VideoInfo[index]['thumbnail'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VideoInfo[index]['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    VideoInfo[index]['time'],
                    style: TextStyle(
                      color: Colors.grey[500],
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFeaeefc),
                ),
                child: const Center(
                  child: Text(
                    '15 rest',
                    style: TextStyle(
                      color: Color(0xFF839fed),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFF839fed),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _controlPlayView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {},
          child: const Icon(
            Icons.fast_rewind,
            size: 36,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_isPlay) {
              setState(() {
                _isPlay = false;
              });
              _controller?.pause();
            } else {
              setState(() {
                _isPlay = true;
              });
              _controller?.play();
            }
          },
          child: Icon(
            _isPlay ? Icons.pause : Icons.play_arrow,
            size: 36,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () async {},
          child: const Icon(
            Icons.fast_forward,
            size: 36,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            "Preparing...",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white60,
            ),
          ),
        ),
      );
    }
  }

  _onControlPlayViewUpdate() {
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('controller can not be initialized');
      return;
    }
    final playing = controller.value.isPlaying;
    _isPlay = playing;
  }

  _initializeVideo(int index) async {
    final Controller =
        VideoPlayerController.network(VideoInfo[index]['videoUrl']);
    _controller = Controller;
    setState(() {
      _isPlay = true;
    });
    Controller
      ..initialize().then((_) {
        //Controller.addListener((_onControlPlayViewUpdate()));
        Controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
  }
}
