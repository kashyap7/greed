
class DiceSet
  NON_SCORING_FACE = [2, 3, 4, 6]
  def initialize
    @values = []
  end

  def roll(n)
    @values = []
    n.times { @values << Random.rand(1..6)}
  end

  def non_scoring_dice_count
    non_scoring_dice = 0
    NON_SCORING_FACE.each do |diceface|
      face_count = @values.count(diceface)
      if face_count != 3
        non_scoring_dice += face_count > 3 ? face_count - 3 : face_count
      end
    end
    return non_scoring_dice
  end

  def score
    result = 0
    NON_SCORING_FACE.each do |num|
      if @values.count(num) >= 3
        result += 100 * num
      end
    end
    # Handle the ones in the roll
    one_count = @values.count(1)
    result += one_count >= 3 ? (1000 + (one_count - 3) * 100) : one_count * 100
    # Handle the fives in the roll
    five_count = @values.count(5)
    result += five_count >= 3 ? (500 + (five_count - 3) * 50) : five_count * 50 
    return result
  end

  def dump_values(predicate)
    puts predicate + @values.join(", ")
  end
end
