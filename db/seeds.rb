require('pry')
require_relative('../models/merchant')
require_relative('../models/tag')
require_relative('../models/transaction')

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()

tesco = Merchant.new('name' => 'Tesco')
chanter = Merchant.new('name' => 'The Chanter')
amazon = Merchant.new('name' => 'Amazon')
virgin = Merchant.new('name' => 'Virgin Media')

tesco.save()
chanter.save()
amazon.save()
virgin.save()

groceries = Tag.new('category' => 'Groceries', 'colour' => '#D90368')
fun = Tag.new('category' => 'Fun', 'colour' => '#F75C03')
education = Tag.new('category' => 'Education', 'colour' => '#820263')
bills = Tag.new('category' => 'Bills', 'colour' => '#291720')

groceries.save()
fun.save()
education.save()
bills.save()

transaction1 = Transaction.new('amount' => 15.98, 'merchant_id' => tesco.id, 'tag_id' => groceries.id)
transaction2 = Transaction.new('amount' => 32.75, 'merchant_id' => chanter.id, 'tag_id' => fun.id)
transaction3 = Transaction.new('amount' => 9.15, 'merchant_id' => amazon.id, 'tag_id' => education.id)
transaction4 = Transaction.new('amount' => 45.00, 'merchant_id' => virgin.id, 'tag_id' => bills.id)
transaction5 = Transaction.new('amount' => 20.99, 'merchant_id' => amazon.id, 'tag_id' => fun.id)

transaction1.save()
transaction2.save()
transaction3.save()
transaction4.save()
transaction5.save()

binding.pry
nil
