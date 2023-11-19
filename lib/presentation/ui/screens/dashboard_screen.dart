import 'package:edtech/presentation/ui/utility/assets_path.dart';
import 'package:edtech/presentation/ui/widgets/enrolled_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  Map<String, String> enrolledCourseData = {
    'Competitive Programming': AssetsPath.courseCoverSVG,
    'Flutter App Development': AssetsPath.courseCoverSVG,
    'Web Design': AssetsPath.courseCoverSVG,
    'Web Development': AssetsPath.courseCoverSVG,
    'Graphic Design': AssetsPath.courseCoverSVG,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsPath.edTechLogo2SVG,
              width: 100,
            ),
            const Text('Dashboard'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Enrolled Courses',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.green),
              ),
              const SizedBox(height: 16),
              // Add some space between the text and the GridView
              Expanded(
                child: ListView.separated(
                  itemCount: enrolledCourseData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return EnrolledCourseCard(
                      courseTitle: enrolledCourseData.keys.elementAt(index),
                      imageLink: enrolledCourseData.values.elementAt(index),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
