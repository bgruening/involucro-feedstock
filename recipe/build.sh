#! /bin/sh

set -e

export GOPATH="$( pwd )"
export GO111MODULE=on

cd "$( go env GOPATH )"/src/github.com/involucro/involucro

go build \
  -o "${PREFIX}/bin/involucro" \
  -ldflags="-s -X github.com/involucro/involucro/app.version=${PKG_VERSION}" \
  ./cmd/involucro

# Since https://github.com/conda/conda-build/issues/4121, conda build supports
# collected license files via directories, so we use go-licenses to save
# third-party licenses to "3rd_party_license"
go-licenses save ./cmd/involucro --save_path=3rd_party_license
