module Authentication
  def sign_in_as(user)
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  def sign_up_as(user)
    visit root_path
    click_on 'Sign Up'
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    click_on 'Sign Up'
  end

  def worker_sign_in_as(user)
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    user.role = 'worker'
    user.save
  end

  def admin_sign_in_as(user)
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    user.role = 'admin'
    user.save
  end
end
