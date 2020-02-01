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

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
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
