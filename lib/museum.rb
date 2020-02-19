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


end
