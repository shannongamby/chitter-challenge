require 'peep'

describe Peep do

  context 'posting a peep' do
    it 'adds a new peep to the database' do
      Peep.create(message: 'This is a peep')
      expect(Peep.all.length).to eq 1
    end
  end

  context 'listing peeps' do
    it 'retrieves all peeps from the database' do
      Peep.create(message: 'This is peep number 1')
      Peep.create(message: 'This is peep number 2')
      peeps = Peep.all
      expect(peeps.length).to eq 2
    end
  end

  context 'wrapping data in ruby' do
    it 'should wrap peep data in ruby methods' do
      peep = Peep.create(message: 'This is a peep')
      expect(peep.message).to eq 'This is a peep'
    end
  end
end
