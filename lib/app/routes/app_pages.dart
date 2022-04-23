import 'package:get/get.dart';

import '../modules/call_screen/bindings/call_screen_binding.dart';
import '../modules/call_screen/views/call_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CALL_SCREEN,
      page: () => CallScreenView(),
      binding: CallScreenBinding(),
    ),
  ];
}
