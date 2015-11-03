require 'sinatra'
require_relative 'contact'

get '/' do
	@crm_app_name = "My CRM"
	erb :index
end


get'/contacts' do
	Contact.create("Yehuda", "Katz", { email: "yehuda@example.com", notes: "Developer"})
  Contact.create("Mark", "Zuckerberg", { email: "mark@facebook.com", notes: "CEO"})
  Contact.create("Sergey", "Brin", { email: "sergey@google.com", notes: "Co-Founder"})
	erb :contacts
end

get'/contacts/new' do
	erb :new
end