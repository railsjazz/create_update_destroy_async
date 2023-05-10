class User < ApplicationRecord
  has_many :projects, dependent: :destroy
end
