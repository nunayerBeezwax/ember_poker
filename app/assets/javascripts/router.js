// For more information see: http://emberjs.com/guides/routing/

Poker.Router.map(function() {
  this.resource('table', { path: '/' });
    this.route('player', { path: '/player' });
});
