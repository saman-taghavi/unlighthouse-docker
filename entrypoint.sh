#!/bin/sh
set -e

ARGS=""

[ -n "$SITE" ] && ARGS="$ARGS --site $SITE"
[ -n "$ROOT" ] && ARGS="$ARGS --root $ROOT"
[ -n "$CONFIG_FILE" ] && ARGS="$ARGS --config-file $CONFIG_FILE"
[ -n "$OUTPUT_PATH" ] && ARGS="$ARGS --output-path $OUTPUT_PATH"

# Feature flags
[ "$CACHE" = "true" ] && ARGS="$ARGS --cache"
[ "$CACHE" = "false" ] && ARGS="$ARGS --no-cache"

[ "$DESKTOP" = "true" ] && ARGS="$ARGS --desktop"
[ "$MOBILE" = "true" ] && ARGS="$ARGS --mobile"

[ "$THROTTLE" = "true" ] && ARGS="$ARGS --throttle"

[ -n "$SAMPLES" ] && ARGS="$ARGS --samples $SAMPLES"
[ -n "$SITEMAPS" ] && ARGS="$ARGS --sitemaps $SITEMAPS"
[ -n "$URLS" ] && ARGS="$ARGS --urls $URLS"
[ -n "$EXCLUDE_URLS" ] && ARGS="$ARGS --exclude-urls $EXCLUDE_URLS"
[ -n "$INCLUDE_URLS" ] && ARGS="$ARGS --include-urls $INCLUDE_URLS"

[ "$ENABLE_JS" = "true" ] && ARGS="$ARGS --enable-javascript"
[ "$ENABLE_JS" = "false" ] && ARGS="$ARGS --disable-javascript"

[ "$ENABLE_I18N" = "true" ] && ARGS="$ARGS --enable-i18n-pages"
[ "$ENABLE_I18N" = "false" ] && ARGS="$ARGS --disable-i18n-pages"

[ "$DISABLE_DYNAMIC" = "true" ] && ARGS="$ARGS --disable-dynamic-sampling"

[ -n "$EXTRA_HEADERS" ] && ARGS="$ARGS --extra-headers $EXTRA_HEADERS"
[ -n "$DEFAULT_QUERY_PARAMS" ] && ARGS="$ARGS --default-query-params $DEFAULT_QUERY_PARAMS"

[ "$DEBUG" = "true" ] && ARGS="$ARGS --debug"

echo "Running: npx unlighthouse $ARGS"
exec npx unlighthouse $ARGS
