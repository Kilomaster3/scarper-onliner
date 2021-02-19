# frozen_string_literal: true

require 'csv'

class CSVFileWritter
  def self.to_file(file_name, array)
    CSV.open("#{file_name}.csv", 'w') do |csv|
      csv << %w[Name Label Image]
      array.each do |item|
        csv << [item[:name], item[:text], item[:image]]
      end
    end
  end
end
