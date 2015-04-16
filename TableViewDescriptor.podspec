#
# Be sure to run `pod lib lint GGLocalizationSystem.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TableViewDescriptor"
  s.version          = "1.0"
  s.summary          = "Simplify Table view delegation via blocks."
  s.homepage         = "https://github.com/myrddinus/GGLocalizationSystem"
  s.license          = 'MIT'
  s.author           = { "GWENN GUIHAL" => "gguihal@voyages-sncf.com" }
  s.source           = { :git => "https://github.com/myrddinus/GGLocalizationSystem.git", :tag => 1.0 }
  #s.social_media_url = 'https://twitter.com/_myrddin_'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'TableViewDescriptor'
end
