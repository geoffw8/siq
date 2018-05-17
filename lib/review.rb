class Review < Organisation
  attr_reader :label

  def initialize(label = nil)
    @label = (label || DateTime.now).strftime('%d/%m/%Y')
    self.children = []
  end

  def average_score
    (children.sum(&:score) / children.count.to_f).round(2)
  end
end