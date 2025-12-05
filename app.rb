require 'sinatra'
require 'sqlite3'
require 'slim'
require 'sinatra/reloader'




get('/') do
    slim(:home)
end

get('/todos') do
    db = SQLite3::Database.new("db/todos.db")
    db.results_as_hash = true
    @datados = db.execute("SELECT * FROM todos")
    slim(:"todos/index")
end

get('/Categories') do
    slim(:categories)
end

post('/todos/:id/update') do
    id = params[:id].to_i
    name = params[:name]
    description = params[:description]
    db = SQLITE3::Database.new('db/todos.db')
    db.execute("UPDATE todos SET name=?,description=? WHERE id=?", [name, description, id])    
    redirect('/todos')
end

get('/todos/:id/edit') do
  
    db = SQLite3::Database.new('db/todos.db')
    db.results_as_hash = true
    id = params[:id].to_i
    @special_todo = db.execute("SELECT * FROM todos WHERE id = ?", id).first
    slim(:"todos/edit")
  
end

post('/todo') do 
    new_todo = params[:new_todo] 
    description = params[:description]
    db = SQLite3::Database.new('db/todo.db') 
    db.execute("INSERT INTO todos (name, amount) VALUES (?,?)",[new_todo,description])
    redirect('/todos')
end

post('/todo/:id/delete') do
    delete = params[:id].to_i
    db = SQLite3::Database.new('db/todo.db')
    db.execute("DELETE FROM todos WHERE id=(?)",delete)
    redirect('/todos')
end
