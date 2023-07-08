const axios = require("axios");
const fs = require("fs");

const unix = str => (new Date(str)).getTime();

const params = {
    webhooks: {
        updates: process.env.WEBHOOK_UPDATES,
        errors: process.env.WEBHOOK_ERRORS
    },

    token: process.env.API_TOKEN,
};

const path2repo = path => {
    let p = path.split("/");
    return p[1] + "/" + p[2];
}

const perpage = 30;

let packs = {};
let packsRaw = {};
let packCount = 0;

let packsLast = {};
let packsNew = [];
let packsUpdated = [];
let packsMalformed = [];
let packsBlacklisted = [];

let blacklist = [ ];

let requestList = [];
let failureWait = 45;
let page = 1;

function gather() {
    const request = {
        url: "https://api.github.com/search/repositories",
        method: "GET",
    
        params: {
            "q": "ntm resourcepack",
            "perpage": perpage,
            "page": page
        }
    };

    axios.request(request)
        .then((response) => {
        let data = response.data;
        let items = data.items;

        let maxPages = Math.ceil(data.total_count / perpage);

        console.log("Gathered", page + "/" + maxPages);
        
        for(let item of items) {
            if (!item.size)
                continue;
            
            let name = item.full_name;

            let url = "https://raw.githubusercontent.com/" + name + "/" + item.default_branch + "/meta.json";

            requestList.push(axios.get(url).catch(() => {}));
            
            packsRaw[name] = item;

            packCount ++;
        }

        if ((page ++) >= maxPages) {
            console.log("Fetch complete.");
            console.log("Collecting pack meta.");

            axios.all(requestList)
                .then(
                    checkFailed(
                        (response) => {
                            let name = path2repo(response.request.path);
                            handlePack(name, packsRaw[name], response.data);
                            
                            if (!(-- packCount))
                                allDone();
                        },
                        (error) => {
                            console.log(error);
                            console.log("ERROR");
                        }
                    )
                )
                .catch((e) => {
                    console.log(e);
                    console.log("axios.all Failed.");
                });
        }
        else setTimeout(() => gather(), 1000);
    })
    .catch((e) => {
        console.log(e);
        console.log("Something went wrong - likely due to rate limit. Retrying in " + failureWait + "s.");
        setTimeout(() => gather(), failureWait * 1000);
    });
}

function checkFailed(then, caught) {
    return function(responses) {
        responses.forEach(response => {
            if (!response || response?.error)
                return caught(response);
            
            return then(response);
        });
    }
}

function handlePack(name, item, meta) {
    if (blacklist.indexOf(name) != -1 || blacklist.indexOf("user:" + item.owner.login) != -1) {
        console.log(name, "is banned.");

        packsMalformed.push({ name: name, descriptionShort: "malformed meta.json" });

        return;
    }
    
    let malformed = false;

    if (typeof meta != "object") {
        if (!packsLast[name]);
            packsMalformed.push({ name: name, descriptionShort: "malformed meta.json" });

        console.log(name, "malformed meta.json");

        malformed = true;

        return;
    }

    if (!packsLast[name]) {
        packsNew.push(meta);
    }
    else if (packsLast[name].updated != unix(item.updated_at)) {
        packsUpdated.push(meta);
    }
    
    packs[name] = {
        full_name: name,
        name: item.name,
        owner: item.owner.login,
        created: unix(item.created_at),
        updated: unix(item.updated_at),
        stars: item.stargazers_count,

        malformed: malformed,

        meta: {
            name: meta.name ?? name,
            descriptionShort: meta.descriptionShort ?? "NTM Resourcepack",
            description: meta.description ?? "No description provided"
        }
    };
}

function sendEmbed(kind, embeds) {
    let url = params.webhooks[kind];

    if (!url)
        return;

    axios.post(url, { content: "", embeds: embeds });
}

function allDone() {
    let today = new Date();
    let packList = Object.values(packs);
    let time = today.getHours() + ":" + today.getMinutes() + " " + today.getDate() + "/" + (today.getMonth() + 1) + "/" + today.getFullYear();

    let diff = packList.length - Object.keys(packsLast).length;

    if (diff > 0) {
        diff = "(+" + diff + ")";
    }
    else if (diff < 0) {
        diff = "(" + diff + ")";
    }
    else diff = "";
    
    const embed = {
        title: "Resourcepacks updates",
        description: time + " Total: " + packList.length + " " + diff,
        color: 0xFFFFFF,
        fields: [ ],
        footer: {
            "text": time
        }
    };
    
    let fields = [];
    
    embed.title = "";
    embed.color = 0xe6d927;

    if (packsUpdated.length > 0) {
        for(let pack of packsUpdated) {
            fields.push({
                name: "♻ " + pack.name,
                value: pack.descriptionShort
            });
        }
    }
    
    if (packsNew.length > 0) {
        for(let pack of packsNew) {
            fields.push({
                name: "🆕 " + pack.name,
                value: pack.descriptionShort
            });
        }
    }

    embed.fields = fields;

    if (fields.length > 0)
        sendEmbed("updates", [ embed ]);
    
    fields = [];

    if (packsBlacklisted.length > 0) {
        for(let pack of packsBlacklisted) {
            fields.push({
                name: "❌ " + pack.name,
                value: pack.descriptionShort
            });
        }
    }

    if (packsMalformed.length > 0) {
        for(let pack of packsMalformed) {
            fields.push({
                name: "⚠ " + pack.name,
                value: pack.descriptionShort
            });
        }
    }

    embed.title = "Malformed packs";
    embed.fields = fields;

    if (fields.length > 0)
        sendEmbed("errors", [ embed ]);
    
    fs.writeFileSync("resourcepacks.json",
        JSON.stringify(packList, null, 2));
}

// beware the pipeline

function start() {
    axios.get("https://raw.githubusercontent.com/toarch7/nt-recreated-public/main/pack-blacklist.json")
        .then((response) => {
            let data = response.data;
            blacklist = data;
            
            gather();
        })
        .catch(() => {
            console.warn("Was unable to fetch pack blacklist, proceeding anyway.");

            gather();
        });
}

axios.get("https://raw.githubusercontent.com/toarch7/nt-recreated-public/main/resourcepacks.json")
    .then((response) => {
        let data = response.data;

        for(let i of data)
            packsLast[i.full_name] = i;
        
        console.log("Previous count:", data.length);
        
        start();
    })
    .catch((ex) => {
        console.log("Was unable to fetch previous list but oh well.");

        start();
    });