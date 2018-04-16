
class Player
  attr_reader :total_points
  CUT_OFF = 300
  def initialize
    @total_points = 0
    @can_accumalate = false
  end

  def add_points(points)
    if @can_accumalate
      @total_points += points
    elsif points >= CUT_OFF
      @can_accumalate = true
      @total_points += points
    end
  end
end