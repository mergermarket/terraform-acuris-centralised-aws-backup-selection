FROM hashicorp/terraform:0.15.0

WORKDIR /opt/

ENV AWS_DEFAULT_REGION eu-west-1 
ENV PYTHONPATH /opt/scripts/

RUN apk add --no-cache python3 && \
    pip3 install boto3 flake8

COPY . .
