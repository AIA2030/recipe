import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:flutter/material.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe>? _recipesList;

  List<Recipe>? get recipesList => _recipesList;

  Recipe? _recipe;

  Recipe? get recipe => _recipe;

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

  Future<void> getRecipe() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('recipes').get();

      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipesList = [];
      }
      notifyListeners();
    } catch (e) {
      _recipesList = [];
      notifyListeners();
    }
  }

  Future<void> getCertinRecipe(String id) async {
    try {
      var result =
      await FirebaseFirestore.instance.collection('recipes').doc(id).get();
      if (result.exists) {
        _recipe = Recipe.fromJson(result.data() ?? {}, result.id);
      } else {
        _recipe = null;
      }
      notifyListeners();
    } catch (e) {
      _recipe = null;
      notifyListeners();
    }
  }
}