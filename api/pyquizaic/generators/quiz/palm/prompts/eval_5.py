# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import copy
import json
import os


# eval5 prompt keeps the "correct" field as a hint but seems to bias the LLM

class QuizevalHelper:

    def __init__(self):
        prompt_version = os.path.basename(__file__)[:-3]
        file_path = os.path.join(os.path.dirname(__file__), f"{prompt_version}.txt")
        with open(file_path, encoding='utf-8') as fp:
            self.prompt_template = fp.read()

    def __str__(self):
        return "eval_5"

    def prepare_prompt(self, quiz, topic):
        # Use correct answer as a hint to the model
        quiz_eval = copy.deepcopy(quiz)
        # for item in quiz_eval:
        #     item.pop("correct")
        prompt = self.prompt_template.format(quiz=json.dumps(quiz_eval, indent=4), topic=topic)
        return prompt

    @staticmethod
    def parse_output_and_eval_quiz(validity, prediction, quiz, topic):
        try:
            # Sometimes the model returns invalid JSON with a trailing comma, remove it.
            if prediction[-3:] == ",\n]":
                prediction = prediction[:-3] + "\n]"

            evaluation = json.loads(prediction)
        except ValueError as e:
            print(f'prediction:"{prediction}"')
            raise ValueError("An exception occurred during JSON parsing", e)

        # [{"on_topic": true, "correct": "George Washington"},
        for index, item in enumerate(evaluation):
            question = quiz[index]['question']

            if not item["on_topic"]:
                validity["valid_quiz"] = False
                validity["invalid_questions"].add(question)
                validity["details"].append(f"Invalid #5: The question is not on the topic - question: '{question}'"
                                           f", topic: {topic}")

            expected_correct = item["correct"]
            actual_correct = quiz[index]["correct"]
            if expected_correct != actual_correct:
                validity["valid_quiz"] = False
                validity["invalid_questions"].add(question)
                validity["details"].append(f"Invalid #6: The correct answer is not correct - question: '{question}"
                                           f"', expected: {expected_correct}, actual: {actual_correct}")

            if question not in validity["invalid_questions"]:
                validity["valid_questions"].add(question)

        return validity
