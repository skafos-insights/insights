module.exports = {
  files: {
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        after: ["web/static/css/app.css"] // concat app.css last
      }
    }
  },
  plugins: {
    sass: {
      options: {
        includePaths: ["css"],
        precision: 8 // minimum precision required by bootstrap
      }
    },
  },
};