require "rake/clean"
require 'rake/extensiontask'

task :compile => "ext/hacks/structs.rb"
Rake::ExtensionTask.new("hacks")

CLOBBER.include "ext/hacks/structs.rb"

def walk doc, &blk
  yield doc
  (doc["inner"] || []).each { |child| walk(child, &blk) }
end

def struct doc, name
  walk doc do |node|
    if node["kind"] == "RecordDecl" && node["name"] == name && node["inner"]
      return [name, node["inner"].find_all { |x| x["kind"] == "FieldDecl" }.map { |x|
        x["name"]
      }]
    end
  end
  nil
end

STRUCTS = %w{
  RTypedData
  RBasic
  RObject
  RArray
  RData
}

file "ext/hacks/structs.rb" do
  require "tempfile"
  require "rbconfig"
  require "open3"
  require "json"

  h_dir = RbConfig::CONFIG["rubyhdrdir"]
  arch_dir = RbConfig::CONFIG["rubyarchhdrdir"]
  file = Tempfile.new('c_file')

  begin
    file.write "#include <ruby.h>"
    file.close

    cmd = "clang -I#{h_dir} -I#{arch_dir} -xc -Xclang -ast-dump=json -fsyntax-only #{file.path}"
    stdout_and_stderr, status = Open3.capture2e(cmd)
    doc = JSON.load stdout_and_stderr

    require "pp"
    structs = STRUCTS.map { |name| struct doc, name }.pretty_inspect

    File.open("ext/hacks/structs.rb", "w") do |f|
      f.write "module Hacks\n  STRUCTS = #{structs}\nend"
    end
  ensure
    #file.unlink   # deletes the temp file
  end
end
