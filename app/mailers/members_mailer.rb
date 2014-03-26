class MembersMailer < ActionMailer::Base
  default from: "sigmanuepl@gmail.com"

  def welcome(user)

  end

  def all_members(message)
  	gb = Gibbon::API.new
    gb.campaigns.create(
	 { type: "regular", options: {list_id: 'a5eb726f54', subject: "Sigma Nu is cool", 
	   from_email: "sigmanuepl@gmail.com", from_name: "Darth Vader", generate_text: true}, 
	   content: { html: message.render } })
  end
end
