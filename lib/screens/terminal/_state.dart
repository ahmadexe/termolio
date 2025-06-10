part of 'terminal.dart';

class _ScreenState extends ChangeNotifier {
  // ignore: unused_element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  String currentPath = '~';

  void setCurrentPath(String path) {
    currentPath = path;
    notifyListeners();
  }

  void resetCurrentPath() {
    currentPath = '~';
    notifyListeners();
  }

  final String pathPrefix = 'ahmadexe@termolio';

  List<String> history = [];
  void addToHistory(String path) {
    history.add(path);
    if (history.length > 100) {
      history.removeAt(0);
    }
    notifyListeners();
  }

  void processCommand(String input) {
    if (input.trim().isEmpty) return;

    final completeValue = 'termolio@ahmad $currentPath % $input';
    history.add(completeValue);
    if (history.length > 100) {
      history.removeAt(0);
    }
    controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    controller.clear();

    notifyListeners();

    // TODO: Handle the actual command (e.g., parse and respond)
  }
}
