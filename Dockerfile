FROM elenacuoco/env_wdf

RUN mkdir /adapter && mkdir /export && mkdir /import
WORKDIR /adapter

ADD .  /adapter/.

CMD ["/bin/bash"]