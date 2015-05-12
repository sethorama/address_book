FactoryGirl.define do
	factory :user do
		user_first_name "Seth"
		user_last_name "Reece"
		sequence(:email) { |n| "user#{n}@example.com" }
		password "password"
		password_confirmation "password"
	end
end