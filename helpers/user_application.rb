module UserSession

	def current_user
		@current_user ||=User.get(session[:user_id]) if session[:user_id]
	end

end

module TestHelpers

	def sign_up(name = "Joe",
							username = "joebloggs",
							email = "test@example.com",
							password = "test",
							password_confirmation = "test")
		visit '/users/new'
		expect(page.status_code).to eq 200
		fill_in :name, :with => name
		fill_in :username, :with => username
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Sign Up"
	end

end