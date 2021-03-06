#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'Pony'

get '/' do
	erb "Привет! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Оригинальный</a> шаблон модифицировался в <a href=\"http://rubyschool.us/\">Ruby School!!!</a>"			
end

get '/about' do
	@error = 'Something wrong'
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

#	f = File.open './public/users.txt', 'a'
#	f.write "Имя : #{@username},\t Телефон: #{@phone},\t Дата записи : #{@datetime},\t Парекмахер: #{@barber},\t Цвет покраски #{@color} \n"
#	f.close

	hh = {
		:username => 'Введите имя', 
		:phone => 'Введите Телефон', 
		:datetime => 'Введите дату и время'
	}

	@error = hh.select {|key,vv| params[key] == ""}.values.join(" , ")

	if @error !=""
		return erb :visit		
	end

	erb "Ok , username is #{@username}, phone #{@phone}, date and time #{@datetime}, barber is #{@barber}, color #{@color}"
end

post '/contacts' do



	@mail = params[:mail]
	@msgarea = params[:msgarea]
	@theme = params[:theme]

#	f = File.open './public/contacts.txt', 'a'
#	f.write "Емэйл : #{@mail}, сообщение : #{@msgarea}\n"
#	f.close
	
	hh = {
		:mail => 'введите email', 
		:theme => 'введите тему',
		:msgarea => 'Введите сообщение', 
	}

	@error = hh.select {|kk| params[kk] == ""}.values.join(" , ")

	if @error !=""
		return erb :contacts
		
	end

	

	
	Pony.mail(
		:to => @mail, 
		:from => 'victorhad@mail.ru', 
		:subject => @theme, 
		:body => @msgarea, 
		:via => :smtp, 
		:via_options => {
   :address     => 'smtp.mail.ru',
   :port     => '25',
   :enable_starttls_auto => true, 
    :user_name     => '',
    :password => '',
    :auth     => :plain           # :plain, :login, :cram_md5, no auth by default  
 })

	erb "Ok , mail is #{@mail}, theme #{@theme}, msgarea #{@msgarea}"

end