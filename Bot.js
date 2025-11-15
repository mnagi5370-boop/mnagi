const { Client, GatewayIntentBits } = require('discord.js');
const fs = require('fs');

// قراءة إعدادات الديسكورد من config.json
const config = JSON.parse(fs.readFileSync('config.json', 'utf8'));

const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent
    ]
});

// رسالة تشغيل البوت
client.on("ready", () => {
    console.log(`🔹 Logged in as ${client.user.tag}`);
});

// أمر تجريبي: !ping
client.on("messageCreate", (message) => {
    if (message.author.bot) return;

    if (message.content === config.prefix + "ping") {
        message.reply("Pong! ✅ البوت شغال");
    }
});

// تسجيل الدخول باستخدام التوكن
client.login(config.token);
const express = require("express");
const server = express();

server.all("/", (req, res) => {
  res.send("Bot is Running!");
});

function keepAlive() {
  server.listen(3000, () => {
    console.log("Server is Ready!");
  });
}

keepAlive();
