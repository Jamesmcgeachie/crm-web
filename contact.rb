class Contact

	attr_reader :id
	attr_accessor :first_name, :last_name, :email, :notes

	@@contacts = []
	@@id = 1

	def initialize(first_name, last_name, options = {})
		@first_name = first_name
		@last_name = last_name
		@email = options[:email]
		@notes = options[:notes]
		@id = @@id
		@@id += 1
	end

	def self.delete_all
		@@contacts = []
		@@id = 1
	end

	def delete
		@@contacts.delete(self)
	end


	def self.create(first_name, last_name, options = {})
		new_contact = new(first_name, last_name, options)
		@@contacts << new_contact
		new_contact
	end

	def self.all
		@@contacts
	end

	def self.find(id)
		@@contacts.each do |contact|
			if contact.id == id
				return contact
			end
		end
	end

	def update(key, value)
		case
		when key == "first_name"
			self.first_name = value
		when key == "last_name"
			self.last_name = value
		when key == "notes"
			self.notes = value
		when key == "email"
			self.email = value
		end
	end

	def self.search_by_attribute(key, value)
		contacts = []
		@@contacts.each do |contact|
			if contact.send(key.to_sym) == value
				contacts << contact
			end
		end
		return contacts
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end