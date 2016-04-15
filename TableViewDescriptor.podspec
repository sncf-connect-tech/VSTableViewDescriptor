Pod::Spec.new do |s|
  s.name             = "TableViewDescriptor"
  s.version          = "1.0.5"
  s.summary          = "Structure UItableview implementation in a data-oriented way instead of index-oriented."
  s.homepage         = "https://github.com/voyages-sncf-technologies/VSTableViewDescriptor"
  s.license          = 'MIT'
  s.author           = { "GWENN GUIHAL" => "gwenn.guihal@gmail.com" }
  s.source           = { :git => "https://github.com/voyages-sncf-technologies/VSTableViewDescriptor.git", :tag => "1.0.5" }


  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'VSTableViewDescriptor'
end
