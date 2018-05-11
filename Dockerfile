FROM python:3.6-slim

WORKDIR /servo

# Install dependencies
RUN pip3 install requests PyYAML && \
    apt-get update && apt-get install -y apache2-utils

ADD https://raw.githubusercontent.com/opsani/servo-skopos/master/adjust \
    https://raw.githubusercontent.com/opsani/servo-ab/master/measure \
    https://raw.githubusercontent.com/opsani/servo/master/measure.py \
    https://raw.githubusercontent.com/opsani/servo/master/servo \
    app.yaml \
    app-model.yaml \
    app-env.yaml \ 
    /servo/

RUN chmod +x /servo/adjust /servo/measure /servo/servo 


ENTRYPOINT [ "python3", "servo" ]