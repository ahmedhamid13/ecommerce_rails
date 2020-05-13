Pay.setup do |config|
    config.chargeable_class = 'Pay::Charge'
    config.chargeable_table = 'pay_charges'
  
    # For use in the receipt/refund/renewal mailers
    config.business_name = "SouCom"
    config.business_address = "city center,Alexandria"
    config.application_name = "SouCom"
    config.support_email = "helpme@example.com"
  
    config.send_emails = false
  
    config.automount_routes = true
    config.routes_path = "/pay" # Only when automount_routes is true
  end