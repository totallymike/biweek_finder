require 'biweek_finder/version'

module BiweekFinder
  def self.from_path(path = '.')
    sort from_a subdirectories(path)
  end

  def self.subdirectories(path = '.')
    dir = Dir.open(path)
    dir.select {|f| File.directory?(File.join(path, f))}
  end

  def self.from_a(arr = [])
    arr.find_all do |name|
      self.is_biweek? name
    end
  end

  def self.sort(arr = [])
    arr.sort {|a, b| a <=> b}
  end

  def self.is_biweek?(str)
    if /^20/ =~ str
      true
    else false
    end
  end
end
