require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )

require( 'pry-byebug' )

customer1 = Customer.new({'name' => 'Arnold', 'funds' => '20.00'})
customer1.save()

film1 = Film.new({'title'=> 'Terminator', 'price' => '7.95'})
film1.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer1.id})
ticket1.save()

binding.pry()
nil
