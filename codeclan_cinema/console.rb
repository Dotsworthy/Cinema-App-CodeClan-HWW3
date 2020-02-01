require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )


require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({'name' => 'Arnold', 'funds' => '20.00'})
customer1.save()
customer2 = Customer.new({'name' => 'Sylvester', 'funds' => '15.00'})
customer2.save()
customer3 = Customer.new({'name' => 'Wesley', 'funds' => '0.00'})
customer3.save()

film1 = Film.new({'title'=> 'Terminator', 'price' => '7.95'})
film1.save()
film2 = Film.new({'title'=> 'Rambo', 'price' => '7.95'})
film2.save()
film3 = Film.new({'title' => 'Blade', 'price' => '7.95'})
film4 = Film.new({'title' => 'Commando', 'price' => '5.95'})
film4.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id})
ticket1.save()
ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer2.id})
ticket2.save()

binding.pry()
nil

# I can't delete the customer or film without manually deleting the ticket first. Should ON DELETE CASCADE be dealing with this?
