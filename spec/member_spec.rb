RSpec.describe Member do
  subject { described_class.new('Branch', 'Oxford Circus') }

  it 'should return the correct type' do
    expect(subject.type).to eq('Branch')
  end

  it 'should return the correct name' do
    expect(subject.name).to eq('Oxford Circus')
  end
end