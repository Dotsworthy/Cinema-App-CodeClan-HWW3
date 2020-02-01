require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )

require( 'pry-byebug' )

customer1 = Customer.new({'name' => 'Arnold', 'funds' => '20.00'})
customer1.save()

binding.pry()
nil
