import sys
from urlparse import urlparse

result = urlparse(sys.argv[1])

print result.scheme, result.username, result.password, result.hostname, result.path
