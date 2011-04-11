Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '176795145703361', 'd667b85873b11458373adb8f5d167f6e'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
