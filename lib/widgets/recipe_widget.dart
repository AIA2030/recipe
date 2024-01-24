import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/provider/recipe.provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipeWidget extends StatefulWidget {
  const RecipeWidget({super.key});

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {

  void initState() {
    init();
    super.initState();
  }

  void init() async {
    await Provider.of<RecipeProvider>(context, listen: false).getRecipe();
  }

  @override
  void dispose() {
    Provider.of<RecipeProvider>(context, listen: false).disposeCarousel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeProvider>(
    builder: (ctx, recipeProvider, _) => recipeProvider.recipesList == null
    ? const CircularProgressIndicator()
        : (recipeProvider.recipesList?.isEmpty ?? false)
    ? const Text('No Data Found')
        : Column(
    children: [
    CarouselSlider(
    carouselController: recipeProvider.carouselController,
    options: CarouselOptions(
    autoPlay: true,
    height: 200,
    viewportFraction: .75,
    enlargeStrategy: CenterPageEnlargeStrategy.height,
    enlargeCenterPage: true,
    onPageChanged: (index, _) =>
    recipeProvider.onPageChanged(index),
    enlargeFactor: .3),
    items: recipeProvider.recipesList!.map((recipe) {
    return Stack(
    children: [
    Container(
    width: MediaQuery.of(context).size.width,
    margin:
    const EdgeInsets.symmetric(horizontal: 5.0),
    decoration: BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.fitWidth,
    image: NetworkImage(recipe.image!))),
    ),
    Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.black38,
    borderRadius: BorderRadius.circular(25)),
    child: Padding(
    padding: const EdgeInsets.all(4.0),
    child: Text(
    recipe.title.toString(),
    style: const TextStyle(
    fontSize: 16.0, color: Colors.white),
    ),
    ),
    ),
    ),
    ],
    );
    }).toList(),
    ),
    DotsIndicator(
    dotsCount: recipeProvider.recipesList!.length,
    position: recipeProvider.sliderIndex,
    onTap: (position) => recipeProvider.onDotTapped(position),
    decorator: DotsDecorator(
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0)),
    ),
    ),
    ],
    ),
    );
  }
}
