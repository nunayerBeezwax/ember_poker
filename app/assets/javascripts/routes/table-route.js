Poker.TableRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('players');
  }
});
