FROM amazonlinux:latest

# Need to set "ulimit -n" to a small value to stop yum from hanging:
# https://bugzilla.redhat.com/show_bug.cgi?id=1715254#c1
RUN ulimit -n 1024 && yum -y update && yum -y install \
    git \
    gcc \
    python37 \
    python37-pip \
    python37-devel \
    zip \
    md5sum \
    && yum clean all

# Make it possible to build numpy:
# https://github.com/numpy/numpy/issues/14147
ENV CFLAGS=-std=c99
