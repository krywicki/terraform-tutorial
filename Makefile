PACKAGE_NAME=lambda
TEMPLATE=template.yml
VERSION=1.0.0
ARTIFACT=${PACKAGE_NAME}-${VERSION}.zip

.PHONY: init test clean

init:
	cd src; pip install -r requirements.txt

clean:
	rm -rf .aws-sam/build

build:
	sam build -t ${TEMPLATE} --use-container
	cd .aws-sam/build/LambdaFunction && zip -rq ../${ARTIFACT} *

test:
	pytest

github-release:
	gh release create ${VERSION} --notes "Release for ${VERSION}"

github-upload:
	gh release upload ${VERSION} .aws-sam/build/${ARTIFACT}
