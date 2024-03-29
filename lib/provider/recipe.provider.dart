import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/utils/toast_message_status.dart';
import 'package:daily_recipe/widgets/toast_message.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe>? _recipesList;

  List<Recipe>? get recipesList => _recipesList;

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

  Future<void> addRecipesToUser(String recipeId, bool isAdd) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"users_ids" : FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
            });
      } else {
        await FirebaseFirestore.instance.collection('recipes').doc(recipeId).update(
            {"users_ids" : FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
            });
      }
      OverlayLoadingProgress.stop();
      getRecipe();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.failed,
        ),
      );
    }
  }
}