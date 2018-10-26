require 'pg'

class Peep

  attr_reader :id, :message, :time

  def initialize(id:, message:, time:)
    @id = id
    @message = message
    @time = time
  end

  def self.create(message:, time: Time.now)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'peep_manager_test')
    else
      connection = PG.connect(dbname: 'peep_manager')
    end
    result = connection.exec("INSERT INTO peeps (message, time) VALUES('#{message}', '#{time.strftime("%Y-%m-%d %k:%M")}') RETURNING id, message, time;")
    Peep.new(id: result[0]['id'], message: result[0]['message'], time: result[0]['time'])
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'peep_manager_test')
    else
      connection = PG.connect(dbname: 'peep_manager')
    end
    result = connection.exec("SELECT * FROM peeps;")
    result.map { |peep| Peep.new(id: peep['id'], message: peep['message'], time: peep['time']) }
  end

end
