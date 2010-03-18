
require 'objective-j'
require 'objective-j/bundletask'

if !ENV['CONFIG']
    ENV['CONFIG'] = 'Debug'
end

ObjectiveJ::BundleTask.new(:CappuccinoTwitterDemo) do |t|
    t.name          = 'CappuccinoTwitterDemo'
    t.identifier    = 'com.justinfreitag.CappuccinoTwitterDemo'
    t.version       = '0.1'
    t.author        = 'Justin Freitag'
    t.email         = 'justin.freitag @nospam@ gmail.com'
    t.summary       = 'CappuccinoTwitterDemo'
    t.sources       = FileList['*.j']
    t.resources     = FileList['Resources/*']
    t.index_file    = 'index.html'
    t.info_plist    = 'Info.plist'
    t.build_path    = File.join('Build', ENV['CONFIG'], 'CappuccinoTwitterDemo')
    t.flag          = '-DDEBUG' if ENV['CONFIG'] == 'Debug'
    t.flag          = '-O' if ENV['CONFIG'] == 'Release'
end

task :default => [:TweetsOnCappuccino]
