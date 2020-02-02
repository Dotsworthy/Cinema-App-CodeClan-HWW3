require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id, :screening_id

  def initialize(options)
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @sc
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

  def update()
    sql = "
    UPDATE tickets SET (
      film_id,
      customer_id
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@film_id, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

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
