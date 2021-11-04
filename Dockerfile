FROM python:3-alpine

WORKDIR /opt/

ENV AWS_DEFAULT_REGION eu-west-1 
ENV PYTHONPATH /opt/scripts/

ENV TERRAFORM_VERSION=0.13.2
ENV TERRAFORM_ZIP=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ENV TERRAFORM_SUM=6c1c6440c5cb199e85926aea65773450564f501fddcd7876f453ba95b45ba746

RUN apk add -U ca-certificates curl git && \
    cd /tmp && \
    curl -fsSLO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP} && \
    echo "${TERRAFORM_SUM}  /tmp/${TERRAFORM_ZIP}" | sha256sum -c - && \
    unzip /tmp/${TERRAFORM_ZIP} -d /usr/bin && \
    rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

RUN apk add --no-cache python3 py3-pip && \
    pip3 install boto3 flake8


COPY . .

CMD ["sh", "/opt/run_test.sh"]
