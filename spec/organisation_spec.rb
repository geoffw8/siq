RSpec.describe Organisation do
  subject { described_class.new }

  let(:review) { Review.new }
  let(:member) { Member.new('Branch', 'Branch Name') }

  before do
    5.times { |i| subject.add(review) }
    5.times { |i| subject.add(member) }

    allow(review).to receive(:average_score).and_return(5.0)
    allow(member).to receive(:average_score).and_return(1.0)
  end

  describe '#add' do
    it 'returns the correct number of children' do
      expect(subject.children.count).to eq(10)
    end
  end

  describe '#average_score' do
    context 'without children' do
      it 'returns the correct value' do
        expect(subject.average_score).to eq(3.0)
      end
    end

    context 'with children' do
      before do
        subject.children = []

        london = Member.new('Region', 'London')
        2.times do |i|
          review = Review.new
          review.add(Rating.new('Access', 1))
          review.add(Rating.new('Lighting', 4))
          review.add(Rating.new('Security', 5))
          london.add(review)
        end

        oxford_circus = Member.new('Branch', 'Oxford Circus')
        2.times do |i|
          review = Review.new
          review.add(Rating.new('Access', 2))
          review.add(Rating.new('Staff', 3))
          review.add(Rating.new('Merchandising', 4))
          oxford_circus.add(review)
        end

        manager = Member.new('Manager', 'Simon Simonson')
        review = Review.new
        review.add(Rating.new('Access', 2))
        manager.add(review)

        assistant_manager = Member.new('Assistant Manager', 'Jim Jimson')
        review = Review.new
        review.add(Rating.new('Access', 5))
        assistant_manager.add(review)
        manager.add(assistant_manager)

        oxford_circus.add(manager)
        london.add(oxford_circus)
        subject.add(london)
      end

      it 'returns the correct value for the whole tree' do
        expect(subject.average_score).to eq(3.28)
      end

      it 'returns the correct value for a specific branch' do
        expect(subject.members[0].members[0].members[0].average_score).to eq(3.5)
      end
    end
  end

  describe '#average_review_score' do
    it 'returns the correct value' do
      expect(subject.average_review_score).to eq(5.0)
    end
  end

  describe '#average_member_score' do
    it 'returns the correct value' do
      expect(subject.average_member_score).to eq(1.0)
    end
  end

  describe '#reviews' do
    it 'contains only reviews' do
      expect(subject.reviews.map(&:class).uniq).to eq([Review])
    end
  end

  describe '#members' do
    it 'contains only members' do
      expect(subject.members.map(&:class).uniq).to eq([Member])
    end
  end

  describe '#find_review' do
    it 'returns the correct reviews' do
      3.times do |i|
        date = (DateTime.now - i)
        subject.add(Review.new(date))
      end

      date_to_find = (DateTime.now - 1).strftime('%d/%m/%Y')
      review = subject.find_review(date_to_find)

      expect(review.map(&:label).uniq).to eq([date_to_find])
    end
  end
end