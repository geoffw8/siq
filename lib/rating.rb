class Rating
  attr_reader :label, :score

  def initialize(label, score)
    raise ArgumentError, 'ScoreOutOfBounds' unless (0..5).include?(score)
    @label = label
    @score = score
  end
end