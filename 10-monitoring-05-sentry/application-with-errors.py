#!/usr/bin/env python3

import sentry_sdk

sentry_sdk.init(
    "https://e29eb4e5f88b4f3ba1f6a4a4fcad44d3@o1130092.ingest.sentry.io/6174040",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)

sum = 2 + '1'