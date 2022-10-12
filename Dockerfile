ARG IMAGE=python:3.10-bullseye

FROM $IMAGE AS builder
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH=/root/.local/bin:$PATH
WORKDIR /root/cdk-commander
COPY pyproject.toml poetry.lock /root/cdk-commander/
RUN poetry export -o requirements.txt && \
    grep -e '[a-z]' requirements.txt || \
    cat /dev/null > requirements.txt

FROM $IMAGE
WORKDIR /root/cdk-commander
COPY --from=builder /root/cdk-commander/requirements.txt /root/cdk-commander/
RUN apt-get update && \
    apt-get install -y libmariadb-dev && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/*
RUN test ! -s requirements.txt || \
    pip install -r requirements.txt
COPY cdk_commander /root/cdk-commander/cdk_commander
