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

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
