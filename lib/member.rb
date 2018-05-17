class Member < Organisation
  attr_reader :type, :name

  def initialize(type, name)
    @type = type
    @name = name
    self.children = []
  end
end