
Pod::Spec.new do |s|
  s.name         = 'RXGetAddressBook'
  s.version      = '1.0.0'
  s.summary      = 'Get the name and phone number of the system address book.'
  s.homepage     = 'https://github.com/srxboys/RXGetAddressBook'
  #s.screenshots  = 'https://github.com/srxboys/RXGetAddressBook/blob/master/srxboys_RXGetAddressBook.gif'
  s.license      = 'MIT'
  s.author       = {'srxboys' => 'srxboys@126.com'}
  s.platform     = :ios, '6.0'
  #s.ios.deployment_target = '6.0'
  #s.osx.deployment_target = '10.8'
  s.source       = {:git => 'https://github.com/srxboys/RXGetAddressBook.git', :tag => s.version}
  s.source_files  = 'RXAddressBook/*.{h,m}'
  s.frameworks = 'AddressBookUI', 'ContactsUI'
  s.requires_arc = true
end
