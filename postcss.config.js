const postcssElmCssTailwind = require("postcss-elm-css-tailwind");

module.exports = {
  plugins: [
    require("tailwindcss")("./tailwind.config.js"),
    postcssElmCssTailwind(),
  ],
};