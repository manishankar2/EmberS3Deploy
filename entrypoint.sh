#!/bin/sh
if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

if [ -z "$BUILD_ENV" ]; then
  echo "BUILD_ENV is not set. Quitting."
  exit 1
fi

if [ "$REQUIRE_SSH" = "true" ]
then
  mkdir -p /root/.ssh && \
      chmod 0700 /root/.ssh && \
      ssh-keyscan github.com > /root/.ssh/known_hosts

  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
      chmod 600 /root/.ssh/id_rsa
fi

S3_PREFIX=""
if [ -z "$PREFIX" ]
then
  S3_PREFIX=${GITHUB_REF##*/}
else
  S3_PREFIX=$PREFIX
fi

npm config set prefix /usr/local
echo "Install ember cli"
npm install -g ember-cli
if [ "$BOWER" = "true" ]
then
  echo "Installing bower"
  npm install -g bower
  bower install --allow-root
fi
echo "Yarn install.."
yarn install
echo "Deploying to S3.."
BUCKET=$AWS_S3_BUCKET PREFIX=$S3_PREFIX ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY ./node_modules/.bin/ember deploy $BUILD_ENV --verbose
