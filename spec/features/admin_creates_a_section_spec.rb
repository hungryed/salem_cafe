require 'spec_helper'

feature 'admin creates a section' do
  let(:admin) { FactoryGirl.create(:user, role: 'admin')  }
  let(:worker) { FactoryGirl.create(:user, role: 'worker')  }
  let(:user) { FactoryGirl.create(:user)}

  context "valid admin" do

    scenario 'with valid attributes' do
      admin_sign_in_as(admin)
      visit root_path
      click_on 'Add Section'
      fill_in 'Name', with: 'Grill'
      fill_in 'Description', with: 'Hot Cooked foods'
      select '11 AM' , from: 'Start Time'
      select '02 PM' , from: 'End Time'
      click_on 'Create Section'

      expect(page).to have_content 'Section added successfully'
      click_on 'View Sections'
      expect(page).to have_content 'Grill'
      expect(page).to have_content 'Hot Cooked foods'
    end

    scenario 'without valid attributes' do
      admin_sign_in_as(admin)
      visit root_path
      click_on 'Add Section'
      click_on 'Create Section'

      expect_presence_error_for('section', :name)
      expect_presence_error_for('section', :description)
    end
  end

  context "non admin type user" do
    let!(:section) { FactoryGirl.create(:section) }

    scenario "normal users can't create a section" do
      sign_in_as(user)
      visit root_path
      expect(page).to_not have_content 'Add Section'
      visit new_section_path

      expect(page).to have_content 'Naw Son'
    end

    scenario "normal users can view a section" do
      sign_in_as(user)
      visit root_path
      click_on 'View Sections'

      expect(page).to have_content section.name

      expect(page).to have_content section.name
      expect(page).to have_content section.description
    end

    scenario "worker can't create a section" do
      worker_sign_in_as(worker)
      visit root_path
      expect(page).to_not have_content 'Add Section'
      visit new_section_path

      expect(page).to have_content 'Naw Son'
    end

    scenario "worker can view a section" do
      worker_sign_in_as(worker)
      visit root_path
      click_on 'View Sections'

      expect(page).to have_content section.name

      expect(page).to have_content section.name
      expect(page).to have_content section.description
    end
  end
end
