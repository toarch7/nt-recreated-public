#!/usr/bin/env bash
set -e

all_good=true

if command -v node >/dev/null 2>&1; then
    echo -e "\e[32m[v]\e[0m node installation found \e[36m($(node --version))\e[0m"
else
    echo -e "\e[31m[x]\e[0m node is not found"
    all_good=false
fi

if command -v npm >/dev/null 2>&1; then
    echo -e "\e[32m[v]\e[0m npm installation is found \e[36m($(npm --version))\e[0m"
else
    echo -e "\e[31m[x]\e[0m npm is not found"
    all_good=false
fi

if [[ $all_good -neq false ]] then
    echo -e "\e[31mFailure\e[0m: Missing or incomplete node.js setup!"
    echo -e "Please, make sure that you have properly proceeded with installing \e[36mnode\e[0m and \e[36mnpm\e[0m before running the script:\e[36m https://nodejs.org/en \e[0m"
    exit 1
fi

run-regen-script() {
    cd node-scripts
    npm ci
    npm run regen
}

run-regen-script