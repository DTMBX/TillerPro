module.exports = {
  ci: {
    collect: {
      /* Adjust URL to the built site used in the workflow */
      url: ['http://127.0.0.1:4000/'],
      startServerCommand: 'bundle exec jekyll serve --port 4000',
      numberOfRuns: 3
    },
    upload: {
      target: 'temporary-public-storage'
    }
  }
};
