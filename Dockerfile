#  Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM node
MAINTAINER C Johannessen "cjohannessen@us.ibm.com"
## Install the sidecar
RUN curl -sSL https://github.com/amalgam8/amalgam8/releases/download/v0.4.2/a8sidecar.sh | sh

# Install the application
RUN mkdir -p /app
COPY ./ /app/
RUN ls -al /app/.
RUN cd /app && npm install  
# ADD app.js /app/app.js
# ENV WEB_PORT 80
EXPOSE  8080

## script_to_launch_sidecar_and_app
ENTRYPOINT ["a8sidecar", "--register", "--proxy", "node", "/app/app.js"]

## Inject environment variables into the microservices container
ENV A8_SERVICE=orders:v1
ENV A8_ENDPOINT_PORT=8080
ENV A8_ENDPOINT_TYPE=http
ENV A8_REGISTRY_URL=http://dev-a8-registry-CBJ-123.mybluemix.net
ENV A8_CONTROLLER_URL=http://dev-a8-controller-CBJ-123.mybluemix.net

# Define command to run the application when the container starts
# CMD ["node", "/app/app.js"] 

