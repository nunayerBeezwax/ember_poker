Poker.Table = DS.Model.extend({
  players: DS.attr(),
  board: DS.attr(),
  hands: DS.attr(),
  pot: DS.attr(),
  button: DS.attr(),
  active_players: DS.attr(),
  sb: DS.attr(),
  bb: DS.attr(),
  action: DS.attr(),
  current_bet: DS.attr()
});
