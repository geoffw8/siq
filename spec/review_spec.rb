RSpec.describe Review do
  subject { described_class.new }

  describe '#average_score' do
    it 'returns the correct value' do
      subject.children << double(:child, score: 1)
      subject.children << double(:child, score: 3)
      subject.children << double(:child, score: 5)

      expect(subject.average_score).to eq(3.0)
    end
  end
end