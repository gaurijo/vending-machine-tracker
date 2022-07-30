# As a visitor
# When I visit a snack show page

############################################

#   and I see a count of the different kinds of items in that vending machine.

require 'rails_helper' 
RSpec.describe 'Snack show page' do 
   it "has the name of that snack & price" do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)
      machine_2 = Machine.create!(location: "Hayward", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)

      visit "/snacks/#{chips.id}"

      expect(page).to have_content("Chips")
      expect(page).to have_content("2")
      expect(page).to_not have_content("Gum")
   end

   it "has a list of locations with machines that carry this snack and avg price" do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)
      machine_2 = Machine.create!(location: "Hayward", owner_id: owner.id)
      machine_3 = Machine.create!(location: "Fremont", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_2.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_3.id, snack_id: trail.id)

      visit "/snacks/#{chips.id}"

      expect(page).to have_content("Cupertino")
      expect(page).to have_content("Hayward")
      expect(page).to_not have_content("Fremont")
      expect(page).to have_content("2.00")
   end

   it "has a count of the different snacks in that vending machine" do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)
      machine_2 = Machine.create!(location: "Hayward", owner_id: owner.id)
      machine_3 = Machine.create!(location: "Fremont", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: gum.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)

      MachineSnack.create!(machine_id: machine_2.id, snack_id: trail.id)

      visit "/snacks/#{chips.id}"

      expect(page).to have_content("3 kinds of snacks")
   end
end
