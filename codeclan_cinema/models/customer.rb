require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options['name']
    @funds = options['funds'].to_f
    @id = options['id'].to_i if options['id']
  end

# I am not 100% sure what is going on in this code
  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
      )
      VALUES
      (
      $1,
      $2
      )
      RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "
    UPDATE customers SET (
      name,
      funds
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def buy_ticket(film)
    if remove_funds(film.price) == false
      return "Not enough money. Transaction cancelled"
      else
        new_ticket = Ticket.new({'film_id' => film.id, 'customer_id' => @id})
        new_ticket.save()
        @funds = remove_funds(film.price)
        update()
    end
  end

  def remove_funds(amount)
    if @funds < (amount)
      return false
    else
    @funds -= amount
  end
  end

  def add_funds(amount)
    @funds += amount
  end

  def films()
  sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE customer_id = $1"
  values = [@id]
  film_data = SqlRunner.run(sql, values)
  return film_data.map {|films| Film.new (films)}
  end

  def self.all()
  sql = "SELECT * FROM customers"
  customers = SqlRunner.run(sql)
  result = customers.map { |user| Customer.new( user ) }
  return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end
end
