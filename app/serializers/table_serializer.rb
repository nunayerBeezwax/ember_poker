class TableSerializer < ActiveModel::TableSerializer
  attributes :players, :dealer, :board, :hands, :pot, :button,
    :active_players, :sb, :bb, :action, :current_bet
end
