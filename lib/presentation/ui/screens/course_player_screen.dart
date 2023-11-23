import 'package:edtech/presentation/ui/screens/dashboard_screen.dart';
import 'package:edtech/presentation/ui/widgets/bookmark_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CoursePlayerScreen extends StatefulWidget {
  final String courseName;

  const CoursePlayerScreen(this.courseName, {Key? key}) : super(key: key);

  @override
  _CoursePlayerScreenState createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'SG2WNlQfqyc',
      flags: const YoutubePlayerFlags(
        forceHD: true,
        autoPlay: true,
      ),
    );
  }

  List<String> videoId = [
    'SG2WNlQfqyc',
    'oi6zk7cVHUw',
    'cq34RWXegM8',
    'OpcPZdfJbq8',
    'yQ8HNNVGSBY'
  ];

  List<String> modules = [
    'Module 1',
    'Module 2',
    'Module 3',
    'Module 4',
    'Module 5'
  ];
  int currentModuleIndex = 0;

  List<dynamic> bookmarks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            color: Colors.black,
            child: Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {},
                onEnded: (data) {
                  print("Video ended");
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: modules.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(modules[index]),
                  selected: currentModuleIndex == index,
                  tileColor: currentModuleIndex == index ? Colors.green : null,
                  selectedTileColor: Colors.green,
                  onTap: () {
                    setState(() {
                      currentModuleIndex = index;
                      _controller.load(videoId[index]);
                    });
                  },
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: currentModuleIndex > 0
                    ? () {
                        setState(() {
                          currentModuleIndex--;
                          _controller.load(videoId[currentModuleIndex]);
                        });
                      }
                    : null,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentModuleIndex < modules.length
                    ? () {
                        setState(() {
                          currentModuleIndex++;
                          _controller.load(videoId[currentModuleIndex]);
                        });
                        if (currentModuleIndex == modules.length) {
                          print('Certificate');
                          showClaimCertificateSnackbar();
                        }
                      }
                    : null,
                child: const Text('Next'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  double currentVideoPosition =
                      _controller.value.position.inSeconds.toDouble();

                  setState(() {
                    bookmarks.add(currentModuleIndex);
                    bookmarks.add(currentVideoPosition);
                  });
                },
                child: const Text('Bookmark'),
              ),
              ElevatedButton(
                onPressed: () async {
                  _controller.pause();
                  Map<String, dynamic>? bookmark =
                  await Get.to(() => BookmarkList(bookmarks));

                  if (bookmark != null) {
                    int moduleIndex = bookmark['moduleIndex'];
                    double bookmarkedTime = bookmark['videoTime'];

                    // Load the correct video first
                    _controller.load(videoId[moduleIndex]);

                    // Seek to the bookmarked time after the video is loaded
                    _controller.addListener(() {
                      if (_controller.value.isReady) {
                        _controller.removeListener(() {});
                        _controller.seekTo(Duration(seconds: bookmarkedTime.toInt()));
                        _controller.play();
                      }
                    });
                  }
                },
                child: const Text('View Bookmarks'),
              ),

            ],
          ),
        ],
      ),
    );
  }

  void showClaimCertificateSnackbar() {
    Get.snackbar(
      'Claim Your Certificate',
      'Congratulations! You are eligible to claim your certificate.',
      snackPosition: SnackPosition.BOTTOM,
      duration: null,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
          Get.offAll(() => DashboardScreen());
        },
        child: const Text('Claim'),
      ),
    );
  }
}
