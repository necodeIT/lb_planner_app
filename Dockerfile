FROM nginx:bookworm

ARG MOODLE_ENDPOINT
ARG LB_PLANNER_ENDPOINT
ARG REFRESH_INTERVAL
ARG IMPORTANT_REFRESH_INTERVAL
ARG LESS_IMPORTANT_REFRESH_INTERVAL
ARG SENTRY_DSN
ARG APP_NAME
ARG MAJOR_VERSION
ARG MINOR_VERSION
ARG PATCH_VERSION
ARG BUILD_NUMBER
ARG BUILD_CHANNEL
ARG RELEASE_DATE
ARG PATCH_NOTES
ARG POSTHOG_API_KEY
ARG POSTHOG_HOST
ARG PRIVACY_POLICY_URL
ARG ECHIDNA_CLIENT_KEY
ARG ECHIDNA_CLIENT_ID
ARG ECHIDNA_HOST
ARG CALENDAR_PLAN_FEATURE_ID
ARG BASE_HREF

# Write args into .env file
RUN echo "MOODLE_ENDPOINT=$MOODLE_ENDPOINT" > .env
RUN echo "LB_PLANNER_ENDPOINT=$LB_PLANNER_ENDPOINT" >> .env
RUN echo "REFRESH_INTERVAL=$REFRESH_INTERVAL" >> .env
RUN echo "IMPORTANT_REFRESH_INTERVAL=$IMPORTANT_REFRESH_INTERVAL" >> .env
RUN echo "LESS_IMPORTANT_REFRESH_INTERVAL=$LESS_IMPORTANT_REFRESH_INTERVAL" >> .env
RUN echo "SENTRY_DSN=$SENTRY_DSN" >> .env
RUN echo "APP_NAME=$APP_NAME" >> .env
RUN echo "MAJOR_VERSION=$MAJOR_VERSION" >> .env
RUN echo "MINOR_VERSION=$MINOR_VERSION" >> .env
RUN echo "PATCH_VERSION=$PATCH_VERSION" >> .env
RUN echo "BUILD_NUMBER=$BUILD_NUMBER" >> .env
RUN echo "BUILD_CHANNEL=$BUILD_CHANNEL" >> .env
RUN echo "RELEASE_DATE=$RELEASE_DATE" >> .env
RUN echo "PATCH_NOTES=$PATCH_NOTES" >> .env
RUN echo "POSTHOG_API_KEY=$POSTHOG_API_KEY" >> .env
RUN echo "POSTHOG_HOST=$POSTHOG_HOST" >> .env
RUN echo "PRIVACY_POLICY_URL=$PRIVACY_POLICY_URL" >> .env
RUN echo "DISTRIBUTION_TYPE=web" >> .env
RUN echo "ECHIDNA_CLIENT_KEY=$ECHIDNA_CLIENT_KEY" >> .env
RUN echo "ECHIDNA_CLIENT_ID=$ECHIDNA_CLIENT_ID" >> .env
RUN echo "ECHIDNA_HOST=$ECHIDNA_HOST" >> .env
RUN echo "CALENDAR_PLAN_FEATURE_ID=$CALENDAR_PLAN_FEATURE_ID" >> .env

RUN apt-get update && apt-get install -y curl git unzip && apt-get clean

RUN chsh -s /bin/bash

# Install FVM
RUN curl -fsSL https://fvm.app/install.sh | bash

# Clone the app source code and set working directory
WORKDIR /app/

COPY . /app/
COPY nginx.conf /etc/nginx/nginx.conf

# Install Flutter version via FVM (defined in the app's .fvmrc file)
RUN fvm use -f

# init git with upstream to 'https://github.com/necodeIT/lb_planner_app.git'

RUN git config --global init.defaultBranch main
RUN git init
RUN git remote add origin "https://github.com/necodeIT/lb_planner_app.git"
RUN git fetch
RUN git symbolic-ref HEAD refs/remotes/origin/main

# get latest tag from the repo a and split into major, minor and patch
RUN git describe --tags --abbrev=0 | tr -d 'v' | tr '.' '\n' > .version

# get number of commits since last tag aka build number
RUN git log --oneline $(git describe --tags --abbrev=0 @^)..@ | wc -l > .build_number

# Get date of last commit
RUN git log -1 --format=%cd --date=format:%Y-%m-%d > .release_date

# replace or add MAJOR_VERSION, MINOR_VERSION, PATCH_VERSION, BUILD_NUMBER in .env file

RUN sed -i "s/MAJOR_VERSION=.*/MAJOR_VERSION=$(cat .version | head -n 1)/g" .env
RUN sed -i "s/MINOR_VERSION=.*/MINOR_VERSION=$(cat .version | head -n 2 | tail -n 1)/g" .env
RUN sed -i "s/PATCH_VERSION=.*/PATCH_VERSION=$(cat .version | tail -n 1)/g" .env
RUN sed -i "s/BUILD_NUMBER=.*/BUILD_NUMBER=$(cat .build_number)/g" .env
RUN sed -i "s/RELEASE_DATE=.*/RELEASE_DATE=$(cat .release_date)/g" .env

RUN fvm flutter pub get

# Build the app without tree shaking icons because it currently crashes the build (idk if its a package issue or a flutter issue)
RUN fvm flutter build web --release -o /usr/share/nginx/html --dart-define-from-file=.env --no-tree-shake-icons --base-href $BASE_HREF

RUN sed -i "s/secondsSinceEpoch/$(date +%s)/g" /usr/share/nginx/html/index.html

RUN sed -i "s/{appname}/$(grep APP_NAME .env | cut -d '=' -f 2 | tr -d '"')/g" /usr/share/nginx/html/index.html

# cleanup to reduce image size

RUN fvm flutter clean

# cant run as it  asks for confirmation and currently there is no force flag
#RUN fvm destroy

RUN rm -rf .git .version .build_number
RUN rm -rf ~/fvm

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
