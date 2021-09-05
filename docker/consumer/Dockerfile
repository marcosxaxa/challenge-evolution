FROM python:3.6-alpine

RUN addgroup -S kafka && adduser -S kafka -G kafka
# RUN ln -sf /bin/bash /bin/sh
# RUN addgroup -g 1500 -S kafka RUN adduser -S -G kafka -u 1500 -s /bin/bash -h /home/kafka kafka
# RUN useradd -u 1500 /bin/bash kafka

USER kafka:kafka

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY consumer.py .

CMD [ "python3", "consumer.py"]

RUN find /app -perm +6000 -type f -exec chmod a-s {} \; || true