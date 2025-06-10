part of 'configs.dart';

class App {
  static void init(BuildContext context, [VoidCallback? callback]) {
    AppMedia.init(context);
    AppScreen.init();
    AppUnit.init();
    Space.init();
    AppText.init();
    ScreenUtil.init(context, designSize: const Size(428, 926));

    if (callback != null) {
      callback();
    }
  }
}
