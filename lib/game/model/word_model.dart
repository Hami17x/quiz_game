class Word {
  final String value;
  final String definition;
  final String type;
  final List<dynamic> examples;

  Word({
    required this.value,
    required this.type,
    required this.definition,
    required this.examples,
  });

  static Word fromJson(json) => Word(
      value: json["value"],
      type: json["type"],
      definition: json["definition"],
      examples: json["examples"]);
}
