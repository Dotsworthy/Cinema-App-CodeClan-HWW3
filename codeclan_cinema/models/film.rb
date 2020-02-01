require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @title = options['title']
    @price = options['price'].to_f
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
      )
      VALUES
      (
      $1,
      $2
      )
      RETURNING id"
      # I am not 100% sure what is happening on line 26
    values = [@title, @price]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "
    UPDATE films SET (
      title,
      price
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
  sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return customer_data.map {|customer| Customer.new (customer)}
  end

  def customer_count()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    customers = ticket_data.map{|ticket| Ticket.new(ticket)}
    return customers.count
    # return customers.uniq {|customer| customer} do I actually need this?
  end

  def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  result = films.map { |user| Film.new( user ) }
  return result
end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end


end
