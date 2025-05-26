FROM ghcr.io/indykoning/unlighthouse-docker
LABEL maintainer="saman-taghavi"

# Build-time ARGs (can be overridden via --build-arg), fallback to CapRover runtime ENV
ARG SITE=http://localhost
ENV SITE=${SITE}

ARG URLS=/host
ENV URLS=${URLS}

ARG OUTPUT_PATH=./desktop-report
ENV OUTPUT_PATH=${OUTPUT_PATH}

ARG SAMPLES=1
ENV SAMPLES=${SAMPLES}

ARG EXCLUDE_URLS=/blog,/blog/*
ENV EXCLUDE_URLS=${EXCLUDE_URLS}

ARG DESKTOP=true
ENV DESKTOP=${DESKTOP}

ARG MOBILE=false
ENV MOBILE=${MOBILE}

ARG ENABLE_JS=false
ENV ENABLE_JS=${ENABLE_JS}

ARG THROTTLE=true
ENV THROTTLE=${THROTTLE}

ARG DEBUG=false
ENV DEBUG=${DEBUG}

EXPOSE 80

CMD ["sh", "-ec", "\
    args=\"--site $SITE --urls $URLS --output-path $OUTPUT_PATH --samples $SAMPLES --exclude-urls $EXCLUDE_URLS\"; \
    [ \"$DESKTOP\" = \"true\" ] && args=\"$args --desktop\"; \
    [ \"$MOBILE\" = \"true\" ] && args=\"$args --mobile\"; \
    [ \"$ENABLE_JS\" = \"true\" ] && args=\"$args --enable-javascript\"; \
    [ \"$THROTTLE\" = \"true\" ] && args=\"$args --throttle\"; \
    [ \"$DEBUG\" = \"true\" ] && args=\"$args -d\"; \
    args=\"$args --build-static\"; \
    echo \"Running unlighthouse-ci with args: $args\"; \
    unlighthouse-ci $args ; \
    echo \"Starting static server at $OUTPUT_PATH on port 80\"; \
    npx sirv-cli $OUTPUT_PATH -p 80 \
    "]
