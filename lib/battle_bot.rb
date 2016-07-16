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
    return true if @health <= 0
    false
  end

  def has_weapon?
    return true if @weapon
    return false
  end

  def pick_up(weapon)
    raise ArgumentError unless weapon.is_a?(Weapon)
    raise ArgumentError if weapon.bot != nil
    unless @weapon 
      weapon.bot = self
      @weapon = weapon 
    end
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def take_damage(val) 
    raise ArgumentError unless val.is_a?(Fixnum)
    @health -= val
    if @health <= 0
      puts "This bot has died."
      @@count -= 1
      @health = 0
    end
    return @health
  end

  def heal 
    unless self.dead?
      @health += 10 
      @health = 100 if @health > 100
      @health 
    end
  end

  def attack(enemy)
    raise ArgumentError unless enemy.is_a?(BattleBot)
    raise ArgumentError if enemy == self
    raise ArgumentError unless @weapon
    enemy.receive_attack_from(self)
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
    self.dead?
    if has_weapon?  && !dead?
      attack(enemy)
    end
  end

  def self.count
    @@count 
  end


end