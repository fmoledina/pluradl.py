FROM python:3.8.2-slim-buster

WORKDIR /pluradl

COPY . .

RUN chmod +x entrypoint.sh && \
    rm -rf /pluradl/courses/* && \
    # rm -rf /pluradl/exercise_files/* \ # for future, when I figure out how to Dockerize chromedriver/selenium
    rm -rf /pluradl/courselist.txt

ENV USERNAME \ 
    PASSWORD \
    RECORD_SUBTITLES="true" \
    DOWNLOAD_VIDEO="true"

VOLUME /pluradl/courses

ENTRYPOINT ["/pluradl/entrypoint.sh"]