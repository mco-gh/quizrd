FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/code-oss:latest

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter doctor -v

RUN mkdir -p /home/user
COPY ./ /usr/local/quizaic/

COPY codelab/200_codelab-setup.sh /etc/workstation-startup.d/
RUN chmod +x /etc/workstation-startup.d/200_codelab-setup.sh
