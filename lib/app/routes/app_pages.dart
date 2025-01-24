import 'package:get/get.dart';

import '../modules/edit_image_screen/bindings/edit_image_screen_binding.dart';
import '../modules/edit_image_screen/views/edit_image_screen_view.dart';
import '../modules/gallery_screen/bindings/gallery_screen_binding.dart';
import '../modules/gallery_screen/views/gallery_screen_view.dart';
import '../modules/home_screen/bindings/home_screen_binding.dart';
import '../modules/home_screen/views/home_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/viewer_screen/bindings/viewer_screen_binding.dart';
import '../modules/viewer_screen/views/viewer_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => HomePage(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.GALLERY_SCREEN,
      page: () => const GalleryScreenView(),
      binding: GalleryScreenBinding(),
    ),
    GetPage(
      name: _Paths.VIEWER_SCREEN,
      page: () => const ViewerScreenView(),
      binding: ViewerScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_IMAGE_SCREEN,
      page: () => const EditImageScreenView(),
      binding: EditImageScreenBinding(),
    ),
  ];
}
