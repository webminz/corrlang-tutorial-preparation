FROM codercom/code-server:latest
USER root
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH=$JAVA_HOME/bin:$PATH
ENV JAVA_VERSION=jdk-21.0.10+7
RUN set -eux; apt update; apt install -y --no-install-recommends gnupg ca-certificates graphviz nodejs npm
RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       amd64) \
         ESUM='991be6ac6725e76109ecbd131d658f992dcbeacba3a8b4b6650302c8012b52fb'; \
         BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.10%2B7/OpenJDK21U-jre_x64_linux_hotspot_21.0.10_7.tar.gz'; \
         CORRLANG_URL='https://github.com/webminz/corrlang-cli/releases/download/v1.0.0-alpha-nightly/corrl-linux-amd64'; \
         ;; \
       arm64) \
         ESUM='3ca84da7c4f57eee8d7e7f0645dc904a3a06456d32b37a4dd57a5e7527245250'; \
         BINARY_URL='https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.10%2B7/OpenJDK21U-jre_aarch64_linux_hotspot_21.0.10_7.tar.gz'; \
         CORRLANG_URL='https://github.com/webminz/corrlang-cli/releases/download/v1.0.0-alpha-nightly/corrl-linux-arm64'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    wget --progress=dot:giga -O /tmp/openjdk.tar.gz ${BINARY_URL}; \
    wget --progress=dot:giga -O /tmp/openjdk.tar.gz.sig ${BINARY_URL}.sig; \
    wget --progress=dot:giga -O /tmp/corrl ${CORRLANG_URL}; \
    mkdir -p /home/coder/.local/bin; \
    mv /tmp/corrl /home/coder/.local/bin/corrl; \
    chown -R coder:coder /home/coder/.local/bin; \
    chmod 744 /home/coder/.local/bin/corrl; \
    export GNUPGHOME="$(mktemp -d)"; \
    # gpg: key 843C48A565F8F04B: "Adoptium GPG Key (DEB/RPM Signing Key) <temurin-dev@eclipse.org>" imported
    gpg --batch --keyserver keyserver.ubuntu.com --recv-keys 3B04D753C9050D9A5D343F39843C48A565F8F04B; \
    gpg --batch --verify /tmp/openjdk.tar.gz.sig /tmp/openjdk.tar.gz; \
    rm -rf "${GNUPGHOME}" /tmp/openjdk.tar.gz.sig; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p "$JAVA_HOME"; \
    tar --extract \
        --file /tmp/openjdk.tar.gz \
        --directory "$JAVA_HOME" \
        --strip-components 1 \
        --no-same-owner \
    ; \
    rm -f /tmp/openjdk.tar.gz; \
    # https://github.com/docker-library/openjdk/issues/331#issuecomment-498834472
    find "$JAVA_HOME/lib" -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf; \
    ldconfig; \
    # https://github.com/docker-library/openjdk/issues/212#issuecomment-420979840
    # https://openjdk.java.net/jeps/341
    java -Xshare:dump; \
    chown -R coder:coder $JAVA_HOME;
# TODO: install java, node, corrl
USER coder
ENV PATH=$PATH:/home/coder/.local/bin
RUN corrl install
RUN mkdir -p /home/coder/project
ADD --chown=coder:coder https://github.com/webminz/usecase_SalesInvicesHR.git /home/coder/endpoints
RUN npm install --prefix /home/coder/endpoints/endpoint1; \
    npm install --prefix /home/coder/endpoints/endpoint2; \
    npm install --prefix /home/coder/endpoints/endpoint3
COPY --chown=coder:coder config.yaml /home/coder/.config/code-server/config.yaml
COPY --chown=coder:coder settings.json /home/coder/.local/share/code-server/User/settings.json
#COPY --chown=coder:coder extension /home/coder/.local/share/code-server/extensions/corrlang
COPY --chown=coder:coder case_01 /home/coder/project/case_01
COPY --chown=coder:coder case_02 /home/coder/project/case_02
COPY --chown=coder:coder case_03 /home/coder/project/case_03
COPY --chown=coder:coder README.md /home/coder/project/README.md
ENV PATH=$JAVA_HOME/bin:$PATH
COPY --chown=coder:coder --chmod=744 startup.sh /home/coder/startup.sh
CMD ["startup.sh"]
