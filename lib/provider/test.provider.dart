import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/test.model.dart';
import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  List<Test>? _testsList;

  List<Test>? get testsList => _testsList;

  Test? _test;

  Test? get test => _test;

  int sliderIndex = 0;
  CarouselController? carouselController;

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void disposeCarousel() {
    carouselController = null;
  }

  void onDotTapped(int position) async {
    await carouselController?.animateToPage(position);
    sliderIndex = position;
    notifyListeners();
  }

  void initCarousel() {
    carouselController = CarouselController();
  }

  Future<void> getTest() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('test').get();

      if (result.docs.isNotEmpty) {
        _testsList = List<Test>.from(
            result.docs.map((doc) => Test.fromJson(doc.data(), doc.id)));
      } else {
        _testsList = [];
      }
      notifyListeners();
    } catch (e) {
      _testsList = [];
      notifyListeners();
    }
  }

  Future<void> getCertinTest(String id) async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('test').doc(id).get();
      if (result.exists) {
        _test = Test.fromJson(result.data() ?? {}, result.id);
      } else {
        _test = null;
      }
      notifyListeners();
    } catch (e) {
      _test = null;
      notifyListeners();
    }
  }
}