# <img src="./src/icons/hat.svg" style="width: 1em; vertical-align: middle"> Purplocity Frontend 2


> Written in Astro, TypeScript, and SCSS




Host your own instance of Purplocity, no configuration required at all.

You will need to install git and at least NodeJS v19.
Need to check your Node version? Just run
```sh
node check-node-version.js
```





```sh
git clone https://github.com/PsychyBruh/Purplocity
cd Purplocity
npm install
npm run build
npm start
```


This program will look for a config in `./config/config.js`. You copy the example config:

```sh
cp ./config/config.example.js ./config.js
```

We provide an example configuration in [./config/config.example.js](./config/config.example.js)


> This guide assumes your using linux as your host

1. Install dependencies

   You will need to install [git](https://git-scm.com/download/linux).

2. Install NodeJS

   > You need at least NodeJS v19 to deploy Purplocity.

   We recommend installing from [NodeSource](https://github.com/nodesource/distributions#table-of-contents), or using [Node Version Manager](https://github.com/nvm-sh/nvm#table-of-contents) to install the latest version.

   [Most distros usually have very outdated versions of NodeJS.](https://gist.github.com/e9x/b549f46081ce794914461f2fbb9566bd#file-nodejs-across-linux-distributions-md)

   Verify you're using NodeJS v19 or higher:

   ```sh
   node -v
   ```

3. Install [PM2](https://pm2.keymetrics.io/docs/usage/quick-start/)

   > PM2 is a daemon process manager that will help you manage and keep your application online. Getting started with PM2 is straightforward, it is offered as a simple and intuitive CLI, installable via NPM.

   ```sh
   npm i -g pm2
   ```

4. Install the repo

   ```sh
   git clone https://github.com/PsychyBruh/Purplocity
   cd Purplocity
   npm install
   npm run build
   ```

5. Start the frontend in PM2

   This will start a process in PM2 called "purplocity".

   ```sh
   pm2 start ./run-server.js --name purplocity
   ```

6. View the logs

   > Press <kbd>CTRL</kbd> + <kbd>C</kbd> to exit the logs.

   ```sh
   pm2 logs purplocity
   ```

7. Save your PM2 config and enable running on startup

   This will make it so `pm2` runs automatically when your VPS restarts.

   ```sh
   pm2 save
   pm2 startup
   ```

8. Setup a reverse proxy

   By default, Purplocity listens on http://127.0.0.1:8080/ and isn't accessible over the internet.

   Keep in mind that you want to setup HTTPS/SSL, otherwise Ultraviolet won't work.

   I personally recommend Caddy as a reverse proxy.

   > Caddy is a powerful, extensible platform to serve your sites, services, and apps...

   https://caddyserver.com/docs/

   You can view the example Caddyfile at [./config/Caddyfile](./config/Caddyfile)


Within the boundaries of your Astro enterprise, you'll unveil the succeeding unambiguous hierarchical construct:

```text
/
├── public/
├── src/
│   └── pages/
│       └── index.astro
└── package.json
```

Astro utilizes `.astro` or `.md` documents located in the `src/pages/` division. Each file is propagated as a route subject to its filenomenclature.

The `src/components/` section holds no particular status, yet we find it a conducive locus for any Astro constituents.

All static facets, such as metamorphic representations, can be allocated in the `public/` regiment.


Execute all commands from the root of the project, employing a terminal:

| Directive                 | Implementation                                       |
| :------------------------ | :--------------------------------------------------- |
| `npm install`             | Installs dependencies                                |
| `npm start`               | Starts Purplocity                                |
| `npm run dev`             | Initialize local dev server at `localhost:4321`      |
| `npm run build`           | Construct productive site to `./dist/`               |
| `npm run preview`         | Localize preview of your build                       |
| `npm run astro ...`       | Apply CLI directives like `astro add`, `astro audit` |
| `npm run astro -- --help` | Assistance for Astro CLI operations                  |

