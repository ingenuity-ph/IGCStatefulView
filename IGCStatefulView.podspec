#
# Be sure to run `pod lib lint IGCStatefulView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IGCStatefulView'
  s.version          = '0.2.4'
  s.summary          = 'Displays a corresponding data state (loading, error, etc) for a UIView instance (includes UITableView and UICollectionView).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A UIView extension wherein the capability of displaying states is available to properly convey to users the current state of the view with respect to its current data.
                       DESC

  s.homepage         = 'https://github.com/ingenuity-ph/IGCStatefulView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jason Jon E. Carreos' => 'jason@ingenuity.ph' }
  s.source           = { :git => 'https://github.com/ingenuity-ph/IGCStatefulView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'IGCStatefulView/Classes/**/*'
  s.resource =  'IGCStatefulView/**/*.xib'

  # s.resource_bundles = {
  #   'IGCStatefulView' => ['IGCStatefulView/Resources/StateView.xib']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
