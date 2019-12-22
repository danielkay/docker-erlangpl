# Based on https://github.com/ruanpienaar/erlangpl_docker
#
# MIT License
#
# Copyright (c) 2017 Ruan Pienaar
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM buildpack-deps:jessie
FROM node:7.2.0
RUN npm install -g elm@0.18.0
RUN npm install -g elm-test@0.18.0
RUN npm install --global yarn
ENV OTP_VERSION="19.3"
RUN set -xe \
        && OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz" \
        && OTP_DOWNLOAD_SHA256="fc82c5377ad9e84a37f67f2b2b50b27fe4e689440ae9e5d0f5dcfb440a9487ac" \
        && runtimeDeps='libodbc1 \
                        libsctp1 \
                        libwxgtk3.0-0' \
        && buildDeps='unixodbc-dev \
                        libsctp-dev \
                        libwxgtk3.0-dev' \
        && apt-get update \
        && apt-get install -y --no-install-recommends $runtimeDeps \
        && apt-get install -y --no-install-recommends $buildDeps \
        && curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" \
        && mkdir -p /usr/src/otp-src \
        && tar -xzf otp-src.tar.gz -C /usr/src/otp-src --strip-components=1 \
        && rm otp-src.tar.gz \
        && cd /usr/src/otp-src \
        && ./otp_build autoconf \
        && ./configure \
                --enable-sctp \
                --enable-dirty-schedulers \
        && make -j$(nproc) \
        && make install \
        && find /usr/local -name examples | xargs rm -rf \
        && apt-get purge -y --auto-remove $buildDeps \
        && rm -rf /usr/src/otp-src /var/lib/apt/lists/*

RUN git clone https://github.com/erlanglab/erlangpl.git && cd erlangpl && make rebar && make release
