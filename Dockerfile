FROM sphinxdoc/sphinx

WORKDIR /docs
COPY requirements.txt /docs
RUN pip3 install -r requirements.txt

RUN apt-get update \
    && apt-get install -y \
          git \
    && apt-get autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
