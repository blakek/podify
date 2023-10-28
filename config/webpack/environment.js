const { environment } = require("@rails/webpacker");
const { VueLoaderPlugin } = require("vue-loader");
const vue = require("./loaders/vue");

const crypto = require("crypto");

// HACK: Fix Node.js 17+ "digital envelope routines::initialization error"
// https://stackoverflow.com/q/69692842/1130172
const origCreateHash = crypto.createHash;
crypto.createHash = (algorithm, options) => {
  const newAlgorithm = algorithm === "md4" ? "md5" : algorithm;
  return origCreateHash(newAlgorithm, options);
};

environment.plugins.prepend("VueLoaderPlugin", new VueLoaderPlugin());
environment.loaders.prepend("vue", vue);
module.exports = environment;
