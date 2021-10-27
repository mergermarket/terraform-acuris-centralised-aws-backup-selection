FROM hashicorp/terraform:0.13.2

WORKDIR /opt/

ENV AWS_DEFAULT_REGION eu-west-1 
ENV PYTHONPATH /opt/scripts/

RUN apk add --no-cache python3 py3-pip && \
    pip3 install boto3 flake8

COPY . .
