require 'mechanize'
module Ksn

  class LogonForm

    attr_reader :form
    
    def initialize(page)
      @form = page.form_with(:name => 'form1')
    end

    def logon(name,password)
      form.user_name = name
      form.password = password
      form.click_button
    end
    
  end


  class Agent

    attr_reader :agent
    attr_accessor :current_page


    def initialize
      @agent = Mechanize.new
      @agent.user_agent_alias = 'Windows IE 7'
    end

    def home_url
      'https://ksn2.faa.gov/'
    end

    def get(page)
      agent.get(page)
    end

    def home
      @current_page = agent.get(home_url)
    end

    def logon(name,password)
      @current_page = logon_form.logon(name,password)
      raise 'Authenticate Error' if logon_page?
      @current_page = home if gateway_page?
    end

    def logon_form
      LogonForm.new(current_page)
    end

    def logon_page?
      current_page.title  == 'FAA - Logon Page'
    end

    def gateway_page?
      current_page.title == 'Microsoft Forefront Unified Access Gateway - Logon Page'
    end

    def home_page?
      current_page.title == home_url
    end
    

  end
end
