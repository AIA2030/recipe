import 'package:daily_recipe/provider/Ingredients.provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  double rating =0;

  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<IngredientsProvider>(
          builder: (context, ingredientProvider, _) => ingredientProvider.ingredientsList == null
              ? const CircularProgressIndicator()
              : (ingredientProvider.ingredientsList?.isEmpty ?? false)
              ? const Text('No Data Found')
              : ListView.builder(
            itemCount: ingredientProvider.ingredientsList!.length,
            itemBuilder: (context, index) => ListTile(
              leading: Checkbox(
                value: ingredientProvider.ingredientsList![index].users_ids
                ?.contains(FirebaseAuth.instance.currentUser?.uid),

                onChanged: (value) {
                  ingredientProvider.addIngredientsToUser(ingredientProvider.ingredientsList![index].docId!,
                      value ?? false);
                },),

              title: Text(ingredientProvider.ingredientsList![index].name ?? 'No Name'),

              trailing: Container(
                padding: EdgeInsets.all(10.0),
                height: 60,
                width: 60,
                child:  Image.network(ingredientProvider.ingredientsList![index].image ?? 'Not Found Image', fit: BoxFit.cover,),
              ),
            ),
          ),
      ),
    );
  }
}
