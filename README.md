udp datagram size bisection
---------------------------

We like to use the UDP transport for reporting errors to [sentry](https://github.com/getsentry/sentry).
But Rails tracebacks are very large, and even in a brand new dummy app, a gzipped traceback could easily be too large to fit into a single datagram.
So I wanted to know just how big they could be, since apparently based on some cursory googling, this is actually a hard question to answer.
