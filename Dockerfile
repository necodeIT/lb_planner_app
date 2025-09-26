FROM nginx:bookworm

ARG APP_NAME
ARG BASE_HREF=/

COPY ./build/web /usr/share/nginx/html

RUN sed -i "s/secondsSinceEpoch/$(date +%s)/g" /usr/share/nginx/html/index.html

RUN sed -i "s|<base href=\"/\">|<base href=\"$BASE_HREF\">|g" /usr/share/nginx/html/index.html

RUN sed -i "s/{appname}/$(grep APP_NAME .env | cut -d '=' -f 2 | tr -d '"')/g" /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
