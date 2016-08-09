FROM ruby:2

RUN apt-get update -qq && \
    apt-get install -y \
        locales \
        build-essential \
        libpq-dev \
        nodejs \
        netcat \
        supervisor

# Use en_US.UTF-8 as our locale
RUN locale-gen en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US:en 
ENV LC_ALL en_US.UTF-8


RUN mkdir -p /app

WORKDIR /app
ADD ./ap/Gemfile /app/Gemfile
ADD ./ap/Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD ./ap /app
ADD etc/supervisor/app.conf /etc/supervisor/conf.d/

ADD entripoint.sh /
RUN chmod +x /entripoint.sh

CMD ["/entripoint.sh"]
