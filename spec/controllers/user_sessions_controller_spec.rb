require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    context "with valid credentials" do
      let!(:user) { User.create(
          user_first_name: "Seth", 
          user_last_name: "Reece", 
          email: "seth@me.com", 
          password: "password", 
          password_confirmation: "password"
        ) }

      it "redirects to the contacts path" do
        post :create, email: "seth@me.com", password: "password"
        expect(response).to be_redirect
        expect(response).to redirect_to(contacts_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({email: "seth@me.com"}).and_return(user)
        post :create, email: "seth@me.com", password: "password"
      end

      it "authenticates user" do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "seth@me.com", password: "password"
      end

      it "sets the user_id in the session" do
        post :create, email: "seth@me.com", password: "password"
        expect(session[:user_id]).to eq(user.id)
      end
    end

    shared_examples_for "bad login" do
      it "renders the new template" do
        post :create, email: email, password: password
        expect(response).to render_template('new')
      end

      it "gives a flash error" do
        post :create
        expect(flash[:error]).to eq("There was a problem logging in. Please check your email and/or password.")
      end
    end

    context "with no credentials" do
      let(:email) { "" }
      let(:password) { "" }
      it_behaves_like "bad login"
    end

    context "with a bad password" do
      let!(:user) { User.create(
          user_first_name: "Seth", 
          user_last_name: "Reece", 
          email: "seth@me.com", 
          password: "password", 
          password_confirmation: "password"
        ) }

      let(:email) { user.email }
      let(:password) { "wrongpass" }
      it_behaves_like "bad login"
    end

    context "with a bad email" do
      let!(:user) { User.create(
          user_first_name: "Seth", 
          user_last_name: "Reece", 
          email: "seth@me.com", 
          password: "password", 
          password_confirmation: "password"
        ) }

      let(:email) { "user@wrong.com" }
      let(:password) { "password" }
      it_behaves_like "bad login"
    end
  end

end
