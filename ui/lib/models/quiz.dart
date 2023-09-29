class Quiz {
  // provided by quiz creator (in order of appearance on create quiz form)
  String name;
  String generator;
  String answerFormat;
  String topic;
  int numQuestions;
  int difficulty;

  // managed by firestore (in alphabetical order)
  String? id;
  final String? selfLink;
  final String? timeCreated;
  final String? updated;

  // managed by backend api (in alphabetical order)
  final String? creator;
  final String? imageUrl;
  final String? pin;
  // qAndA is generated by API but could also be manually created or edited by end user.
  String qAndA;
  final int? runCount;

  Quiz({
    // provided by quiz creator (in order of appearance on create quiz form)
    required this.name,
    required this.generator,
    required this.answerFormat,
    required this.topic,
    required this.numQuestions,
    required this.difficulty,

    // managed by firestore (in alphabetical order)
    this.id,
    this.selfLink,
    this.timeCreated,
    this.updated,

    //. managed by backend api (in alphabetical order)
    this.creator = '',
    this.imageUrl = 'assets/assets/images/quizaic_logo.png',
    this.pin = '',
    this.qAndA = '',
    this.runCount = 0,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      // provided by quiz creator (in order of appearance on create quiz form)
      name: json['name'],
      generator: json['generator'],
      answerFormat: json['answerFormat'],
      topic: json['topic'],
      numQuestions: json['numQuestions'],
      difficulty: json['difficulty'],

      // managed by firestore (in alphabetical order)
      id: json['id'],
      selfLink: json['selfLink'],
      timeCreated: json['timeCreated'],
      updated: json['updated'],

      //. managed by backend api (in alphabetical order)
      creator: json['creator'],
      imageUrl: json['imageUrl'],
      pin: json['pin'],
      qAndA: json['qAndA'],
      runCount: json['runCount'],
    );
  }

  Map toJson() => {
        'name': name,
        'generator': generator,
        'answerFormat': answerFormat,
        'topic': topic,
        'numQuestions': numQuestions,
        'difficulty': difficulty,
        'id': id,
        'selfLink': selfLink,
        'timeCreated': timeCreated,
        'updated': updated,
        'creator': creator,
        'imageUrl': imageUrl,
        'pin': pin,
        'qAndA': qAndA,
        'runCount': runCount,
      };
}
