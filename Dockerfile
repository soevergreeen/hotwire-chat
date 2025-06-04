FROM ruby:3.2.4-slim

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      nodejs \
      yarn \
      && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .
RUN sed -i '1 s|ruby\.exe|ruby|' bin/*

RUN gem install bundler -v 2.5.11 \
 && bundle install --jobs 4 --retry 3

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
