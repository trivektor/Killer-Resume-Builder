Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'yYBcVi6hv17lbixu2jPEA', '8BEbqq7QDExyhtaBqgvchfjwMlQOHQgTdZcxoCvytI'
  provider :facebook, '176795145703361', 'd667b85873b11458373adb8f5d167f6e'
  provider :linked_in, 'OrNo2OSp34A6hvM4ATiUuqpRW4ysnuALV_gRGBgmPzBghfcidzaKearPlw1YYKAN', 'DfwJf-H-4tZHRLMzgNO4_Ns9vx1Aepm4SSShikDpqashbWAm-C0_FS5VW8AJfHi1'
end
