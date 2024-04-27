# Aion Lightning 4.9 Automated Build with Docker

This repository is a fork from Aion Lightning 4.9 aiming to make things easier for starters.

## Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Basic Docker Knowledge](https://docs.docker.com/guides/get-started/)
- [Git](https://git-scm.com/downloads) (Optional)

If you have no Docker Knowledge, please, open [this link](https://docs.docker.com/guides/walkthroughs/what-is-a-container/) and follow each step until you reach, at least, [Multi-container Apps](https://docs.docker.com/guides/walkthroughs/multi-container-apps/). It should take you less than 30 minutes to follow through and you'll be more prepared to any problem that you might find.

## How to use

### Step 1 - Downloading required files

You may want to clone this repository as it will be easier to keep it updated if I make any change.

```
git clone https://github.com/gustavobarbosa-web/Aion-Lightning-4.9-docker.git
```

If you'd rather not use git or just don't want to, just download the ZIP file from [this link](https://github.com/gustavobarbosa-web/Aion-Lightning-4.9-docker/archive/refs/heads/master.zip)

### Step 2 - Setting up config files

First thing to do is prepare your environment file. There's a file named `.env.example` in the main folder from this repo. Make a copy in the same folder and name it `.env`. For starters, the default config is enough to keep your server running, but as you explore you might want to add or change as you go.

### Step 3 - Building server binaries

If you have [Basic Docker Knowledge](https://docs.docker.com/guides/get-started/), you might have found our `docker-compose.yml` and `Dockerfile` already. So, now, it's time to build your container image containing the compiled server binaries.

For that, use your favorite terminal emulator (powershell, bash, zsh, fish, anything) to navigate to the root folder of our project and run:

```
docker compose build
```

This might take a few minutes, so, be patient.

### Step 4 - Starting our server

Finally, you just have to execute your server:
```
docker compose up -d
```

This might take a few time too, as it'll be loading server files into memory. When the server container returns a healthy status, the command will be finished and your server will be ready to accept connections.

## Additional information

### What about the database?

The database for this server is prepopulated with data from `sql` folder on the first time you run it. You can make changes to the database by accessing `http://localhost:8080` from any browser you like.

### Server logs

When your server starts, you'll find a new folder named `logs` in the root folder of our project. Inside this folder you'll find logs for the three servers that are currently running. This may help you figure out any problem you may find during runtime.

### Server configuration

During runtime, you might want to change a few settings from your server. To do that, navigate to the folder of the server you're trying to change, open config folder and make any changes you want. Then, restart your server container.

#### Example:

Let's say I want to change my server experience rate to 10x. For that, I'll open the file in `AL-Game/config/main/rates.properties` in any text editor and change the line `gameserver.rate.regular.xp = 1` to `gameserver.rate.regular.xp = 10`.

Now, all I have to do is run `docker compose restart aion49-server` to restart my server container, or `docker compose restart` if I want to restart all containers at once.

## Original ReadMe

### Aion Lightning 4.9 Full and Free Source / Tools + Utils

Open Source Reborn! Ihr braucht nicht warten bis Euch Leute in ihr Team lassen, die aus einem öffentlichen Source Code ein Staatsgeheimnis machen. Aion Lightning ist und war Open Source und wird es nun auch wieder sein. Sollte diese Projektseite nicht mehr verfügbar sein, der Code ist auf sehr vielen Plattformen hinterlegt.

Wenn Du lust hast an der Entwicklung des Servers, dessen Code und Datenbank mitzuwirken, dann melde Dich im Forum von http://mmo-warzone.de und werde ein Teil unseres Teams.
