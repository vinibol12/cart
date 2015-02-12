class InfoController < ApplicationController
  skip_before_action :authorize, [:contact, :faq, :news]


  # GET /info/contact
  def contact
  end


end
