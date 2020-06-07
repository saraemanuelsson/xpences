require('pry')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/expense')

Expense.delete_all()
Merchant.delete_all()
Tag.delete_all()

tesco = Merchant.new('name' => 'Tesco', "active" => 1)
chanter = Merchant.new('name' => 'The Chanter', "active" => 1)
amazon = Merchant.new('name' => 'Amazon', "active" => 1)
virgin = Merchant.new('name' => 'Virgin Media', "active" => 1)

tesco.save()
chanter.save()
amazon.save()
virgin.save()

groceries = Tag.new('category' => 'Groceries', 'colour' => '#D90368', "active" => 1)
fun = Tag.new('category' => 'Fun', 'colour' => '#F75C03', "active" => 1)
education = Tag.new('category' => 'Education', 'colour' => '#820263', "active" => 1)
bills = Tag.new('category' => 'Bills', 'colour' => '#291720', "active" => 1)

groceries.save()
fun.save()
education.save()
bills.save()

expense1 = Expense.new('amount' => 15.98, 'date' => "2020-05-24", 'merchant_id' => tesco.id, 'tag_id' => groceries.id)
expense2 = Expense.new('amount' => 32.75, "date" => "2020-05-25",'merchant_id' => chanter.id, 'tag_id' => fun.id)
expense3 = Expense.new('amount' => 9.15, "date" => "2020-05-28", 'merchant_id' => amazon.id, 'tag_id' => education.id)
expense4 = Expense.new('amount' => 45.00, "date" => "2020-06-01", 'merchant_id' => virgin.id, 'tag_id' => bills.id)
expense5 = Expense.new('amount' => 20.99, "date" => "2020-06-06",'merchant_id' => amazon.id, 'tag_id' => fun.id)

expense1.save()
expense2.save()
expense3.save()
expense4.save()
expense5.save()

binding.pry
nil
