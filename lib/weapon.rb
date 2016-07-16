class Weapon

  attr_reader :name, :damage

  attr_accessor :bot

  def initialize(name, damage = 5)
    raise ArgumentError unless name.is_a? String
    raise ArgumentError unless damage.is_a? Fixnum
    @damage = damage
    @name = name
    @bot = nil
  end

  def bot=(x) 
    if (x.is_a? BattleBot) || (x.nil?)
      @bot = x
    else
      raise ArgumentError 
    end
  end

  def picked_up?
    return true if @bot
    return false
  end



end