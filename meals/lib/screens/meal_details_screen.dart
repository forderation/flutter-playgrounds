import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatefulWidget {
  static const ROUTE = '/meal-details';
  final Function toogleFav;
  final Function isMealFav;

  MealDetailsScreen(this.toogleFav, this.isMealFav);

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  Widget buildSectionTitle(BuildContext ctx, String title) {
    return Container(
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.headline1,
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget buildGridIng(BuildContext ctx, List<String> ingredients) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: MediaQuery.of(ctx).size.height * 0.25,
      width: double.infinity,
      child: Card(
        elevation: 5,
        child: GridView(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: ingredients
              .map((e) => Container(
                    padding: EdgeInsets.all(10),
                    child: Flexible(
                      fit: FlexFit.tight,
                      child: Text(
                        e,
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(ctx).accentColor,
                        borderRadius: BorderRadius.circular(15)),
                  ))
              .toList(),
        ),
      ),
    );
  }

  IconData getStateFavIcon(String mealId) {
    return widget.isMealFav(mealId) ? Icons.favorite : Icons.favorite_border;
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final mealData = DUMMY_MEALS.firstWhere((element) => element.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${mealData.title}'),
        actions: [
          IconButton(
              icon: Icon(
                getStateFavIcon(mealId),
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                widget.toogleFav(mealId);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.network(
                mealData.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildGridIng(context, mealData.ingredients),
            buildSectionTitle(context, 'Steps'),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Card(
                elevation: 5,
                child: ListView.builder(
                  itemBuilder: (ctx, idx) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            child: Text('# ${idx + 1}'),
                          ),
                          title: Text(mealData.steps[idx]),
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: mealData.steps.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(mealId);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
