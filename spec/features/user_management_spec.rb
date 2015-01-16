require 'spec_helper'

include TestHelpers

feature "User signs up" do 
	scenario "when being a new user visiting the site" do
		expect{sign_up}.to change(User, :count).by 1
		expect(page).to have_content "Welcome, Joe"
		expect(User.first.email).to eq "test@example.com"
	end

	scenario "with a password that doesn't match" do
		expect{sign_up('Joe', 'Joebloggs', 't@e.com', '1', '2')}.to change(User, :count).by 0
		expect(current_path).to eq '/users'
		expect(page).to have_content "Password does not match the confirmation"
	end

	scenario "with an email thats already registered" do
		expect{sign_up}.to change(User, :count).by 1
		expect{sign_up}.to change(User, :count).by 0
		expect(page).to have_content "Email is already taken"
	end

end

feature "User signs in" do

	before(:each) do
		User.create(:name => "Joe",
								:username => "Joebloggs",
								:email => "test@test.com",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "with correct credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, Joe")
		sign_in('test@test.com', 'test')
		expect(page).to have_content("Welcome, Joe")
	end

	scenario "with incorrect credentials" do
		visit '/'
		expect(page).not_to have_content("Welcome, Joe")
		sign_in('test@test.com', 'wrong')
		expect(page).not_to	have_content("Welcome, Joe")
	end

end

feature "User signs out" do

	before(:each) do
		User.create(:name => "Joe",
								:username => "Joebloggs",
								:email => "test@test.com",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "while being signed in" do
		sign_in('test@test.com', 'test')
		click_button "Sign Out"
		expect(page).not_to have_content "Welcome, Joe"
		expect(page).to have_content "See you soon!"
	end

end

feature "User can post a peep" do

	before(:each) do
		User.create(:name => "Joe",
								:username => "Joebloggs",
								:email => "test@test.com",
								:password => 'test',
								:password_confirmation => 'test')
	end

	scenario "once signed in" do
		sign_in('test@test.com', 'test')
		fill_in :body, :with => "Hello"
		click_button "Submit"
		expect(page).to have_content "Hello"
	end


end






