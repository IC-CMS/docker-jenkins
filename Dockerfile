FROM jenkins/jenkins:2.124-alpine

USER root
# plugins.txt contains list of default plugins
COPY plugins.txt /tmp/plugins.txt
# Configuration scripts set log in info, and install plugins etc.
COPY configuration/*.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY configuration/jenkins.CLI.xml /usr/share/jenkins/ref/
RUN chown jenkins:jenkins /usr/share/jenkins/ref/init.groovy.d/*.groovy \
  && chown jenkins:jenkins /usr/share/jenkins/ref/jenkins.CLI.xml \
  && chown jenkins:jenkins /tmp/plugins.txt \
  && apk --no-cache add shadow \
  && groupadd -g 792 docker \
  && apk --no-cache add docker \
  && usermod -aG docker jenkins \
  && rm -rf /var/cache/apk/* \
  && echo -e '#!/bin/bash\ndocker run --network=host -it --rm --cap-add IPC_LOCK -v /tmp:/mytmp -v $(pwd):/app --env-file/var/jenkins_home/vault/docker_vault.env_file -w /app --log-driver=none vault:0.9.5 "$@"' > /usr/bin/vault \
  && chmod +x /usr/bin/vault
USER jenkins
# Turns off the Jenkins Admin Setup Wizard
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
# Change the default Jenkins Update Center
# ENV JENKINS_UC="http://<your update center>"
RUN /usr/local/bin/install-plugins.sh < /tmp/plugins.txt
