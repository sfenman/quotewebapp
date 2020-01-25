FROM python:3.6-alpine

RUN adduser -D quote

WORKDIR /home/quoteapp

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY quote.py config.py start.sh ./
RUN chmod +x start.sh

ENV FLASK_APP quote.py

RUN chown -R quote:quote ./
USER quote

EXPOSE 5000
ENTRYPOINT ["./start.sh"]
