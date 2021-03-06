require 'yaml'

module ZipCodes
  VERSION = '0.2.1'

  class << self
    def identify(code)
      db[code]
    end

    def get_zip(city, state_name)
      zip_codes = []
      db.each do |zip|
        if zip[1][:state_name] == state_name && zip[1][:city] == city
          zip_codes << zip[0]
        end
      end
      zip_codes
    end

    def get_cities(state_name)
      cities = []
      db.each do |zip|
        if zip[1][:state_name] == state_name
          cities << zip[1][:city]
        end
      end
      cities.uniq
    end

    def all_zipcodes
      codes = []
      db.each do |zip|
        codes << zip[0]
      end
      codes
    end

    def db
      @db ||= begin
        this_file = File.expand_path(File.dirname(__FILE__))
        us_data = File.join(this_file, 'data', 'US.yml')
        YAML.load(File.open(us_data))
      end
    end

    def load
      db
    end
  end
end
