# Build Stage
FROM {{cookiecutter.docker_build_image}}:{{cookiecutter.docker_build_image_version}} AS build-stage

LABEL app="build-{{cookiecutter.app_name}}"
LABEL REPO="https://{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}"

ENV PROJPATH=/go/src/{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}
WORKDIR /go/src/{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}

RUN apk --update add ca-certificates git
RUN ./build.sh

# Final Stage
FROM {{cookiecutter.docker_image}}

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/{{cookiecutter.app_name}}/bin

WORKDIR /opt/{{cookiecutter.app_name}}/bin
COPY docker/passwd /etc/passwd
COPY --from=build-stage /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build-stage /go/src/{{cookiecutter.git_domain }}/{{ cookiecutter.git_user}}/{{cookiecutter.app_name}}/bin/{{cookiecutter.app_name}} /opt/{{cookiecutter.app_name}}/bin/

USER {{cookiecutter.app_name}}

ENTRYPOINT ["/opt/{{cookiecutter.app_name}}/bin/{{cookiecutter.app_name}}"]
