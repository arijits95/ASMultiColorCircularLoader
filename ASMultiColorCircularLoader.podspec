Pod::Spec.new do |spec|

  spec.name         = "ASMultiColorCircularLoader"
  spec.version      = "0.0.2"
  spec.summary      = "This is a multicolor circular spinner which acts a a beautiful loader and is highly customizable."

  spec.description  = <<-DESC
  ASMultiColorCircularSpinner is a lightweight circular loader which spins to reveal and hide multiple colors thereby creating a beautiful animation. It is also very customizable.
                   DESC

  spec.homepage     = "https://github.com/arijits95/ASMultiColorCircularLoader"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Arijit" => "arijits95@gmail.com" }

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/arijits95/ASMultiColorCircularLoader.git", :tag => "#{spec.version}" }
  spec.source_files  = "ASMultiColorCircularLoader/ASMultiColorCircularLoader/Source/*"

end
