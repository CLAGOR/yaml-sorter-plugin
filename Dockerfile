FROM openjdk:11-jdk-slim-buster

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# Install Gradle
ARG GRADLE_VERSION=7.3.3
ARG GRADLE_HOME=/opt/gradle
RUN curl -L https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip \
    && unzip gradle.zip \
    && mv gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
    && rm gradle.zip
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Create project directory
RUN mkdir -p /app
WORKDIR /app

# Copy project files
COPY . .

# Build project with Gradle
RUN gradle build

# To copy the built .yarn file outside of the container use:
# docker container cp <container-id>:/app/build/libs/yml-sorter-forked.jar /target/path
