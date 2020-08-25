class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :inputs
  has_many :tests

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_last_name_and_first_name_and_email,
                  against: %i[last_name first_name email],
                  using: {
                    tsearch: { prefix: true }
                  }

  def result_for_test(_test)
    # Récupérer une instance de l'utilisateur actuel
    # @user = User.find(params(:user_id)) # à finir?
    # Récupérer les inputs de l'utilisateur pour le test actuel
    # @inputs = @user.inputs.where(test_question_id.test_id:(params()))
    # Récupérer les entrées de
    # returns a percentage
  end

  # me permet de faire user.tests_as_candidate et me sort tous les tests d'un candidat
  def tests_as_candidate
    inputs.map(&:test_question).map(&:test).uniq
  end

  def completion_for_test(test)
    # return a percentage
  end

  def results_per_tag(test)
    # returns a hash : keys are tags and values are percentage of success
  end
end
