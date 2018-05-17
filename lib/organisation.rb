class Organisation
  attr_accessor :children

  def initialize
    @children = []
  end

  def add(child)
    @children << child
  end

  def reviews
    find_class(Review)
  end

  def members
    find_class(Member)
  end

  def find_review(label)
    reviews.select { |c| c if c.label == label }
  end

  def find_class(klass)
    self.children.select { |c| c if c.class == klass }
  end

  def average_review_score
    reviews.sum(&:average_score) / reviews.count
  end

  def average_member_score
    members.sum(&:average_score) / members.count
  end

  def average_score
    (children.sum(&:average_score) / children.count.to_f).round(2)
  end
end