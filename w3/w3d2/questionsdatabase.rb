require 'singleton'
require 'sqlite3'
require 'active_support/inflector'

require_relative 'save'
require_relative 'common_methods'
require_relative 'question'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true

    self.type_translation = true
  end
end
