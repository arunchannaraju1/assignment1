#!/bin/bash

# Script to verify the attestation of the package whl combined with package SBOM

thisdir=`(cd \`dirname $0\` > /dev/null 2>&1; pwd)`
proj_dir=${thisdir}/..

pkg_name="ac11937-rekor-tools"
pkg_dir=${proj_dir}/packages/${pkg_name}

dist_dir=${pkg_dir}/dist

pkg_ver=`${thisdir}/get_package_version.sh`

cd $proj_dir

read -n1 -s -r -p "Sign into GitHub first, then press any key to continue..."
echo ""

set -x
cosign verify-blob-attestation \
	--bundle ${dist_dir}/sbom-attestation.bundle \
	--certificate-identity "ac11937@nyu.edu" \
	--certificate-oidc-issuer https://github.com/login/oauth \
	--type cyclonedx \
	--check-claims \
	${dist_dir}/ac11937_rekor_tools-${pkg_ver}-py3-none-any.whl
