import 'package:termolio/services/file_system/node.dart';

class DirectoryNode extends Node {
  List<Node> children;

  DirectoryNode({required super.name, required this.children});
  
  @override
  bool get isDirectory => true;
}