RSpec.describe Rating do
  subject { described_class.new('Appearance', 5) }

  context 'with valid attributes' do
    it 'should return the correct label' do
      expect(subject.label).to eq('Appearance')
    end

    it 'should return the correct score' do
      expect(subject.score).to eq(5)
    end
  end

  context 'score is within range' do
    it 'should not raise an exception' do
      expect { subject }.to_not raise_exception
    end
  end

  context 'score is outside of range' do
    it 'should raise an exception if less than 0' do
      expect { Rating.new('Appearance', -1) }.to raise_error(ArgumentError)
    end

    it 'it should raise an exception if more than 5' do
      expect { Rating.new('Appearance', 6) }.to raise_error(ArgumentError)
    end
  end
end