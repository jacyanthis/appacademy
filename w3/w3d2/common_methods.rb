require 'active_support/inflector'

module CommonClassMethods
  def find_by_id(id)
    table = self.to_s.underscore.pluralize
    puts table

    self.new(QuestionsDatabase.instance.execute(<<-SQL, id).first)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = ?
    SQL
  end

  def where(args_hash) #args_hash is a hash of column names (symbols) with desired values
    puts "i am in where and args_hash is #{args_hash}"
    PendingWhereQuery.new(args_hash, self)
  end

class PendingWhereQuery

  def initialize(args_hash, relevant_class)
    puts "i am in initialize and i have args_hash: #{args_hash}"
    @args_hash = args_hash
    @relevant_class = relevant_class
  end

  def where(new_args_hash)
    new_args_hash.each do |k, v|
      @args_hash[k] = v
    end
  end

  def method_missing(method_name, *args, &block)
    puts "i found a missing method: #{method_name}"
    puts "my args are: #{args}"
    array = execute_where_query(@args_hash)
    puts "i executed the where query"
    array.send(method_name, *args, &block)
  end

  def execute_where_query(args_hash)
    puts "i'm executing args_hash: #{args_hash}"
    table = @relevant_class.to_s.underscore.pluralize
    data = args_hash.values
    col_names = args_hash.keys

    params_str = col_names.each_with_object([]) do |var, arr|
      arr << "#{var} = ?"
    end.join(", ")

    rows = QuestionsDatabase.instance.execute(<<-SQL, data)
      SELECT
        *
      FROM
        #{table}
      WHERE
        #{params_str}
    SQL
    puts rows
    rows.map { |row| @relevant_class.new(row) }
  end
end


  def first(args_hash) #args_hash is a hash of column names (symbols) with desired values
    table = self.to_s.underscore.pluralize
    data = args_hash.values
    col_names = args_hash.keys

    params_str = col_names.each_with_object([]) do |var, arr|
      arr << "#{var} = ?"
    end.join(", ")

    rows = QuestionsDatabase.instance.execute(<<-SQL, data)
      SELECT
        *
      FROM
        #{table}
      WHERE
        #{params_str}
      LIMIT
        1
    SQL

    rows.map { |row| self.new(row) }.first
  end

  def any?(args_hash)
    !first(arg_hash)
  end

  def method_missing(method_name, *arg, &block)
    desired_value = arg[0]
    column = method_name.to_s.match(/find\_by\_(\w*)/)[1].to_sym

    where({column => desired_value})
  end

end
