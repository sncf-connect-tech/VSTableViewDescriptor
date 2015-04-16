#
# Be sure to run `pod lib lint TableViewDescriptor.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TableViewDescriptor"
  s.version          = "1.0.1"
  s.summary          = "Simplify Table view delegation via blocks."
  s.homepage         = "http://gitlab.socrate.vsct.fr/dwm-mobile/TableDescriptorIOS"
  s.license          = 'MIT'
  s.author           = { "GWENN GUIHAL" => "gguihal@voyages-sncf.com" }
  s.source           = { :git => "http://gitlab.socrate.vsct.fr/dwm-mobile/PodspecsIOS.git", :tag => "1.0.1" }


  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'VSTableViewDescriptor'
end
