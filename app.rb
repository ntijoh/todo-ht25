require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sinatra/reloader'




get('/') do
    slim(:home)
end

get('/ToDos') do
    db = SQLITE3::Database.new("db/todos.db")
    db.results_as_hash = true
    @datados = db.execute("SELECT * from todos")
    slim(:"Todos/index")
end

get('/Categories') do
    slim(:categories)
end

post('/Todos/:id/update') do
    id = params[:id].to_i
    name = params[:name]
    description = params[:description]
    db = SQLITE3::Database.new('db/todos.db')
    db.execute("UPDATE todos SET name=?,description=? WHERE id=?", [name, description, id])    
    redirect('/Todos')
end