class Address < ActiveRecord::Base
  validates_presence_of :first_name, :message => "First name cannot be blank"
  validates_presence_of :last_name, :message => "Last name cannot be blank"
  validates_presence_of :day_phone, :message => "Day phone cannot be blank"
  validates_presence_of :address_line_1, :message => "Address line 1 cannot be blank"
  validates_presence_of :city, :message => "City cannot be blank"
  validates_presence_of :state, :message => "State must be selected"
  validates_presence_of :zip, :message => "Zip code cannot be blank"
  validates_format_of :day_phone, :with => /^[0-9]{3,3}-[0-9]{3,3}-[0-9]{4,4}$/, :message => "Phone number format is not valid"
  validates_format_of :evening_phone, :with => /^[0-9]{3,3}-[0-9]{3,3}-[0-9]{4,4}$/, :message => "Phone number format is not valid"

  def day_phone=(phone)
    @day_phone=convert_phone(phone)
  end

  def evening_phone=(phone)
    @evening_phone=convert_phone(phone)
  end

  def convert_phone(phone)
    phone.gsub(/[^0-9]/, "").gsub(/^([0-9]{0,3})([0-9]{0,3})([0-9]{0,})$/) do |match|
      tmp = ""
      tmp += $1 if $1.size > 0
      tmp += "-" + $2 if $2.size > 0
      tmp += "-" + $3 if $3.size > 0
      tmp
    end
  end
end
