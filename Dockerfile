FROM ghcr.io/indykoning/unlighthouse-docker
LABEL maintainer="saman-taghavi"

ENV SITE="http://otaghak.com" \
    URLS="/host" \
    OUTPUT_PATH="./desktop-report" \
    SAMPLES=1 \
    EXCLUDE_URLS="/blog,/blog/*" \
    DESKTOP="true" \
    MOBILE="false" \
    ENABLE_JS="false" \
    THROTTLE="true" \
    DEBUG="true"

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