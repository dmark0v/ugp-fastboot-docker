FROM node:6.10-alpine

COPY . /app

RUN \
  apk --no-cache add git openssh && \
  mkdir -p ~/.ssh && \
  chmod 700 ~/.ssh && \
  cp /app/ssh/id_rsa ~/.ssh/id_rsa && \
  chmod 0600 ~/.ssh/id_rsa && \
  cp /app/ssh/id_rsa ~/.ssh/id_rsa.pub && \
  chmod 0600 ~/.ssh/id_rsa.pub && \
  cat /app/ssh/known_hosts >> ~/.ssh/known_hosts && \
  cat /app/ssh/ssh_config >> ~/.ssh/config && \
  chmod 0600 ~/.ssh/known_hosts &&\
  cd /app && \
  npm install && \
  ./node_modules/.bin/ember build --production && \
  npm prune --production && \

EXPOSE 3000

CMD ["node", "/app/lib/fastboot-server/start.js"]
