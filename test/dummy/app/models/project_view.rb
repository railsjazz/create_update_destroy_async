class ProjectView < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validate :some_method

  private

  def some_method
  end
end
