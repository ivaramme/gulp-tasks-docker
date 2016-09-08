# gulp-tasks-docker

The `gulp-task` docker container provides a minimal set of tools needed to automate the usage of Gulp (a well known Javascript/nodeJS based automation tool) without having to install any depedencies or new applications (aside from the expected Docker Engine and Docker Compose). Development teams will have access to the same building tools and versions without having to worry about NPM modules being too old or cross versions.

# What you need...

- Docker Engine: https://docs.docker.com/engine/understanding-docker/
- Docker Compose: https://docs.docker.com/compose/install/

# Expectations:

The container expects a Gulp file (`gulpfile.js`) to exist inside the `/app` directory. That file should have a defined default task. 

Since the container runs `gulp` by default, any changes to the gulp configuration file will require a restart, a task that is simply done by invoking `docker compose restart myapp` as stated above. Whenever you make changes to your JS files or HTML files, Gulp will detect those changes and automatically create the changes. There's no need to restart then.

The container exposes a port to support `gulp-connect` for serving files from gulp without having to start a server like Apache or Nginx. That port is by default `3000`.

# How it works

There are three main files in this project:

- `Dockerfile`:

It relies on `StackSmith` to make sure it gets all the updates needed whenever a new version of the container is available extending the Node container.. By default uses an ubuntu install and uses some of the standards used in other Bitnami projects. 

As customary it installs Gulp using NPM and also exposes a port for serving assets. Then relies on the the `app-entrypoint.sh` file to perform the specific task.

- `app-entrypoint.sh`:

Bash script that installs gulp locally (in the project's directory as recommended) and then install all the packages included in the `packages.json` file using NPM.

Then it runs gulp, which expects a `gulpfile.js` to be available in the work directory `/app` which is mounted as a volume by docker compose. That file is completely provided by the developers as well as the dependencies inside the `packages.json` file.

- `docker-compose.yml`:

Simple definition to define all components needed to run a project of this kind.

# Usage:

- The container expects there's a `gruntfile.js` in the folder where you'll execute this container with the tasks definitions.
- Inside your project's location, download the docker-compose.yml file from: https://raw.githubusercontent.com/ivaramme/gulp-tasks-docker/master/docker-compose.yml.
- Execute `docker-compose up` and wait for the container to download (if it is the first time) and until it's execute.
- Once downloaded, the service should be up and running and will allow you to load the HTML page from the browser connecting to the container on port 3000.
- If you make changes to the gulpfile.js to import or create new tasks, you'll need to restart the gulp container by using the following ccommand: docker-compose restart myapp

For an example of how this project works, please take a look at the following repository: https://github.com/ivaramme/gulp-tasks-app

# Executing commands

You can invoke specific Gulp tasks from the container. To accomplish that you need to execute: `docker-compose run myapp <gulp-task-name>`. This will allow you to run several tasks defined in your gulpfile.

# Motivations for this project

I've seen multiple projects where backend developers and front end developers use different tools, release cycles and methodologies. Little by little, front end developers have started using tools to automate and standarize their tasks closing the gap with the tools used by BE developers long time ago, and this is great!

But in my experience I've also seen FE teams that struggle with different computer settings (Mac OS vs Windows, different versions, etc.) and that prevent them from moving forward in adapting new tools like Gulp, Grunt, etc. This is basically the reason why I decided to base this project on Gulp, to create an easier way for FE developers to standarize their tools.

Now an easy and yet very helpful extension of this project would be providing support to developers to run both the FE and BE on their machines - even if they are running against an specific artifact instead of going to a dev environment or QA which are very frequently forgotten by BE Developers and Sys Ops. I believe that docker provides an easy way to close that gap.
