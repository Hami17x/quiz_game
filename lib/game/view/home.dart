import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/game/model/question_model.dart';
import 'package:quiz_game/game/view/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/onboarding_page.dart';
import '../../theme/theme.dart';
import '../view_model/question_provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizz App'),
        actions: [
          ElevatedButton(
              onPressed: () {
                inspect(questions);
              },
              child: Text("sdsd")),
          IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("showHome", false);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => OnboardingPage()));
              },
              icon: Icon(Icons.arrow_back)),
          IconButton(
              onPressed: () {
                context.read<ThemeProvider>().changeTheme();
              },
              icon: Icon(Icons.change_circle))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
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
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(games[index].name),
                ),
              );
            }),
      ),
    );
  }
}
