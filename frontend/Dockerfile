# Etapa de build: constrói a aplicação React
FROM node:20-alpine AS build-deps
WORKDIR /usr/src/app
COPY package*.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Etapa final: serve a aplicação construída com um servidor Node.js/Express
FROM node:20-alpine
WORKDIR /usr/src/app
RUN apk add --no-cache jq nano
COPY --from=build-deps /usr/src/app/build ./build
COPY server.js ./
COPY add-env-vars.sh-front ./add-env-vars.sh
RUN chmod +x add-env-vars.sh
RUN npm install express@4.18.2
EXPOSE 3250

# Comando de inicialização do contêiner
# 1. Executa o script para substituir as variáveis de ambiente nos arquivos estáticos.
# 2. Inicia o servidor Express para servir os arquivos.
CMD ["sh", "-c", "sh ./add-env-vars.sh && node server.js"]
