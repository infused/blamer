# Stop ActiveRecord from printing schema statements to the console
$stdout = StringIO.new

ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string :name
  end
  
  create_table :monkeys do |t|
    t.string :name
  end
  
  create_table :widgets do |t|
    t.string :name
    t.userstamps
  end
  
  create_table :sprockets do |t|
    t.string :name
    t.userstamps
  end
end