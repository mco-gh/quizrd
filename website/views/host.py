# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from flask import Blueprint, g, redirect, request, render_template
from middleware.logging import log
from views.helpers.time import convert_utc

host_bp = Blueprint("host", __name__, template_folder="templates")

restrict = False

@host_bp.route("/host/<int:pin>")
def host(pin):
    if restrict: return render_template("errors/403.html"), 403
    current_user = None
    log(f"pin: {pin}")

    if g.session_data:
        current_user = g.session_data.get("email")

    #if current_user != "marcacohen@gmail.com" and current_user != "ksprashanth@google.com":
        #log(f"user not authoriozed to run quiz", severity="ERROR")
        #return render_template("errors/403.html"), 403

    try:
        quizzes = g.api.quizzes_get()
    except Exception as e:
        log(f"Exception when listing quizzes view: {e}", severity="ERROR")
        quizzes = []

    quiz = None;
    for q in quizzes:
        if q.pin == str(pin):
            quiz = q
            break
    if not quiz:
        log(f"Requested quiz with pin {pin} not found", severity="ERROR")

    return render_template("host.html", pin=pin, quiz=quiz, current_user=current_user)
