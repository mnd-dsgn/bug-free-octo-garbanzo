class Weapon

  attr_reader :name, :damage

  attr_accessor :bot

  def initialize(name, damage = nil)
    @name = name
    raise ArgumentError unless name.is_a?(String)
    raise ArgumentError unless damage.is_a?(Fixnum)
    @damage = damage if damage
    @bot = nil
  end

  def name=(n) 
    @name
  end


end