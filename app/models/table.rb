class Table

  attr_reader :players, :dealer, :board, :hands, :pot, :button, :active_players,
              :sb, :bb, :action, :current_bet

  def initialize(num_of_players)
    @players = []
    @dealer = Dealer.new(self)
    num_of_players.times { @players << Player.new(@players.length+1, 1000, self) }
    @board = []
    @pot = 0
    @button = rand(1..@players.count)
    @hands = []
  end

  def community_cards(card)
    @board << card
  end

  def action(player)
    hand = player.combine(@board)
    case player.decision(hand, @current_bet)
    when 'Call'
      @pot += @current_bet
      return 'Call'
    when 'Raise'
      self.bet(@current_bet * 3)
      return 'Raise'
    when 'Check'
      return 'Check'
    when 'Fold'
      return 'Fold'
    end
  end

  def bet(amount)
    @pot += amount
    @current_bet = amount
  end

  def active_players
    @players.select do |player|
      if player.hole_cards.count == 2
        player.combine(@board)
      end
    end
  end

  def clear_board
    @board = []
  end

  def empty_pot
    @pot = 0
  end

  def move_button
    @button += 1
    if @button > @players.count
      @button = 1
    end
  end

###### Blinds ####

  def blinds_table
    @blinds_table = { 1 => 50, 2 => 100, 3 => 200, 4 => 400 }
  end

  def blinds(level)
    self.small_blind(level)
    self.big_blind(level)
  end

  def small_blind(level)
    @sb = (self.blinds_table[level]) / 2
    @players.find{|p|p.seat==(@dealer.action_tracker)}.ante(@sb)
  end

  def big_blind(level)
    @bb = (self.blinds_table[level])
    if @button + 2 == 10
      @players[0].ante(@bb)
    elsif @button + 2 == 11
      @players[1].ante(@bb)
    else
      @players.find{|p|p.seat==@dealer.action_tracker+1}.ante(@bb)
    end
  end
end

###### Future Projects #######3


  # def showdown
    ### Needs significant retooling
    # @hands = []
    # winner = []
    # @players.each do |player|
    #   @hands << player.combine(@board)
    # end
    # @hands.each do |hand|
    #   winner << "Player #{hand.player.seat}: #{Evaluator.make_best(hand)}"
    # end
    # @players.each do |player|
    #   puts "---------"
    #   player.hole_cards.each do |card|
    #     puts "#{player.seat}: #{card.rank} #{card.suit}"
    #   end
    # end
    # @board.each do |card|
    #   puts "#{card.rank} #{card.suit}"
    # end
    # return winner
  # end
