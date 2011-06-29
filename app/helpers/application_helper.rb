module ApplicationHelper
  def error_messages_for_attribute(object, attribute)
    if object.errors.on(attribute)
      html = '<small class="errors"><ul>'
      object.errors.on(attribute).each do |message|
        html += "<li>" + message + "</li>"
      end
      html += "</ul></small>"
    end
  end

  def cc_types
    ['Select Card',
     'American Express',
     'Discover',
     'Mastercard',
     'Visa']
  end

  def states_array
    ['AK',
	'AL',
	'AR',
	'AZ',
	'CA',
	'CO',
	'CT',
	'DC',
	'DE',
	'FL',
	'GA',
	'HI',
	'IA',
	'ID',
	'IL',
	'IN',
	'KS',
	'KY',
	'LA',
	'MA',
	'MD',
	'ME',
	'MI',
	'MN',
	'MO',
	'MS',
	'MT',
	'NC',
	'ND',
	'NE',
	'NH',
	'NJ',
	'NM',
	'NV',
	'NY',
	'OH',
	'OK',
	'OR',
	'PA',
	'RI',
	'SC',
	'SD',
	'TN',
	'TX',
	'UT',
	'VA',
	'VT',
	'WA',
	'WI',
	'WV',
	'WY']
  end
end
