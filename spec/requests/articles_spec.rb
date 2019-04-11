require 'rails_helper'

RSpec.describe "Articles", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user) # Create the user

    # Set up the basic premise of the test by making sure that you have to log in
    visit root_path
    expect(current_path).to eq(new_user_session_path)
    expect(current_path).to_not eq(root_path)

    # Within the form #new_user do the following
    # The reason I put this within a within block is so if there are 2 form fields
    # on the page called Email it will fill in only this one
    within('#new_user') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end

    # Since we've logged in we should check if the application redirected us to the right path
    expect(current_path).to eq(root_path)
    expect(current_path).to_not eq(new_user_session_path)
    expect(page).to have_content('Signed in successfully.')
  end

  describe 'GET #index' do

    describe 'valid: ' do
    it 'should return a list of articles' do
      @article = FactoryBot.create(:article)
      click_link 'Articles'
      expect(current_path).to eq(articles_path)

      expect(page).to have_content(@article.title)
      # save_and_open_page
      end
    end
    describe 'invalid: ' do

    end
  end

  describe 'GET #show' do
    describe 'valid: ' do
      it 'should return an aritcle' do
        @article = FactoryBot.create(:article)
        click_link 'Articles'
        expect(current_path).to eq(articles_path)

        expect(page).to have_content(@article.title)

        click_link "Show"
        expect(current_path).to eq(article_path(@article))

        expect(page).to have_content(@article.title)
        expect(page).to have_content(@article.content)
        expect(page).to have_content(@article.user.email)
      end
    end

    describe 'invalid: ' do
      it 'should not return an article if one does not exist' do
        visit article_path(99999)
        expect(current_path).to eq(articles_path)
        expect(page).to have_content("The article you're looking for cannot be found")

      end
    end
  end

  describe 'GET #new' do
    describe 'valid: ' do

    end

    describe 'invalid: ' do
      # Devise handles this so we skip
    end
  end
  describe 'GET #edit' do
    describe 'valid: ' do
      # Devise handles this so we skip
    end

    describe 'invalid: ' do
      # Devise handles this so we skip
    end
  end

  describe "DELETE #destroy" do
    describe 'valid: ' do
      # Devise handles this so we skip
    end
  end
end


