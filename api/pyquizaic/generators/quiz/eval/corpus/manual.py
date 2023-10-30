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

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import json
import random
import sys
import time
import vertexai
from vertexai.language_models import TextGenerationModel

sys.path.append("../../../../../")
from pyquizaic.generators.quiz.quizgenfactory import QuizgenFactory

gen = QuizgenFactory.get_gen("opentrivia")
gen2 = QuizgenFactory.get_gen("palm")

num_questions = 100
questions_per_quiz = 5
num_answers = 4
count = 0
qa = []
labels = []
seen = {}

# Generate QA and labels.
topics = list(gen.get_topics())

while True:
    topic = random.choice(topics)
    quiz = gen2.gen_quiz(topic, questions_per_quiz, num_answers)
    for question in quiz:
        q = question["question"]
        if q in seen:
            print("skipping")
            continue
        seen[q] = True
        count += 1
        responses = question["responses"]
        correct = question["correct"]
        for r in responses:
            label = "false"
            if r == correct:
                label = "true"
            qa.append(f"- Q: {q} A: {r}")
            labels.append(label)
    if count >= num_questions:
        break


def write_keys(d, f):
    for key in d:
        f.write(f"{key}\n")


with open("assertions.man.txt", "w") as f:
    write_keys(qa, f)
with open("labels.man.txt", "w") as f:
    write_keys(labels, f)
