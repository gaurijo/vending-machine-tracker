require 'rails_helper'

RSpec.describe 'Machine show page' do 
   it "has the name of all the snacks associated with that machine, along with their price" do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)
      machine_2 = Machine.create!(location: "Hayward", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)

      visit "/machines/#{machine_1.id}"

      expect(page).to have_content("Chips")
      expect(page).to have_content("Trailmix")
      expect(page).to have_content("2")
      expect(page).to have_content("4")
      expect(page).to_not have_content("Gum")
   end

   it "has the average price for all snacks in that machine" do 
      owner = Owner.create!(name: "PepsiCo")
      machine_1 = Machine.create!(location: "Cupertino", owner_id: owner.id)

      chips = Snack.create!(name: "Chips", cost: 2.00)
      trail = Snack.create!(name: "Trailmix", cost: 4.00)
      gum = Snack.create!(name: "Gum", cost: 1.00)

      MachineSnack.create!(machine_id: machine_1.id, snack_id: chips.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: trail.id)
      MachineSnack.create!(machine_id: machine_1.id, snack_id: gum.id)

      visit "/machines/#{machine_1.id}"

      expect(page).to have_content("2.33")
   end
end

# As a visitor
# When I visit a vending machine show page
# I also see an average price for all of the snacks in that machine