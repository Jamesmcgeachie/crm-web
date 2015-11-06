require 'data_mapper'
DataMapper.setup(:default, 'sqlite:crm_development.db')

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :notes, Text

	def full_name
		"#{first_name} #{last_name}"
	end
end

DataMapper.auto_upgrade!