import 'package:daily_recipe/provider/recipe.provider.dart';
import 'package:daily_recipe/widgets/recipe_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  double rating =0;

  @override
  void initState() {
    Provider.of<RecipeProvider>(context, listen: false).getRecipe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton (icon: Icon(FontAwesomeIcons.barsStaggered, color: Colors.black87, size: 25,), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage()));
          },),
            actions: [
              IconButton(icon: Icon(Icons.notifications_none_outlined, color: Colors.black87, size: 25),onPressed: () {
              },),
            ],
        ),


        body: SafeArea(
          child: Consumer<RecipeProvider>(
            builder: (context, recipeProvider, _) => recipeProvider.recipesList == null
                ? const CircularProgressIndicator()
                : (recipeProvider.recipesList?.isEmpty ?? false)
                ? const Text('No Data Found')
                : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: recipeProvider.recipesList!.length,
              itemBuilder: (context, int index) => Container(
                padding: EdgeInsets.all(10),
                child: Column(
                children: [
                  Card(
                    color: Colors.grey.shade50,
                    clipBehavior: Clip.antiAlias,
                    child:Padding(
                      padding: EdgeInsets.all(10),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Container(
                            padding: EdgeInsets.all(5),
                            height: 70,
                            width: 100,
                            child:  Image.network(recipeProvider.recipesList![index].image ?? 'Not Found Image', fit: BoxFit.cover,),
                          ),

                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Text( recipeProvider.recipesList![index].type ?? 'No Name', style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: Colors.cyan, fontFamily: 'Hellix'),),


                                  ],
                                ),

                                SizedBox(height: 5,),

                                Text( recipeProvider.recipesList![index].title ?? 'No Name', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),),

                                SizedBox(height: 5,),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      maxRating: 1,
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      itemBuilder: (context, _) => Icon(Icons.star_rounded, color: Colors.deepOrange,size: 4 ),
                                      onRatingUpdate: (rating) => setState(() {
                                        this.rating = rating;
                                      }

                                      ),

                                    ),

                                    SizedBox(width: 10,),

                                    Text( 'Rates: ${recipeProvider.recipesList![index].rate}', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),

                                  ],
                                ),
                                SizedBox(height: 5,),

                                Text( 'Calories: ${recipeProvider.recipesList![index].calories}', style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),),

                                SizedBox(height: 5,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Icon(FontAwesomeIcons.clock, color: Colors.grey.shade400, size: 12),
                                              SizedBox(width: 5,),
                                              Text( 'Total Time: ${recipeProvider.recipesList![index].total_time}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),

                                            ],
                                          ),

                                          SizedBox(width: 30,),

                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Icon(FontAwesomeIcons.bellConcierge, color: Colors.grey.shade400, size: 12),
                                              SizedBox(width: 5,),
                                              Text( 'Serving: ${recipeProvider.recipesList![index].serving}', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                          ),

                          Container(
                            alignment:Alignment.topRight,

                            child: IconButton(icon: Icon(FontAwesomeIcons.heart, color: Colors.grey.shade400, size: 20),onPressed: () {
                              recipeProvider.addRecipesToUser(recipeProvider.recipesList![index].docId! ,
                                  FirebaseAuth.instance.currentUser?.uid != null &&
                                      !recipeProvider.recipesList![index].users_ids!.contains(FirebaseAuth.instance.currentUser?.uid));
                            },),

                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                ),
              ),
            ),
          ),
        )
    );


  }
}