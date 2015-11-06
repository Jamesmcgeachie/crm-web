require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, 'sqlite3:database.sqlite3')

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

Contact.create("Foo", "Bar", {email: "foo@bar.com", notes: "some note"})
Contact.create("James", "McGeachie", {email: "wefwefeff@bar.com", notes: "fwefwefee"})

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get'/contacts' do
	erb :contacts
end

get'/contacts/new' do
	erb :new_contact
end

post '/contacts' do
  Contact.create(params[:first_name], params[:last_name], { email: params[:email], notes: params[:notes]})
  redirect to('/contacts')
end

get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :show
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
 	if @contact
	  @contact.first_name = params[:first_name]
	  @contact.last_name = params[:last_name]
	  @contact.email = params[:email]
	  @contact.notes = params[:notes]

   	redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact.delete
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end
