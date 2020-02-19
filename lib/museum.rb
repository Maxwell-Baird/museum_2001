require 'pry'
class Museum

  attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
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

end
