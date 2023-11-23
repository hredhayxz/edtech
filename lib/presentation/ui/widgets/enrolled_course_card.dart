import 'package:edtech/presentation/ui/screens/course_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EnrolledCourseCard extends StatelessWidget {
  const EnrolledCourseCard({
    super.key,
    required this.courseTitle,
    required this.imageLink,
  });

  final String courseTitle;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SvgPicture.asset(
              imageLink,
              fit: BoxFit.cover,
              width: screenSize.width,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Text(
                  courseTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.green),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenSize.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => CoursePlayerScreen(courseTitle));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Continue Course',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
