class AddEmailToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :contact_email, :string
  end
end
