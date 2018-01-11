#!/bin/bash

# Install Erlang
dpkg -s esl-erlang &> /dev/null
if [ $? -eq 0 ]; then
    echo "esl-erlang package is installed!"
else
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
    sudo apt-get update
    sudo apt-get install -y esl-erlang
fi

# Install Elixir, Phoenix
dpkg -s elixir &> /dev/null
if [ $? -eq 0 ]; then
    echo "elixir package is installed!"
else
    sudo apt-get install -y elixir
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
fi

# Install Node.js LTS (for frontend)
dpkg -s nodejs &> /dev/null
if [ $? -eq 0 ]; then
    echo "nodejs package is installed!"
else
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get install -y nodejs
fi

# Docker
dpkg -s docker-ce &> /dev/null
if [ $? -eq 0 ]; then
    echo "docker-ce package is installed!"
else
    apt-get update 
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88
    sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
    sudo apt-get update
    sudo apt-get install docker-ce
fi

sudo docker run --name todo-postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres
sudo docker run --name todo-pgadmin4 --link todo-postgres:postgres -p 5050:5050 -d fenglc/pgadmin4
sudo docker ps

# Elixir & Phoenix
mix deps.get
mix deps.compile

# Database
mix ecto.create
mix ecto.migrate

# About
echo "==== pgadmin4 | http://localhost:5050 ===="
echo "Use default administrator account to log in:"
echo "user: pgadmin4@pgadmin.org"
echo "password: admin"
echo ""
echo "Add server, and use postgres as hostname, postgres as user, postgres as password"
echo ""
echo "=== To Do List | Elixir & Phoenix ==="
echo "Setup datase: mix ecto.create"
echo "Start: mix phx.server"