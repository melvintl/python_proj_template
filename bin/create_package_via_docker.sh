#!/bin/bash
echo "Start: Deployment Package Creation"
DEPLOY=/deploy_folder

mkdir $DEPLOY
pip3 install -r /app/requirements.txt -t $DEPLOY
cp -r /app/src/* $DEPLOY/
ls $DEPLOY
cd $DEPLOY
zip -X -r /app/deploy.zip ./
echo "Completed: Deployment Package Creation"

