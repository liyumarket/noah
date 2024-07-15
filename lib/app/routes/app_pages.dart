import 'package:get/get.dart';
import 'package:noahrealstate/app/modules/activeproperties/bindings/viewallproperties_binding.dart';
import 'package:noahrealstate/app/modules/activeproperties/views/viewallproperties_view.dart';

import '../modules/abouts/bindings/abouts_binding.dart';
import '../modules/abouts/views/abouts_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/fqas/bindings/fqas_binding.dart';
import '../modules/fqas/views/fqas_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/map_page/bindings/map_page_binding.dart';
import '../modules/map_page/views/map_page_view.dart';
import '../modules/property_detail/bindings/property_detail_binding.dart';
import '../modules/property_detail/views/property_detail_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/unit_detail/bindings/unit_detail_binding.dart';
import '../modules/unit_detail/views/unit_detail_view.dart';
import '../modules/update_detail/bindings/update_detail_binding.dart';
import '../modules/update_detail/views/update_detail_view.dart';
import '../modules/updates/bindings/updates_binding.dart';
import '../modules/updates/views/updates_view.dart';
import '../modules/video_player_screen/bindings/video_player_screen_binding.dart';
import '../modules/video_player_screen/views/video_player_screen_view.dart';
import '../modules/viewallproperties/bindings/viewallproperties_binding.dart';
import '../modules/viewallproperties/views/viewallproperties_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
      transition: Transition.fade
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () =>  SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTY_DETAIL,
      page: () => PropertyDetailView(),
      binding: PropertyDetailBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTS,
      page: () => const AboutsView(),
      binding: AboutsBinding(),
    ),
    GetPage(
      name: _Paths.FQAS,
      page: () => const FqasView(),
      binding: FqasBinding(),
    ),
    GetPage(
      name: _Paths.VIEWALLPROPERTIES,
      page: () => const ViewallpropertiesView(),
      binding: ViewallpropertiesBinding(),
    ),
    GetPage(
      name: _Paths.UNIT_DETAIL,
      page: () => UnitDetailView(),
      binding: UnitDetailBinding(),
    ),
    GetPage(
      name: _Paths.UPDATES,
      page: () => UpdatesView(),
      binding: UpdatesBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_DETAIL,
      page: () => const UpdateDetailView(),
      binding: UpdateDetailBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_PLAYER_SCREEN,
      page: () => const VideoPlayerScreenView(),
      binding: VideoPlayerScreenBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PAGE,
      page: () =>  MapPageView(),
      binding: MapPageBinding(),
    ),
       GetPage(
      name: _Paths.ACTIVEPROPERTIES,
      page: () =>  const ActivepropertiesView(),
      binding: ActivepropertiesBinding(),
    ),
  ];
}
