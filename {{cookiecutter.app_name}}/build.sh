#!/bin/sh
set -eux



BIN_NAME={{cookiecutter.app_name}}

VERSION=$(grep "const Version " version/version.go | sed -E 's/.*"(.+)"$$/\1/')
GIT_COMMIT=$(git rev-parse HEAD)
GIT_DIRTY=$(test -n "`git status --porcelain`" && echo "+CHANGES" || true)
BUILD_DATE=$(date '+%Y-%m-%d-%H:%M:%S')

IMAGE_NAME="{{cookiecutter.app_name}}"
go build -ldflags "-X github.com/kcollasarundell/{{cookiecutter.app_name}}/version.GitCommit=${GIT_COMMIT}${GIT_DIRTY} -X github.com/kcollasarundell/bcg-notifier/version.BuildDate=${BUILD_DATE}" -o bin/${BIN_NAME}
