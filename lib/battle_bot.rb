class BattleBot

  attr_reader :name, :health, :enemies, :weapon

  def initialize(str)
    @name = str
    @health = 100
    @enemies = []
    @weapon = nil
    @dead = false
    @@count += 1
  end

  def dead?
    if @health <= 0
      @@count -= 1
      true 
    else
      false
    end
  end

  def has_weapon?
    return true if @weapon
    return false
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a?(Weapon)
    @weapon = weapon unless @weapon
  end

  def drop_weapon
    @weapon = nil
    @weapon.bot = nil
  end

  def take_damage(val) 
    raise Exception unless val.is_a?(Fixnum)
    @health -= val
    if @health <= 0
      @health = 0
    end
    return @health
  end

  def heal 
    unless dead?
      @health += 10 
      @health = 100 if @health > 100
      @health 
    end
  end

  def attack(enemy)
    raise ArgumentError unless enemy.is_a?(BattleBot)
    raise ArgumentError if enemy == self
    raise ArgumentError unless @weapon
  end

  def receive_attack_from(enemy) 
    raise ArgumentError unless enemy.is_a?(BattleBot)
    raise ArgumentError if enemy == self
    raise ArgumentError unless enemy.weapon
    take_damage(enemy.weapon.damage)
    @enemies << enemy unless @enemies.include?(enemy)
    defend_against(enemy)
  end

  def defend_against(enemy)
    dead?
    has_weapon?
    if has_weapon? && !dead 
      attack(enemy)
    end
  end

  def self.count
    @@count 
  end


end