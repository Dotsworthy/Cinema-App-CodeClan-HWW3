require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize(options)
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      film_id,
      customer_id
      )
      VALUES
      (
      $1,
      $2
      )
      RETURNING id"
      # I am not 100% sure what is happening on line 26
    values = [@film_id, @customer_id]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i

  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # def find_by_id(id)
  #   sql = "SELECT * FROM tickets WHERE id = $1"
  #   values = [id]
  #   ticket = SqlRunner.run(sql, values).first
  #   return Ticket.new(ticket)
  # end

  def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |user| Ticket.new( user ) }
  return result
end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end
end
