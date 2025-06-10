part of '../configs.dart';

class SpaceToken {
  static late double t05;
  static late double t10;
  static late double t15;
  static late double t20;
  static late double t25;
  static late double t30;
  static late double t60;
  static late double t100;

  static void init() {
    t05 = 0.5.fs();
    t10 = 1.0.fs();
    t15 = 1.5.fs();
    t20 = 2.0.fs();
    t25 = 2.5.fs();
    t30 = 3.0.fs();
    t60 = 6.0.fs();
    t100 = 10.0.fs();
  }
}
