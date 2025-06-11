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
    "Hello visitor, it's good to see you here\nTry <help> command for more info or <about> to know more about me",
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
          fileSystem.cd('', reset: true);
          return;
        }
        history.add(e.toString());
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
            '''Available commands:\nhelp, h, commands or cmds, man termoliobuiltins - Show this help message and list of commands available\nclear, cls - Clear the terminal screen\nwhoami, wami, about, aboutme, ahmadexe - Show information about the author\nls - List the contents of the current directory\ncwd, pwd - Show the current working directory\ncd <path> - Change the current directory to <path>\ncat <file> - Display the contents of the specified file''';
        history.add(response);
        notifyListeners();

      case 'clear' || 'cls':
        history.clear();
        notifyListeners();

      case 'whoami' || 'wami' || 'about' || 'aboutme' || 'ahmadexe':
        final response =
            '''Hey, I'm Muhammad Ahmad or Ahmadexe or the guy behind Termolio. I'm a software engineer who loves building cool stuff. Whether it's open-source tools, side projects, or random ideas I turn into reality, I'm all about creating things that feel thoughtful and sharp.\nI come from a computer science background, but I’ve never been the “just follow the syllabus” type. I like exploring, tinkering, and pushing boundaries — from dev tools to full-stack apps. I believe good software is equal parts logic and soul..\nYou can find more about me on my GitHub profile: https://github.com/ahmadexe\nMedium: https://medium.com/@ahmadexe\nLinkedIn: https://www.linkedin.com/in/ahmadexe/''';
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
          "$pathPrefix ${fileSystem.currentDirectory.name} % termolio: command not found: $command Try 'help' for more information.",
        );
    }
  }
}
