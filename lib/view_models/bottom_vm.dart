import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../utils/hive_utils.dart';
import '../utils/session_key.dart';
import '../view/bottom.dart';
import 'base_vm.dart';

class BottomVM extends BaseViewModel{
  late PageController pageController;
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  set tabIndex(int value) {
    _tabIndex = value;
    notifyListeners();
  }
  @override
  initView() {
    pageController=  PageController(initialPage:_tabIndex);
    return super.initView();
  }

}