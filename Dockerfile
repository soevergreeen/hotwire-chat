# 1. Указываем официальную Ruby‑базу
FROM ruby:3.2.4-slim

# 2. Устанавливаем системные зависимости для компиляции гемов, Node.js (asset pipeline) и PostgreSQL‑клиент
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      nodejs \
      yarn \
      && rm -rf /var/lib/apt/lists/*

# 3. Создаём рабочую директорию
WORKDIR /app

COPY . .
RUN sed -i '1 s|ruby\.exe|ruby|' bin/*
# 4. Копируем Gemfile и Gemfile.lock, чтобы кешировать bundle install
COPY Gemfile Gemfile.lock ./

# 5. Устанавливаем bundler и гемы
RUN gem install bundler -v 2.5.11 \
 && bundle install --jobs 4 --retry 3
# 6. Копируем весь код приложения
# 7. Предварительные задачи (опционально)
# ENV RAILS_ENV=production
# RUN bundle exec rails assets:precompile

# 8. Определяем порт и команду запуск
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
