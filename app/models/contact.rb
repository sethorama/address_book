class Contact < ActiveRecord::Base

	validates :first_name, presence: true
	validates :last_name, presence: true,
											  length: { minimum: 2 }
	validates :street, presence: true,
										 length: { minimum: 4 }
	validates :city, presence: true,
									 length: { minimum: 2 }
	validates :state, presence: true,
									  length: { minimum: 2 }
	validates :zip_code, presence: true,
											 length: { is: 5 },
											 format: {
											 	with: /[0-9]/
											 }

end
