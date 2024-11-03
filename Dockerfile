FROM python:latest
WORKDIR /app

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


ADD helper ./helper
ADD predictors ./predictors
COPY .env .
COPY kicktippbb.py .

RUN apt-get update && apt-get -y install cron
COPY crontab /etc/cron.d/crontab
RUN chmod 0644 /etc/cron.d/crontab
RUN /usr/bin/crontab /etc/cron.d/crontab
RUN touch /var/log/cron.log

CMD ["cron", "-f"]

#CMD [ "python", "kicktippbb.py", "reference-round-jhor" ]