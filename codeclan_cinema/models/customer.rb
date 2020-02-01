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

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end
end
