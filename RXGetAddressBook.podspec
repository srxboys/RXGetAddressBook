
Pod::Spec.new do |s|


  s.name         = "RXAddressBook"
  s.version      = "1.0.0"
  s.summary      = "Get the name and phone number of the system address book."

 
  s.description  = <<-DESC
			AddressBookUI、ContactsUI 库->修改required为optional	
                   DESC

  s.homepage     = "https://github.com/srxboys/RXGetAddressBook"
  s.screenshots  = "https://github.com/srxboys/RXGetAddressBook/blob/master/srxboys_RXGetAddressBook.gif"



  s.license      = "MIT (RXAddressBook)"
  s.author       = { "sunmengxin" => "sunmengxin@126.cn" }

  s.platform     = :ios, "6.0"
 

  s.source       = { :git => "https://github.com/srxboys/RXGetAddressBook.git", :tag => "1.0.0" }

  s.source_files  = "RXAddressBook/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

   s.frameworks = "AddressBookUI", "ContactsUI"



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
