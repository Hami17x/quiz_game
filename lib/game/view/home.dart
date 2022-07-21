import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/model/word_model.dart';
import 'package:quiz_game/game/view/game.dart';

import '../../theme/theme.dart';
import '../model/question_model.dart';
import '../view_model/question_provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
        actions: [
          /*
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("showHome", false);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OnboardingPage()));
              },
              icon: Icon(Icons.arrow_back)),
              */
          IconButton(
              onPressed: () {
                context.read<ThemeProvider>().changeTheme();
              },
              icon: context.watch<ThemeProvider>().isLightTheme
                  ? Icon(Icons.light_mode)
                  : Icon(Icons.dark_mode))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("tıkla")),
            Text(
              "Popular",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            _popularGames(context, context.watch<QuestionProvider>().games),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Levels",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                  width: 200,
                  child: Card(
                    child: Center(
                        child: Image.asset(
                      "assets/coming_soon.png",
                      width: 100,
                      height: 100,
                    )),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Others",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => SizedBox(
                height: 200,
                child: Card(
                  child: Center(
                      child: Image.asset(
                    "assets/coming_soon.png",
                    width: 100,
                    height: 100,
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView _popularGames(BuildContext context, List<Game> games) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: games.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            onTap: () {
              context.read<QuestionProvider>().retry();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GamePage(
                        game: games[index],
                      )));
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(15)),
              child: Text(games[index].name),
            ),
          );
        });
  }
}
