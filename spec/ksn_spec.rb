require_relative 'spec_helper'

require "ksn"

module Ksn
  
  describe Agent do
    it "can be created" do
      expect(Agent.new).to be_instance_of Agent
    end


    it "has a home_url" do
      agent = Agent.new
      expect( agent.home_url).to eq( 'https://ksn2.faa.gov/')
    end

    it "fetches the login page" ,:vcr do
      
      agent = Agent.new
      page = agent.home
      expect(page).to be_instance_of Mechanize::Page
    end
    

    it 'gets the logon page' , :vcr do
      agent = Agent.new
      page = agent.home
      expect(agent.logon_page?).to be_true      
                                 end



    it 'can log on', :vcr do
                         agent = Agent.new
                         page = agent.home
                         agent.logon('FAA/Dominic E Sisneros', 'LBawsapp1#')
                         expect(agent.current_page.uri.to_s).to eq('https://ksn2.faa.gov/SitePages/Home.aspx')
    end



  end

end



