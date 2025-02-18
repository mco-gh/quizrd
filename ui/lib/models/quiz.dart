// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

class Quiz {
  // provided by quiz creator (in order of appearance on create quiz form)
  String name;
  String generator;
  String customGenUrl;
  String answerFormat;
  String topic;
  int numQuestions;
  String difficulty;
  String language;

  // managed by firestore (in alphabetical order)
  String? id;
  final String? selfLink;
  final String? timeCreated;
  final String? updated;

  // managed by backend api (in alphabetical order)
  final String? creator;
  final String? pin;
  // qAndA is generated by API but could also be manually created or edited by end user.
  final int? runCount;
  String? imageUrl;
  String qAndA;

  Quiz({
    // provided by quiz creator (in order of appearance on create quiz form)
    required this.name,
    required this.generator,
    required this.customGenUrl,
    required this.answerFormat,
    required this.topic,
    required this.numQuestions,
    required this.difficulty,
    required this.language,

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
    //print('json: $json');
    return Quiz(
      // provided by quiz creator (in order of appearance on create quiz form)
      name: json['name'],
      generator: json['generator'],
      customGenUrl: json['customGenUrl'],
      answerFormat: json['answerFormat'],
      topic: json['topic'],
      numQuestions: json['numQuestions'],
      difficulty: json['difficulty'],
      language: json['language'],

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
        'customGenUrl': customGenUrl,
        'answerFormat': answerFormat,
        'topic': topic,
        'numQuestions': numQuestions,
        'difficulty': difficulty,
        'language': language,
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
