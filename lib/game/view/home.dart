import 'package:flutter/material.dart';
import 'package:quiz_game/global/theme/theme.dart';
import 'widget/question_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<ThemeProvider>().changeTheme();
              },
              icon: Icon(Icons.change_circle))
        ],
        title: Text("home"),
      ),
      body: QuestionWidget(),
    );
  }
}
