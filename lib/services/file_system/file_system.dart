import 'package:flutter/material.dart';
import 'package:termolio/services/file_system/directory_node.dart';
import 'package:termolio/services/file_system/file_node.dart';
import 'package:termolio/services/file_system/node.dart';

class FileSystem {
  late DirectoryNode _currentDirectory;
  late DirectoryNode _root;
  bool _isInitialized = false;

  FileSystem() {
    if (_isInitialized) return;
    _isInitialized = true;
    init();
  }

  DirectoryNode get currentDirectory => _currentDirectory;

  List<DirectoryNode> navigationHistory = [];

  void init() {
    _root = DirectoryNode(
      name: '~',
      children: [
        DirectoryNode(
          name: 'projects',
          children: [
            DirectoryNode(
              name: 'Agenix',
              children: [
                FileNode(
                  content:
                      "Build smart AI agents in Flutter with memory, tools, and LLMs like Gemini. Fast, pluggable, and developer-friendly.\nGitHub: https://github.com/ahmadexe/agenix\nPub dev: https://pub.dev/packages/agenix",
                  name: 'README.md',
                ),
              ],
            ),
            DirectoryNode(name: 'PRISM', children: []),
            DirectoryNode(name: 'Termolio', children: []),
            DirectoryNode(name: 'PRSIM Chain', children: []),
          ],
        ),
        DirectoryNode(name: 'awards', children: []),
        DirectoryNode(name: 'experience', children: []),
        DirectoryNode(
          name: 'articles',
          children: [
            FileNode(
              content:
                  'Explore how to send push notifications in Flutter web, medium link: https://medium.com/@ahmadexe/flutterfire-push-notifications-via-fcm-flutter-web-b475f3e0a5e2',
              name: 'FlutterFire Push Notifications via FCM — Flutter Web',
            ),
            FileNode(
              content:
                  'Do concurrent programming the right way, from the basics to the most used concurrency patterns in Go. Read more at: https://medium.com/@ahmadexe/concurrency-in-go-everything-you-need-to-know-5319e69a9e54',
              name: 'Concurrency in GO: Everything You Need to Know',
            ),
            FileNode(
              content:
                  "My journey building PRISM, learn about the architecture for the PRISM's mobile application and backend. Read more at: https://medium.com/@ahmadexe/behind-the-code-journey-building-prism-f3bf7de0883d",
              name: 'Behind the Code: Journey Building PRISM',
            ),
          ],
        ),
      ],
    );
    _currentDirectory = _root;

    navigationHistory.clear();
  }

  String ls() {
    final String content = _currentDirectory.children
        .map((e) => e.name)
        .join('\n');
    return content;
  }

  void cd(String path, {bool reset = false}) {
    if (reset) {
      _currentDirectory = _root;
      navigationHistory.clear();
      return;
    }

    if (path == '~') {
      navigationHistory.clear();
      _currentDirectory = _root;
    } else if (path == '..') {
      if (navigationHistory.isEmpty) {
        return;
      } else if (navigationHistory.length == 1) {
        navigationHistory.clear();
        _currentDirectory = _root;
        return;
      }

      navigationHistory.removeLast();
      _currentDirectory = navigationHistory.last;
    } else {
      DirectoryNode localCurrent = _currentDirectory;
      List<String> splitPath = path.split('/');

      for (int i = 0; i < splitPath.length; i++) {
        if (splitPath[i] == '') {
          continue;
        }

        Node node = localCurrent.children.firstWhere(
          (element) => element.name == splitPath[i],
        );

        if (node.isDirectory) {
          localCurrent = node as DirectoryNode;
          navigationHistory.add(localCurrent);
        } else {
          throw ("Not a directory");
        }
      }
      _currentDirectory = localCurrent;
    }
  }

  String cat(String fileName) {
    try {
      final Node file = _currentDirectory.children.firstWhere(
        (element) => element.name.toLowerCase() == fileName.toLowerCase(),
      );

      if (!file.isDirectory) {
        return (file as FileNode).content;
      }

      return "cat: ${file.name}: Is a directory";
    } catch (e) {
      debugPrint(e.toString());
      return "cat: no such file or directory: $fileName";
    }
  }
}
