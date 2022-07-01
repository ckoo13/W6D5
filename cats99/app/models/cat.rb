# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  age         :integer          not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

require "action_view"

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    #Calculate Age Method
    def calculate_age(birth_date)
        age = ((Time.zone.now - birth_date.to_time) / 1.year.seconds).floor
    end

    #Validations
    validates :name, presence: true
    validates :birth_date, presence: true
    validates :sex, presence: true, inclusion: { in: %w(M F), message: "%{value} is not a valid sex"}
    validates :color, presence: true, inclusion: { in: %w(black white orange tabby tuxedo calico red), message: "%{value} is not a valid color"}
end
