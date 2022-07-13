import 'package:quiz_game/game/model/question_model.dart';

final games = [
  Game(
    questions: (questions.toList()..shuffle()).take(4).toList(),
    name: 'Quizz',
  ),
  Game(
    //questions: (questions..shuffle()).take(4).toList(),
    questions: (questions.toList()..shuffle()).take(4).toList(),
    name: 'Quizz2',
  ),
  Game(
      name: "B1 Adverb",
      questions: b1Adverb
          .map((e) => Question(
              text: e.definition,
              options: getOptions(
                  e.value, b1Adverb.map((e) => Option(text: e.value)).toList()),
              option: Option(text: e.value)))
          .toList())
];

final questions = [
  Question(
      option: Option(text: "a"), text: "a?", options: getOptions("a", options)),
  Question(
      option: Option(text: "b"), text: "b?", options: getOptions("b", options)),
  Question(
      option: Option(text: "c"), text: "c?", options: getOptions("c", options)),
];

final options = [
  Option(text: "a"),
  Option(text: "b"),
  Option(text: "c"),
  Option(text: "d"),
  Option(text: "e"),
  Option(text: "f"),
  Option(text: "g"),
];

class Word {
  final String value;
  final String definition;
  final Type type;
  //final Level level;
  final List<String> examples;

  Word({
    required this.value,
    required this.type,
    required this.definition,
    required this.examples,
  });
}

enum Type { adverb, adjective }
enum Level { a1, a2, b1, b2, c1 }

final b1Adverb = [
  Word(
      value: "absolutely",
      type: Type.adverb,
      definition: "used to emphasize that something is completely true",
      examples: ["You're absolutely right.", "Are you absolutely sure?"]),
  Word(
      value: "ahead",
      type: Type.adverb,
      definition: "further forward in space or time; in front",
      examples: [
        "The road ahead was blocked.",
        "This will create problems in the months ahead."
      ]),
  Word(
      value: "apart",
      type: Type.adverb,
      definition: "separated by a distance, of space or time",
      examples: [
        "Their birthdays are only three days apart.",
        "The two houses stood 500 metres apart."
      ]),
  Word(
      value: "approximately",
      type: Type.adverb,
      definition:
          "used to show that something is almost, but not completely, accurate or correct",
      examples: [
        "The two buildings were approximately equal in size.",
        "The journey took approximately seven hours."
      ]),
  Word(
    value: "backwards",
    type: Type.adverb,
    definition: "towards a place or position that is behind",
    examples: [
      "I lost my balance and fell backwards.",
      "He took a step backwards."
    ],
  ),
  Word(
    value: "cheap",
    type: Type.adverb,
    definition: "for a low price",
    examples: [
      "They're selling fabrics cheap this week.",
      "private equity companies that borrow cheap"
    ],
  )
];

final demo = Word(
  value: "word",
  type: Type.adverb,
  definition: "definiton",
  examples: ["example1", "example2"],
);
