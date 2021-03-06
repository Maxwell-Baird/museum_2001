require 'pry'
class Museum

  attr_reader :name, :exhibits, :patrons, :revenue
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    exhibit_names = @exhibits.map {|exhibit| exhibit.name}
    intersection = (patron.interests & exhibit_names)
    interests = []
    intersection.each do |name|
      interests << @exhibits.find {|exhibit| name == exhibit.name}
    end
    interests
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_of_exhibits
    sorted_exhibits = @exhibits.sort_by { |exhibit| exhibit.cost}
    patrons_by_exhibit = patrons_by_exhibit_interest
    patrons_of_exhibits_hash = Hash.new([])
    sorted_exhibits.each do |exhibit|
      patrons_by_exhibit[exhibit].each do |patron|
        if patron.spending_money > exhibit.cost
          patrons_of_exhibits_hash[exhibit] << patron
          patron.spending_money -= exhibit.cost
          @revenue += exhibit.cost
        end
      end
    end
    patrons_of_exhibits_hash
  end

  def patrons_by_exhibit_interest
    by_exhibit = Hash.new()
    @exhibits.each do |exhibit|
      by_exhibit[exhibit] = []
      @patrons.each do |patron|
        interested = recommend_exhibits(patron)
        interested.each do |potential|
          if potential == exhibit
            by_exhibit[exhibit] << patron
          end
        end
      end
    end
    by_exhibit
  end

  def ticket_lottery_contestants(exhibit)
    contestants = patrons_by_exhibit_interest
    contestants[exhibit].find_all {|patron| patron.spending_money < exhibit.cost}
  end

  def draw_lottery_winner(exhibit)
    winner_array = ticket_lottery_contestants(exhibit)
    winner_array.sample
  end

  def announce_lottery_winner(exhibit)
    winner = draw_lottery_winner(exhibit)
    if winner.class == Patron
      "#{winner.name} has won the #{exhibit.name} exhibit lottery"
    else
      "No winners for this lottery"
    end
  end

end
