part of 'terminal.dart';

class _ScreenState extends ChangeNotifier {
  // ignore: unused_element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
    scrollController.dispose();
  }

  final FileSystem fileSystem = FileSystem();

  final String pathPrefix = 'ahmadexe@termolio';

  List<String> history = [
    "Hello visitor, it's good to see you here\nTry <help> command for more info.",
  ];
  void addToHistory(String path) {
    history.add(path);
    if (history.length > 100) {
      history.removeAt(0);
    }
    notifyListeners();
  }

  void processCommand(String input) {
    if (input.trim().isEmpty) return;

    final completeValue =
        '$pathPrefix ${fileSystem.currentDirectory.name} % $input';
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

    _respondToCommand(input);
  }

  void _respondToCommand(String command) {
    if (command.contains('cd')) {
      try {
        final path = command.split(' ')[1];
        fileSystem.cd(path);
      } catch (e) {
        if (command.split(" ").length == 1) {
          history.add("cd: missing operand");
          return;
        }
        history.add("cd: no such file or directory: $command");
      }

      notifyListeners();
      return;
    }

    if (command.contains('cat')) {
      final divide = command.split(' ');
      divide.removeAt(0);
      final path = divide.join(' ');
      final response = fileSystem.cat(path);
      history.add(response);
      notifyListeners();
      return;
    }

    switch (command) {
      case 'help' || 'h' || 'commands' || 'cmds' || 'man termoliobuiltins':
        final response =
            '''Available commands:\nhelp, h, commands or cmds, man termoliobuiltins - Show this help message and list of commands available\nclear, cls - Clear the terminal screen\nwhoami, wami, about, aboutme, ahmadexe - Show information about the author\nls - List the contents of the current directory\ncwd, pwd - Show the current working directory''';
        history.add(response);
        notifyListeners();

      case 'clear' || 'cls':
        history.clear();
        notifyListeners();

      case 'whoami' || 'wami' || 'about' || 'aboutme' || 'ahmadexe':
        final response =
            '''Ahmadexe is a software engineer and the creator of Termolio.\nHe is passionate about creating innovative solutions and enjoys working on open-source projects.\nHe has a background in computer science and has worked on various projects across different domains.\nYou can find more about him on his GitHub profile: https://github.com/ahmadexe''';
        history.add(response);
        notifyListeners();

      case 'pwd' || 'cwd':
        history.add(fileSystem.currentDirectory.name);
        notifyListeners();

      case 'ls':
        final response = fileSystem.ls();
        history.add(response);
        notifyListeners();

      default:
        history.add(
          "$pathPrefix ${fileSystem.currentDirectory.name} % termolio: command not found: $command",
        );
    }
  }
}
