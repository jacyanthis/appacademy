require 'byebug'

module Save

  def save
    table = self.class.to_s.underscore.pluralize
    data = instance_variables.each_with_object({}) do |variable, hash|
      no_at = variable.to_s.sub(/@/, "")
      hash[no_at.to_sym] = send(no_at)
    end
    puts "data is #{data}"

    if id
      update(table, data)
    else
      data.delete(:@id)
      QuestionsDatabase.instance.execute(<<-SQL, data)
        INSERT INTO
          #{table} (#{data.values.join(", ")})
        VALUES
          (#{data.keys.join(", ")})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def update(table, data)
    params_str = data.keys.each_with_object([]) do |var, arr|
      arr << "#{var} = :#{var}" unless var.to_s == "id"
    end.join(", ")
    QuestionsDatabase.instance.execute(<<-SQL, data)
      UPDATE
        questions
      SET
        #{params_str}
      WHERE
        id = :id
    SQL
  end

end
