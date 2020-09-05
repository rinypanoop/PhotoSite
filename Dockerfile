FROM ruby:2.6.3
MAINTAINER rgeorge7@horizon.csueastbay.edu

ENV RAILS_ENV development
COPY . photosite
WORKDIR photosite
RUN gem install rails bundler
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn
RUN bundle update --bundler
RUN bundle install
RUN yarn install --check-files
RUN rails webpacker:install
ENTRYPOINT ./entrypoint.sh



EXPOSE 3000
RUN  bundle exec rake assets:precompile
RUN  bundle exec rake db:migrate


