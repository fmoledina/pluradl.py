#!/bin/bash

set -e
cp /pluradl/courses/courselist.txt /pluradl/courselist.txt

if [ -z "${USERNAME}" ]
then
    echo "Need to provide Pluralsight username in the USERNAME environment variable"
    exit 1
fi

if [ -z "${PASSWORD}" ]
then
    echo "Need to provide Pluralsight password in the PASSWORD environment variable"
    exit 1
fi

if [ -z "${RECORD_SUBTITLES}" ]
then
    RECORD_SUBTITLES="true"
fi

if [ "${RECORD_SUBTITLES}" = "true" ]
then
    SUBTITLE=""
else
    SUBTITLE="--subtitle"
fi

echo $DOWNLOAD_VIDEO
if [ "${DOWNLOAD_VIDEO}" = "true" ]
then
    python /pluradl/pluradl.py --user "${USERNAME}" --pass "${PASSWORD}" "${SUBTITLE}"
fi

## for future, when I figure out how to Dockerize chromedriver/selenium
# echo $DOWNLOAD_EXERCISE
# if [ "${DOWNLOAD_EXERCISE}" = "true" ]
# then
#     python /pluradl/pluraexercise.py --user "${USERNAME}" --pass "${PASSWORD}"
# fi
