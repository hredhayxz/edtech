import 'package:edtech/presentation/state_holders/course_player_controller.dart';
import 'package:get/get.dart';

class StateHolderBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(CoursePlayerController());
  }
}
