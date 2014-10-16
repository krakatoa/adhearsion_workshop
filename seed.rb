require 'sequel'

DB = Sequel.sqlite :database => "./accounts.db"

DB.create_table :accounts do
  primary_key :id
  String :dni
  String :name
  Float :balance
end

accounts = DB[:accounts]

accounts.insert(:dni => '33021803', :name => "Fernando Alonso", :balance => 1500)
