class Patient < ApplicationRecord

  attribute :patient_file

  class << self
    def basic_search(search_string)
      all.where("patients.name ILIKE ?", "%#{search_string}%")
    end
  end
end
