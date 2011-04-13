Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'yYBcVi6hv17lbixu2jPEA', '8BEbqq7QDExyhtaBqgvchfjwMlQOHQgTdZcxoCvytI'
  provider :facebook, '176795145703361', 'd667b85873b11458373adb8f5d167f6e'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
