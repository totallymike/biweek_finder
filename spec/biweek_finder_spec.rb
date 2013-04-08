require 'spec_helper'
require 'biweek_finder'

describe BiweekFinder do
  describe "pattern matching" do
    it "can recognize a biweek timestamp" do
      expect(BiweekFinder.is_biweek? '20122930').to be true
      expect(BiweekFinder.is_biweek? 'fooDir').to be false
    end
  end

  describe "sorting" do
    it "sorts the biweeks appropriately" do
      expect(BiweekFinder.sort %w{20121112 20120102}).to eq %w{20120102 20121112}
    end
  end

  describe "Directory reading" do
    dirs  = %w{20130910 20131112 20081112 fooDir}
    files = %w{20131111.txt file1.txt file2.txt}

    before(:all) do
      $temp_dir = Dir.mktmpdir
      dirs.each do |dir|
        Dir.mkdir File.join($temp_dir, dir)
      end
      files.each do |file|
        File.new(File.join($temp_dir, file), 'w')
      end
    end

    after(:all) do
      dirs.each do |dir|
        Dir.rmdir File.join($temp_dir, dir)
      end
      files.each do |file|
        File.unlink File.join($temp_dir, file)
      end
      Dir.rmdir $temp_dir
    end

    it "should return only directories named after biweeks" do
      expect(BiweekFinder.from_path $temp_dir).
        to eq %w{20081112 20130910 20131112}
    end
  end
end
