require 'spec_helper'

describe PasswordResetController do
	describe "GET new" do		
		it "renders the new template" do
			get :new
			expect(response).to render_template('new')
		end
	end

	describe "POST create" do
		context "with a valid user and email" do
			let(:user) { create(:user) }

			it "finds the user" do
				expect(User).to receive(:find_by).with(email: user.email).and_return(user)
				post :create, email: user.email
			end

			it "sends a password reset email" do
				expect{ post :create, email: user.email }.to change(ActionMailer::Base.deliveries, :size)
			end

			it "sets the flash message" do
				post :create, email: user.email
				expect(flash[:success]).to match(/sent to your email address/)
			end
		end

		context "with no user found" do
			it "renders the new page" do
				post :create, email: "bad@email.com"
				expect(response).to render_template("new")
			end

			it "sets the flash message" do
				post :create, email: "bad@email.com"
				expect(flash[:notice]).to match(/not found/)
			end
		end
	end

	describe "GET edit" do
		context "with a valid token" do
			let(:user) { create(:user) }
			before { user.generate_password_reset_token! }

			it "renders the edit page" do
				get :edit, id: user.password_reset_token
				expect(response).to render_template("edit")
			end

			it "assigns a @user" do
				get :edit, id: user.password_reset_token
				expect(assigns(:user)).to eq(user)
			end
		end

		context "with no password_reset_token found" do
      it "renders the 404 page" do
        get :edit, id: 'notfound'
        expect(response.status).to eq(404)
        expect(response).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
	end

	describe "PATCH update" do
		context "with no token found" do
			it "renders the edit page" do
				patch :update, id: 'notfound', user: { password: 'newpassword', password_confirmation: 'newpassword' }
				expect(response).to render_template('edit')
			end

			it "sets the flash message" do
        patch :update, id: 'notfound', user: { password: 'newpassword', password_confirmation: 'newpassword' }
        expect(flash[:notice]).to match(/not found/)
      end
		end

		context "with valid token" do
			let(:user) { create(:user) }
			before { user.generate_password_reset_token! }

			it "updates the user's password" do
				digest = user.password_digest
				patch :update, id: user.password_reset_token, user: { password: 'newpassword', password_confirmation: 'newpassword' }
				user.reload
				expect(user.password_digest).to_not eq(digest)
			end

			it "clears the password_reset_token" do
        patch :update, id: user.password_reset_token, user: { password: 'newpassword1', password_confirmation: 'newpassword1' }
        user.reload
        expect(user.password_reset_token).to be_blank
      end

      it "sets the flash[:success] message" do
        patch :update, id: user.password_reset_token, user: { password: 'newpassword1', password_confirmation: 'newpassword1' }
        expect(flash[:success]).to match(/password updated/i)
      end

      it "redirects to contacts page" do
        patch :update, id: user.password_reset_token, user: { password: 'newpassword1', password_confirmation: 'newpassword1' }
        expect(response).to redirect_to(contacts_path)
      end
		end
	end
end
