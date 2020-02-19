class Patron

  attr_reader :name,  :interests
  attr_accessor :spending_money

  def initialize(name, money)
    @name = name
    @spending_money = money
    @interests = []
  end

  def add_interest(interest)
    @interests << interest
  end
end
