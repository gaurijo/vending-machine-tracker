require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do 
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe 'model methods' do 
    it 'has the average price of snacks in a machine' do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: gum.id)

      expect(machine_1.average_price.to_d.to_f.round(2)).to eq(2.33)
    end

    it 'has the count of snacks in a machine' do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: gum.id)

      expect(machine_1.count).to eq(3)
    end
  end
end
