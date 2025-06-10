import 'package:termolio/services/file_system/node.dart';

class FileNode extends Node {
  final String content;

  FileNode({required this.content, required super.name});
  
  @override
  bool get isDirectory => false;
}
