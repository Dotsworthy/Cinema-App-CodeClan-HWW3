require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_id, :tickets_available, :showing, :day, :type

  def initialize(options)
    @film_id = options['film_id'].to_i
    @tickets_available = options['tickets_available'].to_i
    @showing = options['showing']
    @day = options['day']
    @type = options['type']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO screenings
    (
      film_id,
      tickets_available,
      showing,
      day,
      type
      )
      VALUES
      (
      $1,
      $2,
      $3,
      $4,
      $5
      )
      RETURNING id"
    values = [@film_id, @tickets_available, @showing, @day, @type]
    screening = SqlRunner.run(sql, values).first
    @id = screening['id'].to_i
  end

  def update()
    sql = "
    UPDATE screenings SET (
      film_id,
      tickets_available,
      showing,
      day,
      type,
    ) =
    (
      $1,
      $2,
      $3,
      $4,
      $5
    )
    WHERE id = $6"
    values = [@film_id, @tickets_available, @showing, @day, @type, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
  sql = "SELECT * FROM screenings"
  screenings = SqlRunner.run(sql)
  result = screenings.map { |user| Screening.new( user ) }
  return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
